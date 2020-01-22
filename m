Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4315C32771
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 04:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0672071E
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 04:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAVEBt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:01:49 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41961 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVEBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 23:01:48 -0500
Received: by mail-pf1-f170.google.com with SMTP id w62so2650401pfw.8;
        Tue, 21 Jan 2020 20:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v1TEeQsZodHIEG41lP7CSsxdJfQpKcRlaHsuz/iHyEg=;
        b=FH5J4Nr595ezF64CMceD6mgQa9irn4ivmnZKW5jjDbs/BDRZypRK16QdMAJuEqhGZE
         JF+z7FnOD4MA+2fQFfCCjBehOR78G0xtE0NTlK6HcezQiFh1/lafn1ulcGZX/OxK++Z/
         XXY3pzTWloEyJG6z6N8ocT2sQFnHpshLl7gPfQxVR+MU9B5DjLsgI3fHN7cwwwvI6+lC
         GxZ+Zw6fdgM6q65mGY5/aL2d9Z0RzOlhJ+xeyZAUA7VTsYqExfIpi+A5umCuyaqz+ms3
         PLmdV4XYBIK1IlG01BgHbGjrxngJurj7ulztUwl9ohPzmwxQM7eaVwo8havdgTNHVZGo
         VeHw==
X-Gm-Message-State: APjAAAVAd51cTHhNPeZETXdJLkntr0cbrN1OJ2qt8x5hYcImcu9AGkVm
        y0/hcUSJqgYlOI4chrZIVFr6aXUE
X-Google-Smtp-Source: APXvYqzNHYBRLeEMkMB6GoMuEO2AiTkavbtML7z0Jg1qV4wHuvC/yx2+LdHfqJDsUBRi3w/UXMEltA==
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr9326515pgf.247.1579665707325;
        Tue, 21 Jan 2020 20:01:47 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:1483:dec1:1c24:26ea? ([2601:647:4000:d7:1483:dec1:1c24:26ea])
        by smtp.gmail.com with ESMTPSA id b98sm923620pjc.16.2020.01.21.20.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 20:01:45 -0800 (PST)
Subject: Re: Re [PATCH] Adding multiple workers to the loop device.
To:     "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     Chaitanya.Kulkarni@wdc.com, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
 <20200121201014.52345-1-muraliraja.muniraju@rubrik.com>
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
Message-ID: <19d3397e-f820-bae0-7e4f-93bafe7ce166@acm.org>
Date:   Tue, 21 Jan 2020 20:01:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121201014.52345-1-muraliraja.muniraju@rubrik.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-01-21 12:10, muraliraja.muniraju wrote:
> +	for (i = 0; i < lo->num_loop_workers; i++) {
> +		kthread_init_worker(&(lo->workers[i]));
> +		lo->worker_tasks[i] = kthread_run(
> +				loop_kthread_worker_fn, &(lo->workers[i]),
> +				"loop%d(%d)", lo->lo_number, i);
> +		if (IS_ERR((lo->worker_tasks[i])))
> +			goto err;
> +		set_user_nice(lo->worker_tasks[i], MIN_NICE);
> +	}

Unless if there is a really good reason, the workqueue mechanism should
be used instead of creating kthreads. And again unless if there is a
really good reason, one of the system workqueues (e.g. system_wq) should
be used instead of creating dedicated workqueues.

Bart.
