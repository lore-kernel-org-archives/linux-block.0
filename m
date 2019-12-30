Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05108C2D0C0
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 01:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A90207FD
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 01:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfL3BPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:15:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39772 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfL3BPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Dec 2019 20:15:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id t101so7448113pjb.4
        for <linux-block@vger.kernel.org>; Sun, 29 Dec 2019 17:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vU+gdHn1fCQI5gUq5ed732kHo5vrSzBTuw7XvETg6Ws=;
        b=ewcnosdroJTrvMoe8CCu0fQ+LbhafzOcgF0VtWuhxnLiW528aZL6wzO82lAGtEbd93
         FOKnOs1zQijROWWsoUDm1za2Ox/S9Qi2TFfV2runltmE+v6Ed3kebo4ZfdeJgYnf0KwR
         V4VkGFlhAxQ4Aq+aPZRUHrXrctz9YJqphzzLi1BEnLeu1TEjqFoVgkvlqJnyvWTx/BWZ
         ZmqW/3LiSkggXPufxgk5iFvs+E88kZDe7ek0VrPsaHwNovJUUcEBvY+0/KtmrV/xTB1C
         5Cr/7NUZqDemOrnzI0R4AFzGjX77e87RqqTTavJZHjF73BpecMnk+a+oQkthm06qO5wQ
         LJhQ==
X-Gm-Message-State: APjAAAWp9dzs2NhEy/jsUCMZSTklokm/mGuvKv5cW/p5vXcliryP9xv3
        X4eeAKJn6j9fLH+ow5UHf1I=
X-Google-Smtp-Source: APXvYqziDwLCakAmIOWhu7lI5euqaDMOW92UfrcalK6yX+c9fOfPiGmDY0iTRia/6YumMnWeS8DNhQ==
X-Received: by 2002:a17:902:74c1:: with SMTP id f1mr8946406plt.95.1577668551886;
        Sun, 29 Dec 2019 17:15:51 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:8d02:1c2d:1354:1880? ([2601:647:4000:10b0:8d02:1c2d:1354:1880])
        by smtp.gmail.com with ESMTPSA id s21sm27514467pfe.20.2019.12.29.17.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 17:15:50 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <f49d02ee-9b36-be80-9a84-d74cfb35f796@kernel.dk>
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
Message-ID: <b1969f9b-5b40-ed58-b020-ae0a4a328384@acm.org>
Date:   Sun, 29 Dec 2019 17:15:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f49d02ee-9b36-be80-9a84-d74cfb35f796@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-12-29 08:14, Jens Axboe wrote:
> On 12/28/19 7:32 PM, Ming Lei wrote:
>> There are two issues in get_max_segment_size():
>>
>> 1) the default segment boudary mask is bypassed, and some devices still
>> require segment to not cross the default 4G boundary
>>
>> 2) the segment start address isn't taken into account when checking
>> segment boundary limit
>>
>> Fixes the two issues.
> 
> Given the potential severity of the bug, I think it deserves a somewhat
> richer explanation than just that. It should also go into stable. This
> is what I queued up:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.5&id=add1fc07334260253dfa880d9c964edc8381deac

Although this patch looks fine to me, seeing Jens' patch description
makes me wonder whether the DMA segment boundary for the mpt3sas adapter
should be made explicit, e.g. by setting the SCSI host .dma_boundary
parameter in the mpt3sas driver? From the SCSI core:

	blk_queue_segment_boundary(q, shost->dma_boundary);

Bart.
