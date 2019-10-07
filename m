Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF4ECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8617E206C2
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJGOWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:22:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40104 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJGOWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 10:22:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id d26so8313606pgl.7
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2019 07:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2ZU8AY+CJmWkLyfUgAeyR2aXIDvnBdwACnWcLlxdnE=;
        b=M9pYhGhcsfRVmYfh4leTHQFj4XL5fHsFN2OmxQgwnbUbkUMptV5mPZ4GSioPS/0aqP
         0DP86TC9YgR3Z6OTG6NES/euPiLMeICuCzTbaL5P4x2KnWVnyxRUU5Aqs9PifpPgWBu7
         HiaodFaBhGQT5c0havGotCElUBDwv9SSgPtipV3EYAImBtLklYX5ot0c+Cwhm7XE4MVG
         KzNhqAK/ONMa8TbMeHnt1YTfr4Aj4eRm56cq/1tJbTCBxpgtb40lEJJovQh086NmmzxT
         SyH1GFa53reyMHRY3M4iPhh35ORAdVaB0r4UVMQNiu0E8WecNQJxblT+XvQy3ilCLR/+
         vmYg==
X-Gm-Message-State: APjAAAUUBjWhdGnP6pQHCgpwQK27XYlX7i6nbri5ZcbxXll/Oz4RJJuF
        /IQvf8JR5l+UY9RdTaWwE3WQIdv4
X-Google-Smtp-Source: APXvYqwvmodEbeN46swNwsCbEQpLckki2U1XU/C9gNMWEzNLqhoU91D0r0IB4lHEKWCBm3DTFBdWaw==
X-Received: by 2002:a63:6a46:: with SMTP id f67mr15645380pgc.152.1570458131646;
        Mon, 07 Oct 2019 07:22:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d1:bc53:340c:20b7:901e])
        by smtp.gmail.com with ESMTPSA id e184sm17911318pfa.87.2019.10.07.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:22:10 -0700 (PDT)
Subject: Re: packet writing support
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
 <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
 <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
 <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
 <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
 <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
 <977cedab873dfe0705701b3b43c621a7a516e396.camel@cyberfiber.eu>
 <ce56abfd-f309-5471-0201-6226731fa452@suse.de>
 <6eb30ce355f90eca126cbd2f11d359db2bbe69f1.camel@cyberfiber.eu>
 <9596b5fe35dbab5f7804308167bb67b5e6cde52b.camel@cyberfiber.eu>
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
Message-ID: <844e6f57-d97d-0c2e-1493-a356cd792a8a@acm.org>
Date:   Mon, 7 Oct 2019 07:22:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <9596b5fe35dbab5f7804308167bb67b5e6cde52b.camel@cyberfiber.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-10-07 02:17, Mischa Baars wrote:
> On Mon, 2019-10-07 at 11:11 +0200, Mischa Baars wrote:
>> necesarry
> 
> a) If necessary I could do the maintaining, sure.

You may want to start with having a look at the following:
* pktcdvd: invalid opcode 0000 kernel BUG in pkt_make_request
(https://bugzilla.kernel.org/show_bug.cgi?id=201481)
* pktcdvd triggers a lock inversion complaint
(https://bugzilla.kernel.org/show_bug.cgi?id=202745)

Thanks,

Bart.
