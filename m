Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8816C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7305920657
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BeRjHkB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfFXQMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:12:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54054 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfFXQMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 12:12:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so13355165wmj.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rMN3NSCV14U/djjBqah6itWb6YLCN7v9XBQWW70vOiE=;
        b=BeRjHkB5wYZcB0jrLUQae5J+2zrr8Fi+4ULgoGxmhOTCEhZaCQWl9uoSw20Kwytdtp
         HFBr4/cRhHhBi734UmikNXERcSu7e0qyFPJqfh0IaXGf0iLwr65cwOuXwV7xb02cN22y
         zrxBXMPYsWoDIoEfdLmyfQEzNFobWQqwCzgzHh/0xWh5vtnxpwMiei3OgqOExDl02rbh
         1EQvfX1RjPlMHJVLO8G8tyYpcEn3teDS5EP55YmZ21lmfLWJYjUEJ0RFCs+sGjt0Myft
         sEOYfRwUIulLKMvCrjL3UmxuT00e5rkhzZMRJSVTfpTk+8VDjxCgwgCZy3fJxq8/wmW7
         2S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rMN3NSCV14U/djjBqah6itWb6YLCN7v9XBQWW70vOiE=;
        b=QSXQzY/lwCf/KVa4FmlIbrVlQWvWAzlNs/THzP5190wLEjN5iwHDIdPCvX69gx/og8
         4ACOONw6dgACFCbvSZ0EPoQ6DJERdTuCecoG/1ip+x+J8Yd+Y1mAVQV+HtNyU5ph9O+A
         QsPpfHih/P/GAN2JpSXg1ezEtaoAVBAq09AgQIvTa5ZpfThv7fwlfs5zwd68DpJh62li
         yU1SlMHkIJDP/86un7hepa883C9+qvCCXcIiV6SyaMtN6zA3/nH4cdJYj37XPLOA9TZl
         0QIwS678hZaeX3VU8sh/eTkuQ6KrLjHWO9pn+UNTGKo6R7xLEqDCISWxpEB381AgAYwC
         ibLw==
X-Gm-Message-State: APjAAAUQP5Hga1zffMnECWwXhkhWA21tNC0nPnmavrZuE19P4To1peoz
        TU1JKzaN0ZA/sbrxPj8TvR1swA==
X-Google-Smtp-Source: APXvYqxvj+TKqmmdbdKdA9FT/+f9mo+PTcoV+zToyGdDKDe5WcV9XGyShouys4BnvOkWQTBFTD7dpg==
X-Received: by 2002:a1c:343:: with SMTP id 64mr17469148wmd.116.1561392770706;
        Mon, 24 Jun 2019 09:12:50 -0700 (PDT)
Received: from [172.20.10.174] ([85.184.65.84])
        by smtp.gmail.com with ESMTPSA id a81sm15903831wmh.3.2019.06.24.09.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:12:50 -0700 (PDT)
Subject: Re: [PATCH BUGFIX V2] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20190622204416.33871-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aec3e7b1-c235-ddb1-62b2-4ad7a7246a35@kernel.dk>
Date:   Mon, 24 Jun 2019 10:12:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190622204416.33871-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/19 2:44 PM, Paolo Valente wrote:
> By mistake, there is a '&' instead of a '==' in the definition of the
> macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator with
> the correct one.

A bit worrying that this wasn't caught in testing, as it would have
resulted in _any_ queue being positive for totally seeky?

Anyway, applied.

-- 
Jens Axboe

