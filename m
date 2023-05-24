Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD0C77B7C
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 23:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjEXXHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjEXXHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 19:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B2E77
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 16:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD95E64173
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 23:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D86C433D2;
        Wed, 24 May 2023 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684969593;
        bh=ueZIpV+tDraVtN8FtFByTvVw6PuXW711xTS7+s88RFg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mWtnapL8678oj0q+C/53CvlRh+0SpPI8H8NOhZfHzyHk4GiBaXO0l2IEy0XQ1pJCy
         bpm5tvFfDMI05j6hAEPkkAvVSNnivdAFkMz2qzTf7sWlXUrzVJLGdM1oY5RUP5GmcH
         QOnkI6/9omvJ91zft6TaY0C72CiQEw82E/KnTrc3LH6rHMwV/xjLjJIHrp45P7LMDG
         s7eu2vbpKbGLzjKDk0dyFUVlBiX6XTTwjI5alOOBV3VCnGDDnaQs9tlM48KRsiM0/Y
         f2ymRBjqNTzFRK0b8pb4E5tghYiviLakv1q3Qg5CTqRjoqaV1mKUatDwZdUlgGSzqn
         6T4ocy+CL7agw==
Message-ID: <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
Date:   Thu, 25 May 2023 08:06:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
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
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a40b10d9-4e30-438f-2509-28bb0df4a161@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/23 02:56, Bart Van Assche wrote:
> On 5/23/23 17:31, Ming Lei wrote:
>> On Tue, May 23, 2023 at 10:19:34AM -0700, Bart Van Assche wrote:
>>> The mq-deadline scheduler restricts the queue depth to one per zone for zoned
>>> storage so at any time there is at most one write command (REQ_OP_WRITE) in
>>> flight per zone.
>>
>> But if the write queue depth is 1 per zone, the requeued request won't
>> be re-ordered at all given no other write request can be issued from
>> scheduler in this zone before this requeued request is completed.
>>
>> So why bother to requeue the BLK_STS_RESOURCE request via scheduler?
> 
> Hi Ming,
> 
> It seems like my previous email was not clear enough. The mq-deadline 
> scheduler restricts the queue depth per zone for commands passed to the 
> SCSI core. It does not restrict how many requests a filesystem can 
> submit per zone to the block layer. Without this patch there is a risk 
> of reordering if a request is requeued, e.g. by the SCSI core, and other 
> requests are pending for the same zone.

Yes there is, but the contract we established for zoned devices in the block
layer, from the start of the support, is that users *must* write sequentially.
The block layer does not attempt, generally speaking, to reorder requests.

When mq-deadline is used, the scheduler lba reordering *may* reorder writes,
thus hiding potential bugs in the user write sequence for a zone. That is fine.
However, once a write request is dispatched, we should keep the assumption that
it is a well formed one, namely directed at the zone write pointer. So any
consideration of requeue solving write ordering issues is moot to me.

Furthermore, when the requeue happens, the target zone is still locked and the
only write request that can be in flight for that target zones is that one being
requeued. Add to that the above assumption that the request is the one we must
dispatch first, there are absolutely zero chances of seeing a reordering happen
for writes to a particular zone. I really do not see the point of requeuing that
request through the IO scheduler at all.

In general, even for reads, requeuing through the scheduler is I think a really
bad idea as that can potentially significantly increase the request latency
(time to completion), with the user seeing long tail latencies. E.g. if the
request has high priority or a short CDL time limit, requeuing through the
scheduler will go against the user indicated urgency for that request and
degrade the effectivness of latency control easures such as IO priority and CDL.

Requeues should be at the head of the dispatch queue, not through the scheduler.

As long as we keep zone write locking for zoned devices, requeue to the head of
the dispatch queue is fine. But maybe this work is preparatory to removing zone
write locking ? If that is the case, I would like to see that as well to get the
big picture. Otherwise, the latency concerns I raised above are in my opinion, a
blocker for this change.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

