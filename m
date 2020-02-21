Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E8C11D00
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 02:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB4E2465D
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 02:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgBUCuu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:50:50 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:39801 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgBUCuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 21:50:50 -0500
Received: by mail-pj1-f48.google.com with SMTP id e9so85649pjr.4
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 18:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CraDicGBBtzqBCNndIjjvdIXByIW7/VwFt16R0kLFcc=;
        b=VnyebXnN8TLQ+WbvVlYqJqldxOpoPpaK0/MZlYa/f19L3lTfuH0zNqTMCITpvS9dXt
         +MssXQP8AWMKWgV20M6XfOXHGrOLYP2Jtnh+AVmv32+mwB6U9+Rx2grkQCLy4tax4LcF
         Jr6wOTksPtiVcTS9dZYyuZTw1CMoKy+BG1JTMCTJFBRrDCLdArM2syCfGa3DlyuH+aqz
         3kPfh49F8nIcaANSVk6fxpUXav3L0FvsxHjRwD4kO6nRJROZSkvkN8Grevhc466MlSSr
         Z7mGX3bzODM58sy5vkP5utYiHW5zs9a53L5GX1uAVmywr+m5PrsU7gy3j1fKd6UgwtIu
         pa0Q==
X-Gm-Message-State: APjAAAUwsDg84e0069ArDuglN4+IZd8AJtUMAsh6dohWAmZ2S4K4T3vT
        iIBB7+xl2MbyYTjyGO4J36Y=
X-Google-Smtp-Source: APXvYqyFKX2KOP54WYYdCNfoLIrCmNr8IitjM5zs3IYxA48n8HD6McYjMTz87j82nG+g4MpVBgtopw==
X-Received: by 2002:a17:902:341:: with SMTP id 59mr35810962pld.29.1582253448154;
        Thu, 20 Feb 2020 18:50:48 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:e57a:a1b3:1a44:bb8c? ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id p4sm635493pgh.14.2020.02.20.18.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 18:50:47 -0800 (PST)
Subject: Re: [PATCH v2 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
References: <20200220024441.11558-1-bvanassche@acm.org>
 <20200220024441.11558-3-bvanassche@acm.org>
 <20200220100524.GA31206@ming.t460p>
 <37505ee7-fba6-1b25-64c4-f632280e8b70@acm.org>
 <20200220204713.GB28199@ming.t460p>
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
Message-ID: <ee2ebbe9-6d95-461b-ba22-c7e51093ae5a@acm.org>
Date:   Thu, 20 Feb 2020 18:50:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220204713.GB28199@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-20 12:47, Ming Lei wrote:
> Actually, I suggested to do the following way:
> 
> if (set->nr_maps == 1)
> 	set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
> 
> then people won't be confused wrt. relation between set->nr_hw_queues
> and .nr_queues of each mapping.

Ah, thanks for the clarification. I will make that change.

Bart.
