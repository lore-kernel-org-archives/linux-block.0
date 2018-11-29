Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B7FC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 03:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047620863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 03:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w55Ezx6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6047620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeK2ORi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:17:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45377 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2ORh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 09:17:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so259684plm.12
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 19:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eOzY4SNgF1Zqv1Lk3/33qe28TpEajp8xfBP2kmD5tNc=;
        b=w55Ezx6RTjwS4ZL6bYRXGXdIOxBKiXIQpboxhBse71dWgmLImxFpVPleABOHYWeOun
         aTJ5dxDdo40zgBhqcvdJIrDD9m8kYt3h7rIy1AtZCS1Okt0SRVaRtlEMsC4PBnz3F9Sq
         wqCBwfCb4JO299eAefakDGTAR9peWw4iK4L109jSuu891EqE83XS9euvOBfSxpn7lxYg
         Hs93xFSa17LblxJzQ+JnLFMORnbQ+B/hgXbBtH+ulDcdY4CXCevtqObEUeqYisCXClb8
         5keDWnrtXB0YMXQn2CjOi4pisBReTbVCB+ye3tF9pNPQ/M6QdhbpKuyrltpCDpyJT2h7
         76rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOzY4SNgF1Zqv1Lk3/33qe28TpEajp8xfBP2kmD5tNc=;
        b=ZGTpvfd7ZcNY583nZz9GR+HBCuAc3x0c+434N8xjbOBSaTJZhgJFy6BTbVQZsI0dQ1
         ROHKiEgYL+5P6wlwXIiO6hS+REciinmzGKRMHi72GC6uqQv0NJd2ajrrD6eCLuEy/6jj
         whwoTFO/+tpT3KHIniezweTzgIuj71JBIHHCfEQYs/T6KsUh7wDRSW9fkeIxZmdCzp2W
         OS11n/2cvcvprALSiiBakIhpFts9hjxjJXaSYBBOXJqEwcm/b38YDb3QrZFV8hiKW08a
         s25CLYzeEGKsGQpjOaaC3shg2Bfm1pVsFVasdtS9C9dw1tbWjBMkhhFaKZumrxgbgD1C
         EHVA==
X-Gm-Message-State: AA+aEWZedLBdlC5aDLp11a12xlxxXLjeKyiaKTzdyr7CXSeHzs82jHZI
        W7DI703MVwQe3xqSFAWX9nJmHSo/IWE=
X-Google-Smtp-Source: AFSGD/V+L7deRCiwXnYpJxclROl7cGPZnBxb8vAgCpQqDqMFEhIJthknvFgwTzy46ng8iKkD5GZBUQ==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr40484692plb.17.1543461226687;
        Wed, 28 Nov 2018 19:13:46 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n23-v6sm563532pfg.84.2018.11.28.19.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 19:13:45 -0800 (PST)
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk> <20181128021029.GF11128@ming.t460p>
 <35b33a34-9e24-5acb-7a4e-57433328bf3d@kernel.dk>
 <20181129012342.GB23249@ming.t460p>
 <e937451d-57dd-41a4-fc4d-b5bbdb10869f@kernel.dk>
 <20181129025143.GC23390@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41d9d590-6a59-c050-c8a8-2506342b93a4@kernel.dk>
Date:   Wed, 28 Nov 2018 20:13:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129025143.GC23390@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 7:51 PM, Ming Lei wrote:
> On Wed, Nov 28, 2018 at 07:19:09PM -0700, Jens Axboe wrote:
>> On 11/28/18 6:23 PM, Ming Lei wrote:
>>> On Tue, Nov 27, 2018 at 07:34:51PM -0700, Jens Axboe wrote:
>>>> On 11/27/18 7:10 PM, Ming Lei wrote:
>>>>> On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
>>>>>> We need this for blk-mq to kick things into gear, if we told it that
>>>>>> we had more IO coming, but then failed to deliver on that promise.
>>>>>>
>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>> ---
>>>>>>  drivers/block/virtio_blk.c | 15 +++++++++++++++
>>>>>>  1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>>> index 6e869d05f91e..b49c57e77780 100644
>>>>>> --- a/drivers/block/virtio_blk.c
>>>>>> +++ b/drivers/block/virtio_blk.c
>>>>>> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
>>>>>>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>>>>>>  }
>>>>>>  
>>>>>> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>>>>>> +{
>>>>>> +	struct virtio_blk *vblk = hctx->queue->queuedata;
>>>>>> +	int qid = hctx->queue_num;
>>>>>> +	bool kick;
>>>>>> +
>>>>>> +	spin_lock_irq(&vblk->vqs[qid].lock);
>>>>>> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
>>>>>> +	spin_unlock_irq(&vblk->vqs[qid].lock);
>>>>>> +
>>>>>> +	if (kick)
>>>>>> +		virtqueue_notify(vblk->vqs[qid].vq);
>>>>>> +}
>>>>>> +
>>>>>>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>>>  			   const struct blk_mq_queue_data *bd)
>>>>>>  {
>>>>>> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
>>>>>>  
>>>>>>  static const struct blk_mq_ops virtio_mq_ops = {
>>>>>>  	.queue_rq	= virtio_queue_rq,
>>>>>> +	.commit_rqs	= virtio_commit_rqs,
>>>>>>  	.complete	= virtblk_request_done,
>>>>>>  	.init_request	= virtblk_init_request,
>>>>>>  #ifdef CONFIG_VIRTIO_BLK_SCSI
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>>> If .commit_rqs() is implemented, virtqueue_notify() in virtio_queue_rq()
>>>>> should have been removed for saving the world switch per .queue_rq()
>>>>
>>>> ->commits_rqs() is only for the case where bd->last is set to false,
>>>> and we never make it to the end and flag bd->last == true. If bd->last
>>>> is true, the driver should kick things into gear.
>>>
>>> OK, looks I misunderstood it. However, virtio-blk doesn't need this
>>> change since virtio_queue_rq() can handle it well. This patch may introduce
>>> one unnecessary VM world switch in case of queue busy.
>>
>> Not it won't, it may in the case of some failure outside of the driver.
> 
> If the failure is because of out of tag, blk_mq_dispatch_wake() will
> rerun the queue, and the bd->last will be set finally. Or is there
> other failure(outside of driver) not covered?

The point is to make this happen when we commit the IOs, not needing to
do a restart (or relying on IO being in-flight). If we're submitting a
string of requests, we should not rely on failures happening only due to
IO being going and thus restarting us. It defeats the purpose of even
having ->last in the first place.

>> The only reason that virtio-blk doesn't currently hang is because it
>> has restart logic, and the failure case only happens in the if we
>> already have IO in-flight.
> 
> Yeah, virtqueue_kick() is called in case of any error in
> virtio_queue_rq(), so I am still wondering why we have to implement
> .commit_rqs() for virtio-blk.

It's not strictly needed for virtio-blk with the restart logic that it
has, but I think it'd be nicer to kill that since we have other real use
cases of bd->last at this point.

>>> IMO bd->last won't work well in case of io scheduler given the rq_list
>>> only includes one single request.
>>
>> But that's a fake limitation that definitely should just be lifted,
>> the fact that blk-mq-sched is _currently_ just doing single requests
>> is woefully inefficient.
> 
> I agree, but seems a bit hard given we have to consider request
> merge.

We don't have to drain everything, it should still be feasible to submit
at least a batch of requests. For basic sequential IO, you want to leave
the last one in the queue, if you have IOs going, for instance. But
doing each and every request individually is a huge extra task. Doing
IOPS comparisons of kyber and no scheduler reveals that to be very true.

>>> I wrote this kind of patch(never posted) before to use sort of
>>> ->commits_rqs() to replace the current bd->last mechanism which need
>>> one extra driver tag, which may improve the above case, also code gets
>>> cleaned up.
>>
>> It doesn't need one extra driver tag, we currently get an extra one just
>> to flag ->last correctly. That's not a requirement, that's a limitation
>> of the current implementation. We could get rid of that, and it it
>> proves to be an issue, that's not hard to do.
> 
> What do you think about using .commit_rqs() to replace ->last? For
> example, just call .commit_rqs() after the last request is queued to
> driver successfully. Then we can remove bd->last and avoid to get the
> extra tag for figuring out bd->last.

I don't want to make ->commit_rqs() part of the regular execution, it
should be relegated to the "failure" case of not being able to fulfil
our promise of sending a request with bd->last == true. Reasons
mentioned earlier, but basically it's more efficient to commit from
inside ->queue_rq() if we can, so we don't have to re-grab the
submission lock needlessly.

I like the idea of separate ->queue and ->commit, but in practice I
don't see it working out without a performance penalty.

-- 
Jens Axboe

