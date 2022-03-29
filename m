Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C07C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 22:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiC2WcE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiC2WcD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 18:32:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44081197
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 15:30:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m3so32709085lfj.11
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=pVfFf2LUiJ+lsVTn/1q73IQZHWiUdzX5dxpnEtrh5/M=;
        b=Jrjr0c4GoXhREc6Y0AuBp/HQXw7DCz11gV9pvXQC2uHO/Lx+rb0jidySb0jUtdMDjI
         3DuH9EqKXs0rVWa8iBLD6aFZjOeBWOQDnC6sOP1EzlxLCrsLBZQC6OiDfwZf5MeOcCD+
         9+brZg2Ra5mOgBJrkdC4VJUTwfgpSN4R2FUOBWpGID2cA76JzRyNDWDZAFPBAhfmXGXr
         9vsXT3zp4tYzYpMabRRa2K6THyetJCe0KpvV+RzTMc1A5SzCG+axrcLPnE2dtec0u4x7
         dZxzaT9jB/LYFsDSDsd9kS4o4p7QfijPX2RhruEONplfcG0vvh6+dzPHsIcajGsJ14j1
         4mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=pVfFf2LUiJ+lsVTn/1q73IQZHWiUdzX5dxpnEtrh5/M=;
        b=vXF8JHiEG/4jgu7lWng2EyRnDwX0jRqrSYLbvUjjzznwQy6LCAjq0WJXCN9FtMA8RV
         UB40Kqj5B+kXFRd1DbpxJKs3kw8H/EoVHLTBToDmz24evmc9Eir/AlYiBH9MSortuAxO
         OxqFLquzK9FRDDWFcpV8JU+jmaklVUX270HVkhj02nKmNER0Cmt3i3qcNJZDNbWRG4fg
         91E50Ozdx7jxSXTQYMDUpDDC+r7Or6B6HIgDbIVAR9DqbJu4toyxrpwC5OBdZG0L/FcI
         nNwG7tVOUM3ymysRzgM5mzaIc+Cn3UzGEcgypL6x5fPgIF/cB7dIxr7rBVc6ZlB0zSUN
         20qQ==
X-Gm-Message-State: AOAM533Vdotr7vXXH7eUpDkiDxCWbpSk3ku0AYQeQt4Psr2X/BelSt6c
        5zEm0+xlc8gzGaP6BaGq74sYQQ==
X-Google-Smtp-Source: ABdhPJwjPyIRXEqSaJ3aXsai40mgW0ySP5DWFmKQLoiwZAkLzP+t506D6D+qytxazIQad66XZ7nyZQ==
X-Received: by 2002:a05:6512:1398:b0:445:bcef:e4fd with SMTP id p24-20020a056512139800b00445bcefe4fdmr4506411lfa.398.1648593016505;
        Tue, 29 Mar 2022 15:30:16 -0700 (PDT)
Received: from [192.168.0.120] ([2.92.192.13])
        by smtp.gmail.com with ESMTPSA id h22-20020a0565123c9600b0044a3b2549c1sm2129416lfv.165.2022.03.29.15.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 15:30:16 -0700 (PDT)
Message-ID: <7e7c19f3-ec6a-9a82-5b6f-04edbdc7040d@openvz.org>
Date:   Wed, 30 Mar 2022 01:30:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [dm-devel] [PATCH 3/4] dm-qcow2: Introduce driver to create block
 devices over QCOW2 files
Content-Language: en-US
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <164846619932.251310.3668540533992131988.stgit@pro>
 <164846631540.251310.2398727490395218229.stgit@pro>
 <YkMK1cmWyEJGoMB+@infradead.org>
 <241b972d-5f78-6282-4f67-131a2566d479@openvz.org>
In-Reply-To: <241b972d-5f78-6282-4f67-131a2566d479@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29.03.2022 18:24, Kirill Tkhai wrote:
> On 29.03.2022 16:34, Christoph Hellwig wrote:
>> On Mon, Mar 28, 2022 at 02:18:35PM +0300, Kirill Tkhai wrote:
>>> The driver is request based, since this allows to use blk-mq
>>> merging of request. Driver splits requests itself, and every
>>> request (i.e., qio) after splitting fits a single cluster.
>>> (In some cases it is worth to create bigger splits, and this
>>> is a subject of further optimizations).
>>
>> Nak, please don't do that.  If you want finer grained processing use
>> a bio based driver, not a request based one.  This is just getting us
>> into tons of problems.
> 
> Could you explain what you mean? Why shouldn't I use generic bio merging
> code, but implementing my own merging? Which problems you point?
> 
> Generic blk-mq is well tested and lots of people work on its performance.
> It's not obvious reason I should better implement own realization.

In addition to this message. Possible, I confused you with patch description. Let I explain on example.

There are a lot cases, when block device receives sequential bios, which
consist of one page. The driver wants to have these bios are merged together because of
it's not a good idea to call call_write_iter() for each of such 1-page bios.

The same time, in QCOW2 format two sequential clusters may be placed inconsequently.
For instance, let we have 1Mb cluster size and mapping:

virtual device range      range inside QCOW2 file
[0Mb, 1Mb]            ->  [20Mb, 21Mb]
[1Mb, 2Mb]            ->  [30Mb, 31Mb].

This may happen because of cluster #1 were allocated later than cluster #0.
In case of a request going to [512K, 1.5Mb], it intersects cluster boundary
and we want to split it into two. Otherwise it impossible to call call_write_iter().

Solving the problem with 1-page bios, an implementing own elevator for only driver
does not look a good idea. Making an elevator with performance comparable with
generic block layer's is not a trivial task. At least it will require the same
amount of code that block layer has. This is not a solution for a single driver.

From the driver side, it tells block layer about optimal IO size, so the number
of splits should gravitate to zero.

Looking at another drivers like loop and nbd, they both are request based.
Necessity to split a request to fit a filesystem extent is not a reason to stop
merging loop requests, isn't it?! Also, nbd merges bios despite they are splitted
by qemu-nbd in userspace level to fit 1 cluster boundary just like my driver does.
Because, this is the only way. I've already tried another way, when I started
writing this driver as bio-based. But then found that this is not a good solution,
and converted it in request-based.

Kirill
