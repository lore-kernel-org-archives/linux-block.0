Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F778C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11828619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhCWQym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:54:42 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:38707 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhCWQyj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:54:39 -0400
Received: by mail-pj1-f46.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso12416789pji.3
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rhue+PMD7lcSwRDm9/LSgaFj1hwON71pQSCOJMu7TnU=;
        b=rB4eE0gWNiiUwHPjSmDcQMdHSj3eYqV6KqPCD4Fjg9obd80zRYam0KDIocOz794vj5
         M7xU1RBRcuMfeyFVpb/HDOkSE9jIDbJBs6ODzH16Q3rk8/5ESKxZvJdhDhC8VdWfHxdh
         RhTQpxtS5jcbOIXL3xB7GGJbWpsZumdFixj3OfcTIguo6IdoCWHO1KuXXZPWrf8+osUT
         Y46oxWecFaLqdNbLNe8apPEBTsSRnHiWAg54IjoYv2jL1nKLD3j+udl80BHQAIBdvIHX
         h55OWsyilfIChWqIp48MNEktIHxc8Z9abBefE4+9kO60HoV35IzFEs61Pv1tQkO2TUmJ
         Ct5A==
X-Gm-Message-State: AOAM531H6m9e38QVUpvmsS1AyWvmfdfC+xwzx3dzbN87SgwJ5P+X7QkT
        rxcoDmkPmtySPqFcpWsDAd0=
X-Google-Smtp-Source: ABdhPJxY+14Wg+F4KFF0Ga187ZpMTeiwsNYv3efM2W0n+lG4Hozh9MYnONdsI0gUQGXcJbl+9hlENQ==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr5329699pjs.219.1616518478881;
        Tue, 23 Mar 2021 09:54:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9? ([2601:647:4802:9070:3b29:de57:36aa:67b9])
        by smtp.gmail.com with ESMTPSA id d124sm17690803pfa.149.2021.03.23.09.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:54:38 -0700 (PDT)
Subject: Re: [RFC PATCH V2 09/13] block: use per-task poll context to
 implement bio based io poll
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-10-ming.lei@redhat.com>
 <522a2c87-e9f3-e62a-e09b-084821c698a0@grimberg.me> <YFnYhBIiFhiyX8Wb@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <713f2a27-4a2c-8723-3dfd-de6d68956eb2@grimberg.me>
Date:   Tue, 23 Mar 2021 09:54:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFnYhBIiFhiyX8Wb@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
>>> +{
>>> +	bio->bi_iter.bi_private_data = cookie;
>>> +}
>>> +
>>
>> Hey Ming, thinking about nvme-mpath, I'm thinking that this should be
>> an exported function for failover. nvme-mpath updates bio.bi_dev
>> when re-submitting I/Os to an alternate path, so I'm thinking
>> that if this function is exported then nvme-mpath could do as little
>> as the below to allow polling?
>>
>> --
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 92adebfaf86f..e562e296153b 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -345,6 +345,7 @@ static void nvme_requeue_work(struct work_struct *work)
>>          struct nvme_ns_head *head =
>>                  container_of(work, struct nvme_ns_head, requeue_work);
>>          struct bio *bio, *next;
>> +       blk_qc_t cookie;
>>
>>          spin_lock_irq(&head->requeue_lock);
>>          next = bio_list_get(&head->requeue_list);
>> @@ -359,7 +360,8 @@ static void nvme_requeue_work(struct work_struct *work)
>>                   * path.
>>                   */
>>                  bio_set_dev(bio, head->disk->part0);
>> -               submit_bio_noacct(bio);
>> +               cookie = submit_bio_noacct(bio);
>> +               blk_bio_poll_post_submit(bio, cookie);
>>          }
>>   }
>> --
>>
>> I/O failover will create misalignment from the polling context cpu and
>> the submission cpu (running requeue_work), but I don't see if there is
>> something that would break here...
> 
> I understand requeue shouldn't be one usual event, and I guess it is just
> fine to fallback to IRQ based mode?

Well, when it will failover, it will probably be directed to the poll
queues. Maybe I'm missing something...

> This patchset actually doesn't cover such bio submission from kernel context.

What is the difference?
