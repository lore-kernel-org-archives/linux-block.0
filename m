Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3C9C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10B0206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEPQYR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 12:24:17 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46461 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPQYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 12:24:16 -0400
Received: by mail-pl1-f179.google.com with SMTP id b12so2211822plz.13
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 09:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0DIUX5VNWSjEw0+UGqOxL8pM2LN76PJgsXLJf8Y5c/k=;
        b=M4SEHChcnBont7l4wKsbgoeFkvHsbIqD+8emrCLrHR1YJyiCLT7ZGgqT8g154aRi8S
         wx2MhsTAjkPzY2iH32MmribS1K/AOJXy1ndHb8oBHXMmkN13sFOTsf5dYZocmtbSnJAH
         R0C47MHJSw/IAoGRetQrHY/JHeb95OhqMw5KZHOolQYPJoGAjp9mgL8KxsNGfUzvqOdS
         iregFStOkmoIVDGB2IG83Jta0x2BhG+UreqGPrMDJLf3KPlOKP1rogpAORE+nx+deECZ
         Z4aBgb8NdV/0whdxjT0y5L3EUcdprW0hZgjEYjO4RdpHF/nWEozfssFpUG70xjPYVXOJ
         0Sqw==
X-Gm-Message-State: AOAM531cbY3WT5o2XkS6pfEEHSlo/WvDqe+W2WZGwFEzCPMveMRZe4YI
        lEcqfSf1GmDxhadJcK9Bz0lmZhYm
X-Google-Smtp-Source: ABdhPJwymYnDt+nC9pNSClcSp5ILgBJLQKrcqDOUCGJ5FRScm4yk8TPI5EJEvdRZhjk60EQTPMW61w==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr8459952pla.311.1589646255258;
        Sat, 16 May 2020 09:24:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:97a:fd5b:e2c1:c090? ([2601:647:4000:d7:97a:fd5b:e2c1:c090])
        by smtp.gmail.com with ESMTPSA id w2sm4255275pja.53.2020.05.16.09.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 09:24:14 -0700 (PDT)
Subject: Re: [PATCH 1/4] blk-mq: move the call to blk_queue_enter_live out of
 blk_mq_get_request
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200516153430.294324-1-hch@lst.de>
 <20200516153430.294324-2-hch@lst.de>
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
Message-ID: <4a63a828-21e6-77f7-2988-ad85349eb2e2@acm.org>
Date:   Sat, 16 May 2020 09:24:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200516153430.294324-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-16 08:34, Christoph Hellwig wrote:
> Move the blk_queue_enter_live calls into the callers, where they can
> successively be cleaned up.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
