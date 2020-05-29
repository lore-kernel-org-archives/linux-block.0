Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AD720897
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2QOW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 12:14:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 12:14:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id x18so1328228pll.6
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 09:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tWTqNNryCv8ab8Epl8V4G4MlmVY90wjsVFAKoFIN+fw=;
        b=eiAh7IzDWlrXASCGi8vBthlOnOXZmqx7fam4tWxwR49zcrJsQhT2e7IQP1Vp+zOE5u
         nCr+X9V+dwp6aiO+s5qwABVMNBd2aB84CzZD9DY3Gy2/jE15Bv2masuLGAisnuGrq7wL
         73ugSf1E7ndIAtGklyRx78jBqkreN+26DIoWo5zJITxZETiuwKt3ubQ8xzJgna3NEXK1
         KBWucBnm2J2qCVK2+PJSjrhoYdHlpEerI4AWYWWqkPjxnnrN+Nmdk/c/Vd4EpsMf2ust
         x3t0YkPsGI0vI8260scSvQkrSpruh6e99JG+mp7rH5ZpWWMsUS8g6X9vfVI75xsBKVwm
         CC0w==
X-Gm-Message-State: AOAM530VL2+NNlrDu5RBk9CIbMZtj1mQNXTxyidWoH42j0TTBS9v1yIQ
        3BJnywYWWB9LVG70aD3hvjM=
X-Google-Smtp-Source: ABdhPJyY+HqqFns0b956CsrBED2qzrwHQHiOL9p/hDgArV7OidYXljkEcdWEDiUyM5s3ReMGw9OBsg==
X-Received: by 2002:a17:90b:2391:: with SMTP id mr17mr3851792pjb.220.1590768860323;
        Fri, 29 May 2020 09:14:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9d55:11e:7174:3ec6? ([2601:647:4000:d7:9d55:11e:7174:3ec6])
        by smtp.gmail.com with ESMTPSA id l23sm7551371pff.80.2020.05.29.09.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 09:14:19 -0700 (PDT)
Subject: Re: [PATCH 7/8] blk-mq: add blk_mq_all_tag_iter
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200529135315.199230-1-hch@lst.de>
 <20200529135315.199230-8-hch@lst.de>
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
Message-ID: <ca2b66d0-c1cd-b683-5955-410c0cd6229d@acm.org>
Date:   Fri, 29 May 2020 09:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529135315.199230-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-29 06:53, Christoph Hellwig wrote:
> Add a new blk_mq_all_tag_iter function to iterate over all allocated
> scheduler tags and driver tags.  This is more flexible than the existing
> blk_mq_all_tag_busy_iter function as it allows the callers to do whatever
> they want on allocated request instead of being limited to started
> requests.
> 
> It will be used to implement draining allocated requests on specified
> hctx in this patchset.

Reviewed-by: Bart van Assche <bvanassche@acm.org>
