Return-Path: <SRS0=N2dH=5O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FDEC43331
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56B220781
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 20:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgC2UUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:20:04 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39202 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgC2UUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 16:20:04 -0400
Received: by mail-pj1-f66.google.com with SMTP id z3so5872586pjr.4;
        Sun, 29 Mar 2020 13:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cP8nBYBs0BtbWOtwLrgbS+MCmqHS1Hl6MqV2riUDxTI=;
        b=g8/g0h0kZSHpKzUA0nD761BRvYifF3Yl0rJ6/5UlcytxONzxaOsm+y4UHTI0+eKn5t
         m27+48LKGeamlpjHgXKyv5u8joS1rsiH9Mc8FeiJbE20/EJJLDi3/YVynYtJuP2Y0llf
         oPOi5Wsej0Dwa6BsKuBASucWx6VnT+0BQeaqgPTuM+52EpnaJKSnt2n/VTDjCnskEJDr
         82qJConJ1aqEWAwnBE1ET9wrozaYVbIkPQYahXXi93eID4Cbm/7SlqGCzpnoYlrrcZRR
         6Y3rJNa0Xc+ZB23Lu3k2SyXKUy+yQ2aF7GAj4bs34ECEIEbHUbLRKZnc1Sv+TUToMdJt
         DU8g==
X-Gm-Message-State: AGi0PuafF1B5AE9d6DQTAdlUIm/mdYqdTyC1Cnd7y0Fk4c22/KJuYNC/
        tZppnxdjE1LiTXZoiN0hPMU=
X-Google-Smtp-Source: APiQypJEGkMiefXWXMns6fh/FyVH5uJuViDT+PpI9XmH7fuh7YZ559y970umgRq2ICRHXR5Xtw4Cgg==
X-Received: by 2002:a17:90a:a487:: with SMTP id z7mr6214404pjp.32.1585513202282;
        Sun, 29 Mar 2020 13:20:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:1d21:aef6:5c03:df86? ([2601:647:4000:d7:1d21:aef6:5c03:df86])
        by smtp.gmail.com with ESMTPSA id 144sm8578106pfx.184.2020.03.29.13.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 13:20:01 -0700 (PDT)
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de
Cc:     Chaitanya.Kulkarni@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20200329140459.18155-1-maco@android.com>
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
Message-ID: <81b67b60-5b2f-f98f-f5df-1ddc2b2ae6b4@acm.org>
Date:   Sun, 29 Mar 2020 13:19:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200329140459.18155-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-29 07:04, Martijn Coenen wrote:
> -static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> -		       struct block_device *bdev, unsigned int arg)
> +static int loop_set_fd_with_offset(struct loop_device *lo, fmode_t mode,
> +		struct block_device *bdev, unsigned int arg, loff_t offset)

Since this function has to be modified, please add an additional patch
to rename 'arg' into 'fd'. Additionally, how about renaming
"loop_set_fd_with_offset" into "loop_set_fd_and_offset"? I think the
latter name reflects more clearly the purpose of this function.

> @@ -1624,6 +1625,17 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  		break;
>  	case LOOP_GET_STATUS64:
>  		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
> +	case LOOP_SET_FD_WITH_OFFSET: {
> +		struct loop_fd_with_offset fdwo;
> +
> +		if (copy_from_user(&fdwo,
> +				(struct loop_fd_with_offset __user *) arg,
> +				sizeof(struct loop_fd_with_offset)))
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The kernel code that I'm familiar with uses sizeof(<variable name>)
instead of sizeof(<struct name>). That makes it less likely that
changing the type of the variable will introduce a mismatch between the
sizeof() expression and the size of the variable.

Thanks,

Bart.
