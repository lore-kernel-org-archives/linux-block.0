Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A887C43461
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5581620BED
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 20:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIUxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:53:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37453 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgIIUxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Sep 2020 16:53:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id w7so3240867pfi.4
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2020 13:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ScU0r+gXwX86iZJWxxwUa2WSn8lrc4iNy9X+IZrvWE=;
        b=l8uIxtjekcDYa1SjyLEV50kc9z1iVOKe1+1iUYYtMBET3o+XtdjLO7jCIVCLbYJi/3
         /Wuc6wBUL1AR/EiyrnteFXVuW7gO/T0LaXSDocGUb2ezoL6U3X9/I8gSHLD/jgnWp2Zp
         4/Yzf+S17vcRxNcfliRfmu5rOqwUEItCsIYzPPj8Cm6tpKwFJKrN+E26M5xDH4P7q5gL
         4D8ibIlfQV0/IV9BM0brPjpYNJBAh5lys0aZ10yx+gQbSj5pV/CGO4mYlAILirctItfe
         qqoz/R8DK5jTKrqcMQ5hxO6bx1LbLsMpGqBqQwgEbLijuQTiDfPb8WRTAIXXFvW6K3WP
         elxQ==
X-Gm-Message-State: AOAM5324mgbkjk6trMFGsV6HgO4kW8AgS7S+JFrvXbiSJrKdRmI26+RR
        OvOpXmRkRngHRErh38HCxr4=
X-Google-Smtp-Source: ABdhPJxknxzrUZz+JsVrvs8r5KVsMgkBl0lLFEQip7Npd4GkgYxJqjD0FHImdhYtZaEBEUv6fAOASw==
X-Received: by 2002:a63:5663:: with SMTP id g35mr1943565pgm.163.1599684812840;
        Wed, 09 Sep 2020 13:53:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5905:3209:6aa:d817? ([2601:647:4802:9070:5905:3209:6aa:d817])
        by smtp.gmail.com with ESMTPSA id u2sm108640pji.50.2020.09.09.13.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 13:53:32 -0700 (PDT)
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dae73b2c-c191-c8a6-4287-838ab4962467@grimberg.me>
Date:   Wed, 9 Sep 2020 13:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>   void blk_mq_quiesce_queue(struct request_queue *q)
>>   {
>> -	struct blk_mq_hw_ctx *hctx;
>> -	unsigned int i;
>> -	bool rcu = false;
>> +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
>> +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
>>   
>> -	__blk_mq_quiesce_queue_nowait(q);
>> +	if (!was_quiesced && blocking)
>> +		percpu_ref_kill(&q->dispatch_counter);
>>   
>> -	queue_for_each_hw_ctx(q, hctx, i) {
>> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
>> -			synchronize_srcu(hctx->srcu);
>> -		else
>> -			rcu = true;
>> -	}
>> -	if (rcu)
>> +	if (blocking)
>> +		wait_event(q->mq_quiesce_wq,
>> +				percpu_ref_is_zero(&q->dispatch_counter));
>> +	else
>>   		synchronize_rcu();
>>   }
> 
> In the previous version, you had ensured no thread can unquiesce a queue
> while another is waiting for quiescence. Now that the locking is gone,
> a thread could unquiesce the queue before percpu_ref reaches zero, so
> the wait_event() may never complete on the resurrected percpu_ref.

Yea, where did that go?
