Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C18C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C2A2075A
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgAHDF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:05:29 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45378 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHDF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 22:05:29 -0500
Received: by mail-pg1-f178.google.com with SMTP id b9so809675pgk.12
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 19:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CZKkmKEIa+mseeeTLJLTyVKbG95SB3g8gb5JIIBRux4=;
        b=gUCF34MmnbvOY+54FG3VSHrmtWKwUkJ4lieA2rrVO6ZqxnHBdtG9TT3EICpcom75Nf
         N2jfX129o7LM5kM9eqg5l/OnRaE6YOINeWp8QUAuOYcTy40t1zPm3ZfMW6n6Yj4ESaCJ
         RBHbEi+Mw+e8Pl9ga5M1qOPGqYNiKN8Q8MjkmXxs5HtaRIYKSAj+4rTSmyNCOnHjglSw
         F0/d1SLi9ElMJyHudy6BG7IJYrtq+rDpRheLcutAPbN0pofL3MIf/xLx0fvDILsuGURd
         CJktB3x1Us/dOpnUT2VFr97IsDdpGG4FWmw66c1XOpR/PrWWuP4r31ujsQZxBqRKR8mC
         9nXA==
X-Gm-Message-State: APjAAAWRMZv1YaticLQuxR6J0LyiScxiu9zSWd1BaopC9Yewh73GG5hK
        oZdpRjgzpTREVWK5OgH3bzk=
X-Google-Smtp-Source: APXvYqwMrwiZlHSjiRBGy3L1v8zvYBSKKFZTWkcj2sIztEd8Omcz5n3YoaE6zBf6rzzJxcmgGzfTIA==
X-Received: by 2002:a62:f247:: with SMTP id y7mr2737140pfl.5.1578452728883;
        Tue, 07 Jan 2020 19:05:28 -0800 (PST)
Received: from ?IPv6:2601:647:4000:13e0:5954:1854:c34a:9e99? ([2601:647:4000:13e0:5954:1854:c34a:9e99])
        by smtp.gmail.com with ESMTPSA id b4sm1048923pfd.18.2020.01.07.19.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 19:05:27 -0800 (PST)
Subject: Re: [PATCH] docs: block/biovecs: update the location of bio.c
To:     jgq516@gmail.com, axboe@kernel.dk, corbet@lwn.net
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20200106103735.10327-1-guoqing.jiang@cloud.ionos.com>
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
Message-ID: <a6abb135-6d8d-be40-f02e-e5a0b83bb3dd@acm.org>
Date:   Tue, 7 Jan 2020 19:05:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200106103735.10327-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-01-06 02:37, jgq516@gmail.com wrote:
> Replace fs with block since bio.c had been moved to block folder.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
