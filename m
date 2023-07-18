Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40182EB64DA
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 06:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGRGrU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 02:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGRGrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 02:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A63FB2
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 23:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D70361482
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 06:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6CCC433C8;
        Tue, 18 Jul 2023 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689662837;
        bh=cFxL+nUI5sVBg3EK7GP0AOGQKSHG4QIvN5VtaihNYBo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sQ/BmKNDC9R1zt/7bMfJh2Qmodx0495w1xtfAjeNzxHZ70/d2Q9mPbWTiLP/8AoUn
         WBhs3Xg35qR16WM0KDaQuiEKcw/MJtvRMSJQKUI99D/uglYxFM6KriM1HiGze3s/Ut
         8pNyVOP5KCCGOtF0wDOfI+K7HgCKD1hiUNN/RmokG5f28LwCyR+xuDnSTxPmP9mWQV
         jfFQ4+3feffN4JVZuvLnxG6DzhMOW0Gx9YZJ/Ti9Ostme9Aom1hiuC7BW7YzNi5viL
         XCUYAPY0izJ08PjwceUcFEhGc9pFnYoMKmIWQFUvTR91+99cXGCP3n3fIhdjDIJeCD
         mKo6dQaRWkwsg==
Message-ID: <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
Date:   Tue, 18 Jul 2023 15:47:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-5-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230710180210.1582299-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 03:01, Bart Van Assche wrote:
> From ZBC-2: "The device server terminates with CHECK CONDITION status, with
> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
> same command, that specifies: a) the starting LBA in a sequential write
> required zone set to a value that is not equal to the write pointer for that
> sequential write required zone; or b) an ending LBA that is not equal to the
> last logical block within a physical block (see SBC-5)."
> 
> I am not aware of any other conditions that may trigger the UNALIGNED
> WRITE COMMAND response.

Trying to write less than 4KB on a 4Kn drive. But that should not ever happen
for kernel issued commands.

> 
> Send commands that failed with an unaligned write error to the SCSI error
> handler. Let the SCSI error handler sort SCSI commands per LBA before
> resubmitting these.
> 
> Increase the number of retries for write commands sent to a sequential
> zone to the maximum number of outstanding commands.

I think I mentioned this before. When we started btrfs work, we did something
similar (but at the IO scheduler level) to try to avoid adding a big lock in
btrfs to serialize (and thus order) writes. What we discovered is that it was
extremely easy to fall into a situation were the maximum number of possible
outstanding request is already issued, but they all are behind a "hole" and
indefinitely delayed because the missing request cannot be issued due to the max
nr request limit being reached. No forward progress and deadlock.

I do not see how your change addresses this problem. The same will happen with
this and I do not have any suggestion how to solve this. For btrfs, we ended up
using cone append emulation for scsi to avoid the big lock and avoid the FS from
having to order writes. That solution guarantees forward progress. Delaying
already issued writes that are not sequential has no such guarantees.


-- 
Damien Le Moal
Western Digital Research

