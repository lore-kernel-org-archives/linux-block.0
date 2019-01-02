Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E2C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD622218FC
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546445013;
	bh=xJe4x5LoyNo23qHY2gish3TdOJX2Uh7Q5ewzr1+cbjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nKVHoyL4Nu5vdYzfwFd/GGHaaWMd3NWAXtpAlFw3cG/JqJs1G9fnNZfk74YGGsV0Y
	 qYoLvT35TykklVC9PQ00MTvTjxtrS15Ea877tzb4LpcO4PIWiPCsAZ3z+QXTf0XnvX
	 UDXCu2iKVe2raHpirNixwFwWtAEqaMIlevPKDYmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfABQDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:03:33 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36664 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbfABQDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 11:03:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id i73so12192602ywg.3;
        Wed, 02 Jan 2019 08:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u1Y5F5QyWMT81pPdUhO/4L6FwI8LQOLlKRkMDxzGx2w=;
        b=UJ0p0Wz7uxup9TAief0MdXe76Ow8aRiZXnQIibAx+cZyy+mDwHhPQpKVxkEDi5zJin
         ggIW/pbu/86h7LHHdU3hnO7kkKzvtFTP2XI6y4tEy1kvI/t8tMh2ZBiFsg3eD3oKV7bf
         Kk7OTZb0jVEv7dDlylaPcaFKhgQ8mh9G9Ct2BzpcUqQuyJU2O9qMFk5IkuuwL0i0VGI+
         kI9PMD8A1WU7/sTzmeCjtSfZWHziSTehGV1uUMsjYNtfOVDpt3X+s9lP4jVLVULmTQEX
         4E/KVcv0vXDmy7ve643oSX65v35qFiSm5Q+UOXFfS2rO5f365LVjnCEpE5+zMEqjbX7+
         bucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u1Y5F5QyWMT81pPdUhO/4L6FwI8LQOLlKRkMDxzGx2w=;
        b=hwEGGghQaY832o95kWSUyRT7ngV6llQG2d5g6ObJuOwOlklGJfmkSoxVm/Z0SbciVA
         XERjMJA+X3ch5CvDHmiihbcv65Lm5/daDV7aO3WrAkn9Clsr0HK8iDzNYaRSVR7kEXn0
         qPxe9clIYTwB7bgl6MuZ4/bMtPRKVXwN13khnPVsfxlqmhJ0/99DJMNkn054OOBi/whu
         JSFWywLykmXoRN8FPJu2w0/RMEEWuX8mWvvH+FFysVi/KXbpB8jXUKYoSDaHi2Mae23x
         NJ/j1eGs5HidUkq7vISYEfq32HZdB/gAIpmWZwYzwL3UhKt/sYqdBCMzmOYgGRmXYPvr
         YP9g==
X-Gm-Message-State: AA+aEWa77UoZXOOUIHAQFdJeBJReY4yJVHxKhFXRfbEaura/K5RQKsuZ
        mN/PF7ywSNCOxNMFKJpgTNQ3hlv2
X-Google-Smtp-Source: AFSGD/XRokfuq18vR8XdJiyPHASGxD98isxgDwv7M3U8ofu2gsfZHPafHj4vWrebUdFe+dBIL8tptQ==
X-Received: by 2002:a81:6257:: with SMTP id w84mr45542791ywb.273.1546445011281;
        Wed, 02 Jan 2019 08:03:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:f03d])
        by smtp.gmail.com with ESMTPSA id x4sm42970059ywj.80.2019.01.02.08.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:03:30 -0800 (PST)
Date:   Wed, 2 Jan 2019 08:03:28 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
        Angelo Ruocco <angelo.ruocco.90@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
Message-ID: <20190102160328.GR2509588@devbig004.ftw2.facebook.com>
References: <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
 <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
 <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
 <20181218164126.GX2509588@devbig004.ftw2.facebook.com>
 <EC4F9B54-2352-4D85-B56C-5800CFEBCCB8@linaro.org>
 <A360EBDC-B297-4754-AF5C-0A6C30D725B4@linaro.org>
 <20181227234144.GE2509588@devbig004.ftw2.facebook.com>
 <F2A4E669-8C79-46D7-8A97-2C561FF5346B@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2A4E669-8C79-46D7-8A97-2C561FF5346B@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Sun, Dec 30, 2018 at 11:25:25AM +0100, Paolo Valente wrote:
> What's the benefit of throwing away months of work, on which we agreed
> before starting it, and that solves a problem already acknowledged by
> interested parties?

Showing multiple conflicting numbers definitely isn't anything which
is agreed upon.

Thanks.

-- 
tejun
