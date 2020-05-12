Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41927C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2896120675
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgELBZa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 21:25:30 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:33502 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgELBZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 21:25:30 -0400
Received: by mail-pl1-f180.google.com with SMTP id t7so4684037plr.0
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 18:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=JzwhTAFsOYwsoYlNPre3Jv++o+SYjuTWIoWMlLjzA8w=;
        b=Gr79OjXDBd8Js4mc+G7CzQyi1CFpXW0XmEN8e5dHNXgcpevmLxPC6PtkTKGRWVWqKy
         YPfKBIRLZBtD9pvKXLymG3KPxyuRpfzmuee1xnLba7UUHzQcLBniKgD6eCxFrkKEVcl1
         Qq/KNHHbgkwbb9nKHhF1nobI+BDVRe1A+sl1G3sQmd7xqsNnVBPY5fYUSizKVM5UfcnT
         YH4TR75T4qR50wo4SIJproBBGZECwvmG2x9nnJqViynAwPFOFbHl5T17KqGZjHUiwXwV
         tLLFPsL/NEgGZxKmOUB62oogJFHhlIHjqBIlb4qmkpOgGop/GhyY1In1v827i+Z/bm3Y
         d1Pw==
X-Gm-Message-State: AGi0Pua6TMw4e+NFfACYTXYGjDtKpzX84j+u7Jwm23dOJqzVXrtzxjsH
        05X0+fX2qZLuJshC7CWwgq0=
X-Google-Smtp-Source: APiQypJyi759jMjG7FShKiMNezndA+RIHq7mGgV6DfsGrFKyF6/oj7vh5RhzebG9Ue5o20HQyCSuIw==
X-Received: by 2002:a17:90b:ecf:: with SMTP id gz15mr28005940pjb.208.1589246728966;
        Mon, 11 May 2020 18:25:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c4e5:b27b:830d:5d6e? ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id s44sm11521240pjc.28.2020.05.11.18.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 18:25:27 -0700 (PDT)
Subject: Re: null_handle_cmd() doesn't initialize data when reading
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
 <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
 <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
 <55674c05-37dc-0646-af78-db4c3b112683@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <1e455c9f-4908-f476-f674-c0c920c17f9c@acm.org>
Date:   Mon, 11 May 2020 18:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <55674c05-37dc-0646-af78-db4c3b112683@acm.org>
Content-Type: multipart/mixed;
 boundary="------------F24AFD384831367C72655FDD"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------F24AFD384831367C72655FDD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 2020-05-11 16:18, Bart Van Assche wrote:
> Anyway, can you give the patch below a try?

The patch in my previous email handles MQ mode but not bio mode. The
attached patch should handle both.

Thanks,

Bart.

--------------F24AFD384831367C72655FDD
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-null_blk-Zero-initialize-read-buffers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-null_blk-Zero-initialize-read-buffers.patch"

From f3fcdf9000226dc1354557eae53d4541d4059d03 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 11 May 2020 15:21:02 -0700
Subject: [PATCH] null_blk: Zero-initialize read buffers

---
 drivers/block/null_blk_main.c | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 06f5761fccb6..39dd82683e10 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1250,8 +1250,53 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }
 
+static void nullb_zero_bvec(const struct bio_vec *bvec)
+{
+	struct page *page = bvec->bv_page;
+	u32 offset = bvec->bv_offset;
+	u32 left = bvec->bv_len;
+
+	while (left) {
+		u32 len = min_t(u32, left, PAGE_SIZE - offset);
+		void *kaddr;
+
+		kaddr = kmap_atomic(page);
+		memset(kaddr + offset, 0, len);
+		kunmap_atomic(kaddr);
+		page++;
+		left -= len;
+		offset = 0;
+	}
+}
+
+static void nullb_zero_bio_data_buffer(struct bio *bio)
+{
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+
+	bio_for_each_bvec(bvec, bio, iter)
+		nullb_zero_bvec(&bvec);
+}
+
+static void nullb_zero_rq_data_buffer(const struct request *rq)
+{
+	struct req_iterator iter;
+	struct bio_vec bvec;
+
+	rq_for_each_bvec(bvec, rq, iter)
+		nullb_zero_bvec(&bvec);
+}
+
+/* Complete a request. Only called if dev->memory_backed == 0. */
 static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 {
+	struct nullb_device *dev = cmd->nq->dev;
+
+	if (dev->queue_mode == NULL_Q_BIO && bio_op(cmd->bio) == REQ_OP_READ)
+		nullb_zero_bio_data_buffer(cmd->bio);
+	else if (req_op(cmd->rq) == REQ_OP_READ)
+		nullb_zero_rq_data_buffer(cmd->rq);
+
 	/* Complete IO by inline, softirq or timer */
 	switch (cmd->nq->dev->irqmode) {
 	case NULL_IRQ_SOFTIRQ:

--------------F24AFD384831367C72655FDD--
