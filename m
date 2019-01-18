Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A312C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B46020850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VcTdX6Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfARQ3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:29:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfARQ3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:29:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so6275355pgr.11
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nQrbJ0EWr1OvfqJaPKfn7vIaxcP1q4imKqHU7SMPXMM=;
        b=VcTdX6QuJhKGwBA1UDj5gDRDp3EyRO6TSycxmGdTv4io5axflpP16TLoq4jUTRiFhh
         CCUhz9wusG4nwqAoVd7uGMbzZQQqQ6JhkvCuWfyO165rOr+MVa0MVUvTRzFawHqZnZss
         b2YKXbyprpGIPxYkLgZa/LcH7FDTMTTAUo3w0FOi4YiA8qneAJ81YTdL4daBa2/+GhV5
         gDIuwAyreLUwqTj78y+hMPgrnnR/S+LJ9J/HJaTC/fZWD1e4Zmb+JnVtvc2jqaayMHv5
         ImDZktFAjE5n1Y8kyShazJAGl+yZkcF6g8OplmH+Iwhc/EJ1fqhJybjW3UIFaKkaKZee
         TTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQrbJ0EWr1OvfqJaPKfn7vIaxcP1q4imKqHU7SMPXMM=;
        b=n0oOhI8N8Xwyf6evH1alt+atEtACiNZgKoWLj803bFYblMJdr+voqrP8N4HFLzwdhR
         tvpfvPN/qYpPQH8ISgLyeVgsStAKwlQUuN/LCxiqKovfkv5zjOcQC8gh6ymUPr1QUgnB
         oRAUt63W1NeL5Q0lw6scvJkh/zYg1hi84iaRE+Tj2aaLhoNzWokB87BEe4KqJHKdoxLR
         IYWznW+22EmJA47CUMk9zP5elpk5NhaKyfPR9L84BC503f8qeQk5SLxGmuvGSx2ZZDNb
         0ZZeIf/Rccs+j8IAjrb+ygyWvlHTPI0aPd4e4erWZT/Tu6aa5epc/mW1RcNhudM4XJn3
         Mgiw==
X-Gm-Message-State: AJcUukezWrajWtvDaUvBWhN+Q9+7DiM+9xLeYMr/1s6xWN1pmYuO5rAE
        r1gfM0W1N/c/yXi6jR2Dy3o1/A==
X-Google-Smtp-Source: ALg8bN5TANL6+JUoAz5uihNYNESvWGnniDJ1pPJpTIuZ5+dSwa5BR4Kp1L7n4qBW7JHItRLMbQEJQA==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr19834553pfh.151.1547828956436;
        Fri, 18 Jan 2019 08:29:16 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o189sm12469032pfg.117.2019.01.18.08.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:29:15 -0800 (PST)
Subject: Re: [PATCH BUGFIX RFC 0/2] reverting two commits causing freezes
From:   Jens Axboe <axboe@kernel.dk>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, hurikhan77+bko@gmail.com
References: <20190118115219.63576-1-paolo.valente@linaro.org>
 <c3b182a2-7f82-2860-436b-c1d59d6661ff@kernel.dk>
Message-ID: <960acfd8-2425-2d30-41e9-4cd10bc20bdf@kernel.dk>
Date:   Fri, 18 Jan 2019 09:29:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c3b182a2-7f82-2860-436b-c1d59d6661ff@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 6:35 AM, Jens Axboe wrote:
> On 1/18/19 4:52 AM, Paolo Valente wrote:
>> Hi Jens,
>> a user reported a warning, followed by freezes, in case he increases
>> nr_requests to more than 64 [1]. After reproducing the issues, I
>> reverted the commit f0635b8a416e ("bfq: calculate shallow depths at
>> init time"), plus the related commit bd7d4ef6a4c9 ("bfq-iosched:
>> remove unused variable"). The problem went away.
> 
> For reverts, please put the justification into the actual revert
> commit. With this series, if applied as-is, we'd have two patches
> in the tree that just says "revert X" without any hint as to why
> that was done.
> 
>> Maybe the assumption in commit f0635b8a416e ("bfq: calculate shallow
>> depths at init time") does not hold true?
> 
> It apparently doesn't! But let's try and figure this out instead of
> blindly reverting it. OK, I think I see it. For the sched_tags
> case, when we grow the requests, we allocate a new set. Hence any
> old cache would be stale at that point.
> 
> How about something like this? It still keeps the code of having
> to update this out of the hot IO path, and only calls it when we
> actually change the depths.
> 
> Totally untested...

Now tested, and it seems to work for me. Note that haven't tried to
reproduce the issue, I just verified that the patch functionally
does what it should - when depths are updated, the hook is invoked
and updates the internal BFQ depth map.

-- 
Jens Axboe

