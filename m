Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6255EC432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1958D2085B
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VShXE6QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfK3U4F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:56:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3U4F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 15:56:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id e6so16116384pgi.11
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2019 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uEgawNzSWxhied7eJMcDGpDU5tVmGngFbZvCJqRYEVk=;
        b=VShXE6QTRMlOUcvcP6+DNxhrBZRfdfwTXITrM/WB3dDp4WZb+fBy7IEw7loJqZjq8R
         NKLa1rhn7Z6AxrC8NXq/VvDSm6L4LtzL1oZSKK7sF0NIVsssUowFXmg3Ggnakx029RnJ
         XjMuQsrNohr1IRNibViF0KLcvHkSDFJos8hPn4FBO99QA4wSnvB7jVMJ+d9pMovpmdMp
         P9PVZmt5m3oD75xZZEomYUd52LmhblQ4fr9jZzZ8F9D2Tpnx1wEOzehnSfaDjWxhSNH/
         2IofVeKVuQy+crnI7MHhZwqSmTd4R2+hjX1GSjrUfMNCPbBhv3TktwAS0XXy4S8TQBNM
         K6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uEgawNzSWxhied7eJMcDGpDU5tVmGngFbZvCJqRYEVk=;
        b=GcL0JajtqxxFxzdlOBIfRISajHyyyCtYgzhd3WwM8i5Q0fGlRBubGbpmLaG+8IyCt8
         sN0Nz+cVw09KMdtdbDvfGT9TZXx/31VISb6uBkDw/4z8l1ZGN55DABvtg0ShYF+ziFBa
         EXPpmY6fGQg48m3d9qAW7JDd0EU64b9nBpqov9ZOENG4vZGeXsmJX8kYtNnEa+WMa2W1
         FGhxGol/qvO9xd0dU9JnAffxPJyYHA04Mu+cIhb3bJZJMJ6Btb4cNDHP/uT6xhppAwEe
         wgTT5c69tvSEi7w6PBBRcmijNEX6t+NFoZYJspnG+4v3bEITBez9RjLnAgIOBI3GKKjF
         Q5Ow==
X-Gm-Message-State: APjAAAXDabrWLM8+EurItz8XRIG8zeU87uLIqfq7kbwy8mimKgq99R75
        XTOIc+jeppT3GLVIRyX9ZdhRLA==
X-Google-Smtp-Source: APXvYqwJSEOA7gu9xgCRQoi8z5xuefmYj9hMCv9d5JZuDxfkQ4i944Dt0HJpgH02HZV2mISwXZSxYA==
X-Received: by 2002:a63:2063:: with SMTP id r35mr24421656pgm.120.1575147364330;
        Sat, 30 Nov 2019 12:56:04 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:4c44:14f1:fc4c:1a31? ([2605:e000:100e:8c61:4c44:14f1:fc4c:1a31])
        by smtp.gmail.com with ESMTPSA id x4sm7061779pff.143.2019.11.30.12.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 12:56:03 -0800 (PST)
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
 <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
 <20191130185634.GA1848835@rani.riverdale.lan>
 <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>
 <84a065b0-956c-460a-3575-260df7117fb8@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4dd79f37-c874-59b2-c37e-193ff0696131@kernel.dk>
Date:   Sat, 30 Nov 2019 12:56:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <84a065b0-956c-460a-3575-260df7117fb8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/19 12:11 PM, Pavel Begunkov wrote:
> On 30/11/2019 21:57, Jens Axboe wrote:
>> On 11/30/19 10:56 AM, Arvind Sankar wrote:
>>> On Sat, Nov 30, 2019 at 12:22:27PM +0300, Pavel Begunkov wrote:
>>>> On 30/11/2019 02:24, Arvind Sankar wrote:
>>>>> On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
>>>>>> On 30/11/2019 01:17, Arvind Sankar wrote:
>>>>>>>
>>>>>>> The loop can be simplified a bit further, as done has to be 0 once we go
>>>>>>> beyond the current bio_vec. See below for the simplified version.
>>>>>>>
>>>>>>
>>>>>> Thanks for the suggestion! I thought about it, and decided to not
>>>>>> for several reasons. I prefer to not fine-tune and give compilers
>>>>>> more opportunity to do their job. And it's already fast enough with
>>>>>> modern architectures (MOVcc, complex addressing, etc).
>>>>>>
>>>>>> Also need to consider code clarity and the fact, that this is inline,
>>>>>> so should be brief and register-friendly.
>>>>>>
>>>>>
>>>>> It should be more register-friendly, as it uses fewer variables, and I
>>>>> think it's easier to see what the loop is doing, i.e. that we advance
>>>>> one bio_vec per iteration: in the existing code, it takes a bit of
>>>>> thinking to see that we won't spend more than one iteration within the
>>>>> same bio_vec.
>>>>
>>>> Yeah, may be. It's more the matter of preference then. I don't think
>>>> it's simpler, and performance is entirely depends on a compiler and
>>>> input. But, that's rather subjective and IMHO not worth of time.
>>>>
>>>> Anyway, thanks for thinking this through!
>>>>
>>>
>>> You don't find listing 1 simpler than listing 2? It does save one
>>> register, as it doesn't have to keep track of done independently from
>>> bytes. This is always going to be the case unless the compiler can
>>> eliminate done by transforming Listing 2 into Listing 1. Unfortunately,
>>> even if it gets much smarter, it's unlikely to be able to do that,
>>> because they're equivalent only if there is no overflow, so it would
>>> need to know that bytes + iter->bi_bvec_done cannot overflow, and that
>>> iter->bi_bvec_done must be smaller than cur->bv_len initially.
>>>
>>> Listing 1:
>>>
>>>      bytes += iter->bi_bvec_done;
>>>      while (bytes) {
>>>          const struct bio_vec *cur = bv + idx;
>>>
>>>          if (bytes < cur->bv_len)
>>>              break;
>>>          bytes -= cur->bv_len;
>>>          idx++;
>>>      }
>>>
>>>      iter->bi_idx = idx;
>>>      iter->bi_bvec_done = bytes;
>>>
>>> Listing 2:
>>>
>>>      while (bytes) {
>>>          const struct bio_vec *cur = bv + idx;
>>>          unsigned int len = min(bytes, cur->bv_len - done);
>>>
>>>          bytes -= len;
>>>          done += len;
>>>          if (done == cur->bv_len) {
>>>              idx++;
>>>              done = 0;
>>>          }
>>>      }
>>>
>>>      iter->bi_idx = idx;
>>>      iter->bi_bvec_done = done;
>>
>> Have yet to take a closer look (and benchmark) and the patches and
>> the generated code, but fwiw I do agree that case #1 is easier to
>> read.
>>
> Ok, ok, I'm not keen on bike-shedding. I'll resend a simplified version

Sweet thanks. Make sure it's green.

-- 
Jens Axboe

