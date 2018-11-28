Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D92C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B620851
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G1Yuwze0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9B620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeK1Nev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:34:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42745 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeK1Nev (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 08:34:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so8760389pga.9
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 18:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mXEFKd5qgMIQuIVeBYfSpZ12XTpltkgTIf9CA6qlF8E=;
        b=G1Yuwze0oU0ZteLuA4NEYnxmN5uB+s4BYtHej5Wp5hu87jees+tmWmgfkiOr4mf7ps
         ne/sWy4Hl8YeXCpIh7FaG0BR8X9gYjtgu7xWAeiy6haWcD0vJrHZ3cWxpqKO0EqSUXvt
         yOk/upnF93rJiiXFPEjjMwIE6heObpwkoPw5gDigHeq1fWQXWg1ke5k7cHrvUY3xUi9w
         dwclZDvtFYzT4kJwgBIfXWGGadcFc3qLkvAtvuG9UN7urwHFU+/umPejdubJiZmjJU65
         o1vuvg+6VkzM1/Dg5pRT4UPFafWTitfcdO7toq4M13vUrGDa2HClMAuSu09i8UjmH5RM
         j4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXEFKd5qgMIQuIVeBYfSpZ12XTpltkgTIf9CA6qlF8E=;
        b=d02dlADmuZ1gnJSKFPvPiQouTOyuU3qZG4tye0F5+BrqR2IjOwQ5wfn2B9TjvoggFO
         f1/w7T1eGMEAUosWiJmQl41huUOVmCfiPimF27uASg0qrcb667+gLFp1AEB4iISo4JaP
         NI3vA3d8Qp2Wy1emgSy1ri0c669RM2ZBbofdf14LXpb62IsJZH0uAolQISZYNgNKjRtB
         94MWdxx6p0EVDUhZNLtBOJlDpMWXqy0WOe6+hbFkGtHJg3KHEAInfUNgs9YSHQzH6Ntw
         BhHWkgqxkkKlMDD/BlmLyt8hiBCFKIunMEaE2ODKjE5bXe1afsbFb7mTtZTEfnSrw2/L
         KGLQ==
X-Gm-Message-State: AA+aEWa29bc5mSO7ctlWp3m8ry38VGVxR3IPnA4MvwmCUsmivVOc193e
        SohA0POLT2KCIxa+UtXoLKHU4g==
X-Google-Smtp-Source: AFSGD/XzFHENJo+orOFugy3vjsLJLiUJVn8ULW1X+yFA8Sq49q6RgJBie+i5tk/nk3+YbrWGDwW2xQ==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr32177903pgc.25.1543372494590;
        Tue, 27 Nov 2018 18:34:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p24sm14225335pfk.155.2018.11.27.18.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 18:34:53 -0800 (PST)
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk> <20181128021029.GF11128@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <35b33a34-9e24-5acb-7a4e-57433328bf3d@kernel.dk>
Date:   Tue, 27 Nov 2018 19:34:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128021029.GF11128@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 7:10 PM, Ming Lei wrote:
> On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
>> We need this for blk-mq to kick things into gear, if we told it that
>> we had more IO coming, but then failed to deliver on that promise.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  drivers/block/virtio_blk.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 6e869d05f91e..b49c57e77780 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
>>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>>  }
>>  
>> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>> +{
>> +	struct virtio_blk *vblk = hctx->queue->queuedata;
>> +	int qid = hctx->queue_num;
>> +	bool kick;
>> +
>> +	spin_lock_irq(&vblk->vqs[qid].lock);
>> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
>> +	spin_unlock_irq(&vblk->vqs[qid].lock);
>> +
>> +	if (kick)
>> +		virtqueue_notify(vblk->vqs[qid].vq);
>> +}
>> +
>>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  			   const struct blk_mq_queue_data *bd)
>>  {
>> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
>>  
>>  static const struct blk_mq_ops virtio_mq_ops = {
>>  	.queue_rq	= virtio_queue_rq,
>> +	.commit_rqs	= virtio_commit_rqs,
>>  	.complete	= virtblk_request_done,
>>  	.init_request	= virtblk_init_request,
>>  #ifdef CONFIG_VIRTIO_BLK_SCSI
>> -- 
>> 2.17.1
>>
> 
> If .commit_rqs() is implemented, virtqueue_notify() in virtio_queue_rq()
> should have been removed for saving the world switch per .queue_rq()

->commits_rqs() is only for the case where bd->last is set to false,
and we never make it to the end and flag bd->last == true. If bd->last
is true, the driver should kick things into gear.


-- 
Jens Axboe

