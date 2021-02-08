Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9812AC433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567F464E8A
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 09:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhBHJ4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 04:56:23 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36725 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhBHJyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 04:54:20 -0500
Received: by mail-pl1-f182.google.com with SMTP id e9so7539470plh.3
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 01:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUVJHeNW9MlOneWkjHLNPQZJvynUxw9m2/BndYImcEM=;
        b=VuyKP3cqUyMFCBHO/AxYq+sb10qRQnnYNlYkHrj4Qb/qhaqrQgsuQwbnXZAtbB8Q3q
         FdncOG6R/vKqpWvRF9cN9yParFR27fgZcbX2Hj2KjfQR07biRX9QExFgIGQ9qLXBQbqI
         jZ0l9Db00WoHDq6hhQ/C5/iZ4nIAGwlKH5UrwY4wgyg4zeNZohY4OVIQ+J7Nnl/R/phI
         e1G12q6OyHY31htE2WOFwg1z0y+pNwnqR1LOG4PdGmTwJPJjkWfchTUsTXkvQb0e3Nl3
         TSTBWCidarhCkEr0ZsdyDDaAwpYrEqXzuNo6hgP1zKEyIUkSmzYFyKwVVR4ZMJCbl52Q
         YkAQ==
X-Gm-Message-State: AOAM5309DsKVN9an0B/tjzTumUi1b0WEPk1DxyRDySX/SDjSfa77kyj/
        h3cRszEx59ijblzJPFSK3Wc=
X-Google-Smtp-Source: ABdhPJyvkQUI5BBdMjcgNjXoHpmxxGnKjdGebgRKKTQHxNS5CsAeBE+CaYx/JKQEw3nW4W6tcs1MgQ==
X-Received: by 2002:a17:902:9b93:b029:e0:a40b:cbd7 with SMTP id y19-20020a1709029b93b02900e0a40bcbd7mr15373848plp.16.1612778019040;
        Mon, 08 Feb 2021 01:53:39 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a769:ced1:851:e710? ([2601:647:4802:9070:a769:ced1:851:e710])
        by smtp.gmail.com with ESMTPSA id j26sm17212441pfa.35.2021.02.08.01.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 01:53:38 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <BYAPR04MB4965E82FFD9D6FC443C8E67686B09@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <36f95b6a-bd50-eae8-ccd5-9a714c942c12@grimberg.me>
Date:   Mon, 8 Feb 2021 01:53:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E82FFD9D6FC443C8E67686B09@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/6/21 11:14 PM, Chaitanya Kulkarni wrote:
> Sagi,
> 
> On 2/5/21 19:19, Yi Zhang wrote:
>> Hello
>>
>> We found this kernel NULL pointer issue with latest linux-block/for-next and it's 100% reproduced, let me know if you need more info/testing, thanks
>>
>> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>
>> Reproducer: blktests nvme-tcp/012
>>
>>
>> [  124.458121] run blktests nvme/012 at 2021-02-05 21:53:34
>> [  125.525568] BUG: kernel NULL pointer dereference, address: 0000000000000008
>> [  125.532524] #PF: supervisor read access in kernel mode
>> [  125.537665] #PF: error_code(0x0000) - not-present page
>> [  125.542803] PGD 0 P4D 0
>> [  125.545343] Oops: 0000 [#1] SMP NOPTI
>> [  125.549009] CPU: 15 PID: 12069 Comm: kworker/15:2H Tainted: G S        I       5.11.0-rc6+ #1
>> [  125.557528] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
>> [  125.565093] Workqueue: kblockd blk_mq_run_work_fn
>> [  125.569797] RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
>> [  125.575544] Code: 8b 75 68 44 8b 45 28 44 8b 7d 30 49 89 d4 48 c1 e2 04 4c 01 f2 45 89 fb 44 89 c7 85 ff 74 4d 44 89 e0 44 8b 55 10 48 c1 e0 04 <41> 8b 5c 06 08 45 0f b6 ca 89 d8 44 29 d8 39 f8 0f 47 c7 41 83 e9
>> [  125.594290] RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246
>> [  125.599515] RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 0000000000000000
>> [  125.606648] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000002000000
>> [  125.613781] RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 0000000000000000
>> [  125.620914] R10: 0000000002800809 R11: 0000000000000000 R12: 0000000000000000
>> [  125.628045] R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 0000000000000000
>> [  125.635178] FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlGS:0000000000000000
>> [  125.643264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  125.649009] CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 00000000007706e0
>> [  125.656142] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  125.663274] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  125.670407] PKRU: 55555554
>> [  125.673119] Call Trace:
>> [  125.675575]  nvme_tcp_queue_rq+0xef/0x330 [nvme_tcp]
>> [  125.680537]  blk_mq_dispatch_rq_list+0x11c/0x7c0
>> [  125.685157]  ? blk_mq_flush_busy_ctxs+0xf6/0x110
>> [  125.689775]  __blk_mq_sched_dispatch_requests+0x12b/0x170
>> [  125.695175]  blk_mq_sched_dispatch_requests+0x30/0x60
>> [  125.700227]  __blk_mq_run_hw_queue+0x2b/0x60
>> [  125.704500]  process_one_work+0x1cb/0x360
>> [  125.708513]  ? process_one_work+0x360/0x360
>> [  125.712699]  worker_thread+0x30/0x370
>> [  125.716365]  ? process_one_work+0x360/0x360
>> [  125.720550]  kthread+0x116/0x130
>> [  125.723782]  ? kthread_park+0x80/0x80
>> [  125.727448]  ret_from_fork+0x1f/0x30
> The NVMe TCP does support merging for non-admin queues
> (nvme_tcp_alloc_tagset()).
> 
> Based on the what is been done for the bvecs in other places in
> kernel especially when merging is enabled bio split case seems to be
> missing from tcp when building bvec. What I mean is following
> completely untested patch :-
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 619b0d8f6e38..dabb2633b28c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -222,7 +222,9 @@ static void nvme_tcp_init_iter(struct
> nvme_tcp_request *req,
>           unsigned int dir)
>   {
>       struct request *rq = blk_mq_rq_from_pdu(req);
> -    struct bio_vec *vec;
> +    struct req_iterator rq_iter;
> +    struct bio_vec *vec, *tvec;
> +    struct bio_vec tmp;
>       unsigned int size;
>       int nr_bvec;
>       size_t offset;
> @@ -233,17 +235,29 @@ static void nvme_tcp_init_iter(struct
> nvme_tcp_request *req,
>           size = blk_rq_payload_bytes(rq);
>           offset = 0;
>       } else {
> -        struct bio *bio = req->curr_bio;
> -        struct bvec_iter bi;
> -        struct bio_vec bv;
> -
> -        vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> -        nr_bvec = 0;
> -        bio_for_each_bvec(bv, bio, bi) {
> +        rq_for_each_bvec(tmp, rq, rq_iter)
>               nr_bvec++;
> +
> +        if (rq->bio != rq->biotail) {
> +            vec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
> +                    GFP_NOIO);
> +            if (!vec)
> +                return;
> +
> +            tvec = vec;
> +            rq_for_each_bvec(tmp, rq, rq_iter) {
> +                *vec = tmp;
> +                vec++;
> +            }
> +            vec = tvec;
> +            offset = 0;
> +        } else {
> +            struct bio *bio = req->curr_bio;
> +
> +            vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> +            size = bio->bi_iter.bi_size;
> +            offset = bio->bi_iter.bi_bvec_done;
>           }
> -        size = bio->bi_iter.bi_size;
> -        offset = bio->bi_iter.bi_bvec_done;
>       }
>   
>       iov_iter_bvec(&req->iter, dir, vec, nr_bvec, size);
> @@ -2271,8 +2285,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct
> nvme_ns *ns,
>       req->data_len = blk_rq_nr_phys_segments(rq) ?
>                   blk_rq_payload_bytes(rq) : 0;
>       req->curr_bio = rq->bio;
> -    if (req->curr_bio)
> +    if (req->curr_bio) {
> +        if (rq->bio != rq->biotail)
> +            printk(KERN_INFO"%s %d req->bio != req->biotail\n",
> __func__, __LINE__);
>           nvme_tcp_init_iter(req, rq_data_dir(rq));
> +    }
>   
>       if (rq_data_dir(rq) == WRITE &&
>           req->data_len <= nvme_tcp_inline_data_size(queue))
> 

That cannot work, nvme-tcp basically will initialize the iter based
on the request bios, as it iterates it may continue if the request
spans more bios. We could change that, but this would mean we need to
allocate in the fast path which is something I'd prefer to avoid.
This is a regression so it must be coming from one of the latest
patches, so that should be addressed.
