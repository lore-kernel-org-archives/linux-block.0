Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF72DC11D00
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 02:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9D02465D
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 02:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgBUCty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:49:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35639 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgBUCty (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 21:49:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so241670plt.2
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 18:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m1KMU52mxmvCMQ9J5kSzI3ixvWAalEyGX2V5vvSz2/U=;
        b=Z7sWWBITKUo926SW//D7RYWXnCg9qvCCGNNe4ZorH/QOH39poYXpPQ2RwYOQ9eUjxc
         BdOin4KbLrz2RvcE4xQvSXayCQWORAqVtQ1CjFI/dO/sypSP92Whju9As0DT/1jR5gxf
         eK7ATNcOS83QBHtuMv/IWhudqSVl4AVYw9tZS6hVAuI4X+QvO2evSr5h45dd8t0XO+CP
         g3KEs0MOjDa85FLXKgCZYkpYvtudULM2VmfwfZfqtTDPxlUqSx5IZHt5Gik+iOtPmNdO
         ekScz4FlNihFfZptRpoci6/cNOS5K3dxu2FJl+eWnamn8JP1gyA8R8dc3BE/4dJmL4vn
         ObiQ==
X-Gm-Message-State: APjAAAXWTrZAybAaJZ+xEjIhFFcRmkEWWN7XAkSS4pU6GXz1mH/t1DDI
        S1oPwPq3a/+1eKkiVydsmNg=
X-Google-Smtp-Source: APXvYqzQEnKu4fv8LPYxmmCMIDf+6m86NpRERPbEQJ6Drh9QP4b1Pzuts5bu8IBjZP61QlLzvjtFeA==
X-Received: by 2002:a17:90b:4015:: with SMTP id ie21mr333177pjb.1.1582253393199;
        Thu, 20 Feb 2020 18:49:53 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:e57a:a1b3:1a44:bb8c? ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id g7sm959461pfq.33.2020.02.20.18.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 18:49:52 -0800 (PST)
Subject: Re: [PATCH] block: Prevent hung_check firing during long sync IO
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>
References: <20200220120527.15082-1-ming.lei@redhat.com>
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
Message-ID: <1c59bb62-c350-b3ab-a2a1-05a3c8620120@acm.org>
Date:   Thu, 20 Feb 2020 18:49:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220120527.15082-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-20 04:05, Ming Lei wrote:
>  	submit_bio(bio);
> -	wait_for_completion_io(&done);
> +
> +	/* Prevent hang_check timer from firing at us during very long I/O */
> +	hang_check = sysctl_hung_task_timeout_secs;
> +	if (hang_check)
> +		while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> +	else
> +		wait_for_completion_io(&done);
>  
>  	return blk_status_to_errno(bio->bi_status);
>  }

Please make this patch compliant with the kernel coding style.
Checkpatch reports the following about the above patch:

WARNING: line over 80 characters
#152: FILE: block/bio.c:1032:
+  while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));

ERROR: trailing statements should be on next line
#152: FILE: block/bio.c:1032:
+  while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));

Thanks,

Bart.
