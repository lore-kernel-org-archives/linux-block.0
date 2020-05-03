Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D9C28CBC
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFD5206E9
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 22:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgECW2Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 May 2020 18:28:16 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:37913 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgECW2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 May 2020 18:28:16 -0400
Received: by mail-pj1-f52.google.com with SMTP id t40so2861998pjb.3
        for <linux-block@vger.kernel.org>; Sun, 03 May 2020 15:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VNb3nmcyDAtasiVcFrkJB6HEYcctrEofi/ZSBI7/Z78=;
        b=MJ+G6dPO2DyxxfHHlRlW3+Z8Rn+0Hl/MZU4+Bep5LyvVSZsDO1NLvX4IQ3aU01nXZ+
         jznH3r1Z6O1b62af0wb6/LuzzusuStZ5xxmlTGokG8dCxh3EKqqNDXizK7LDeqYg9q2u
         b8z8V4TwecTfVv6VDdGocc4Z83z8O5J5ySAIzT4UZeXxU51q57c/Quhf8V98Jw7c05tC
         LVjSUffvoVsWch1ZtYGpH87B2Xkaa/7rklWK3krybaXcFxveUWfpKNTb4yghv9dYVvYj
         zChOhirfhDQuiXIzRpuirxbqqMQWTBXZt1xoWHg7cDXj/M0SaOnIasAbVQX3oE/ORbGW
         5m/Q==
X-Gm-Message-State: AGi0PuYj21ukZQaZYUn67rTVY40wUHpFcFjTx2wX+MV8cISF8F/jM8IY
        nNRzuwsz0tOTNaJ7GJFHyYE=
X-Google-Smtp-Source: APiQypLZGXrIdNaJNEBp8F4FKFlvuYgybIumVOCpKt900G6V2lgH6S9EIbKL4dwLc2cF8HKjnfBDFw==
X-Received: by 2002:a17:90b:3014:: with SMTP id hg20mr13903153pjb.56.1588544895663;
        Sun, 03 May 2020 15:28:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:cbe:bdc0:6452:4260? ([2601:647:4000:d7:cbe:bdc0:6452:4260])
        by smtp.gmail.com with ESMTPSA id f64sm5240099pjd.5.2020.05.03.15.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 15:28:14 -0700 (PDT)
Subject: Re: [PATCH V2] block: add blk_io_schedule() for avoiding task hung in
 sync dio
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20200503015422.1123994-1-ming.lei@redhat.com>
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
Message-ID: <666e4dbd-1454-0cf3-4855-9e40054bab75@acm.org>
Date:   Sun, 3 May 2020 15:28:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503015422.1123994-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-02 18:54, Ming Lei wrote:
> Sync dio could be big, or may take long time in discard or in case of
> IO failure.
> 
> We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
> so apply the same trick for prevent task hung from happening in sync dio.
> 
> Add helper of blk_io_schedule() and use io_schedule_timeout() to prevent
> task hung warning.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
