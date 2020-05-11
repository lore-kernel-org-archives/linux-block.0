Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1142C47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 03:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB53D20746
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 03:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEKDae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 23:30:34 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55257 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgEKDae (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 23:30:34 -0400
Received: by mail-pj1-f66.google.com with SMTP id y6so7155778pjc.4
        for <linux-block@vger.kernel.org>; Sun, 10 May 2020 20:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uLXlBB24hl3VoxvaYO6v7WUnrBQ4NdicbL6Qs3ApGBE=;
        b=TcYJVJFjFsrmdzdU8/2iNBCoL8DBFB97kquvfrwg2SgvkKnL7Am/jViKoKpleuwMbp
         IbkmPSULWtWvaSDngGu4QyO7zkjJeAMCTh3OVY03YoS3vcjJWh01SGLvi8OOYR9LWVNE
         2Vgl9LuiCotyx3iUo8wv7diStmilubWNmXjEenC0Q4uVlIYAErQzFGnzOt/Gaf0hHqOZ
         cMF87vbyF9EVRwSiViwGNMwL0jNeQlXxUNG0U/8pUmdcSsiwt7NpOEr6pUldYCgeRViQ
         u5E4sbSb+gthSoxkk+SwX0uiIF+qx9LPS9nieSCFFTneY/rmBqqu1cbnftqN6YJ7D7mz
         Ih2g==
X-Gm-Message-State: AGi0PuZ7qNxMFRpqX0lISk6O+6mZHGDAlD2qKGU5CcfXqDJz1fydGDfL
        0lvwKGyoT8inZyCM6dyv7T8=
X-Google-Smtp-Source: APiQypLXi9PCSpuxHvRAXMb6C53qj+I/c2+f5cAM4HGGUSVshNrh4ud2cR6Kon3xhXF6Mqg27DRfrg==
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr20665050pjp.72.1589167831560;
        Sun, 10 May 2020 20:30:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89d3:d2d0:75d2:37f1? ([2601:647:4000:d7:89d3:d2d0:75d2:37f1])
        by smtp.gmail.com with ESMTPSA id r21sm8452450pjo.2.2020.05.10.20.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 20:30:30 -0700 (PDT)
Subject: Re: [PATCH V10 11/11] block: deactivate hctx when the hctx is
 actually inactive
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-12-ming.lei@redhat.com>
 <954b942e-3b06-4be7-9f2f-23f87ff514f0@acm.org>
 <20200511021133.GC1418834@T590>
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
Message-ID: <73702cd9-6dcc-a757-be3b-c250e050692c@acm.org>
Date:   Sun, 10 May 2020 20:30:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511021133.GC1418834@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-10 19:11, Ming Lei wrote:
> One simple solution is to pass BLK_MQ_REQ_PREEMPT to blk_get_request()
> called in blk_mq_resubmit_rq() because at that time freezing wait won't
> return and it is safe to allocate a new request for completing old
> requests originated from inactive hctx.

I don't think that will help. Freezing a request queue starts with a
call of this function:

void blk_freeze_queue_start(struct request_queue *q)
{
	mutex_lock(&q->mq_freeze_lock);
	if (++q->mq_freeze_depth == 1) {
		percpu_ref_kill(&q->q_usage_counter);
		mutex_unlock(&q->mq_freeze_lock);
		if (queue_is_mq(q))
			blk_mq_run_hw_queues(q, false);
	} else {
		mutex_unlock(&q->mq_freeze_lock);
	}
}

From blk_queue_enter():

	const bool pm = flags & BLK_MQ_REQ_PREEMPT;
	[ ... ]
	if (percpu_ref_tryget_live(&q->q_usage_counter)) {
		/*
		 * The code that increments the pm_only counter is
		 * responsible for ensuring that that counter is
		 * globally visible before the queue is unfrozen.
		 */
		if (pm || !blk_queue_pm_only(q)) {
			success = true;
		} else {
			percpu_ref_put(&q->q_usage_counter);
		}
	}

In other words, setting the BLK_MQ_REQ_PREEMPT flag only makes a
difference if blk_queue_pm_only(q) == true. Freezing a request queue
involves calling percpu_ref_kill(&q->q_usage_counter). That causes all
future percpu_ref_tryget_live() calls to return false until the queue
has been unfrozen.

Bart.
