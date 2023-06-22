Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E9DEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 23:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjFVXpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjFVXpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 19:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595E2128
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 16:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9402D61938
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 23:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF1EC433C0;
        Thu, 22 Jun 2023 23:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687477531;
        bh=0Odhpc/Muu//pZmBLD8DDeq+6iNQD234HE/CanakeuQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fr4xEb4UrXR5lYNYJGX2gN1PxNS3pQ/GnYWIxoKeueWW+Lxm8CTsr1cx0mxJX6LmD
         sCgkNRWIeTPSd2CpKDnefetiI4lde0z8PTTlDqXoifDxrowIAMo8PrObQm3Z0g/zNv
         56NCVwxlhavlKbRp1BjPl53OryOOJOG7GHUxA+VZjHxDtGfWqnh1Bt/ZsNVvKUZfDG
         NgzKiPdle+MeXsYDbsu8dkuDriOuV2cfuQY2DyKfPAgNM90h64UjF6JtEBBTzBpCl7
         TWfVq50SU11Nk5VaS0HsAffPqZ8FSmoMyUiCoXlTrWu1C9D3ABwqTBsAdggyJdFPvj
         yD6mNOveAJcIQ==
Message-ID: <a11b7721-1eaf-43d6-bcaa-d7fdeb9904ad@kernel.org>
Date:   Fri, 23 Jun 2023 08:45:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
 <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
 <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
 <a40b10d9-4e30-438f-2509-28bb0df4a161@acm.org>
 <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
 <43cc01f3-c1fa-84c4-c3a0-5a1b62982bcd@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <43cc01f3-c1fa-84c4-c3a0-5a1b62982bcd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/23 09:34, Bart Van Assche wrote:
> On 5/24/23 16:06, Damien Le Moal wrote:
>> When mq-deadline is used, the scheduler lba reordering *may* reorder writes,
>> thus hiding potential bugs in the user write sequence for a zone. That is fine.
>> However, once a write request is dispatched, we should keep the assumption that
>> it is a well formed one, namely directed at the zone write pointer. So any
>> consideration of requeue solving write ordering issues is moot to me.
>>
>> Furthermore, when the requeue happens, the target zone is still locked and the
>> only write request that can be in flight for that target zones is that one being
>> requeued. Add to that the above assumption that the request is the one we must
>> dispatch first, there are absolutely zero chances of seeing a reordering happen
>> for writes to a particular zone. I really do not see the point of requeuing that
>> request through the IO scheduler at all.
> 
> I will drop the changes from this patch that send requeued dispatched 
> requests to the I/O scheduler instead of back to the dispatch list. It 
> took me considerable effort to find all the potential causes of 
> reordering. As you may have noticed I also came up with some changes 
> that are not essential. I should have realized myself that this change 
> is not essential.
> 
>> As long as we keep zone write locking for zoned devices, requeue to the head of
>> the dispatch queue is fine. But maybe this work is preparatory to removing zone
>> write locking ? If that is the case, I would like to see that as well to get the
>> big picture. Otherwise, the latency concerns I raised above are in my opinion, a
>> blocker for this change.
> 
> Regarding removing zone write locking, would it be acceptable to 
> implement a solution for SCSI devices before it is clear how to 
> implement a solution for NVMe devices? I think a potential solution for 
> SCSI devices is to send requests that should be requeued to the SCSI 
> error handler instead of to the block layer requeue list. The SCSI error 
> handler waits until all pending requests have timed out or have been 
> sent to the error handler. The SCSI error handler can be modified such 
> that requests are sorted in LBA order before being resubmitted. This 
> would solve the nasty issues that would otherwise arise when requeuing 
> requests if multiple write requests for the same zone are pending.

I am still thinking that a dedicated hctx for writes to sequential zones may be
the simplest solution for all device types:
1) For scsi HBAs, we can likely gain high qd zone writes, but that needs to be
checked. For AHCI though, we need to keep the max write qd=1 per zone because of
the chipsets reordering command submissions. So we'll need a queue flag saying
"need zone write locking" indicated by the adapter when creating the queue.
2) For NVMe, this would allow high QD writes, with only the penalty of heavier
locking overhead when writes are issued from multiple CPUs.

But I have not started looking at all the details. Need to start prototyping
something. We can try working on this together if you want.

-- 
Damien Le Moal
Western Digital Research

