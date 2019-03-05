Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1242FC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 15:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D725320657
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551801401;
	bh=iHVExEbsdI0GDCHdo1Pm4tsZAQgiTHubqlSUbu1Bl4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSln5BQAsdR9CMZsIdPhobQEpFHATCFQidDIBrG7t+jV1OHjwhYNRwF+l6Lmg1C1F
	 /qalb1W6pbkNPquuPEYb+uVS85nfH53L4A/qmuCMb1hgWJNQ4xSzPE6Q2tcQlpBXCr
	 GOf1+uj22ZqELQ+oeQPYw8P+yL0qBi57iN2+2+a4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCEP4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:56:35 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43286 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfCEP4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 10:56:35 -0500
Received: by mail-yw1-f67.google.com with SMTP id u200so7315865ywu.10;
        Tue, 05 Mar 2019 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WTMGFXEwvv834bUyTqH/FDpKhZyzE74Gv015Xci/W80=;
        b=gCM3lObLREqor6Te5QIeF/noQouXPJTTJIhg3fABbhNjvK8U4od1/wtuVUjK2ouuB0
         cIKrr3yzdiuMxfDvFAXplqwoUVJZHron5JR9U4NHXgJYOR+eZ38X4BiY9GKL50rYgDaI
         SGR9OwbLxUEDjidc9ra8qyYdHOykYF8H31DQMeJMhDyFMnMT/eFxYZYeW4/ScfWkLhRy
         jDnScWmM9jJ1H/5foAhWFWpkzc8NtGJgk4G98tXfiVFSeaS3fsJJPdNwc0zYTen10JFX
         oW3uCgzeZSSJpagaMW/7lG/g1loAormNguDSkYBY+b7MnT3wRSRNkutdqn4dtViQGfoC
         9Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WTMGFXEwvv834bUyTqH/FDpKhZyzE74Gv015Xci/W80=;
        b=KSRPqZ9OKD0C+SYjJZCHB+MA4hKCnzzpizOTrUOGeUYL+HK5yajB5agHYJtazkmP9E
         SNIunRZWOCt1G4NZX9HFNQzRKt/p38as4jk1H+YY/Fl95CDrgx+DeLECo2ScDB6QjFgx
         HgBXuxs6vCmpZqd4x7HxICDCD9oxPIW4SB3v6JVDCqwL3ZUvTjCewhRI/R4oEUsFJbhQ
         1hVL+OSEOcwC6AKSQ39BRGkDqfomRZ56oc9jDuDMn9kfG+q6R8+y/IWIzYDtwK2JtTrk
         o+XAHf0O6fQW2vcJ/Qb2b20oQkFg3mWQsOJmYOAL1yEFdSdARwcboriTRgpNpGGuutFR
         +hVw==
X-Gm-Message-State: APjAAAXZ99iwIoynbKvOsTNuDHIjRXqVaJr7JLA9APA8stVFFzx5ntPQ
        BgjK4NhInptkLUSnKXfNX/ZLNe/e
X-Google-Smtp-Source: APXvYqy1YtNR0Rg17eysMQjQusFj2gyFemvar1vhni7du34/bwUqUz+Kqb61kXxZaxHL3YVBDgtAzg==
X-Received: by 2002:a25:e86:: with SMTP id 128mr2755319ybo.10.1551801393613;
        Tue, 05 Mar 2019 07:56:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1676])
        by smtp.gmail.com with ESMTPSA id h8sm3598373ywa.42.2019.03.05.07.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 07:56:32 -0800 (PST)
Date:   Tue, 5 Mar 2019 07:56:31 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: verify format of bandwidth limit and
 detect overflows
Message-ID: <20190305155631.GC50184@devbig004.ftw2.facebook.com>
References: <155125474480.292717.11530762471075713387.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155125474480.292717.11530762471075713387.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Konstantin.

On Wed, Feb 27, 2019 at 11:05:44AM +0300, Konstantin Khlebnikov wrote:
> Unlike to memory cgroup blkio throttler does not support value suffixes.
> 
> It silently ignores everything after last digit. For example this command
> will set rate limit 1 byte per second rather than 1 megabyte per second:
> 
> # echo "7:0 1M" > blkio.throttle.read_bps_device
> # cat blkio.throttle.read_bps_device
> 7:0 1
> 
> Cgroup2 interface has the same flaw:
> 
> # echo "7:0 rbps=1M" > io.max
> # cat io.max
> 7:0 rbps=1 wbps=max riops=max wiops=max
> 
> Also sscanf does not care much about overflows.
> 
> This patch uses modern function kstrtou64 for parsing.
> It rejects trailing garbage and detects integer overflows.
> 
> Also this patch handles iops limit overflows for cgroup-v1 in the same as
> cgroup-v2: limits >= UINT_MAX becomes unlimited.
> 
> Fixes: 2ee867dcfa2e ("blkcg: implement interface for the unified hierarchy")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

So, I'd much rather keep the parsing implementations simple.  Unless
there's a correctness problem (you mentioned overflowing, how would
that happen?), the simpler the better.  I don't think the kernel needs
to be in the business of strict input verification here.

Thanks.

-- 
tejun
