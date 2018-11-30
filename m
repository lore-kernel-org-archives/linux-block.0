Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A6C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C0120868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AihkWRCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C0120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLAFxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:11 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46782 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 00:53:11 -0500
Received: by mail-yb1-f195.google.com with SMTP id x130-v6so2478440ybg.13;
        Fri, 30 Nov 2018 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJNi3nIVOoVbO7Y5pWDXSGG5tKiGbvOBa0lUgfaESs8=;
        b=AihkWRCXAWxzlN+ySJS48rRtyz8NKzZlPyudz8lqJTero4AR9knrHnB0mn8T7ZHUBU
         RCqlyhQYS+CRo9lRtnzzLKeU8HanMo9sJVW/2vz8rTMH+quIx7Jx204Kvq6vP0QiYCsv
         HiEWLV5Zh96TdP8j5F2OIJd2KowyL+pNHXPy5N148OVYxmbvur5+Bl4w5KPAUoZsVmtD
         NBJY4LqcrYiiGLgorcO0UMtiBtdCFDq31lxqg3OP9AtS2jxnxLuAP8E5KUrqgAoFWxdI
         UyCOEpeQqNmEU0Tzlr/v3fN9Z+qjyHQqlm9nHQ+KDA7XTFxNcjT4iCpb7CN/lgebKro9
         Pfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJNi3nIVOoVbO7Y5pWDXSGG5tKiGbvOBa0lUgfaESs8=;
        b=mTwmkcLyA+6dZWtuFrVlAqbf42YalnQyyqI4i6iG3ke6aB/GzsGIiTRVt8YoHWnds5
         aUrkfEzfALA/NHO2EvNPhcCpfWHDI11/Px8oi+ZxCmKxhM7hM73Ntu0iHSVSj9MVJYBD
         YFV9UxaSpN8S5LRZBErgzRghQi23MFxqvcYNBfJag/9OWPD4EgWsMWAq9GviddPDFPAX
         MzyiaEeh/dbrBV87LS6gN0WR9BmmKDSRZGhtG4zkyTQndK1hQ5uCrg6ejnGr5+UfKW4Q
         zTNRIc25ErPNiJbwz0Bl4Ql3LGb5TcxPQWVX8IpHMOoQNHD+YJgbkQwSUC4Ol4FtmjJ9
         tqOg==
X-Gm-Message-State: AA+aEWY3vmXznn7ewxeKn2g//kIij3gmJz/MeOqrbKZ9Y6ejIbMUkYmt
        01B8vivyxJZxXO/il3BC4UXeMwGJ
X-Google-Smtp-Source: AFSGD/Vf1Eu8uyVwb1BfsBNqdm245XZCsPIesXVZjDc2Ycn7KMNmZ4ZA239R5JvUGdCLO8dvCoW0MA==
X-Received: by 2002:a5b:a8e:: with SMTP id h14-v6mr6377743ybq.458.1543603378769;
        Fri, 30 Nov 2018 10:42:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:51cf])
        by smtp.gmail.com with ESMTPSA id m3sm1696262ywe.90.2018.11.30.10.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:42:58 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:42:56 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, oleksandr@natalenko.name,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
Message-ID: <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Fri, Nov 30, 2018 at 07:23:24PM +0100, Paolo Valente wrote:
> > Then we understood that exactly the same happens with throttling, in
> > case the latter is activated on different devices w.r.t. bfq.
> > 
> > In addition, the same may happen, in the near future, with the
> > bandwidth controller Josef is working on.  If the controller can be
> > configured per device, as with throttling, then statistics may differ,
> > for the same interface files, between bfq, throttling and that
> > controller.

So, regardless of how all these are implemented, what's presented to
user should be consistent and clear.  There's no other way around it.
Only what's relevant should be visible to userspace.

> have you had time to look into this?  Any improvement to this
> interface is ok for us. We are only interested in finally solving this
> interface issue, as, for what concerns us directly, it has been
> preventing legacy code to use bfq for years.

Unfortunately, I don't have any implementation proposal, but we can't
show things this way to userspace.

Thanks.

-- 
tejun
