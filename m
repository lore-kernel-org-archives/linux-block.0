Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D8C4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C621670
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 18:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="NhdREHYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfIQSPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:15:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34804 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfIQSPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 14:15:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id j1so5649720qth.1
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQ+0M0/WVNygt2cMw5fxv2wOXAHtOs7ihKD2fLrdSxU=;
        b=NhdREHYeK1gG8XEY9PKiQ+J1gPFifIsRBIMd0aMa0qSUDqO1RXKoOV1V6oPLwlFrQf
         WotaXZvB8ryyyMW7+NkvIxqsw+q/6SFFQjEZiXN3Gmm0T1FrJcvOC4i1HyTrV2iI8YrP
         UosYzbLQpCq4wwYgvUwhdKiAvHqpgGInMNcJJ+BOM058BZCHapUFZb+WqyLNMcIosx9L
         TrBXsExwjp8FbVgKpQQd7r08Nd7d8rrjOf/0Wovyk4AbXfnsj0BgOCkLFmmJCqgbgk8X
         1J35Y1SOnBm/YsIfw1tIz8U70NeitfLa3eAv5Lr/eyliukwn8W/yYPq42hyxIvMDmvtW
         dVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQ+0M0/WVNygt2cMw5fxv2wOXAHtOs7ihKD2fLrdSxU=;
        b=udbyi2tRgDiNSO3gPz43Iz3VBx9otq6sQPa60041kOauVWPwEcNV+J3ASUDjB7E8dA
         7HsNy8w/30C7XGhotdFcg+ljj7R855qsngd1IzdXEVH3Typae60v85GnIFJCtQhFI7vL
         fNs5EhRaaJLuKCTZSUXBJ7nAnOuoBpl/6Zj7Ld30pgTm0sftmCz/MLKDaArpXUrvcYLB
         TN2SqJNkpNq5BWOSZnWk6P/Fj4UlU+HzhIqvzspuMZp+ndbhuOwGK81zxyQdS+bDQFER
         YzGjRho4lDTDpP1KtIBK8DryI3GVBUhOv1ixhTY0S53oFkBRXYHUrhEy6eeS6jlJZXk+
         25sQ==
X-Gm-Message-State: APjAAAVwOy6EOmOh7xIP66u/lFcKTvD9/pzwsTVr8J4ze90M2+kQB5q0
        3dxxZyY5XEREw4nyk4NV/ZmXYkc0r+5U2w==
X-Google-Smtp-Source: APXvYqw8aVYBKIlmZO/KUuZEiPAqNNdx14LgA15kI75f7hjfa7CPTyVgrDCQWXCcCLMiWXZoTMHsWw==
X-Received: by 2002:aed:3689:: with SMTP id f9mr89428qtb.5.1568744135946;
        Tue, 17 Sep 2019 11:15:35 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c185sm862385qkg.74.2019.09.17.11.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:15:34 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:15:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 0/2] nbd: fix possible page fault for nbd disk
Message-ID: <20190917181532.ovtqxunxgbx6rhop@MacBook-Pro-91.local>
References: <20190917115606.13992-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917115606.13992-1-xiubli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 17, 2019 at 05:26:04PM +0530, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> V3:
> - fix the case that when the NBD_CFLAG_DESTROY_ON_DISCONNECT bit is not set.
> - add "nbd: rename the runtime flags as NBD_RT_ prefixed"
> 
> V4:
> - Address the use after free bug from Mike's comments
> - This has been test for 3 days, works well.
> 
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, Thanks,

Josef
