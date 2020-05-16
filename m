Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D327C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66B92053B
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="bPJstQng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEPQgh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgEPQgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 12:36:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41AC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 09:36:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so6931282wrt.9
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=B13sWG68ETWTDgjm2nkNm6nKL2sZ6b+sOngTOVADmB4=;
        b=bPJstQngN5CMClqKPSns2BW3XotwLLhcN5Lrw6LAdZ8gRNRE0ovyjHSalchmHvKL6n
         zrMBfWW1qhRVE0Vg4R2+3tbl0CTd/wOf6peMz7PALA2i8hb7CSnwg82YqNeYIB+1D6tp
         WFuzIJkjkiTiZl+uF2I9OAsS+9EnUH4N5E0oeuoO/luW0LValMh+tr0a5tVSIRmFOFKt
         gieM5nvFaGoxd853eLCYbAmJN7PcN1Si1sfaNl+AmeHS2ovBr/CqJMt+Svh63vefseMg
         wxYSWtoburSpsMl9n/DHvsPtxn471iZ3Jxqd93plW6FGOrOaedcxcZ4ULO060BdVceRG
         mRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B13sWG68ETWTDgjm2nkNm6nKL2sZ6b+sOngTOVADmB4=;
        b=i5maXqxzN1brVLpWnu4729MgM6vLZdPkGN9Bu/wF6r8DXoRcx6803Mdy5QMmz3PbeX
         Cwt7MuyBv8u41BamA8ydgE93i1j1tR6IAwi315ZAPAu6bvcwaNY/K68cOFrnTgTix0Ge
         YHOgNcRnRamuPotNxgJ9lHFagw/yuKBM43itDgaFw5zT3ogjlztBbmF4CH9sIFEE31nV
         WV1Iml/1mvJNIjQ4VGAu+LXHKjASJYysHVs4QvMONVB+26XDe0Qb5buTfvfcxSiIKjv0
         7pXyV70WTarI3QWOZ62K7y6lAxB2wLPfEGttb6OWho0L7pp/Xuti9r5wuBNTAUxV2JTb
         EJhw==
X-Gm-Message-State: AOAM532Pp9z0FUu/fqK6LN+gS/Ks2z6UOyeIQfM/KitmRMSMHyKNbiwh
        iaC1dt0kwtHAtMmFVyeeER3zxOLfIAe5Iw==
X-Google-Smtp-Source: ABdhPJz/rIKMq55Mgl7FhH3RJGPE3yDYkGBw2ZPOzFKsZXWZ98t7bsMScBNIG5xw0ix5nJZOV0v3Zg==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr10244783wrt.7.1589646995106;
        Sat, 16 May 2020 09:36:35 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4815:2b00:e80e:f5df:f780:7d57? ([2001:16b8:4815:2b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id z132sm9042097wmc.29.2020.05.16.09.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 09:36:34 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove the bio argument to ->prepare_request
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <20200516154059.328211-1-hch@lst.de>
 <ffaa84e5-8878-84a9-5c52-a04fc3016cfe@acm.org>
 <20200516161346.GA17642@lst.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <7d9889de-8078-0ea8-574a-586edf2c4e6b@cloud.ionos.com>
Date:   Sat, 16 May 2020 18:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200516161346.GA17642@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On 5/16/20 6:13 PM, Christoph Hellwig wrote:
> On Sat, May 16, 2020 at 09:12:10AM -0700, Bart Van Assche wrote:
>> On 2020-05-16 08:40, Christoph Hellwig wrote:
>>> None of the I/O schedulers actually needs it.
>> Is the next step perhaps to remove the bio argument from
>> blk_mq_get_request()? Anyway:
> Yes, but that is a bigger surgery :)

I had local changes for it which was compiled test, and seems no new 
caller of blk_mq_get_request.

commit f888e1aa2cd2480ecc80bd67df5b5d3301408ac8
Author: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Date:   Tue Mar 24 15:11:38 2020 +0100

     blk-mq: remove unused argument from blk_mq_get_request

     We can remove 'bio' from blk_mq_get_request as well since
     prepare_request doesn't need it anymore.

     Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6a1725f7c319..a74c7710fc7d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -332,7 +332,6 @@ static struct request *blk_mq_rq_ctx_init(struct 
blk_mq_alloc_data *data,
  }

  static struct request *blk_mq_get_request(struct request_queue *q,
-                                         struct bio *bio,
                                           struct blk_mq_alloc_data *data)
  {
         struct elevator_queue *e = q->elevator;
@@ -408,7 +407,7 @@ struct request *blk_mq_alloc_request(struct 
request_queue *q, unsigned int op,
         if (ret)
                 return ERR_PTR(ret);

-       rq = blk_mq_get_request(q, NULL, &alloc_data);
+       rq = blk_mq_get_request(q, &alloc_data);
         blk_queue_exit(q);

         if (!rq)
@@ -457,7 +456,7 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q,
         cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
         alloc_data.ctx = __blk_mq_get_ctx(q, cpu);

-       rq = blk_mq_get_request(q, NULL, &alloc_data);
+       rq = blk_mq_get_request(q, &alloc_data);
         blk_queue_exit(q);

         if (!rq)
@@ -1988,7 +1987,7 @@ static blk_qc_t blk_mq_make_request(struct 
request_queue *q, struct bio *bio)
         rq_qos_throttle(q, bio);

         data.cmd_flags = bio->bi_opf;
-       rq = blk_mq_get_request(q, bio, &data);
+       rq = blk_mq_get_request(q, &data);
         if (unlikely(!rq)) {
                 rq_qos_cleanup(q, bio);
                 if (bio->bi_opf & REQ_NOWAIT)

Thanks,
Guoqing
