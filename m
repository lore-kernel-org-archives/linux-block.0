Return-Path: <SRS0=vxC1=ZJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2968FC432C3
	for <linux-block@archiver.kernel.org>; Sun, 17 Nov 2019 01:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F335B2075E
	for <linux-block@archiver.kernel.org>; Sun, 17 Nov 2019 01:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfKQBYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 20:24:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44040 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfKQBYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 20:24:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so8499057pfn.11
        for <linux-block@vger.kernel.org>; Sat, 16 Nov 2019 17:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KPxl3u7L3GlcXlM/9wrTnePSjY0GXz3o+xu74TyxWHs=;
        b=km0or/O/WMGS3e9JSlSDlT2z68zpXkNkDZwGsvzoN1kS+LYA7menXIeN/v6WqAbX5N
         0sP9BzxAc4Rohnu/SlhVSwhfT7qEw2Fpu0frOwGgMMLdHOF377pPAAOPqDd3IZjXvzLv
         J69h7j6CYgngT18rzGCyroJZWwL40Mgbl9E/U9bSRHFAzwxg9UvagVEd4CJxfxtfcN/H
         ZD3G0EovL/dqqCs/wW5Mi4xbWcsdSYAQYhFBFnBl6v9NDjRMxMasXywFjS5KuAsG8q/Y
         ZBtkRFm7qNH/YnL2IDx5SA6EpatHOydWEbOU0uKkipQ5iYRcjyF9XBuEubUdTkaoowni
         fq7w==
X-Gm-Message-State: APjAAAXxdP/lGHK/406TyPdbSaLTvnrSxwlO0kgRoA+PJMw11ZubM4W6
        cSLFJeg69euAX7BHIOov9cU=
X-Google-Smtp-Source: APXvYqwjb/2YyfbelUeebQr0cWH3xh60cFuARPf/yu3Cv5vcIiEftPwkhkzUWd0B2UsfoT4gqAsOSA==
X-Received: by 2002:a63:b49:: with SMTP id a9mr11864pgl.386.1573953847960;
        Sat, 16 Nov 2019 17:24:07 -0800 (PST)
Received: from ?IPv6:2601:647:4000:a8:25f9:8344:b76c:ad19? ([2601:647:4000:a8:25f9:8344:b76c:ad19])
        by smtp.gmail.com with ESMTPSA id n23sm14569252pff.137.2019.11.16.17.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2019 17:24:06 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
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
Message-ID: <4a39a98e-19bc-0a9a-3d92-ceab2c656037@acm.org>
Date:   Sat, 16 Nov 2019 17:24:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191116071754.GB18194@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-11-15 23:17, Ming Lei wrote:
> Now blk-mq takes a static queue mapping between CPU and hw queues, given
> CPU hotplug may happen any time, so the specified hw queue may become
> inactive any time.

Hi Ming,

I can trigger a race between blk_mq_alloc_request_hctx() and
CPU-hotplugging by running blktests. The patch below fixes that race
on my setup. Does this patch also fix the race(s) that you ran into?

Thanks,

Bart.


Subject: [PATCH] blk-mq: Fix a race between blk_mq_alloc_request_hctx() and
 CPU hot-plugging

---
 block/blk-mq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 20a71dcdc339..16057aa2307f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -442,13 +442,15 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
 		return ERR_PTR(-EINVAL);

-	if (hctx_idx >= q->nr_hw_queues)
-		return ERR_PTR(-EIO);
-
 	ret = blk_queue_enter(q, flags);
 	if (ret)
 		return ERR_PTR(ret);

+	if (hctx_idx >= q->nr_hw_queues) {
+		blk_queue_exit(q);
+		return ERR_PTR(-EIO);
+	}
+
 	/*
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
