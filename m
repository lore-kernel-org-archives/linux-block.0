Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE27C33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896502082E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hV44iUaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBCOCy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:02:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38307 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBCOCx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 09:02:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so7874839pgm.5
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5+nfCho9zYZEqsV3OpYlG574SchBNWWNZI1rOz3wd4=;
        b=hV44iUaCu7cEtK9xsLbLB2Cy6zHap6Yt8rZPnYvoH/2bfa2bm1TRIA4xgu4lH4ZrxQ
         eN1mV42bvupWusbanK5e1tCRKCiIx30Np6jx7MjR6N+dRYi8ihROf5G0qyAxseJUKkO3
         59wsHJfHDfZCuREIzei4FnCmYzuPjuzcLkpg2MDeWd2EVVHDTpaubsM4U6oxxTBRVQrk
         AejUa9b9I/tQzk67aJIvUbH2XdzXGLfR+q4Z0g2LzR7rAQHF6oq2z/omvizrMNmhxjFr
         z1KRegZb8U1CDwQapRMF1UKSS2wLPpfH4JS+kgxFgCF3L7n6gv+KWpUwzl4/ajNDWfZn
         ZKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5+nfCho9zYZEqsV3OpYlG574SchBNWWNZI1rOz3wd4=;
        b=MpsktU209B5B1rWgvy7ZZQ8wzjMoEaYaGfWl38m91De6z1ws/ojsTTerLbfiIrOSs8
         ROcqLx1JCwH1t9i7tGHH+IMceUUqmrJmhIM0TfdEyZsyLB00DHxHTFH/2uJdizvSY9H9
         WaAPVxGWjS1nmWVdFlieRQHulIOxob0Jl7qL4YdAMzqXid0toiuCz/2Fpb8DclQQZFY7
         5Pngfzfaqutq8cZ5m1zgy5b1Zad6i7SWG6dRiAKLJC+4Nz1VgnYzTTcySPoV6CHLZv+T
         mtKPvExtP9KtcuLem+wAAUuz6S6k+WM9NyNidcj3Xol1x8ZsWZ1fWm63Q5F2KhauVMwR
         RJJA==
X-Gm-Message-State: APjAAAW80ummP8p7rqtGWLqvViUWsFxSWzq10XUDCmE5yvZiaLjyP8kd
        P31drlRyTuIP8gxiwNQGJ2wqIQ==
X-Google-Smtp-Source: APXvYqyV0/fiioJr3fMwalxfwNVtkTVpX9/0/CYpknqlLA3twkanpEzWyU9yEiPbTyEmMBKj89kPyQ==
X-Received: by 2002:a63:484b:: with SMTP id x11mr25745966pgk.148.1580738573099;
        Mon, 03 Feb 2020 06:02:53 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z29sm20319400pgc.21.2020.02.03.06.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 06:02:52 -0800 (PST)
Subject: Re: [PATCH BUGFIX V2 0/7] block, bfq: series of fixes, and not only,
 for some recently reported issues
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com
References: <20200203104100.16965-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f73edf7b-3b69-8f9e-a881-758582019421@kernel.dk>
Date:   Mon, 3 Feb 2020 07:02:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/20 3:40 AM, Paolo Valente wrote:
> Hi Jens,
> this the V2 of the series. The only change is the removal of ifdefs
> from around gets and puts of bfq groups. As I wrote in my previous
> cover letter, these patches are mostly fixes for the issues reported
> in [1, 2]. All patches have been publicly tested in the dev version of
> BFQ.

I'll apply this one, at least the ifdef cleanup is nice and patch
6/7 no longer makes your eyes burn!

-- 
Jens Axboe

