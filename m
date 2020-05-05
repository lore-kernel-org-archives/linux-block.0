Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B13C47254
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773B42078D
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W1y7ye3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgEEPXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 11:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729749AbgEEPXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 11:23:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE639C061A10
        for <linux-block@vger.kernel.org>; Tue,  5 May 2020 08:23:40 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so1699789iog.13
        for <linux-block@vger.kernel.org>; Tue, 05 May 2020 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPwxKE0klTjrvpCqkN/+GZfurYoGuk/drCYIDVYxA1Q=;
        b=W1y7ye3xLvDWbdVRSKUUL0S+8HrvaPz16PwNA1IjuoxOj8GVxyKW6B6/eMTtHRlIiw
         ocp5PbDJkd5E3DLCWaXeitPpzuGHudOfwlWg5LSj3q6nff83JSBz6DvAeONP/hmEapQN
         2PMBRjrlNEg2eUMQbLK8DAdexla7k7MjnyfemM6nfThLo7eD7rFlFkWVMDUygtBKHDAT
         EPuG8ZLDOPKyb2jXLzt4Midt4KUy4VERIq5gbofnW+NSfKhJpCNaV2ggpvueRJd3SYgV
         vJ5Ed3Tpb+IfkIPJNBfbUrpSCFTJ1tXMu2dTSd1JsQcgNW0A9aaSgJdy9OWOhe932euT
         CXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPwxKE0klTjrvpCqkN/+GZfurYoGuk/drCYIDVYxA1Q=;
        b=kSd+4em+8kfkQx7EWWa457+zLFxBWbF3K5uIssVpJu80Me9xrD+YrYpVSyzdUnoawM
         8JYS7AOMgvHSphHjoNInGFtcb7af6LTHaWE5w8N8gJbTZ1ncpbdh+XXpkSl0fZYBNJSe
         MWRWEhNIjRfqT4WejPgwd7Ti6XeBuEgCeQTC3FNWq9Uy6jdp7WkghqQLFXXl77LQ91IJ
         CF64RY6a5WXwbs0l011Ho5t+SMAk80lFmMZR3f2v+IK3kGaYEAlUzaFqc6JK3NQey4hU
         KulDdyL0EElEN294dUD1j8IV021WhY7vCTT2mbKBx1O5IGmGEiFp4YxFOJja2Pja4pBA
         lZcA==
X-Gm-Message-State: AGi0PuYZRY3JLNXqvwTsK3jLmEo6Ib6/3heJGaafV2bpc8zTiHHphiYn
        JiwF6xSQo9SoSeXWWDumSYrHHQ==
X-Google-Smtp-Source: APiQypJAq2tEbNFshdQhYM92AuCn6z2zFmJm/tKNnvOKeooJrHtg/Dbe1zAetTS+9IMeiH2nlyuzxg==
X-Received: by 2002:a5e:a607:: with SMTP id q7mr3877260ioi.109.1588692218512;
        Tue, 05 May 2020 08:23:38 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y70sm1893526ilk.47.2020.05.05.08.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 08:23:37 -0700 (PDT)
Subject: Re: [block/for-5.7] iocost: protect iocg->abs_vdebt with
 iocg->waitq.lock
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Vlad Dmitriev <vvd@fb.com>
References: <20200504232754.GB3209250@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4377265-1605-077b-9415-183c8efe3da5@kernel.dk>
Date:   Tue, 5 May 2020 09:23:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504232754.GB3209250@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/20 5:27 PM, Tejun Heo wrote:
> Subject: iocost: protect iocg->abs_vdebt with iocg->waitq.lock
> 
> abs_vdebt is an atomic_64 which tracks how much over budget a given cgroup
> is and controls the activation of use_delay mechanism. Once a cgroup goes
> over budget from forced IOs, it has to pay it back with its future budget.
> The progress guarantee on debt paying comes from the iocg being active -
> active iocgs are processed by the periodic timer, which ensures that as time
> passes the debts dissipate and the iocg returns to normal operation.
> 
> However, both iocg activation and vdebt handling are asynchronous and a
> sequence like the following may happen.
> 
> 1. The iocg is in the process of being deactivated by the periodic timer.
> 
> 2. A bio enters ioc_rqos_throttle(), calls iocg_activate() which returns
>    without anything because it still sees that the iocg is already active.
> 
> 3. The iocg is deactivated.
> 
> 4. The bio from #2 is over budget but needs to be forced. It increases
>    abs_vdebt and goes over the threshold and enables use_delay.
> 
> 5. IO control is enabled for the iocg's subtree and now IOs are attributed
>    to the descendant cgroups and the iocg itself no longer issues IOs.
> 
> This leaves the iocg with stuck abs_vdebt - it has debt but inactive and no
> further IOs which can activate it. This can end up unduly punishing all the
> descendants cgroups.
> 
> The usual throttling path has the same issue - the iocg must be active while
> throttled to ensure that future event will wake it up - and solves the
> problem by synchronizing the throttling path with a spinlock. abs_vdebt
> handling is another form of overage handling and shares a lot of
> characteristics including the fact that it isn't in the hottest path.
> 
> This patch fixes the above and other possible races by strictly
> synchronizing abs_vdebt and use_delay handling with iocg->waitq.lock.

Applied, thanks.

-- 
Jens Axboe

