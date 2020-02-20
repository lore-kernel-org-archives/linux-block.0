Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A4C5ACC4
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 01:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD7421D56
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 01:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBTBia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:38:30 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34210 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBTBia (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 20:38:30 -0500
Received: by mail-pf1-f182.google.com with SMTP id i6so1067080pfc.1
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 17:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e9yhtwtnQT3J+2t80hiOFLOuhEViFe8BQo2a7qThV3U=;
        b=C2W/OkSWyCMGN4RH9YwBmIGfvO13n0US0KVc7Ccalan6t/WwcQFY9PboFOYTuPyaEx
         F+nKpVb2DbqBtCP3M7X3jF0s/ZdD8wxJikBF4dRRJnJWGqFKGbS5BqmMsqK5Ud97CHcc
         efGNj4nsyU+agsRoTcz1YrDoxXIyZ3Mq5jPPOrFpRE/fsiXvCNsZESXlPT9y0vQFGYQe
         D968FdVkuDu2tlCBBHEfnJeKHULs9YjX9Jc2iG0E9KDDO9l/oQE6oohR/3WTt85BphKq
         jSm/zGHMc/7/vy/FJdjhEin4udVqKAApR//8BFQNh9bxLLJm8agfoHJWYY9E3oaGiQS0
         /Eww==
X-Gm-Message-State: APjAAAWk4UKk5rKrKrRsjZK/+OO0OEdaVFf3H9KZJzDhQ51bM+mVyLk/
        6v9k0WRCaseOtuMF98gYP00pE6r4onw=
X-Google-Smtp-Source: APXvYqzK8B3h/dr20PCAlhdefKcSRNxEV1ajEL2c47l57meTPcSmqwdxQE3BJHcz31wjBKQcXETHhg==
X-Received: by 2002:a63:3305:: with SMTP id z5mr30080182pgz.319.1582162708840;
        Wed, 19 Feb 2020 17:38:28 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:29a7:b1bb:5b40:3d61? ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id m12sm887014pfh.37.2020.02.19.17.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 17:38:27 -0800 (PST)
Subject: Re: [PATCH] block: fix comment for blk_cloned_rq_check_limits
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200219163415.7618-1-guoqing.jiang@cloud.ionos.com>
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
Message-ID: <90932d72-c03b-0eed-ecd0-920adf846597@acm.org>
Date:   Wed, 19 Feb 2020 17:38:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219163415.7618-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-19 08:34, Guoqing Jiang wrote:
> Since the later description mentioned "checked against the new queue
> limits", so make the change to avoid confusion.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
