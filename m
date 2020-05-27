Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDBAC433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 22:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D6F207D8
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 22:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE0Wie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 18:38:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44309 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0Wic (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 18:38:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id p30so12464997pgl.11
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 15:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sqbeX3iFiAT0lCUEnFUdqw19DYBrLFvvgGzpjRzIvGw=;
        b=deL+xPn6xCpM/TKRR+j4Pc/heymwcTnhtJC915ARqScwcXZ1Sq6ca6kN8qVtxrYYjR
         kAxu3FHJ+0V7wLGLCbA+OFw0kvw12yXsI08A3hbvzfKh5dEWQTntPw4h5psXCayd8lFm
         4L0lOGAAJouxTY7ceCx0fWFBIK3eE1B2swdsGHWimGWailhJYdZtml+dyelstUYIX//Z
         pwD5I5a4mvKjIGPT0/9IFcBe/mTrJ7dmIFfyO+SoHlPdYbMu7w9JHO4jTcpMZJgPJa91
         GzIrDKWPTzwIOJEKD78et9RiBGwXZzf914MGJRC9wVF6taSb9B8HZqD4gZPnwgxawbHt
         xImA==
X-Gm-Message-State: AOAM531i0FerQc0LHtNMhyX5K6eP3U3u0WalqJN4rld0CfAzxFpbLSST
        ve+GM1WKMolHllEGv04v9pI=
X-Google-Smtp-Source: ABdhPJzfypEyX8yRfHYJkZLNLyPKO0+Tjg8xRZCRFnw1UotmGFr5OCSiud/VUeHvKDnh94rxxmAuTQ==
X-Received: by 2002:a63:9d81:: with SMTP id i123mr19893pgd.176.1590619111701;
        Wed, 27 May 2020 15:38:31 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p4sm2830224pff.159.2020.05.27.15.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 15:38:30 -0700 (PDT)
Subject: Re: [PATCH 4/8] blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-5-hch@lst.de>
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
Message-ID: <afa931dc-d382-500b-c95a-3f2cc22d207e@acm.org>
Date:   Wed, 27 May 2020 15:38:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-27 11:06, Christoph Hellwig wrote:
> To prepare for wider use of this constant give it a more applicable name.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

