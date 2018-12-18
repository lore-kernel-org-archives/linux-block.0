Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70330C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F73221873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151400;
	bh=f7YDmal4zaS59t4FNh85WqctGyssNzqUDY+0AA/M6pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XH3B1jQa36pmyR/LHVn1m8oV4G63pH/jSKMJIF6N44AxrHjYsSjp+1zJkxpl90rx/
	 Gqcr58xx0QZe4b9vzBjWRP9LhnuL4E8P2Au8f0Y97ejolbUbG7G7ue1DFh9ksxaDBr
	 LW+I8lWQDIRv0+JwAJtjd2JJDtIv9gxKtHHzS3hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeLRQlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:31 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41097 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeLRQla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:30 -0500
Received: by mail-yb1-f196.google.com with SMTP id e124so6701759ybb.8;
        Tue, 18 Dec 2018 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qxr/PEmJFsRrEklCc2G+CWcsbCOLd3hDZQ0GvBRgCew=;
        b=pvDaeC2cbDIqoVcA3a91jug0vWkjNpchLP/2I2Se4eWplDu/fuTKeXSS/VJV8ywV1q
         i9aIGZnHhCRXA6OCtBTff+pbjuA3yI/AmyteGwyk/ELfIMyGyjOd0u5u8a5SOEmS9IyO
         loJmL9R+FyAQmPEtz4V0PzR8dCuRwlkIpRyVKvJREujIeYdchZnzile8RH0l1A6BZpRI
         j68L6pqFN65vlqESWiDbK4M/bnJifR3Gc5TIrP1uASGG+6OO85l6m1TH3ogYBiDfjiyS
         V34/ZTwVwcy9A7pkAhG8JbqhOMNOXb7TEejxdnWjRpFX3IqFfOhMCPYq56irF+sNyjFe
         wQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qxr/PEmJFsRrEklCc2G+CWcsbCOLd3hDZQ0GvBRgCew=;
        b=U6rzVB3Ub3haAzvsHdsrHVSv+vcUqGYBoTD5Qnr+eRphwWtY1pnlzSEnGUyR1FNNme
         kPKcXrO54YkxnzsGrywufaLgDkVxMIKLeBBGUWNmHRjme0Jz6KFaPTt85uOEB8efp2CW
         ed5ugY8A0kADJVUYKrkkBaQR9/D4uQV9o6nXlotS2JQSmRrgQUDS3BSUR90nEqsdR67x
         U3MOkxlJiogJ/l2Vp46ENJ1vQ1nxNDEpmGvPe+Gyjr//jmjG+76KHc8QgYmD3MT+lsj+
         9lKHju18oyzxE1hQehDN38kEoLBUMusBl+6al2GrI6BWNsSwjL2doyfJqSJXXBJvSgwl
         IacQ==
X-Gm-Message-State: AA+aEWaNsV8pCJgDNlZPdbaChex4lBESPoCfndXYqEXOZIrjSzdtf1w1
        xe7VdKEYK2ERfWZGnymlPqU=
X-Google-Smtp-Source: AFSGD/XPNSc5mjbbY9XH59BLB/2z2usE7bQPynMjKTCa4gkvUWRUEqp3Xn2to4n3OUWAerQYf9dMCA==
X-Received: by 2002:a5b:3d1:: with SMTP id t17mr17820633ybp.435.1545151288729;
        Tue, 18 Dec 2018 08:41:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e01b])
        by smtp.gmail.com with ESMTPSA id y83sm5015892ywd.65.2018.12.18.08.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 08:41:27 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:41:26 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Angelo Ruocco <angelo.ruocco.90@gmail.com>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20181218164126.GX2509588@devbig004.ftw2.facebook.com>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
 <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
 <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Tue, Dec 18, 2018 at 08:48:10AM +0100, Paolo Valente wrote:
> If Tejun cannot see any solution to his concern, then can we just
> switch to this extension, considering that
> - for non-shared names the interface is *identical* to the current
>   one;
> - by using this new interface, and getting feedback we could
>   understand how to better handle Tejun's concern?
> A lot of systems do use weights, and people don't even know that these
> systems don't work correctly in blk-mq.  And they won't work correctly
> in any available configuration from 4.21, if we don't fix this problem.

So, when seen from userland, how it should behave isn't vague or
complicated.  For a given device and policy type, there can be only
one implementation active.  It doesn't make sense to have two weight
mechanisms active on one device, right?  So, the interface should only
present what makes sense to the user for both configuration knobs and
statistics, and that'd be a hard requirement because we don't want to
present confusing spurious information to userspace.

There seemd to have been significant misunderstandings as to what the
requirements are when this was discussed way back, so idk what the
good path forward is at this point.  Just keep the current names?

Thanks.

-- 
tejun
