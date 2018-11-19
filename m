Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C4C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8E920831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BIrr+GCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8E920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeKTBoT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:44:19 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50542 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeKTBoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 20:44:19 -0500
Received: by mail-it1-f194.google.com with SMTP id a185so7523316itc.0
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4iwK+DxPK8ZfpDonYo2YQRxFinFR3rBLQ7W2C7tk4iw=;
        b=BIrr+GCfEaPaxxFKY3GjPGZrIRPObgteuQgmhslPOKLxWVmHdaOnSiv/xmD5MLCCKe
         hZjoSeTI/LbjpUFfJBSzBL3Vg8mxcxuNwalUF3Kuc6YGC3gerOt8QfAeVik4e0JnTMFh
         XKAbmNo/yv9662nE3vd4TCSRCI256phRhrauqloPws1VrrhyecW/+BGH8a/xvJCXhZt2
         BW6TebLVqn5fffSBGxR5OqDOtGZiZujnj0OfzyAbde1rdD18BtFiU6monu8xvHB314ZO
         IoXIIbOOlYHs/152bicHXv6w2CCNijrHDx0+nTcpLa1GnbOAzMc/cgaJtgJu9386EGVS
         9//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4iwK+DxPK8ZfpDonYo2YQRxFinFR3rBLQ7W2C7tk4iw=;
        b=Yd9/9CqU39Yub7cJfjIrw/REygTQyDre1ri9W8pK8hzdmH69025HDSHhX8HCJErYYV
         eMQZ5NuzU2grBaiQu6ZlWGeNzzAgpP5jAoPbhkXOcK5YHUtvgP6JOEi82/nUe3OkTKUu
         FegL0MQ9R3lu0q/LuQmch/1m2PymUt0dcs3VDc4IqHa8VPFvuyoujv7YRVx8yKlAR8SN
         0nlXv30U2R6xbKVUiHBoiM7gi+xzsXhiWS0AWNMEyghwkULsczPf9QT3cHnr1fdniTOt
         jJUHLDwgHnZDk5Zyuq4v4lMp7pHEEaCtfarNlf8D5o0qvBL4m0ivAfzvklQiaJAH4gNB
         Ebjw==
X-Gm-Message-State: AGRZ1gI+KzwIlwmCNDkskAIfzurH0F/aRiQYl5hSH3L4Y931Bql3Y82a
        RH9WRvu7q35jhB7Gz7ZN9QTSzs5Hz5o=
X-Google-Smtp-Source: AJdET5f26Hjkq3zhW8zv7cuqM9704bXnahode8pEw6X+MiQj4WWLfPyEq7RO1H7h/SnbDPoakzHORA==
X-Received: by 2002:a02:8a69:: with SMTP id e38mr13543299jal.81.1542640824175;
        Mon, 19 Nov 2018 07:20:24 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w8-v6sm17077934ita.18.2018.11.19.07.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:20:23 -0800 (PST)
Subject: Re: [PATCH 4/7] blk-mq: when polling for IO, look for any completion
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-5-axboe@kernel.dk> <20181119080233.GD9622@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea9ac6ae-32ab-0fa9-5208-4f4689bf84f2@kernel.dk>
Date:   Mon, 19 Nov 2018 08:20:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119080233.GD9622@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 1:02 AM, Christoph Hellwig wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 52b1c97cd7c6..3ca00d712158 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3266,9 +3266,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>>  	 *  0:	use half of prev avg
>>  	 * >0:	use this specific value
>>  	 */
>> -	if (q->poll_nsec == -1)
>> -		return false;
>> -	else if (q->poll_nsec > 0)
>> +	if (q->poll_nsec > 0)
>>  		nsecs = q->poll_nsec;
>>  	else
>>  		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
> 
> The above comment now doesn't match the code here as the -1 case
> is handled elsewhere.

Good point, I'll fix the comment.

>> +static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
>>  {
>>  	struct request_queue *q = hctx->queue;
>>  	long state;
> 
> Can you merge __blk_mq_poll into blk_mq_poll now that blk_mq_poll
> is pretty trivial?
> 
>>  static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>>  {
>> -	__nvme_rdma_recv_done(cq, wc, -1);
>> +	__nvme_rdma_recv_done(cq, wc);
>>  }
> 
> __nvme_rdma_recv_done and nvme_rdma_recv_done can be merged now.

I'll fold them.

>>  static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
>> @@ -1758,10 +1752,12 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
>>  		struct ib_cqe *cqe = wc.wr_cqe;
>>  
>>  		if (cqe) {
>> -			if (cqe->done == nvme_rdma_recv_done)
>> -				found |= __nvme_rdma_recv_done(cq, &wc, tag);
>> -			else
>> +			if (cqe->done == nvme_rdma_recv_done) {
>> +				__nvme_rdma_recv_done(cq, &wc);
>> +				found++;
>> +			} else {
>>  				cqe->done(cq, &wc);
>> +			}
> 
> And we should probably look into separate poll queues for RDMA as well
> while we're at it.

I'll leave that as an exercise for someone else :-)

-- 
Jens Axboe

