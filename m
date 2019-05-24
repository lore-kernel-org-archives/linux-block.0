Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D6C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7080720868
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 13:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="EYXxJ25S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391408AbfEXNJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 09:09:01 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46904 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXNJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 09:09:01 -0400
Received: by mail-vk1-f193.google.com with SMTP id g194so2095299vke.13
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NFK9aapiSHvsfIUj35JfqUMZ2Y7KkhyrVEtoE1rNlo=;
        b=EYXxJ25SpuP4HuvEOLSk+zi+mVPSGhOX25UDQE/sUtZJKdvkLF44+bWtW1eWv9AX6+
         /pKQzpJ/ypcCzYcgtZcr7B44gBnyZFJDbYJnpzKHyFra6gwrZ8KSSrmUHBtB1+9TxFPS
         EGwMSJHMVfrBBvWbQzV/sH7BnQXaZqevzNOBAeBOsno0bv22fGAlf5FWntZzalS1VaAI
         ZoPzw2wsj0lnH7LEjts6kFv2LbuozDQLeclYFZIdYVaSHmtbgBQ98HAHq1x05qhuahsE
         Plt7dW56m9PAhslYjZ4hGEtZcUo7cpLNyehcLl1VvBT103zfKklMSuPHhSONGeWcDAt3
         yw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NFK9aapiSHvsfIUj35JfqUMZ2Y7KkhyrVEtoE1rNlo=;
        b=ZYFJfPCgBI2KgDpdPUt17ciy4NkBFZCdx/4PbYvaN2WMqPGsfTE3HIfuJvHHsOGD6R
         HcMSBKeT0jP/JTgQqGpAaeuSPX5DKu6Yih4C0Q2pZu+i0hWuwnrH6AlLljdbahy6vOLB
         zTtvb268c3oVJDk6nG1UP0PAM/wZxSEY9El4MMOwNG0hgDVPILsvxUBtRmwRkUxUBx/W
         tyrqY2rQbPfNZEf2135Rveo5r4vSJoETLivHiruEfsQZBVVJdzFqg7Pa2l735ExbozcG
         yPe5LL4vJXyTgBgW7B4NT5F26NdRqhRdmcGxPx2cVn1ZbKQzVn8gwRKHcQbB5skdlfWh
         YWWw==
X-Gm-Message-State: APjAAAV4IDai3PN6HL7FXoomwBR2fmh0PYnOp41O/rtpXwgfdxE4IdJC
        k9kJFp/Flq3w7VUzdWJrjdIqIQ==
X-Google-Smtp-Source: APXvYqwSNSRIsSEWFVwlmbvUZtMXOmCI7hQZGA8lIGGGG7uY/2hEEqrVZAFNsLcsasTdlDybTnGHdg==
X-Received: by 2002:a1f:9d07:: with SMTP id g7mr4795657vke.40.1558703340487;
        Fri, 24 May 2019 06:09:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e914])
        by smtp.gmail.com with ESMTPSA id 143sm1127525vkj.44.2019.05.24.06.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 06:08:59 -0700 (PDT)
Date:   Fri, 24 May 2019 09:08:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nbd: notify userland even if nbd has already
 disconnected
Message-ID: <20190524130856.zod5agp7hk74pcnr@MacBook-Pro-91.local.dhcp.thefacebook.com>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 24, 2019 at 05:43:55PM +0800, Yao Liu wrote:
> Some nbd client implementations have a userland's daemon, so we should
> inform client daemon to clean up and exit.
> 
> Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>

Except the nbd_disconnected() check is for the case that the client told us
specifically to disconnect, so we don't want to send the notification to
re-connect because we've already been told we want to tear everything down.
Nack to this as well.  Thanks,

Josef
