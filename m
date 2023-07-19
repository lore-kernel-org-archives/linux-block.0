Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09A3C001E0
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGSJ73 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGSJ7K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 05:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E8D10D4
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 02:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69896137C
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 09:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6AEC433C7;
        Wed, 19 Jul 2023 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760748;
        bh=SvF1KKQzly9bvUQp8LoQNtgH4Ta4F60U7X/FQ87+wlY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d2El+OqYf0p5ETAAnhNGqahpYbfgAhgx6wB0q9n5PldkmSbor4jk0+GgUC+g6zicZ
         BdnB5F56z6lkVG7XVpzAnsZ0Wgv8BkFKp3O+QbSfxkd4TXN9RkmgQf6B5DqOOsyqva
         h9GBWEGsug6OSASJo/dgq+h9RMNsTOHSpMI2mXuMuY4oOYp1+PyxDiOIhtO0o9hmlc
         hhqnl4ceaY8h0UyIBK13f9NmINJtBzJTFHvBFRrTAqVyXDSq1PJJlTJ/uFJRubYlxa
         nhSj/1lYZx+6ykDvjKgGzgaVM5dghjk9X2buwNcHJCxXxv9kBx3v6DwMbWH7rdo42y
         FGSXeuIlavHnA==
Message-ID: <fd64fa90-1227-6d4d-8f0b-fc67d8c42a7e@kernel.org>
Date:   Wed, 19 Jul 2023 18:59:06 +0900
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
 <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
 <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/23 07:53, Bart Van Assche wrote:
> On 7/17/23 23:47, Damien Le Moal wrote:
>> On 7/11/23 03:01, Bart Van Assche wrote:
>>> Send commands that failed with an unaligned write error to the SCSI
>>> error
>>> handler. Let the SCSI error handler sort SCSI commands per LBA before
>>> resubmitting these.
>>>
>>> Increase the number of retries for write commands sent to a sequential
>>> zone to the maximum number of outstanding commands.
>>
>> I think I mentioned this before. When we started btrfs work, we did
>> something
>> similar (but at the IO scheduler level) to try to avoid adding a big
>> lock in
>> btrfs to serialize (and thus order) writes. What we discovered is that
>> it was
>> extremely easy to fall into a situation were the maximum number of
>> possible
>> outstanding request is already issued, but they all are behind a
>> "hole" and
>> indefinitely delayed because the missing request cannot be issued due
>> to the max
>> nr request limit being reached. No forward progress and deadlock.
>>
>> I do not see how your change addresses this problem. The same will
>> happen with
>> this and I do not have any suggestion how to solve this. For btrfs, we
>> ended up
>> using cone append emulation for scsi to avoid the big lock and avoid
>> the FS from
>> having to order writes. That solution guarantees forward progress.
>> Delaying
>> already issued writes that are not sequential has no such guarantees.
> 
> Hi Damien,
> 
> Thank you for having explained in detail the scenario that you ran into.
> 
> I think what has been explained above is a scenario in which the filesystem
> allocates requests per zone in another order than the LBA order. How about
> requiring that the filesystem allocates and submits zoned writes in LBA
> order
> per zone? I think that this is how F2FS supports zoned storage.

Sure. But what if an application uses the drive directly ? You loose
guarantees of forward progress then. Given that an application has to
use direct IO for writes to sequential zones, this is unlikely to happen
in a "good" scenario, but it also would not be hard to write an
application that can deadlock the drive forever by simply missing one
write in a sequence of writes for a zone... That is my concern. While
f2fs would likely be OK, the delay approach is not solid enough for all
cases.



-- 
Damien Le Moal
Western Digital Research

