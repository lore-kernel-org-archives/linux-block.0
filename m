Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A960C35DF2
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 04:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02724673
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 04:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBYE31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:29:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33519 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgBYE31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 23:29:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so6512170pfn.0;
        Mon, 24 Feb 2020 20:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L5aKXh5kL1YSoSl/wBnA0xoa7XfQ1T6O19RjzdqaTPk=;
        b=F4Ko8LcG9HyDLhBx6hVNwg6VtYjLlDfCzOmdQsBhLznWHmPTQF0FDckKScGY5d/5Jh
         iZ+mjBt4p1jNB63lkfTtnxP3tPZJkSE6559KhMELHIheKoW6CgaktzVAQzPrrIvuq6mi
         HeZY8bdqQHHBhbInsCyN7EC/TzbtJqKCz8fvnSlhVXqh2ilo8MAzlMfSEFMXjwwJOwIg
         i9xWIUlXSMyP+/7Vh3XR6oKAW/cfXvAKB1Z/9dl3AYrXaBgopJbFnehiSXdyCNaOHY8G
         uZoczuB3jBwWUQ5XngTa5uI0+9NV+RoZUPXoSNANEcSQfX8E3YztSQXn7mlxhcppudTt
         Y1jA==
X-Gm-Message-State: APjAAAVig7dthD6bhoTlXL56l35bzPRiuLOTOjfUrwt7hD8J9stqvf7A
        dhmwBqOau4qzRo1PCOnzpMzsiAMz4qk=
X-Google-Smtp-Source: APXvYqylxbW+CBDPFINqX1pBmxFTzdPUuPfyQzBbPgkY422EoqNBU9/V8tj5luTWm0q/OTwfNWHn2Q==
X-Received: by 2002:a63:b143:: with SMTP id g3mr53999956pgp.205.1582604966025;
        Mon, 24 Feb 2020 20:29:26 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:e0d5:574d:fc92:e4e? ([2601:647:4000:d7:e0d5:574d:fc92:e4e])
        by smtp.gmail.com with ESMTPSA id s7sm1095368pjk.22.2020.02.24.20.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 20:29:25 -0800 (PST)
Subject: Re: [PATCH v2 1/1] null_blk: remove unused fields in 'nullb_cmd'
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <20200224183911.22403-1-dongli.zhang@oracle.com>
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
Message-ID: <7aa4133b-2355-999d-9c9d-66336445b1d4@acm.org>
Date:   Mon, 24 Feb 2020 20:29:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224183911.22403-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-24 10:39, Dongli Zhang wrote:
> 'list', 'll_list' and 'csd' are no longer used.
> 
> The 'list' is not used since it was introduced by commit f2298c0403b0
> ("null_blk: multi queue aware block test driver").
> 
> The 'll_list' is no longer used since commit 3c395a969acc ("null_blk: set a
> separate timer for each command").
> 
> The 'csd' is no longer used since commit ce2c350b2cfe ("null_blk: use
> blk_complete_request and blk_mq_complete_request").

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
