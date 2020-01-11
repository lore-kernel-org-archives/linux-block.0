Return-Path: <SRS0=o2oO=3A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF014C33C9E
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 04:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAE32053B
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 04:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgAKEu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 23:50:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50255 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgAKEu4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 23:50:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so1818287pjb.0;
        Fri, 10 Jan 2020 20:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cxclp8Q8/lgnVCpTy2D6gxi3NrsYfm8lBT4BEaAJheA=;
        b=lrUDuhSZF5LpZJbJ8wI6/OhPCDXMmaxqrXkksXSSANK27UhKyretZFOsVbzOuKOucc
         E+TVZk5KB1Y+O05+uQUzpTvrCJ8RZn/8ZBgrLC8q/Zsl8JUk1XdWGJMz3nRVt3aT0mOU
         9iRkQcRsTchMDiIsSYEGLO2koV+S8ypm00HHY70uEuc48UnZgqF1HpDpz0gMkmYfKl5C
         ajaWRe+IJbIhwdNP3qxnjOkgc4EsiLL6rCGDjPE78+kpY5+HtJAql8g4/61+e2ufA5EU
         T31Iy1gnjQb2HaZlQPMeAIqNaOAtoPzga+A907nw3S4whLjzVZ90F0jTUUpNhdKyDHPV
         sKTQ==
X-Gm-Message-State: APjAAAV+NKAIiqeBoobLTN71iWJqY/k79KX4tvstwq7pKEFJ4tQhkqbQ
        u8Q9k36Nvc56WqDcslWThuE=
X-Google-Smtp-Source: APXvYqzVS9RANobbBwOTijb4E/cAooz3YHxtaVLk0bKfJpNqZ0XR+ZCE0ECZ/i61AS3jJCYx98rb4A==
X-Received: by 2002:a17:90a:9bc3:: with SMTP id b3mr9468947pjw.64.1578718255651;
        Fri, 10 Jan 2020 20:50:55 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:a1c6:ca99:4ff4:5a3b? ([2601:647:4000:d7:a1c6:ca99:4ff4:5a3b])
        by smtp.gmail.com with ESMTPSA id v23sm4458658pjh.4.2020.01.10.20.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 20:50:54 -0800 (PST)
Subject: Re: [PATCH] kdev_t: mask mi with MINORMASK in MKDEV macro
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, dhowells@redhat.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     bywxiaobai@163.com, Mingfangsen <mingfangsen@huawei.com>,
        Guiyao <guiyao@huawei.com>, zhangsaisai <zhangsaisai@huawei.com>,
        renxudong <renxudong1@huawei.com>
References: <5d384dcb-5590-60f8-a4e1-efa6b8da151f@huawei.com>
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
Message-ID: <d890c06e-5b56-629a-2e9f-bc19209238e4@acm.org>
Date:   Fri, 10 Jan 2020 20:50:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5d384dcb-5590-60f8-a4e1-efa6b8da151f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-01-09 22:37, Zhiqiang Liu wrote:
> 
> In MKDEV macro, if mi is larger than MINORMASK, the major will be
> affected by mi. For example, set dev = MKDEV(2, (1U << MINORBITS)),
> then MAJOR(dev) will be equal to 3, incorrectly.
> 
> Here, we mask mi with MINORMASK in MKDEV macro.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  include/linux/kdev_t.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
> index 85b5151911cf..40a9423720b2 100644
> --- a/include/linux/kdev_t.h
> +++ b/include/linux/kdev_t.h
> @@ -9,7 +9,7 @@
> 
>  #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
>  #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> -#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
> +#define MKDEV(ma, mi)	(((ma) << MINORBITS) | ((mi) & MINORMASK))
> 
>  #define print_dev_t(buffer, dev)					\
>  	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))

Shouldn't the users of MKDEV() be fixed instead of changing the MKDEV()
definition?

Thanks,

Bart.


