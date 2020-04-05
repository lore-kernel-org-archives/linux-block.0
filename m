Return-Path: <SRS0=lh2f=5V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B3C2BA16
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 03:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AB52070E
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 03:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDEDIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:08:01 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:54046 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDEDIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 23:08:00 -0400
Received: by mail-pj1-f44.google.com with SMTP id l36so4944480pjb.3
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2020 20:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvgFLTmqbpYN5RNoWHYPXVJx56cAmRWS52LALDeeaEI=;
        b=hydApDHBWqbECmsfoeYfGjTsBAxRqXBknPM1u3JS3Csri3+f1+pd3vgC1qCnnYlZO9
         vqSk5CnkYdt2sSLJz3uGcna3gM9GGlDhZRzp5ms1fULMdzFBSXpdjIfCgew167554Nlx
         pPzyowM2IwkErnVFvZb/VsO/y3XChCuXer+cq+5ASF4B+xuRxNWlwQQYN+D1QqgbMkOw
         bDEYea/Vfmq6KGxSBPALqZER6x6x3RBr0PvgdpKJWkQ3kcg7a3tTxpGVYpr5zcOLwzVM
         uqF9QKhjKjuC0JNhxsXTXDqPl1z8JZBrHHa4Lv/Txl2DZ6svyZzdf67ezZotOdnz07Jc
         Oxpw==
X-Gm-Message-State: AGi0PuZsb4c2C62hu9FjYRbUywDKcbl6nsP3tSAASPBsdxY1We/F/nQu
        tDMXZLV3EixwzhE0m+WGsco=
X-Google-Smtp-Source: APiQypJT/0QI8BvPqptByEQSPFAvojwSI+GKP+JKljTMntNNg3m6gdEhZLE5vRTOHKi25Og/3Z4GAA==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr15055191pls.5.1586056079204;
        Sat, 04 Apr 2020 20:07:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:103a:6b0b:334d:7fb2? ([2601:647:4000:d7:103a:6b0b:334d:7fb2])
        by smtp.gmail.com with ESMTPSA id hg20sm8762245pjb.3.2020.04.04.20.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 20:07:58 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e6=2e0-?=
 =?UTF-8?Q?83eb78c=2ecki_=28block=29?=
To:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <cki.30CC7B67BD.D92JFO5H7A@redhat.com>
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
Message-ID: <0a957017-9d26-b3d5-4751-66c971b7c253@acm.org>
Date:   Sat, 4 Apr 2020 20:07:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cki.30CC7B67BD.D92JFO5H7A@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-03 13:04, CKI Project wrote:
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/04/03/518551

From the build log:

ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!

So why has this report been sent to the linux-block mailing list? Does
the build bot perhaps need to become smarter?

Thanks,

Bart.
