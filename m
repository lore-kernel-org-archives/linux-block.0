Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C587C54E8D
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767F320736
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 20:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEKU4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 16:56:53 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50280 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgEKU4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 16:56:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id t9so8479179pjw.0
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 13:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IhpUsO3wYR9QymOo9GLQVcY2Bn0y4Yt+qmSEnYYRyoc=;
        b=YLtYRehyYQCVuPzrZ+ucGq0oe8BLJJXtdn33v4obpemEZk8y0vdShwjyry0PtI/lvv
         8uDc+RrZXSpManpmNevUWlODNLHcFrvydEuTw4DxR3JHJNwtEFXgnMJnOQ2H5eWTVZ9T
         jVACnHrlSgifRH6y9dgUMAYUERG1XYH+3K3F7U/tZ3wcviiX8ZILd3EmCjh7tlJalAHw
         K4/Pp5kQZHSMAj3h5+wt+2pNpt4dvBBUB4UazY1mgLtCxDslMlCIgOgKWMpUmUBm1LpT
         xS3gXqN10pTxDg4Vjc4Ue4IRhX/7nMrMTLBPeKqNWA4G583gLUpakn6nkF27A6xHo0Zf
         Q9Xg==
X-Gm-Message-State: AGi0Pubp4ppvlBWQF6b3E4NIGOXgNXoHdT8uzNNV2cTVscj3qYgCPr8k
        cBjGH5fQwVbUVqwbTDllOMc=
X-Google-Smtp-Source: APiQypJtxrqSIO5QD2tIa7v64M+GXCJL0TmaoPKZuNv1Ql7oJDw0n2df7ahppX82zZIhFAnizm/NkQ==
X-Received: by 2002:a17:90a:8c83:: with SMTP id b3mr24505036pjo.141.1589230611508;
        Mon, 11 May 2020 13:56:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c4e5:b27b:830d:5d6e? ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id b1sm9904859pfi.140.2020.05.11.13.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 13:56:50 -0700 (PDT)
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
 <8ef5352b-a1bb-a3c1-3ad2-696df6e86f1f@acm.org>
 <20200511034827.GD1418834@T590>
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
Message-ID: <832f5935-19f5-8dcf-baee-ad61f0c5d966@acm.org>
Date:   Mon, 11 May 2020 13:56:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511034827.GD1418834@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-10 20:48, Ming Lei wrote:
> On Sun, May 10, 2020 at 08:20:24PM -0700, Bart Van Assche wrote:
>> What I meant is to freeze a request queue temporarily.
> 
> But what is your motivation to freeze queue temporarily?

To achieve a solution for CPU hotplugging that is much simpler than this
patch series, requires less code and hence is easier to test, debug and
maintain.

Thanks,

Bart.
