Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4684DC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 02:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D231B2081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 02:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jlqV0rEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D231B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeK2NW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:22:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38506 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2NW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 08:22:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so221802pfi.5
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 18:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Dk+oKYcJp7UzAWmJxqwo2EgR0EZnNsJoHZK7Co8W4E=;
        b=jlqV0rELxEd7uD+6jOalg4GtSLOFjW0i5OdMhrxW4CUg6MadRp0ZcYK+p6eLgJqbMF
         FPfrp74GgRNCCcIQmIvX0BEIWVxDC+vHl14YYU93DrJJ/SVyEcPwhSEwQAHcLev+IAqU
         nwQlZV+V/F0VmsDHR2bCiJVg8ZClr10isbo56HWqeagdiWXT44hHQPpIxdkabDEUj3A2
         021z/Ysqg8fqYQd1/OpOQYtqmFXt1EiXONMh5dOWRo4/RxU7RJ8A7Lbjr5gYlU8wLcHS
         OW2/lhi9xsay/Hxu2uTSOu/Uf2aLyDut7xiGGS1WTkG9/VOc5RVGk9ADoCsdrksacLFF
         5Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Dk+oKYcJp7UzAWmJxqwo2EgR0EZnNsJoHZK7Co8W4E=;
        b=UdQUxPBB1y3JscfH6MvzDC2C9luQ526WD9iJCRNdITs65H+DW8hriQUgDZJcv0Tts1
         vHf92Ps0EYcvUiAYQh+IZbgfLg5ZMl/+zlHE9irGvM75cfOcMw0d+p4JKu2CP2BxIg+p
         5yhI6L8koaA8K9Uj3ztdvZOK07T0mpgifJuR1YxxcpC2Hd3RLJ2x7sGT7+JiInjk3Sqf
         F3oSkQHy3wkSIF9bcH5DPa3q+Bf5i1znQuk1cGoXHRuCX4YgxQReCBVxIwbTWH63wXEU
         51oG7xcawGgS8o1+J+++H7iP8Izq9v5okdSde0EBbz6yk0DZMQKs1jbBTZ/0wRHgfcOo
         f66g==
X-Gm-Message-State: AA+aEWbhwUUElu0FA4Ww65FQEtjohVbuH98bxsFATGYqmKTs/XHWI/Vb
        ELS/VwfMN0u3x6wQFaatAbBOUA==
X-Google-Smtp-Source: AFSGD/UEz/kPXDYGFTQIyxavIqpiy2LpKv6DQMUfN7zs/+Vx7rbuqHx7Sz6zUjfIidchqx/WxZD6rA==
X-Received: by 2002:a63:d252:: with SMTP id t18mr35514677pgi.133.1543457954172;
        Wed, 28 Nov 2018 18:19:14 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l87sm402617pfj.179.2018.11.28.18.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 18:19:13 -0800 (PST)
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk> <20181128021029.GF11128@ming.t460p>
 <35b33a34-9e24-5acb-7a4e-57433328bf3d@kernel.dk>
 <20181129012342.GB23249@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e937451d-57dd-41a4-fc4d-b5bbdb10869f@kernel.dk>
Date:   Wed, 28 Nov 2018 19:19:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129012342.GB23249@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 6:23 PM, Ming Lei wrote:
> On Tue, Nov 27, 2018 at 07:34:51PM -0700, Jens Axboe wrote:
>> On 11/27/18 7:10 PM, Ming Lei wrote:
>>> On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
>>>> We need this for blk-mq to kick things into gear, if we told it that
>>>> we had more IO coming, but then failed to deliver on that promise.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  drivers/block/virtio_blk.c | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>> index 6e869d05f91e..b49c57e77780 100644
>>>> --- a/drivers/block/virtio_blk.c
>>>> +++ b/drivers/block/virtio_blk.c
>>>> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
>>>>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>>>>  }
>>>>  
>>>> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>>>> +{
>>>> +	struct virtio_blk *vblk = hctx->queue->queuedata;
>>>> +	int qid = hctx->queue_num;
>>>> +	bool kick;
>>>> +
>>>> +	spin_lock_irq(&vblk->vqs[qid].lock);
>>>> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
>>>> +	spin_unlock_irq(&vblk->vqs[qid].lock);
>>>> +
>>>> +	if (kick)
>>>> +		virtqueue_notify(vblk->vqs[qid].vq);
>>>> +}
>>>> +
>>>>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>  			   const struct blk_mq_queue_data *bd)
>>>>  {
>>>> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
>>>>  
>>>>  static const struct blk_mq_ops virtio_mq_ops = {
>>>>  	.queue_rq	= virtio_queue_rq,
>>>> +	.commit_rqs	= virtio_commit_rqs,
>>>>  	.complete	= virtblk_request_done,
>>>>  	.init_request	= virtblk_init_request,
>>>>  #ifdef CONFIG_VIRTIO_BLK_SCSI
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>> If .commit_rqs() is implemented, virtqueue_notify() in virtio_queue_rq()
>>> should have been removed for saving the world switch per .queue_rq()
>>
>> ->commits_rqs() is only for the case where bd->last is set to false,
>> and we never make it to the end and flag bd->last == true. If bd->last
>> is true, the driver should kick things into gear.
> 
> OK, looks I misunderstood it. However, virtio-blk doesn't need this
> change since virtio_queue_rq() can handle it well. This patch may introduce
> one unnecessary VM world switch in case of queue busy.

Not it won't, it may in the case of some failure outside of the driver.
The only reason that virtio-blk doesn't currently hang is because it
has restart logic, and the failure case only happens in the if we
already have IO in-flight. For the NVMe variant, that's not going
to be the case.

> IMO bd->last won't work well in case of io scheduler given the rq_list
> only includes one single request.

But that's a fake limitation that definitely should just be lifted,
the fact that blk-mq-sched is _currently_ just doing single requests
is woefully inefficient.

> I wrote this kind of patch(never posted) before to use sort of
> ->commits_rqs() to replace the current bd->last mechanism which need
> one extra driver tag, which may improve the above case, also code gets
> cleaned up.

It doesn't need one extra driver tag, we currently get an extra one just
to flag ->last correctly. That's not a requirement, that's a limitation
of the current implementation. We could get rid of that, and it it
proves to be an issue, that's not hard to do.

I prefer to deal with actual issues and fix those, not in hypotheticals.

-- 
Jens Axboe

