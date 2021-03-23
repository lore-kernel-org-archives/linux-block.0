Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E395CC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971E2619B7
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCWHbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:31:44 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38647 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCWHbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 03:31:34 -0400
Received: by mail-pg1-f173.google.com with SMTP id l1so10794404pgb.5
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 00:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9eHXV6zSRozwt4aPaor2MdVhMcc8OF3oYeMa61Rg2hA=;
        b=gvSon4+sKT8PDwvmTEu8Q8s6Don0t7UX/hogpmrRqa9Us82Dj+qILunanTLqF70vEw
         BPZS++3WKPNqSDz5pS9ILpTNUsbr7Aslj/gy50PIsB0G6qolMD1osHLxKqfxxi+zNl+f
         PBM++RZSGiiwahAYmCaUs/fmK8wJcX7MjwUaRe3wYKk+UILGSvD6znonVUEmL/FlZCP0
         geBMwRFttMP3K4pZAyyHlerMby6cibd79MmC8m1KgTbY1NyXJ+ym4rwYWs5eY78YP3LD
         /ocDDxj0zjkyssmOrCmrylG7sDW4q3CULfBNGle/UWA+E4+t4rWNMxOt1wcsv7l3aVyS
         eRAw==
X-Gm-Message-State: AOAM532F7n3rKMck9dB+f1EAafZkQ8tqTAdw54f2vEZzuIuOWj6vyss7
        yCIxp78KkYcL4AnJlspnsN4=
X-Google-Smtp-Source: ABdhPJzQfuWmWG6KuZHhFNNhRI6/U2y0eiUntBmspkspNqZDpazCv9k+z5S+JVvsXvV8LYhogIlfzw==
X-Received: by 2002:a62:7b83:0:b029:1f1:5ef3:b4d9 with SMTP id w125-20020a627b830000b02901f15ef3b4d9mr3617710pfc.65.1616484693970;
        Tue, 23 Mar 2021 00:31:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0? ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
        by smtp.gmail.com with ESMTPSA id w203sm15819900pff.59.2021.03.23.00.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 00:31:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
Date:   Tue, 23 Mar 2021 00:31:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Actually, I had been playing around with marking the entire bio as 
> 'NOWAIT'; that would avoid the tag stall, too:
> 
> @@ -313,7 +316,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>          ns = nvme_find_path(head);
>          if (likely(ns)) {
>                  bio_set_dev(bio, ns->disk->part0);
> -               bio->bi_opf |= REQ_NVME_MPATH;
> +               bio->bi_opf |= REQ_NVME_MPATH | REQ_NOWAIT;
>                  trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>                                        bio->bi_iter.bi_sector);
>                  ret = submit_bio_noacct(bio);
> 
> 
> My only worry here is that we might incur spurious failures under high 
> load; but then this is not necessarily a bad thing.

What? making spurious failures is not ok under any load. what fs will
take into account that you may have run out of tags?
