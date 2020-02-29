Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C622C3F2D2
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330CE24697
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgB2Cem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 21:34:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2Cem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 21:34:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so2443625pgs.9
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 18:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3GrZNLMwlJ7Lo+JJZdF5vpagUnHTF9b5B2bdx/LwWEA=;
        b=Qv5hNi0H+JdpZGLMfdfIicCf9ELe2AMKdnM5kyH7ZjkTstFbJxFP0i4U3jx1VvZKdw
         IO+FPWCb+/71ylST3gAkxVu7XbvVl/AILxYHS2oCUJmtIQFJPud40TCWdvcFhE9llm20
         0r2LUl1aYg0atVyzs9GKIzxBPeGZiKoAJEOxswtghSMCrLQh32xH9FunwZska13vzO3D
         Xnoj+fxNQrEoIiJO+DfdoQ+sDe1G3gBGZeyhEBsYAk9SAjHW2imdibM7Co8cipG5+AAD
         PzkrxdYtVz3NJYnROeA3qK58ehaQ5QSK+8eUZLtur1v5vXVjanX09r4M1h3i856Gx7a9
         MNGQ==
X-Gm-Message-State: ANhLgQ3R5DKxus/X6yWgr2Hdp8si7oLT8d1BxQVDt1UG1c5mCsk8Hnur
        pDrxRxLRfNGaGZIPXWyWmoy8lZ7H8UA=
X-Google-Smtp-Source: ADFU+vu9Cx9w7KuqY4ldXBjZPVQlKolmnQ6vizJmrjf6DZm3gGCe4ZXuJoImyY1qIyglle6WP4pfpw==
X-Received: by 2002:a05:6a00:2d3:: with SMTP id b19mr4289363pft.2.1582943680643;
        Fri, 28 Feb 2020 18:34:40 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:34a0:1fb8:34d0:e7e7? ([2601:647:4000:d7:34a0:1fb8:34d0:e7e7])
        by smtp.gmail.com with ESMTPSA id y16sm12477012pfn.177.2020.02.28.18.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 18:34:39 -0800 (PST)
Subject: Re: [PATCH 4/6] block: remove obsolete comments for
 _blk/blk_rq_prep_clone
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-5-guoqing.jiang@cloud.ionos.com>
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
Message-ID: <4e6fcb8b-f07b-55bb-362b-c58ed03df7c0@acm.org>
Date:   Fri, 28 Feb 2020 18:34:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228150518.10496-5-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-28 07:05, Guoqing Jiang wrote:
> Both cmd and sense had been moved to scsi_request, so remove
> the related comments to avoid confusion.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  block/blk-core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 883ffda216e4..9094fd7d1b01 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1583,7 +1583,6 @@ EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
>  
>  /*
>   * Copy attributes of the original request to the clone request.
> - * The actual data parts (e.g. ->cmd, ->sense) are not copied.
>   */
>  static void __blk_rq_prep_clone(struct request *dst, struct request *src)
>  {

Although the removed comment is outdated, the new comment is not useful.

How about inlining __blk_rq_prep_clone() into its only caller and
removing the comment above that function entirely? It's not clear to me
why the code inside __blk_rq_prep_clone() ever was put into a separate
function.

>   *
>   * Description:
>   *     Clones bios in @rq_src to @rq, and copies attributes of @rq_src to @rq.
> - *     The actual data parts of @rq_src (e.g. ->cmd, ->sense)
> - *     are not copied, and copying such parts is the caller's responsibility.
>   *     Also, pages which the original bios are pointing to are not copied
>   *     and the cloned bios just point same pages.
>   *     So cloned bios must be completed before original bios, which means

Adding a comment that explains that some but not all struct request
members are copied and also why would be welcome.

Thanks,

Bart.


