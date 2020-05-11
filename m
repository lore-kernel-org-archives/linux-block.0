Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E10DC54E4A
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8762078E
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 23:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgEKXTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 19:19:04 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40000 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEKXTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 19:19:04 -0400
Received: by mail-pj1-f66.google.com with SMTP id fu13so8483655pjb.5
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 16:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DRsLRT0udoV+ohvAtfy/CdrVVKmjRrJDJALk4t8Iff8=;
        b=CUFDiXo5uSwMEgbtprvKz2QcHVsC25E6g04TsOiNKecuxYmY+pfaBUIQDoUdM4WDEQ
         C82SU9xS2FUUfm3DzJRMQEKoVHhvAM/nCfy28rzDfoL+ozyBxWWFBf6/O9B9CDCM5olG
         GmJ1/+vyunMyB7IPK/Sqja9cKS54H5ciSHdd/efpzsxlJfHsHyiMC6EWBxZDsDbvOrBg
         /B318e5Ev71wkUvC8WvfhmsYDEJkJHUFT/HD3kd++71XVZPpUB1s8YSB2oT9Yn6sVQn+
         CBezs24Hts32kEzQ9cxv78BD3oFqxGZlE71znpcHJo18my+QQMyDumJc5qjmN6v0mHs9
         us+w==
X-Gm-Message-State: AGi0PuZo+FnmB1Ca6g9+FmDYj1EZeatj+vFHFci+Az3PhXYVS25X92b+
        DXoCCFTAekTyDRrxN9v4cfY=
X-Google-Smtp-Source: APiQypJYLWKbvY2RzLs1Wuyv1hUTfIXfyCqYBESKMWL7et0YiI43iJD2BCgYYd96Ltb6YZiTKO+I1g==
X-Received: by 2002:a17:90a:1181:: with SMTP id e1mr26661260pja.234.1589239142834;
        Mon, 11 May 2020 16:19:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c4e5:b27b:830d:5d6e? ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id w69sm10156405pff.168.2020.05.11.16.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 16:19:01 -0700 (PDT)
Subject: Re: null_handle_cmd() doesn't initialize data when reading
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
From:   Bart Van Assche <bvanassche@acm.org>
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
Message-ID: <55674c05-37dc-0646-af78-db4c3b112683@acm.org>
Date:   Mon, 11 May 2020 16:18:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-11 05:58, Alexander Potapenko wrote:
> On Sun, May 10, 2020 at 6:20 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 2020-05-10 03:03, Alexander Potapenko wrote:
>>> Thanks for the explanation!
>>> The code has changed recently, and my patch does not apply anymore,
>>> yet the problem still persists.
>>> I ended up just calling null_handle_rq() at the end of
>>> null_process_cmd(), but we probably need a cleaner fix.
>>
>> Does this (totally untested) patch help? copy_to_nullb() guarantees that
>> it will write some data to the pages that it allocates but does not
>> guarantee yet that all data of the pages it allocates is initialized.
> 
> No, this does not help. Apparently null_insert_page() is never called
> in this scenario.
> If I modify __page_cache_alloc() to allocate zero-initialized pages,
> the reports go away.
> This means there's no other uninitialized buffer that's copied to the
> page cache, the nullb driver just forgets to write anything to the
> page cache.

Hi Alexander,

I had misread the email at the start of this thread. My patch only
affects the "memory backed" mode while the email at the start of this
thread explains that the KMSAN report refers to the memory_backed == 0
mode. Anyway, can you give the patch below a try?

Thanks,

Bart.


diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 06f5761fccb6..682b38ccef57 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1250,8 +1250,36 @@ static inline blk_status_t
null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }

+static void nullb_zero_data_buffer(const struct request *rq)
+{
+	struct req_iterator iter;
+	struct bio_vec bvec;
+	struct page *page;
+	void *kaddr;
+	u32 offset, left, len;
+
+	rq_for_each_bvec(bvec, rq, iter) {
+		page = bvec.bv_page;
+		offset = bvec.bv_offset;
+		left = bvec.bv_len;
+		while (left) {
+			kaddr = kmap_atomic(page);
+			len = min_t(u32, left, PAGE_SIZE - offset);
+			memset(kaddr + offset, 0, len);
+			kunmap_atomic(kaddr);
+			page++;
+			left -= len;
+			offset = 0;
+		}
+	}
+}
+
+/* Complete a request. Only called if dev->memory_backed == 0. */
 static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 {
+	if (req_op(cmd->rq) == REQ_OP_READ)
+		nullb_zero_data_buffer(cmd->rq);
+
 	/* Complete IO by inline, softirq or timer */
 	switch (cmd->nq->dev->irqmode) {
 	case NULL_IRQ_SOFTIRQ:
