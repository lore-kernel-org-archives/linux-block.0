Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B97BC433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 03:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4388761445
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 03:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhDVDzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 23:55:07 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:38666 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDVDzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 23:55:07 -0400
Received: by mail-pg1-f175.google.com with SMTP id w10so31908337pgh.5
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 20:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0GPld9gZM6QCZw7uMJ7EaQFQMbW/T90wzQnT565wXg=;
        b=JU4nNrDP5Kj7xyz0Z7OcBz429PFFcOFKbio7lQGdSgFiqxEaSaWzOYAsJ9SEtBwfCu
         l3jm4abppIH7bw4RVx0R8ATD6bSS9kqPjJxyBcYbZ1jOXdqOG2HocjpuGeNZgxrCTYF3
         yK/q3cWCf6uXZ7ZzgCiwlw8hiGNSr56hqudoF21fPbnqohSh5C+jXjWBzQkvBUzI2/+/
         TFpu+c3YtVq0DvQsI+Hby93fTGjvCR3o9qWfAypc5m5UQPsKlhzqXwy/Feuh2TKYt4dY
         xoAErnQdS53KOGcTdPJtfgGkwQitlob6qGFtMUPrSry41H07oCVI86lSAulb9LIXgKka
         k7nQ==
X-Gm-Message-State: AOAM53082yeoK1naol+96Vm2E6tgLe6JZuvaODmM70KmiGyHvAppaeME
        EYYOZ0y6bLsDkRXnDknV9Mo=
X-Google-Smtp-Source: ABdhPJy9Hem/czLyWK70h8/P2p5xPoo2I4kiQ4m3loTu8MSzwRx11dA9W5VozMSHhvYoEyoRhDjHXg==
X-Received: by 2002:a63:190b:: with SMTP id z11mr1452922pgl.314.1619063672973;
        Wed, 21 Apr 2021 20:54:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:bce0:5b8f:12:4649? ([2601:647:4000:d7:bce0:5b8f:12:4649])
        by smtp.gmail.com with ESMTPSA id ch21sm3386255pjb.8.2021.04.21.20.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 20:54:32 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
References: <20210421000235.2028-1-bvanassche@acm.org>
 <20210421000235.2028-4-bvanassche@acm.org> <YIDqa6YkNoD5OiKN@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b717ffc0-a434-738f-9c63-32901bd164b2@acm.org>
Date:   Wed, 21 Apr 2021 20:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIDqa6YkNoD5OiKN@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 8:15 PM, Ming Lei wrote:
> On Tue, Apr 20, 2021 at 05:02:33PM -0700, Bart Van Assche wrote:
>> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>> +{
>> +	struct bt_tags_iter_data *iter_data = data;
>> +	struct blk_mq_tags *tags = iter_data->tags;
>> +	bool res;
>> +
>> +	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
>> +		down_read(&tags->iter_rwsem);
>> +		res = __bt_tags_iter(bitmap, bitnr, data);
>> +		up_read(&tags->iter_rwsem);
>> +	} else {
>> +		rcu_read_lock();
>> +		res = __bt_tags_iter(bitmap, bitnr, data);
>> +		rcu_read_unlock();
>> +	}
>> +
>> +	return res;
>> +}
> 
> Holding one rwsem or rcu read lock won't avoid the issue completely
> because request may be completed remotely in iter_data->fn(), such as
> nbd_clear_req(), nvme_cancel_request(), complete_all_cmds_iter(),
> mtip_no_dev_cleanup(), because blk_mq_complete_request() may complete
> request in softirq, remote IPI, even wq, and the request is still
> referenced in these contexts after bt_tags_iter() returns.

The rwsem and RCU read lock are used to serialize iterating over
requests against blk_mq_sched_free_requests() calls. I don't think it
matters for this patch from which context requests are freed.

Bart.
