Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37BAC3F2D2
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB93924672
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB2C0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 21:26:18 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41834 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgB2C0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 21:26:18 -0500
Received: by mail-pg1-f170.google.com with SMTP id b1so2439507pgm.8
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 18:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=561rWRZzzFFUOwdsqB0gUShGDB8hnIUSi++qgSQaL7I=;
        b=fePQt66hL98cts2rxJWWAho3cMYaShlxCg1MNUISC4om+OEhvCU8XVTDCn9WaWHnnn
         AD1ajYzcNl+hWyZXWr7Wbc8Y7LRsNBh0FRoi02ltzOnWp8auzBgUxR0K7tzSYAPG5xQC
         5LayNgiW7GdhZ9mnbU1OXiTCxHcFGkwpKWcosHtx6oFsQw6sgXWlphdQZiRh/HgEWZ0k
         NG0QF1DgQNxW1u9OJEIY2XcESd0G19SBLGdqNt5opI8BJS6DOyhCYv10kbmFjrhLFgBm
         KpVqaM3xnmieyjIKxBS8RYIvBAe+H5vJuvRSQHwY8NCTQu07UeGo3YdB4qEYxvtEX1Mq
         bXBw==
X-Gm-Message-State: APjAAAU/cEmD2JudJV9pzpx+OOla0Y2AzJVAVugj5GjUZ5GR7Wj6Nr2l
        +CwYMFlfdADFXGqOvZf/pvFwgtjcAoE=
X-Google-Smtp-Source: APXvYqxR6A4PZOpwyIrsL+rLoVbM3Tqif+CF94R5HjCfnjIMMayRGXxLj/WAuigRp7Jn033QTlaM+w==
X-Received: by 2002:a65:63d1:: with SMTP id n17mr6947333pgv.298.1582943176764;
        Fri, 28 Feb 2020 18:26:16 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:34a0:1fb8:34d0:e7e7? ([2601:647:4000:d7:34a0:1fb8:34d0:e7e7])
        by smtp.gmail.com with ESMTPSA id 5sm12663664pfx.163.2020.02.28.18.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 18:26:16 -0800 (PST)
Subject: Re: [PATCH 2/6] block: use bio_{wouldblock,io}_error in
 direct_make_request
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-3-guoqing.jiang@cloud.ionos.com>
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
Message-ID: <c5b3a8e2-dd86-d163-b808-7de518cf154a@acm.org>
Date:   Fri, 28 Feb 2020 18:26:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228150518.10496-3-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-28 07:05, Guoqing Jiang wrote:
> Use the two functions to simplify code.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

