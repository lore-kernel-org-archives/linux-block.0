Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F50C2BA83
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 03:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F30208C4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 03:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJDOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:14:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41765 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJDOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Feb 2020 22:14:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so2229506plr.8;
        Sun, 09 Feb 2020 19:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qXsmkb1TsjdBw0UvR6UmaPwQwtinUxv/u1zxJ8T/XrA=;
        b=sEOkN3+bX+GYzn2VFHwOeefOHHgaLD7ZKu7W9PSBjLKTKlzMA97dF4qYOL3tpYkgU+
         IxItM3VDQx7UHbMFyObuqfdIenhcGNAMIlA+XqRK4sGfGLuDd25nC59bdr3fZNB5slVl
         m4RmQ+CIrb/AB7l2+RwJe4o/8YXntThBkQ5HwD2f2TsXR4Z1maZdpo152/02KGbR7pHc
         aLjEVjMESbx5c5U56NyPENusRO+LurYu6m4LHwHvQ4gYNf+taajXIqiUkmv3oxXTkUaw
         dle2UcglPd0Wp5G2OH8hK5MDprAjSoveJFqt3sdgzj9m6hzihf7llz87AAvvB6bbyvJr
         jCWA==
X-Gm-Message-State: APjAAAXsGs41xU2z4kvpG7D3C7A20+zQUlDsxHjhzT62x9FdrmAMjq7U
        eCTHqAFc0l37IL2wPtGhQOg=
X-Google-Smtp-Source: APXvYqwwBxy0kgPEHY12+elCLszn3JcJXZNeoesY4YF8gu/a0K3z1h+sQS7DOWfiDLIghDtRYwtPjQ==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr17852520pjt.88.1581304491531;
        Sun, 09 Feb 2020 19:14:51 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:20b3:5fd0:4962:3980? ([2601:647:4000:d7:20b3:5fd0:4962:3980])
        by smtp.gmail.com with ESMTPSA id h7sm10153876pgc.69.2020.02.09.19.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 19:14:50 -0800 (PST)
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, dhowells@redhat.com, asml.silence@gmail.com,
        ajay.joshi@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com,
        luoshijie1@huawei.com, jan kara <jack@suse.cz>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <70ce8830-2594-2b7b-9ca9-5fb7edd374d7@acm.org>
 <f89ae154-d6b7-0a3b-060d-f3131b0c1c1d@huawei.com>
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
Message-ID: <46a5ec83-5a26-fc8a-4cd9-a77d100b7833@acm.org>
Date:   Sun, 9 Feb 2020 19:14:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f89ae154-d6b7-0a3b-060d-f3131b0c1c1d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-09 18:13, yukuai (C) wrote:
> I tested following patch fixes the problem, however I'm not sure if
> move blk_trace_shutdown() and blk_mu_exit_queue() is ok or we should
> just move debgfs-related part.

From blk-mq.c:

/* tags can _not_ be used after returning from blk_mq_exit_queue */
void blk_mq_exit_queue(struct request_queue *q)
{
	struct blk_mq_tag_set	*set = q->tag_set;

	blk_mq_del_queue_tag_set(q);
	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
}

I think that calling blk_mq_exit_queue() from blk_unregister_queue()
would break at least the sd driver. The sd driver can issue I/O after
having called del_gendisk(). See also the sd_sync_cache() call in
sd_shutdown().

Bart.
