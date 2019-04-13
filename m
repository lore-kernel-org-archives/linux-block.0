Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF687C10F0E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 03:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B929720850
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 03:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDMDmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 23:42:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfDMDmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 23:42:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so6024249pfo.6;
        Fri, 12 Apr 2019 20:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X1SqLx96KwnRyANALuw4Zu3LjVX3ibcubgu9eVn1E7U=;
        b=XMToFm7bsO7Sp24thYKs1xoF9bQLajp7pQ4O5z+qfeYDsdHDStoPDDDmO+s1tvP2Vz
         fW6q1DtCBKVV1V4FcAcbe9G8L+fdyHQAeaIOFewTdAyiqxmwqdHBRV0fOK/ooEWacbMs
         y7poLv4bjiRcvm+w14exMPCrEQ46D29WD9cx72PYuUWSbqSjEXfQkrug9MCBkZdxjdkN
         fUw564ZO+X+ZM/ldfuxXJCFnO6H/0mAplDnYfliEjkxHiDEpNDlGFoVl4jnlq4zIWcXK
         LCw08uhe5dfntJci1MKZzkPZg4ppSyUkTPVytvPPcHXV4709VwN5V7pinK6TgMfxxNjK
         xfSg==
X-Gm-Message-State: APjAAAVjEOv34oz//EJF8ewiHhDM9mxevTHmi5QGfpOVLHF8GJd6ZkN2
        cvJEOOgMKtn/xSSy6ZdASRexzQ1q
X-Google-Smtp-Source: APXvYqxKIKAnuPB9vRWgr5ayjlloHGnOgSuZGxvp+VDcRdIcrvW2ZA/cdHZRdqwD2mGGM+o+tGJpLg==
X-Received: by 2002:a63:7c45:: with SMTP id l5mr57463541pgn.303.1555126925648;
        Fri, 12 Apr 2019 20:42:05 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id o67sm101120061pga.55.2019.04.12.20.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 20:42:04 -0700 (PDT)
Subject: Re: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze
 sequence
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     shirley.ma@oracle.com, martin.petersen@oracle.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20190409090828.16282-1-bob.liu@oracle.com>
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
Message-ID: <0763cb5a-5598-69e3-e5ac-765989aab5b1@acm.org>
Date:   Fri, 12 Apr 2019 20:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409090828.16282-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/19 2:08 AM, Bob Liu wrote:
>  void blk_freeze_queue_start(struct request_queue *q)
>  {
> -	int freeze_depth;
> -
> -	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
> -	if (freeze_depth == 1) {
> +	mutex_lock(&q->mq_freeze_lock);
> +	if (++q->mq_freeze_depth == 1) {
>  		percpu_ref_kill(&q->q_usage_counter);
> +		mutex_unlock(&q->mq_freeze_lock);
>  		if (queue_is_mq(q))
>  			blk_mq_run_hw_queues(q, false);
> +	} else {
> +		mutex_unlock(&q->mq_freeze_lock);
>  	}
>  }
Have you considered to move the mutex_unlock() call to the end of the function
such that there is only one mutex_unlock() call instead of two? In case you
would be worried about holding the mutex around the code that runs the queue,
how about changing the blk_mq_run_hw_queues() call such that the queues are
run async?

Bart.
