Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06268C77B73
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjEXSWK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjEXSWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 14:22:10 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C7D13A
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:22:02 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ae408f4d1aso4662885ad.0
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952521; x=1687544521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMqRi4zfVFJs3DdZ4gwAIlvlCBOiYCU78XiruzfGRU4=;
        b=UkD2RrUWJrT0HfieHR9rMQkv8g0aY5D/igHl4zC29EdlDBVJ/NhBqHQ6mcP3XQw5fo
         hFhhUVeh1OgwMtjGo28gpfvO5AlEylPekWHSk5aNyYdMUoBNd3yJHX7TvD0iB0aIO1Fv
         HbJrNxwhU2lQO7rqc/QH3by6t5lckQ4ZMNfrihtGOb2iTGAkrlz1NOn3lwEzBx0v4M6M
         SFlFb3+o22xyBSzL1m5/kKodxh120nII8Nx35CN8CCO4z+2McmXQzBuOZxdW1zzIn5fa
         HQUtZSqCXEcQz87sDS3MatMQaDD6YxtMPPT4uClh7en8St63Vr0Z0Tk5XnfIcygXosC5
         Nybg==
X-Gm-Message-State: AC+VfDzM6RRo0+hgj8/X5W/bjiz7oxqGoz23BmMmacmCw7pYjbWwAbzx
        ZfB6PA6fOIAPjLXpnTJdxGU=
X-Google-Smtp-Source: ACHHUZ56TEYD76XzOBTaKghjffUwOK10mU66EjrWyfCmOUuu3lJRXO76MkuSqj5J7wRMDK0Q83EbhA==
X-Received: by 2002:a17:902:eccc:b0:1af:db10:333b with SMTP id a12-20020a170902eccc00b001afdb10333bmr4752374plh.59.1684952521590;
        Wed, 24 May 2023 11:22:01 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001ab25a19cfbsm9006273plo.139.2023.05.24.11.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:22:01 -0700 (PDT)
Message-ID: <3e4dc15a-1117-1122-1d9d-746aef55ef95@acm.org>
Date:   Wed, 24 May 2023 11:22:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org> <20230523071835.GB8758@lst.de>
 <639fa0ac-e7b9-2ba7-3d68-3fe1a501e779@acm.org>
 <20230524061300.GD19611@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230524061300.GD19611@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 23:13, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 03:30:16PM -0700, Bart Van Assche wrote:
>>   static inline void blk_mq_sched_requeue_request(struct request *rq)
>>   {
>> -	if (rq->rq_flags & RQF_USE_SCHED) {
>> -		struct request_queue *q = rq->q;
>> -		struct elevator_queue *e = q->elevator;
>> -
>> -		if (e->type->ops.requeue_request)
>> -			e->type->ops.requeue_request(rq);
>> -	}
>> +	if (rq->rq_flags & RQF_USE_SCHED)
>> +		rq->rq_flags |= RQF_REQUEUED;
>>   }
> 
> I'd drop this helper function if we go down this way.  But maybe
> we might just want to keep the method.

My understanding is that every .requeue_request() call is followed by a 
.insert_requests() call and hence that we don't need the 
.requeue_request() method anymore if the RQF_REQUEUED flag would be 
introduced?

Thanks,

Bart.
