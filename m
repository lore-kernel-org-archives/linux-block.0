Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713FDEB64DA
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 00:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGUAUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGUAUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 20:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653A2106
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 17:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DF261CCE
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 00:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091E5C433C9;
        Fri, 21 Jul 2023 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689898808;
        bh=+mDyzD0dYlGDmO2K7/HtcreduFPQ7TCEpDRKbzDOI64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qxlsXjVp+SS6k0x5z/Di4o8m+p2AcM15FQ0b56ToEPWrD5uigziKJs91WPO7ai568
         jRHaT4PUwT4j2Q/Vd9xT96BYmOPT6mSufE5EAWNsiXbJgG53eleyGQlUvMA1OGSOIA
         7z3uS4C/lqbN98zth14+Fww8ozyftAVth2V9yzPL8gmvQHiP9VNgg84FMxrGUxA5//
         vSpttva3GgLhHxpIG1AX5rP2b351NwFE6MFz6uQ6vrFvCfcql8dtfnXGYlv8HUTazp
         7z6JoS3es8UqSb2rzoRnPcBgRbsYXVp3e6Z9olXsaHd3+bFAZYXNKtHJGVm/j5d3Cd
         F0xxmt+QzdzFA==
Message-ID: <57e9aa7a-e937-1228-270b-0dce158af9b9@kernel.org>
Date:   Fri, 21 Jul 2023 09:20:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] scsi: Retry unaligned zoned writes
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-5-bvanassche@acm.org>
 <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
 <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
 <fd64fa90-1227-6d4d-8f0b-fc67d8c42a7e@kernel.org>
 <42402057-3806-3930-5ff8-d68816c79ca5@acm.org>
 <c4498ce0-d04d-c8d0-800e-d856d8ed8a8c@kernel.org>
 <075b8a01-d219-89d1-bb38-c5868fafaa1d@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <075b8a01-d219-89d1-bb38-c5868fafaa1d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/23 03:18, Bart Van Assche wrote:
> On 7/19/23 16:07, Damien Le Moal wrote:
>> Not really. I was not thinking about passthrough requests but rather write
>> syscalls to /dev/sdX by applications. sd_setup_read_write_cmnd() is used for
>> these too. After all, /dev/sdX *is* a file system too, albeit the simplest possible.
> 
> How about introducing a new request flag (REQ_*) such that f2fs can disable
> zone locking while it remains enabled for all other users (BTRFS and direct
> I/O)?

That could be a safer approach. Still a little worried about any DM used between
the FS and the device though. The DMs that support zoned devices should be OK
but only under the assumption that the bio issuer (f2fs) guarantees that writes
to the same zone are not issued in parallel when that REQ_NO_ZONE_WRITE (or
whatever the name) is used. This flag definition will need to have a big fat
warning mentioning this constraint, that is, make it clear that it is not a
replacement for zone append (in which case we do not write lock zones and do not
care about ordering).

-- 
Damien Le Moal
Western Digital Research

