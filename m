Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03552C432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79C42075A
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 18:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VmZhy3nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3S6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:58:01 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34228 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3S6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 13:58:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id t21so1999442pjq.1
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2019 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvgoncF/BW8ruOjQkaGF0zAXVY4+8jOiq2/xVo9e8UY=;
        b=VmZhy3nxfoafybZoVQ8qeSTHrfazsp4MfV9RlGeA3Q4SOrTqnE0MKlT/gWK2eOhT/t
         PI9BK4fjLzk274SiPXfDiMi+nPIsw3eK9WcaBFDFnF8Bd/3nqA1Ayy9gJ/XPAfG8QF5m
         FstC4PyjnCgYvwKsAh4kEOfKK1HWJ83kIr7hUX56TUTzdpF3CLB4gZtJiIeYMhCxL6Zr
         ON4bU8KAN2fDR/IgYRDh1dmBIFLjppAha24db+O6YkJlc+PCqC3sCGLBoGRRVmPUBh3K
         ctudn7DFyQOtllMhOMjL7GW793VVFqMf9CM1c6c1NZFqMngERrPDmpV9VSWP//MeNRcq
         xIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvgoncF/BW8ruOjQkaGF0zAXVY4+8jOiq2/xVo9e8UY=;
        b=mFbmuq0ifSaCkm1DX/faufdVEaj4RsehRVgNoqUCc+E1qobDRRzN2izw0KRkClAYbN
         WV6avpE+pl5K1hZbHmB6gyDlPF0j+jmTKPObS94gIGrH9ZMnqMzDO/TAdJdg9VO3LiwL
         pjlax9JnRok5eX0rBep/gfuGi83qN87B+Ji8K0bO/ESt/jHfG9O+U7j8X3yskM0neT8T
         5SfqQLqnywxL/sxywYAHdL+Ac4ta4QqIDKRR/af+6qZsIvN/ycc+RsdnnYNXsiuUvhUs
         gjP00bAYxgjM78dPMNq8hUIicgNLvgEzpcQyNR1zDxM1ipkz6+ka3DwpFVWBmqcUgnrC
         ojeQ==
X-Gm-Message-State: APjAAAV8/dOB9yUakYTE9CajOF3V2xmqlKzb47lGVDh/IMOmGLaPmBNq
        MeTD70NR/OpFK68II/cxq35eqQ==
X-Google-Smtp-Source: APXvYqzRyYqQVcJ/yf9/FSDTc5ClPPqwdRQFU+kyyL3ihJie+/JNP3PjVCFBvkblgeAqKiG7CZx3zw==
X-Received: by 2002:a17:90a:7bcc:: with SMTP id d12mr25759727pjl.63.1575140280387;
        Sat, 30 Nov 2019 10:58:00 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:4c44:14f1:fc4c:1a31? ([2605:e000:100e:8c61:4c44:14f1:fc4c:1a31])
        by smtp.gmail.com with ESMTPSA id e2sm18545781pja.3.2019.11.30.10.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 10:57:59 -0800 (PST)
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
 <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
 <20191130185634.GA1848835@rani.riverdale.lan>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>
Date:   Sat, 30 Nov 2019 10:57:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130185634.GA1848835@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/19 10:56 AM, Arvind Sankar wrote:
> On Sat, Nov 30, 2019 at 12:22:27PM +0300, Pavel Begunkov wrote:
>> On 30/11/2019 02:24, Arvind Sankar wrote:
>>> On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
>>>> On 30/11/2019 01:17, Arvind Sankar wrote:
>>>>>
>>>>> The loop can be simplified a bit further, as done has to be 0 once we go
>>>>> beyond the current bio_vec. See below for the simplified version.
>>>>>
>>>>
>>>> Thanks for the suggestion! I thought about it, and decided to not
>>>> for several reasons. I prefer to not fine-tune and give compilers
>>>> more opportunity to do their job. And it's already fast enough with
>>>> modern architectures (MOVcc, complex addressing, etc).
>>>>
>>>> Also need to consider code clarity and the fact, that this is inline,
>>>> so should be brief and register-friendly.
>>>>
>>>
>>> It should be more register-friendly, as it uses fewer variables, and I
>>> think it's easier to see what the loop is doing, i.e. that we advance
>>> one bio_vec per iteration: in the existing code, it takes a bit of
>>> thinking to see that we won't spend more than one iteration within the
>>> same bio_vec.
>>
>> Yeah, may be. It's more the matter of preference then. I don't think
>> it's simpler, and performance is entirely depends on a compiler and
>> input. But, that's rather subjective and IMHO not worth of time.
>>
>> Anyway, thanks for thinking this through!
>>
> 
> You don't find listing 1 simpler than listing 2? It does save one
> register, as it doesn't have to keep track of done independently from
> bytes. This is always going to be the case unless the compiler can
> eliminate done by transforming Listing 2 into Listing 1. Unfortunately,
> even if it gets much smarter, it's unlikely to be able to do that,
> because they're equivalent only if there is no overflow, so it would
> need to know that bytes + iter->bi_bvec_done cannot overflow, and that
> iter->bi_bvec_done must be smaller than cur->bv_len initially.
> 
> Listing 1:
> 
> 	bytes += iter->bi_bvec_done;
> 	while (bytes) {
> 		const struct bio_vec *cur = bv + idx;
> 
> 		if (bytes < cur->bv_len)
> 			break;
> 		bytes -= cur->bv_len;
> 		idx++;
> 	}
> 
> 	iter->bi_idx = idx;
> 	iter->bi_bvec_done = bytes;
> 
> Listing 2:
> 
> 	while (bytes) {
> 		const struct bio_vec *cur = bv + idx;
> 		unsigned int len = min(bytes, cur->bv_len - done);
> 
> 		bytes -= len;
> 		done += len;
> 		if (done == cur->bv_len) {
> 			idx++;
> 			done = 0;
> 		}
> 	}
> 
> 	iter->bi_idx = idx;
> 	iter->bi_bvec_done = done;

Have yet to take a closer look (and benchmark) and the patches and
the generated code, but fwiw I do agree that case #1 is easier to
read.

-- 
Jens Axboe

