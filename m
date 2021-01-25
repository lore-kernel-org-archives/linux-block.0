Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E219C433E6
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3630222B3F
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbhAYSF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbhAYSFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 13:05:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A8C06178B
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:04:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gx1so89839pjb.1
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HFIw0n1S05QNXPbIf5jQGUjQnr5Q45q0C9PmXQ+j6PM=;
        b=Yd7IlCy2J+9XBpAHZFUsh1BSVxdpDbEN1+b66E1vTmLrRXPZaYT86wm0rnLIDq4uaI
         dbeIsDANBsMnu31ivGGIf4btiuUYelGwEZkFjprJ3IShrG9WO5o6KEDzjA73shaJ/4Qv
         bdnoPCA1HIdSuv2eQA1jZ7ecw7bVI5aVqEA5hKeJrKyJhDif1ObIH43ha8NY6t5bbFd5
         H0xopy8X2ElfNfCz7iiK9o5pTY46r5g8BrFe3ANXWSUY7k2QHxYS7u1y773f9b0pouzn
         RHH+X3RIBxASv/eqOFMNKY9yS9hWAPAkOwBHMszY7VE6EKLK7TaTSxEreGHCk5PD49MC
         N6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFIw0n1S05QNXPbIf5jQGUjQnr5Q45q0C9PmXQ+j6PM=;
        b=nOaqcHeJfmhjIshjmEpIpk6njAZz1d3rYtrfAISi2BGS0gbLWrlLmI5WTd+XhpPvhK
         vh+l8TiLIb/o+mRtihHG3LETd6GXOh03CiwBUy9S2WC6kyVaC9tYQrUS3lpLjxp2Qc2P
         L/ycFy7/27en/aK94n9qiPyaxpvxcEQv/2n85k+1CgoS1olP7OGwI9zB+bJHiQMpdGoL
         v8IhGrk/WfJYIp+zr/93hozNfZmSvB74Hb0ipOgOhc+5VUK+qVpAoBQoqvXXcrIjlit2
         il1vbbnC3dg4BJWfw478kNqWPLIVQktQrsGqhoVL1wdeBhhl1l4J5/DW8tWP+pfkzH9R
         swOA==
X-Gm-Message-State: AOAM530+DwGUdvZTKwzSDvIlZBjp7lhljjU1GD76tRD9ii6OUOXRUNa4
        zeLYDYiUG7Zxv7ovehDpaigtMdcVwPjPIQ==
X-Google-Smtp-Source: ABdhPJzd8uaUcdiXamsAQkzl3wvARZCWqAhwOv8o/vKaeqj24PgXQRalyDWSeRIX5z+g7aBfDYhmDg==
X-Received: by 2002:a17:903:22c2:b029:dd:f952:e341 with SMTP id y2-20020a17090322c2b02900ddf952e341mr1603962plg.67.1611597888016;
        Mon, 25 Jan 2021 10:04:48 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i7sm16885792pfc.50.2021.01.25.10.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 10:04:47 -0800 (PST)
Subject: Re: [PATCH] nbd: freeze the queue while we're adding connections
To:     Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
References: <24dff677353e2e30a71d8b66c4dffdbdf77c4dbd.1611595239.git.josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8393944d-f3d4-42e9-3814-032c141432f8@kernel.dk>
Date:   Mon, 25 Jan 2021 11:04:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <24dff677353e2e30a71d8b66c4dffdbdf77c4dbd.1611595239.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 10:21 AM, Josef Bacik wrote:
> When setting up a device, we can krealloc the config->socks array to add
> new sockets to the configuration.  However if we happen to get a IO
> request in at this point even though we aren't setup we could hit a UAF,
> as we deref config->socks without any locking, assuming that the
> configuration was setup already and that ->socks is safe to access it as
> we have a reference on the configuration.
> 
> But there's nothing really preventing IO from occurring at this point of
> the device setup, we don't want to incur the overhead of a lock to
> access ->socks when it will never change while the device is running.
> To fix this UAF scenario simply freeze the queue if we are adding
> sockets.  This will protect us from this particular case without adding
> any additional overhead for the normal running case.

Applied, thanks.

-- 
Jens Axboe

