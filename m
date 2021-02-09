Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73A3C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AA364E15
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBIKQM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:16:12 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36255 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhBIKID (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 05:08:03 -0500
Received: by mail-wr1-f44.google.com with SMTP id u14so20925249wri.3
        for <linux-block@vger.kernel.org>; Tue, 09 Feb 2021 02:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=305GA5Vcg+XCag1vR4Os30JZqIqVXTHehXGnV8UYBqY=;
        b=dYrEHvgvnJZfmqW89DUNSx9mZe9UuMallD6+ePpmPxldmLE5XZNQv2J1JJpItdkEQw
         TAUYDn3HlkVNIum8OwrkfpiS12072OtgsE1vx5pSQJxL3GWiGdEixokSLK/3nLjDPkAs
         2OJmYuQx7tB8rEUYo4y4+pEZIg8qt8QPrsLl2aowuwIOZ74TYK9NFpTQiT08JGQoA3C9
         manBeUA0439zLyu0lSu5LdVbrS/jKunTGh8neeACiPRIp7RLI3T3KtAf85PGTHsOovMf
         uIJvQiJT01m1DgGaGzp20gexqj7kcIJKHVWQoBYDb7cB4d7RfHIVwJWMh69C6hS18nxN
         6H1g==
X-Gm-Message-State: AOAM5328y/AqSOmdAMHpdEMKlVG1U6oUtGWWi7JBtrvZgFbo0fDqArPQ
        mEE2lEcUcijkdlOUxMb8ZR4=
X-Google-Smtp-Source: ABdhPJxtrwVWsKIozf1x9mCf4BNR2dolgCSM9hgMBqNlLRRbn7nB0ORtYYuFngf9E2ABUsf8aX9zeQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr22346733wru.88.1612865240864;
        Tue, 09 Feb 2021 02:07:20 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id y63sm3690719wmd.21.2021.02.09.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:07:20 -0800 (PST)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
Date:   Tue, 9 Feb 2021 02:07:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210209075001.GA94287@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>
>>> One obvious error is that nr_segments is computed wrong.
>>>
>>> Yi, can you try the following patch?
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 881d28eb15e9..a393d99b74e1 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>>>    		offset = 0;
>>>    	} else {
>>>    		struct bio *bio = req->curr_bio;
>>> +		struct bio_vec bv;
>>> +		struct bvec_iter iter;
>>> +
>>> +		nsegs = 0;
>>> +		bio_for_each_bvec(bv, bio, iter)
>>> +			nsegs++;
>>>    		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>>> -		nsegs = bio_segments(bio);
>>
>> This was exactly the patch that caused the issue.
> 
> What was the issue you are talking about? Any link or commit hash?

The commit that caused the crash is:
0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter

> 
> nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
> number has to be the actual bvec number. But bio_segment() just returns
> number of the single-page segment, which is wrong for iov_iter.

That is what I thought, but its causing a crash, and was fine with
bio_segments. So I'm trying to understand why is that.

> Please see the same usage in lo_rw_aio().

nvme-tcp works on the bio basis to avoid bvec allocation
in the data path. Hence the iterator is fed directly by
the bio bvec and will re-initialize on every bio that
is spanned by the request.
