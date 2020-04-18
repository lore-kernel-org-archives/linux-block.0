Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84AC38A29
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0189A214AF
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDRPoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:44:32 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36593 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDRPoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 11:44:32 -0400
Received: by mail-pl1-f170.google.com with SMTP id g2so2191308plo.3;
        Sat, 18 Apr 2020 08:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZamkwpxxpgEyM+B+GmITRT2zINDFcwHae2UE6fcwVeI=;
        b=rkTSEQf3/9Et7DylOQejH/QXTVS2GTIGOjZwi3N4k1mEclPHMlhaIkSRxCP2gBvn+I
         rNLBAFRXngDHL2Ut5JwBdPbORKKHd304cVek33wFc4osWnsaR6FRcc9+uOoOI67gl9W2
         lKXJH+8UchwK3YOCB7UG1sjzDEUczKfuRogN7YqbpS6GQZsGUoGWUTwepOyqfPAFHvRs
         X+y6CZcxG2v531a4o0hYf1nwZ8K/Bo1divJX9UPaRs1cKtxFHl8M2nmpdgtTLYu1+3MZ
         nw3Dn0Xd1MFNjH4TF85Z/cgwKiXijSrOgUqf41i6nV4BVI5h+WK1dkJBFxi+xwS1DoJn
         UaqQ==
X-Gm-Message-State: AGi0PuZQ82ZaPALhuvgoNR+6iVKUpD8JR97NFlyRccnJySPA4xytZYL4
        FHeHinRPf7ZWbwzHNPy0mencXXC4gmQ=
X-Google-Smtp-Source: APiQypKc0icC6V3EzeYpE1butC2jWyAXIpBwQjx69RKwKx/FX7Pt8Sse/PbuYkYi6EYq/izo1T7RDA==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr10734662pjv.171.1587224670783;
        Sat, 18 Apr 2020 08:44:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:551:c132:d476:f445? ([2601:647:4000:d7:551:c132:d476:f445])
        by smtp.gmail.com with ESMTPSA id y126sm16526608pgy.91.2020.04.18.08.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 08:44:30 -0700 (PDT)
Subject: Re: [PATCH 7/8] bdi: simplify bdi_alloc
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-8-hch@lst.de>
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
Message-ID: <5fa5c23e-174f-657e-f7ce-d2ccbd3e149e@acm.org>
Date:   Sat, 18 Apr 2020 08:44:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416165453.1080463-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-16 09:54, Christoph Hellwig wrote:
> Merge the _node vs normal version and drop the superflous gfp_t argument.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
