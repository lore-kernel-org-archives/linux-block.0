Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EDC433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 21:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15B964E7A
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 21:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhBIVvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:51:06 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36891 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhBIVH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 16:07:57 -0500
Received: by mail-oi1-f176.google.com with SMTP id y199so18948194oia.4
        for <linux-block@vger.kernel.org>; Tue, 09 Feb 2021 13:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iq8/ZgeqgaKeHpzc+K70RawUm9UDMRthE6hF9QeYZYQ=;
        b=Isj9EIPYodDZMDrojxy6wFtLQSXWXN7nw+YqPYC5hwg80YnUrR5Kz3y1JjEplam6R1
         MLn84YIc4QAxSY9/6bPZAWzolP2UykA6ur8H5C/Q+9sYpYevvPkaTLS7NFTsG3taqCF5
         PHQxcd6CK2p7Xq9CZ/f0iUyxgQqsY9tDj1B/Z8pm/38bbhIT2wC0AO0d8ufEqltsoRvu
         8AsWOU5WNb5XYAABk9nmyDLAQdhoqVHgBZPfaNu9Rvc9FMGd0v2fb5raQnWvdyUYc14w
         05cKJK+zQ8E2qCXpmXKuGTbZveINPC0kknjE8Kvl0e33duZFKAP8y/UoIydZA4gSgyBA
         yMFA==
X-Gm-Message-State: AOAM533Hium9+9Y/7TSvtbEEjX0MzgiSyn51TCzUNG50/Fw1iPCirRmR
        l1hbC9z9iW/YITJYXcJxE8Vp2NAgxb0=
X-Google-Smtp-Source: ABdhPJzfDNYVoZUsFJ4psb2NCXI3S4JznsGzCUt+B4N306WmYvCG4yZEEN3V7pKAqEU/tW9kLYwLJQ==
X-Received: by 2002:aca:48c:: with SMTP id 134mr3267246oie.16.1612893714659;
        Tue, 09 Feb 2021 10:01:54 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:fba0:f308:bf9a:df5c? ([2600:1700:65a0:78e0:fba0:f308:bf9a:df5c])
        by smtp.gmail.com with ESMTPSA id q3sm4386185oih.35.2021.02.09.10.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 10:01:54 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
Date:   Tue, 9 Feb 2021 10:01:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>>>> but did not succeed. Given that you have it 100% reproducible,
>>>> can you try to revert commit:
>>>>
>>>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>>>
>>>
>>> Revert this commit fixed the issue and I've attached the config. :)
>>
>> Hey Ming,
>>
>> Instead of revert, does this patch makes the issue go away?
> Hi Sagi
> 
> Below patch fixed the issue, let me know if you need more testing. :)

Thanks Yi,

I'll submit a proper patch, but can you run this change
to see what command has a bio but without any data?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 619b0d8f6e38..311f1b78a9d4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,8 +2271,13 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->data_len = blk_rq_nr_phys_segments(rq) ?
                                 blk_rq_payload_bytes(rq) : 0;
         req->curr_bio = rq->bio;
-       if (req->curr_bio)
+       if (req->curr_bio) {
+               if (!req->data_len) {
+                       pr_err("rq %d opcode %d\n", rq->tag, 
pdu->cmd.common.opcode);
+                       return BLK_STS_IOERR;
+               }
                 nvme_tcp_init_iter(req, rq_data_dir(rq));
+       }

         if (rq_data_dir(rq) == WRITE &&
             req->data_len <= nvme_tcp_inline_data_size(queue))
--
