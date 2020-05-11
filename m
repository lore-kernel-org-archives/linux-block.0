Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D6C47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 03:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EEB2075E
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 03:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEKDU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 23:20:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37298 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgEKDU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 23:20:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id x10so3346452plr.4
        for <linux-block@vger.kernel.org>; Sun, 10 May 2020 20:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bQtpBROQswsVsbYJLStqO+P9mLsmHe7jAV1gmlgs0rM=;
        b=OEwogn2AvRw/j3GBYB84kV8UwrE5lNE/HTSPMWS1M2oHN9jWWyA5AssFUunOLqDWwz
         OaNSoX0kFSVvCs+vwdnzZ1UQhl2tgWobzHZtHpB77mFra8tMZ1b3v5xoeNg9u7uYkxq7
         Rvb9X2V0fmpUeD+3LdXieXoicfnxOF+rHRa1mjEm1MFHeRbZvSJTShEwLuxgEfgsvcru
         DCzwED7KWf39DUsY9ni+tdNaH8C3wD0VedbZ0ymvC5LP4ukjUl4vqvnSyZld/O4gyP2P
         Jp9mwAMarqZizu53zYTHKHCtA/4oYEMXFITA7V1yLSzM1oxo8ZTk9bfBg7elIrMUTX8M
         x5VQ==
X-Gm-Message-State: AGi0Pub0ePB7q3QJ9Vd99txswjXRa2IEuPTGORCoPDl/O57k0zbtb3S2
        vi2fxh1qdkW8LHkVlK0j+yk=
X-Google-Smtp-Source: APiQypKZaLdDygobZn+BWK1P0z0UpG5or09IiINrILLDRH/5VYWlmLHnCJLazpEom2wjiRgvBcY0+g==
X-Received: by 2002:a17:90a:20ee:: with SMTP id f101mr20071663pjg.197.1589167226665;
        Sun, 10 May 2020 20:20:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89d3:d2d0:75d2:37f1? ([2601:647:4000:d7:89d3:d2d0:75d2:37f1])
        by smtp.gmail.com with ESMTPSA id u11sm8023503pfc.208.2020.05.10.20.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 20:20:25 -0700 (PDT)
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-8-ming.lei@redhat.com>
 <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
 <20200509022051.GC1392681@T590>
 <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
 <20200509041042.GG1392681@T590>
 <1918187b-2baa-5703-63ee-097a307cf594@acm.org>
 <20200511014538.GB1418834@T590>
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
Message-ID: <8ef5352b-a1bb-a3c1-3ad2-696df6e86f1f@acm.org>
Date:   Sun, 10 May 2020 20:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511014538.GB1418834@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-10 18:45, Ming Lei wrote:
> On Sat, May 09, 2020 at 07:18:46AM -0700, Bart Van Assche wrote:
>> On 2020-05-08 21:10, Ming Lei wrote:
>>> queue freezing can only be applied on the request queue level, and not
>>> hctx level. When requests can't be completed, wait freezing just hangs
>>> for-ever.
>>
>> That's indeed what I meant: freeze the entire queue instead of
>> introducing a new mechanism that freezes only one hardware queue at a time.
> 
> No, the issue is exactly that one single hctx becomes inactive, and
> other hctx are still active and workable.
> 
> If one entire queue is frozen because of some of CPUs are offline, how
> can userspace submit IO to this disk? You suggestion justs makes the
> disk not usable, that won't be accepted.

What I meant is to freeze a request queue temporarily (until hot
unplugging of a CPU has finished). I would never suggest to freeze a
request queue forever and I think that you already knew that.

>> Please clarify what "when requests can't be completed" means. Are you
>> referring to requests that take longer than expected due to e.g. a
>> controller lockup or to requests that take a long time intentionally?
> 
> If all CPUs in one hctx->cpumask are offline, the managed irq of this hw
> queue will be shutdown by genirq code, so any in-flight IO won't be
> completed or timedout after the managed irq is shutdown because of cpu
> offline.
> 
> Some drivers may implement timeout handler, so these in-flight requests
> will be timed out, but still not friendly behaviour given the default
> timeout is too long.
> 
> Some drivers don't implement timeout handler at all, so these IO won't
> be completed.

I think that the block layer needs to be notified after the decision has
been taken to offline a CPU and before the interrupts associated with
that CPU are disabled. That would allow the block layer to freeze a
request queue without triggering any timeouts (ignoring block driver and
hardware bugs). I'm not familiar with CPU hotplugging so I don't know
whether or not such a mechanism already exists.

>> The former case is handled by the block layer timeout handler. I propose
>> to handle the latter case by introducing a new callback function pointer
>> in struct blk_mq_ops that aborts all outstanding requests.
> 
> As I mentioned, timeout isn't a friendly behavior. Or not every driver
> implements timeout handler or well enough.

What I propose is to fix those block drivers instead of complicating the
block layer core further and instead of introducing potential deadlocks
in the block layer core.

>> Request queue
>> freezing is such an important block layer mechanism that I think we
>> should require that all block drivers support freezing a request queue
>> in a short time.
> 
> Firstly, we just need to drain in-flight requests and re-submit queued
> requests from one single hctx, and queue wide freezing causes whole
> userspace IOs blocked unnecessarily.

Freezing a request queue for a short time is acceptable. As you know we
already do that when the queue depth is modified, when the write-back
throttling latency is modified and also when the I/O scheduler is changed.

> Secondly, some requests may not be completed at all, so freezing can't
> work because freeze_wait may hang forever.

If a request neither can be aborted nor completes then that's a severe
bug in the block driver that submitted the request to the block device.

Bart.
