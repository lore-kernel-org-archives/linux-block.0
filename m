Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C00C43460
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051D561176
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 19:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKTkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhEKTkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 15:40:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B6C061574
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 12:39:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y32so16483462pga.11
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PSahpPiUc5NKlDdMwb0qNt2ijCCQMz01ED1EXmqSDhI=;
        b=RMj+4EQb/aRuO2A1yJ0dCHholXt9fKvAu8HwhU86akDazzDLxb4yDhKAxxKHGtAhO+
         86FQBFH5Y82XbqNv6+iL++1iTewno1EvqwwIXvvWpRx8bWjTvpGNEx0udu4iE2NLwe/V
         /3g4jmcVeyUigddLFMrO/tQkjF4YLDmQLRlAIOZHtnA8BmEjnAPVRda1uuMtc8uaATe6
         2ROU6OWc2xLskRBiS4CqvEoYoQSwXGQAruOwoI/0Js8tYupLxAyVsTb5I4TFKNQYQBsH
         O3npy1g2LZ3EXSY1q05D0N072coptdd6Vli/wBMF1lcDClwejZuDN0x3UNJL+Tadd3NY
         BFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PSahpPiUc5NKlDdMwb0qNt2ijCCQMz01ED1EXmqSDhI=;
        b=fTaj+IA2Z//KkuADASQnGEdGL5IZqR2yav3JhAAbCCkfJiBTMh/EfN/YesRK91ynVa
         B5Hbj1lspQUdhg6fuE1xiDlxO6mg5MGsMa5J6B/rwU32kjJ439BKrutP8MlV8o4qFuNz
         tc20WrOE4S2j8ToRfFAF3CC644pYHzxT/76ykTBKbGvffDQqrLB5ivK7AVaK1SJ0Xol3
         AfBiTX7YEh7ARpn9vsQpDv82H/Vo2maZwA3gyr9v4isoLyVC7jhbnXTaIXyoom/k2wnc
         kk7OKm4bk7vqNRpnGKiOC0CXGSJrzwRUQM8liIlrtS5IOKnBFHZB88GUcc6bVZ41ZOT+
         7dFQ==
X-Gm-Message-State: AOAM533otbFSHCE2MdH3GL0CBsgSp/L3W+Xn2GrDeg9qexVN94f5G88E
        xovj0eIw0GKCzXGX/nYyYqHbGg==
X-Google-Smtp-Source: ABdhPJy0QyoG/x4CMUJXHO5sAdjw2fW0Lb6xqTo+sdK0LLlv7pBZXhwhFqStH9BhS91SP8hhdlIYAw==
X-Received: by 2002:aa7:908c:0:b029:250:b584:a406 with SMTP id i12-20020aa7908c0000b0290250b584a406mr31778622pfa.44.1620761950492;
        Tue, 11 May 2021 12:39:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i3sm2711436pjv.30.2021.05.11.12.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 12:39:09 -0700 (PDT)
Subject: Re: [PATCH for-5.14/block] blkcg: drop CLONE_IO check in
 blkcg_can_attach()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
References: <YJrTvHbrRDbJjw+S@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f89d141-fc55-a41e-4783-649fbd7e34ee@kernel.dk>
Date:   Tue, 11 May 2021 13:39:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJrTvHbrRDbJjw+S@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/21 12:58 PM, Tejun Heo wrote:
> blkcg has always rejected to attach if any of the member tasks has shared
> io_context. The rationale was that io_contexts can be shared across
> different cgroups making it impossible to define what the appropriate
> control behavior should be. However, this check causes more problems than it
> solves:
> 
> * The check prevents controller enable and migrations but not CLONE_IO
>   itself, which can lead to surprises as the outcome changes depending on
>   the order of operations.
> 
> * Sharing within a cgroup is fine but the check can't distinguish that. This
>   leads to unnecessary conflicts with the recent CLONE_IO usage in io_uring.
> 
> io_context sharing doesn't make any difference for rq_qos based controllers
> and the way it's used is safe as long as tasks aren't migrated dynamically
> which is the vast majority of use cases. While we can try to make the check
> more precise to avoid false positives, the added complexity doesn't seem
> worthwhile. Let's just drop blkcg_can_attach().

Applied, thanks.

-- 
Jens Axboe

