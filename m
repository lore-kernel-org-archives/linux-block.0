Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F11C7618E
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDTXh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDTXhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 19:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7F0E65
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 16:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F7C64CD1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 23:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEC7C433D2;
        Thu, 20 Apr 2023 23:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682033843;
        bh=8HTa3eOGzxUvOVQfYRgwZRvYuJdn3Gxa7WY2l/JxVDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ELg4Uhqd3EfODvajZEl0nCB50+ZiwdlnSsXu18KadStQLFGmLaBNTOWJhA8aDHQMl
         xRQco8fvJZq9cw1N1C+I7McVMxELqi7wWUFw0nwiiH9cfhcCT7bqYp9vTGjCQvPGyH
         ayucGjZKXJnFVZ11pFPtEPrZgbnM6XH++fL6FOZ/km69p9WTdaQFNSnUMwftfVu3lb
         Tmf2wE4FCXiMNFLPn5gzCSsY0NYVnNVUkpR+BsV/fcfNsRcptVd8K23NLWVgVCoGjd
         u7q6O7n4zEZVOlTh6k/mL/i3MAO9nzNCiS34197jP21wqekenCTWgqaYh8E/rPjzvg
         S4vUCCAMyoK5Q==
Message-ID: <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
Date:   Fri, 21 Apr 2023 08:37:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 07:51, Bart Van Assche wrote:
> On 4/20/23 15:00, Damien Le Moal wrote:
>> On 4/21/23 02:12, Bart Van Assche wrote:
>>> On 4/20/23 02:23, Niklas Cassel wrote:
>>>> With your change above, we would start rejecting such devices.
>>>>
>>>> Is this reduction of supported NVMe ZNS SSD devices really desired?
>>>
>>> Hi Niklas,
>>>
>>> This is not my intention. A possible solution is to modify the NVMe
>>> driver and SCSI core such that the "zone is full" information is stored
>>> in struct request when a command completes. That will remove the need
>>> for the mq-deadline scheduler to know the zone capacity.
>>
>> I am not following... Why would the scheduler need to know the zone capacity ?
>>
>> If the user does stupid things like accessing sectors between zone capacity and
>> zone size or trying to write to a full zone, the commands will be failed by the
>> drive and I do not see why the scheduler need to care about that.
> 
> Hi Damien,
> 
> Restricting the number of active zones in the I/O scheduler (patch 
> 11/11) requires some knowledge of the zone condition.

Why would you need to handle the max active zone number restriction in the
scheduler ? That is the user responsibility. btrfs does it (that is still buggy
though, working on it).

> According to ZBC-2, for sequential write preferred zones the additional 
> sense code ZONE TRANSITION TO FULL must be reported if the zone 
> condition changes from not full into full. There is no such requirement 
> for sequential write required zones. Additionally, I'm not aware of any 
> reporting mechanism in the NVMe specification for changes in the zone 
> condition.

Sequential write preferred zones is ZBC which does not have the concept of
active zone. In general, for ZBC HDDs, ignoring the max number of open zones is
fine. There is no performance impact that can be measured, unless the user goes
full random write on the device. But in that case, the user is already asking
for bad perf anyway.

I suspect you are thinking about all this in the context of UFS devices ?
My point stands though. Trying to manage the active zone limit at the scheduler
level is not a good idea as there are no guarantees that the user will
eventually issue all the write commands to make zones full, and thus turn them
inactive. This is the responsibility of the user to manage that, so above the
block IO scheduler.

> The overhead of submitting a REPORT ZONES command after every I/O 
> completion would be unacceptable.
> 
> Is there any other solution for tracking the zone condition other than 
> comparing the LBA at which a WRITE command finished with the zone capacity?

The sd driver does some minimal tracking already which is used for zone append
emulation.

> 
> Did I perhaps overlook something?
> 
> Thanks,
> 
> Bart.

