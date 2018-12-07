Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0EC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7025920882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o/dTB9Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7025920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLGCX2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:23:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42885 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGCX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 21:23:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1073391plp.9
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39dDjOtUMVK8S//60tRMq1Q+A1EbvC8r41mT7avVFN4=;
        b=o/dTB9IePIat9xgvYvZd8exj/9xadC4owGYTwgJwjJjhBmwZOIRW6l0D8p9vp6byAe
         5mVfJ6sWxGnA0RkckXuBitEZLoOEnA7cYnPROAOMbHtoUiDaL/my/ijNlPTD3yizc8Ee
         jsTQ1aj1mA8iSkMaF2OrjEX36WjWapFD5jGkgktpQU65sNJCcdgK6rOVHPmI2wL9/Ufm
         w39TIY3pLm1LZdc2rYYxC2le5wmfWOQGSQ3d7jDEvi7CSD/A2fNle3PbLW+LUN4Tl6Wu
         4mxa0wDijxihahAL6lugYVQcDsPktch3PL7pz/QnhJ4SM4C32gbxgqBfxvItGlaKLUum
         c7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39dDjOtUMVK8S//60tRMq1Q+A1EbvC8r41mT7avVFN4=;
        b=ahwZop01MrtUgsdzdwtEGZqE2ocQ3OTP16PhniGF0i6TvBNu2IH/uOCi1takq4Ex23
         zf/5mZVrlMmb0WGUWlc6lpxReSekYs52KTvn6HSCqfOUdinzIHUUSN6E0jSaSls4Tp5E
         JMGlY55z6jLK58OgYTjJoo/+D05/NsSP6cRyAesdjsS7fe2KP9rL54B+8nMKd59k7xun
         rhQyZnCUCPo4MbqfauTAJ1qUQad1BZXPP6YHa+6EEDRYd73Hs7z80N/4soGnxsp/KEhy
         EeSZstr13ROZF0ykEynyqnSPRE9yC0Bp1UPE9rikdTUblBEQjfzwjgCg0hrXqhS2vKMV
         kyfw==
X-Gm-Message-State: AA+aEWZz9oe08wQAxFla0YVcD3PAVtGDFSGXxh3KiKQV8N0CuJLxZEjI
        dclEd4QTluQBukXMrGS8guILqg==
X-Google-Smtp-Source: AFSGD/UablN5UYNDKaM5ctfl9ySIllurdPGA2+lUmeZzwFpsFEljOxf94gVhuF3ZGi5nRcLCGCMWHg==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr408744plk.291.1544149407954;
        Thu, 06 Dec 2018 18:23:27 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g70sm3320778pfg.98.2018.12.06.18.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:23:26 -0800 (PST)
Subject: Re: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of
 throughput
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it
References: <20181206181819.11148-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
Date:   Thu, 6 Dec 2018 19:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206181819.11148-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 11:18 AM, Paolo Valente wrote:
> Hi Jens,
> the first patch in this series fixes an error in the decrementing of
> the counter of the number of groups with pending I/O. This wrong
> decrement caused loss of throughput or, less likely, of control on
> I/O. The second patch is a fix of some wrong comments, which somehow
> contributed to making the above bug more difficult to find.

Are you fine with this going into 4.21? I can't quite tell what your
intent is. The first patch has a Fixes for something that went into
this series, but then patch 2 is a comment update that would not
normally be something to be applied at this stage.

-- 
Jens Axboe

