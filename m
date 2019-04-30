Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80758C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 02:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532E421655
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 02:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfD3CPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:15:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34108 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3CPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 22:15:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so6291386pfd.1;
        Mon, 29 Apr 2019 19:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z1gwxKNHLSONFsApEGgjYueOD3e9fVGkO6awJTe3BDk=;
        b=f/1kzO6yz82E4qrKf13LK/MBMMmaaBy9lirq7j/gU+pcXjjjKWlUJEjbMWAi9Nexa/
         3m+6vCaMxlZjrH/Ak05TvLsVmOT5Z2lh2sUNqFAdSbh5FxvYiRKKKEp6dRG8ioKtyNcE
         Nv8249Z4S5WWTVoYVv9uLiGOlLuD5KKnhsJwoIJ9iD6r5ztFZRTo+UTN3Otn5xtsjpAj
         jpZ/uwbwjWDRrc5UcDTfzUGgs4mVC8I7G3Kxn3rvIhaZOAwGceRIO5dy3zlUw9y3sEof
         r1j2904+K+jDK9qL0zwDZ1j2UXh/B9WsiADTzwZC9PMikhp7dVil3QkwZ/uCCX7/93Dh
         Vdag==
X-Gm-Message-State: APjAAAW4X94UZAK/wnOQWJpDLFZJIse7W0CTD2+yDfDFh1YXJjYFNPa1
        GWjbdmc4pXamm/AbwOVuAWo=
X-Google-Smtp-Source: APXvYqzQc0gGdGwB8yombCx3fl736uuoo232ZhPZX7KLAteSQGFWiE+YR2KxVusP6evWoyv4WoOyIg==
X-Received: by 2002:a63:d345:: with SMTP id u5mr13441728pgi.83.1556590529769;
        Mon, 29 Apr 2019 19:15:29 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id s7sm11129659pfb.38.2019.04.29.19.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 19:15:28 -0700 (PDT)
Subject: Re: [PATCH V9 1/7] blk-mq: grab .q_usage_counter when queuing request
 from plug code path
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190430015229.23141-1-ming.lei@redhat.com>
 <20190430015229.23141-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
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
Message-ID: <447b650c-e264-4545-34a1-b3161a87581d@acm.org>
Date:   Mon, 29 Apr 2019 19:15:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430015229.23141-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/19 6:52 PM, Ming Lei wrote:
> Just like aio/io_uring, we need to grab 2 refcount for queuing one
> request, one is for submission, another is for completion.
> 
> If the request isn't queued from plug code path, the refcount grabbed
> in generic_make_request() serves for submission. In theroy, this
> refcount should have been released after the sumission(async run queue)
> is done. blk_freeze_queue() works with blk_sync_queue() together
> for avoiding race between cleanup queue and IO submission, given async
> run queue activities are canceled because hctx->run_work is scheduled with
> the refcount held, so it is fine to not hold the refcount when
> running the run queue work function for dispatch IO.
> 
> However, if request is staggered into plug list, and finally queued
> from plug code path, the refcount in submission side is actually missed.
> And we may start to run queue after queue is removed because the queue's
> kobject refcount isn't guaranteed to be grabbed in flushing plug list
> context, then kernel oops is triggered, see the following race:
> 
> blk_mq_flush_plug_list():
>         blk_mq_sched_insert_requests()
>                 insert requests to sw queue or scheduler queue
>                 blk_mq_run_hw_queue
> 
> Because of concurrent run queue, all requests inserted above may be
> completed before calling the above blk_mq_run_hw_queue. Then queue can
> be freed during the above blk_mq_run_hw_queue().
> 
> Fixes the issue by grab .q_usage_counter before calling
> blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
> safe because the queue is absolutely alive before inserting request.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
