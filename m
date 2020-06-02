Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C02C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 02:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2703420734
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 02:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgFBC1K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:27:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34291 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFBC1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 22:27:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id z64so4356591pfb.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 19:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ydOOHldNroyQMreD/Np2/3ro5owTXT12DTCkkmf4+1E=;
        b=rPqDbaixsQ1t9810pCm5axAN5/MAy2lyCpJvSzaCmeO1Gei6xwGpGVClApCWVVM+yY
         zFESXS/+xR2GbujCLil2g36b1qPcBUykOzfcV0ncw+q/zVYM7ndC0LJChHVb66BvYg72
         Nnb/E98f2FGp03HcX53TJrO5pUaQrDe9HSNEBbG8KIbfoFyX0CQH3ULMeVY82poYGYB6
         JKOT1G3gES8ECE/Z20mMDCTOjw6lYQPiC2qe1o5/Hf6PbuhLK1ErjopixBACwkY+lq6m
         gfJnB47a59eY47G2wBhwTtpzlTLtDwv+HCrBiOx/CByK2dyCbLyKqitN7ouPIE36ECMa
         lvdQ==
X-Gm-Message-State: AOAM533xq7MI7XqKv4PGWWy+kBKUqOj93Y84UwWrsK7IJIAXpFX9IiqY
        whqjgSgcDUQU2N5AxXpGsxLjBUWj
X-Google-Smtp-Source: ABdhPJwJJbyk7QGkn7hE0KdMBug/9m5OazMAyN4N6ZDqxHmumqxV9ZMjEr6c9DfNiTJ6R581QuUKnQ==
X-Received: by 2002:aa7:8b56:: with SMTP id i22mr15343188pfd.63.1591064829069;
        Mon, 01 Jun 2020 19:27:09 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b15sm745509pjb.18.2020.06.01.19.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 19:27:08 -0700 (PDT)
Subject: Re: [PATCH 1/4] blktrace: use rcu calls to access q->blk_trace
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
 <20200602013208.4325-2-chaitanya.kulkarni@wdc.com>
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
Message-ID: <8c176b63-8a3b-7086-083a-dde931c52012@acm.org>
Date:   Mon, 1 Jun 2020 19:27:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602013208.4325-2-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-01 18:32, Chaitanya Kulkarni wrote:
> Since request queue's blk_trace member is been markds as __rcu,
> replace xchg() and cmdxchg() calls with appropriate rcu API.
> This removes the sparse warnings.

This patch looks like a subset of a patch that was posted a few days ago
by Jan Kara? See also
https://lore.kernel.org/linux-block/20200528092910.11118-1-jack@suse.cz/.

Bart.
