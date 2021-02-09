Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E5C433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D45364EBC
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhBIKkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:40:01 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:40903 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhBIKhc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 05:37:32 -0500
Received: by mail-wm1-f46.google.com with SMTP id o24so2952588wmh.5
        for <linux-block@vger.kernel.org>; Tue, 09 Feb 2021 02:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7RII3tGzt7cobOVI6BO3Z3WndxhaneB61QTbfXxx+g=;
        b=stE9LR4y7vk/8LgYtxjT+/3P6B2KAwz1U4AVnKDFA6MoVU1ol7DVGZytf/hyHfOje/
         MjEVqPbfK12ghEbA+8r8FC3xBuQqlvnD10lvfy1vSJc7Qh3KhCRbHHmj4ofZMxvO1MlC
         xdPcTHglO1/nrUxkBjYNE1x+xBZcDixQd4U4++Y3kU4yoPg7NwK6jOzyCVDv9goRc6kQ
         k18+36fbfzAHVCVVMpaK+ezbqJ09bm94c3G915/r7PYZeh4e0mV1W5fWSB/mvNTCoivF
         JZAiJkx+F7U8ASXhIfxMd+FZrb31/MtikFlrIpBAouqXuDChrH3y1CzbHwOhURDitlSM
         j+cw==
X-Gm-Message-State: AOAM532OCTK2Ha7YAuyrL0qMGwgd3STMhqQ5bzX+9GYIcx7iHgVHKWeN
        mUgM7CMupObGH+yQC5abX2g=
X-Google-Smtp-Source: ABdhPJy3UN4iZqwMRSfjUlyf3puxsRHJs098AQpGEs6HysSjDaCYUb5/+Vv2BshkWgMvPdLWxamczQ==
X-Received: by 2002:a1c:c288:: with SMTP id s130mr2791302wmf.125.1612867006961;
        Tue, 09 Feb 2021 02:36:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id q19sm3960697wmj.23.2021.02.09.02.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:36:46 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>, axboe@kernel.dk,
        Rachel Sibley <rasibley@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
 <20210209075001.GA94287@T590>
 <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
 <20210209103300.GA101814@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7caeb8fa-94cc-89aa-94ec-da084491cc04@grimberg.me>
Date:   Tue, 9 Feb 2021 02:36:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210209103300.GA101814@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/9/21 2:33 AM, Ming Lei wrote:
> On Tue, Feb 09, 2021 at 02:07:15AM -0800, Sagi Grimberg wrote:
>>
>>>>>
>>>>> One obvious error is that nr_segments is computed wrong.
>>>>>
>>>>> Yi, can you try the following patch?
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index 881d28eb15e9..a393d99b74e1 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>>>>>     		offset = 0;
>>>>>     	} else {
>>>>>     		struct bio *bio = req->curr_bio;
>>>>> +		struct bio_vec bv;
>>>>> +		struct bvec_iter iter;
>>>>> +
>>>>> +		nsegs = 0;
>>>>> +		bio_for_each_bvec(bv, bio, iter)
>>>>> +			nsegs++;
>>>>>     		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>>>>> -		nsegs = bio_segments(bio);
>>>>
>>>> This was exactly the patch that caused the issue.
>>>
>>> What was the issue you are talking about? Any link or commit hash?
>>
>> The commit that caused the crash is:
>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
> 
> Not found this commit in linus tree, :-(

The original report is on:
Kernel repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next

>>> nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
>>> number has to be the actual bvec number. But bio_segment() just returns
>>> number of the single-page segment, which is wrong for iov_iter.
>>
>> That is what I thought, but its causing a crash, and was fine with
>> bio_segments. So I'm trying to understand why is that.
> 
> I tested this patch, and it works just fine.

Me too, but Yi hits this crash, I even recompiled with his
config, but still no luck.

>>> Please see the same usage in lo_rw_aio().
>>
>> nvme-tcp works on the bio basis to avoid bvec allocation
>> in the data path. Hence the iterator is fed directly by
>> the bio bvec and will re-initialize on every bio that
>> is spanned by the request.
> 
> Yeah, I know that. What I meant is that rq_for_each_bvec() is used
> to figure out bvec number in loop, which may feed the bio bvec
> directly to fs via iov_iter too, just similar with nvme-tcp.
> 
> The difference is that loop will switch to allocate a new bvec
> table and copy bios's bvec to the new table in case of bios merge.

So in nvme-tcp used bio_for_each_bvec which seems appropriate, just
need to understand what is causing this.
