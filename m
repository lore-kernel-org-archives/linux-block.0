Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7DC38A29
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F0D21D7E
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDRPkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:40:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38789 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDRPkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 11:40:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so2180513plz.5;
        Sat, 18 Apr 2020 08:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tdj0zZGZX7DTstdEtdKhtFcFkERM+JLXcMAxdH7xdMY=;
        b=Xtxs5hryBa5gKP4sdxMVuzJTnPiJexKib7Rg06PB7EidOw3kcSJjhH9MuZO8b3WaJX
         dQ/aZOGb5ztxu5H49ExzYQaRFxShazUzhep/7iwK/uCsEz3UwJaP73GDUFD+p+QZX4Qv
         /7XbpXMxE0/pC90MvaKiZZFvH8UT4l5bkqo8SiXarIprb9sJQnnbEjQTzszSs1EO1+AM
         uXKWBzn0wWgFm0L3WCi6uGjP4U2WtEZP1M+CgmschMJTHkkMPO98OMOxhtp9Ct8zOwiU
         7YpShmlEEa+QsfU9lbi15w4UE4B7hBe3T8658MXQ+ilYYG90S5UD+pRYRIQLY5NNSTfS
         9VtQ==
X-Gm-Message-State: AGi0PubEW3Cs+vjR2/NrgVu2sht8xwRauFoSJQkNSlKE4MHLxZ5c/Tz1
        GAOUIHMIgfZEfJj7AT+aC466giKiQHo=
X-Google-Smtp-Source: APiQypL5hogTx5RoP/Q3/EYCFJYLz8oi4SMpQpzGJAtSS/tqHN+uDiYokrTdfxPPXK5p2eX3WWH7lA==
X-Received: by 2002:a17:902:fe8f:: with SMTP id x15mr5434603plm.221.1587224422262;
        Sat, 18 Apr 2020 08:40:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:551:c132:d476:f445? ([2601:647:4000:d7:551:c132:d476:f445])
        by smtp.gmail.com with ESMTPSA id o63sm9047937pjb.40.2020.04.18.08.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 08:40:21 -0700 (PDT)
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz>
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
Message-ID: <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
Date:   Sat, 18 Apr 2020 08:40:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417085909.GA12234@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-17 01:59, Jan Kara wrote:
> On Thu 16-04-20 18:54:48, Christoph Hellwig wrote:
>> @@ -938,7 +938,8 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>>  	if (bdi->dev)	/* The driver needs to use separate queues per device */
>>  		return 0;
>>  
>> -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
>> +	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
>> +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
>>  	if (IS_ERR(dev))
>>  		return PTR_ERR(dev);
>>  
> 
> This can have a sideeffect not only bdi->dev_name will be truncated to 64
> chars (which generally doesn't matter) but possibly also kobject name will
> be truncated in the same way.  Which may have user visible effects. E.g.
> for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
> other way around - i.e., let device_create_vargs() create the device name
> and then copy to bdi->dev_name whatever fits?

How about using kvasprintf() instead of vsnprintf()?

Thanks,

Bart.
