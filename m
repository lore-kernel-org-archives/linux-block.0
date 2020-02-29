Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369B5C3F2D1
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1213424672
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB2C1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 21:27:13 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:55061 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgB2C1N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 21:27:13 -0500
Received: by mail-pj1-f42.google.com with SMTP id dw13so2014673pjb.4
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 18:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=73Eja54bpnHEIMsF24bht+8ZnF1ImiqPub4SIQp+l3k=;
        b=SfuLO+tdZWgf89rU8uGHTlac8fW1n8hF8CiZZmv2IHeMOkDq39IZ5adDaRJYrkmqME
         QS5fcYvn67HKFQYVFEirkkMpPOQPKNiur5+frZA6t+jd80lgYlTKVKjL+L2cqpWpizHU
         GZ0nO9sOocRKCJpx2gF3zxscwOw4x0BhptDE0DCD5DvgngQqkgtlSBmKCwLqXsX560bQ
         m9mMyUpghJVAT0qryJTsnHFUAFlGLYGBRQ7ilO5UdnYYg4t45hInv7hLNrsx0h17JyYY
         SpP7FbqtaYoZLQy9GR5ONsrU0RNKjwhNWhDquRI7l1iMH7UmjbbtuKT9RBoRNUwoPkin
         cRxA==
X-Gm-Message-State: APjAAAVpHCcD/gzcYA7tZjGAozxrytg1+tIBB9nYrgFAY695R7vULutF
        q3zECtnLjYcemoU/lz6VMjZwh7tpaPs=
X-Google-Smtp-Source: APXvYqwMhCWyW+sruwC7DNwPXfQiNm0uTOhXYyvdoilciF+ppdOBMcvXViALG8ZXpv07ugTEjcaNLA==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr6957453plo.327.1582943231963;
        Fri, 28 Feb 2020 18:27:11 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:34a0:1fb8:34d0:e7e7? ([2601:647:4000:d7:34a0:1fb8:34d0:e7e7])
        by smtp.gmail.com with ESMTPSA id q8sm3624267pje.2.2020.02.28.18.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 18:27:11 -0800 (PST)
Subject: Re: [PATCH 3/6] block: remove redundant setting of QUEUE_FLAG_DYING
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-4-guoqing.jiang@cloud.ionos.com>
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
Message-ID: <41332096-d092-1abb-d323-5a8728958191@acm.org>
Date:   Fri, 28 Feb 2020 18:27:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228150518.10496-4-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-28 07:05, Guoqing Jiang wrote:
> Previously, blk_cleanup_queue has called blk_set_queue_dying to set the
> flag, no need to do it again.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
