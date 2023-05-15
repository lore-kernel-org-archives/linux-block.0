Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC7C77B75
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 15:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjEOPwo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbjEOPwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 11:52:41 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6BE4A
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 08:52:40 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so21867273b3a.0
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 08:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684165960; x=1686757960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRxqXwTKU8nyNetGup6U7DpBcXOVrDZfvUacoZzhZJA=;
        b=axAx/GDcCCV9LDeyz6hWiLBc+CRnnxSoNAdtQFWeCDc7rGPdeKr6DrN/2gzyOwfGc4
         lOe2RviybrUkURNXUmORhoG/3l5kl6oCywo5aQXGLAObobviHhidMVAQS4fU/ZaFitux
         Aws/ac3ezEeBywKPawGPK67ouK6f4/4x1+puiAuunwrM09v7eL3+Nl1nNO2UnCg64z/Q
         GRtKDS38v0kxUX8EoFIEyzUOBc/Bgup1l5w9SxOQxNRF7WNzOEtKrdY7zxSxSZTjqUyq
         ppSJIDW++e5zEBeVnBLJp9dlLWDWa7hBiW1fg+HFv5ahfKpm7ZzSzseaUoDvcDt1IkQh
         sVNA==
X-Gm-Message-State: AC+VfDxw3Cbr2clD3f5iBeAeDkoT0SFNewqfPhEXtSr/rSEWxEweVClb
        d0eNDj6Ijr2/jBahcJgvl9jDQ5A5/Ig=
X-Google-Smtp-Source: ACHHUZ4Gs3zf3/2hvWcZkCmAiWSCapaaIUaPJ/oFowUq9q8b8XyW1Xxzeu8r4g7Vqoxjcvos0L5NeA==
X-Received: by 2002:a17:903:48e:b0:1a9:4cd5:e7e0 with SMTP id jj14-20020a170903048e00b001a94cd5e7e0mr40089642plb.17.1684165959679;
        Mon, 15 May 2023 08:52:39 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b001ac4e316b51sm9360334plg.109.2023.05.15.08.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:52:39 -0700 (PDT)
Message-ID: <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
Date:   Mon, 15 May 2023 08:52:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't called
 for passthrough request
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230515144601.52811-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/23 07:46, Ming Lei wrote:
> @@ -48,7 +53,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
>   
>   static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
>   {
> -	if (rq->rq_flags & RQF_ELV) {
> +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
>   		struct elevator_queue *e = rq->q->elevator;
>   
>   		if (e->type->ops.completed_request)
> @@ -58,7 +63,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
>   
>   static inline void blk_mq_sched_requeue_request(struct request *rq)
>   {
> -	if (rq->rq_flags & RQF_ELV) {
> +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
>   		struct request_queue *q = rq->q;
>   		struct elevator_queue *e = q->elevator;

Has it been considered not to set RQF_ELV for passthrough requests 
instead of making the above changes?

Thanks,

Bart.
