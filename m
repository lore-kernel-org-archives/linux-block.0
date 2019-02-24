Return-Path: <SRS0=0UXK=Q7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430CC43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BF7206B6
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 15:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP/lgAIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfBXPhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:37:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXPhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id s1so3284323plp.9;
        Sun, 24 Feb 2019 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OC7kn1GcMpo3s3dcHCTtzeyKC4a2ZnIHHhN4xw+WDZc=;
        b=mP/lgAIPrpq+WUjaR+QfNzLzKVcrCKEd4VYrOFsSH01scsp/yFv3VuKqx+QHrL5QCc
         E+MmQOFrH/mJeDQlJ7slQBiXZZ5zQ7UbwPuL7KKOdxHZH4/tyFe5RPcTVJedXLCwrLQx
         AA+AqnLyyVEuir8fJC6rcy1p/kI7u8DzN6p9dDDxJ3HMLjfbZsmHoMYz7/yIZhmCaYCO
         2kyuTCocGn+CCtmrXBP+dyDlLuuQ6LbD5zyOLUqskaoPOYO6pA0ushxAe0XmTW8Ps3FL
         OVIwELCMAgd9XfFMKsPR8ks0enhKyfYZHRJYVXnixCg/THuZ3NBvjWQEATQNqUV2jTsn
         U4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OC7kn1GcMpo3s3dcHCTtzeyKC4a2ZnIHHhN4xw+WDZc=;
        b=XAEus+Nk9juJOLwFa3g7w3TUT8zS5yMvpmV1aqbAar157JFcQf7Ql47L9K+nuaBRbG
         ib+xVw8P3VV/GA+AbWB0Eh85XZOpqYWIMOO+Cddu0Ej6tGJp6UtlUIsIMNKHDpp4aD5U
         3OcuBTb7V4KFphvf37LR6IRKaC4udIEhHs9ByjYa5NUKv6Pk0n7qR4GASBV2x9XaA9Ai
         olEz8tvevP3XWJwDmWg8vyXlViC1woGb8xfzed+jULpSNmZJKwtfd+iWURAzYZnRbhKn
         Ap4Kv6ULis0Gx+zFhIulw/pMVcnxGMBomegFuK/QJszlfZBUHfzh+3R/GAXrIP9LGgPX
         UlvA==
X-Gm-Message-State: AHQUAua0iSDikYP7jcnHQAk4tdI0xY27LMtXExvgwllOExSwHHwhs546
        2YiUPOIrl8AA+urDSveESYA=
X-Google-Smtp-Source: AHgI3IbKfYGx9V6SKMI5r52yJoURkNInZW7c6ki1Ep8hKcohbvRdQaEK8qxXt9TGvbEdtmFWULIoag==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr15009276plo.112.1551022638230;
        Sun, 24 Feb 2019 07:37:18 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id v26sm10588675pfg.62.2019.02.24.07.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:37:17 -0800 (PST)
Date:   Sun, 24 Feb 2019 21:07:12 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] badblocks: Prefer unsigned int over unsigned
Message-ID: <20190224153712.GA11981@bharath12345-Inspiron-5559>
References: <20190224141952.GA3653@bharath12345-Inspiron-5559>
 <b96f9ac8-639c-adfa-e0a4-5ff537bc9db4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96f9ac8-639c-adfa-e0a4-5ff537bc9db4@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 24, 2019 at 08:15:30AM -0700, Jens Axboe wrote:
> On 2/24/19 7:19 AM, Bharath Vedartham wrote:
> > Replace unsigned with unsigned int to improve readability.
> 
> Frivolous change, would make a lot more sense to get checkpatch
> to stop complaining about this.
> 
> -- 
> Jens Axboe
>
I understand. I am starting out kernel hacking. I have been working on
fixing checkpatch.pl warnings. If you have any tasks for me in the
kernel, it would be great.

I have also noticed a lot of warnings to replace printk with subsystem
specific warning functions. Is that a valuable change?

Bharath
