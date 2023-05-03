Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4884C7EE21
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjECPjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjECPjv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:39:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C466E9E
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 08:39:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33110a36153so693535ab.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683128390; x=1685720390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVVLdXvIfrw5/3NYijIBIn8HUk/59pymTlkCnyX4gZk=;
        b=hhwOQ1IRNoMXnJdreafhurd7FFlfWlG7ggNpHvGfTwl86HQaxurUdjbTsPCn5g21J1
         WZJUWtptO9CY6OjNiJxnwf2pAtUpeg45ezOSpKhFaDLQj/DAo03745KRyQ2F+QyJoIC9
         4naFiUVk5u0JT3Ssp6HMtEKLywdZYoB54T3elj56qZ3er+ZZv4fyn9T/mJBkQ/dPt/tY
         tE/fUiEnL/YH6Y0TeFqQkPJI5ZEUkgUzquCEMsLcJOOtiES45axH7nEo7sWfo1YQQFRC
         eYhAld8YCZZzXDAqT3Q+RvaF8Lp4Cojc9jUdaquf4cvNbFV7wjzl8SMIGxY1Gjl7gFWK
         3YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128390; x=1685720390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVVLdXvIfrw5/3NYijIBIn8HUk/59pymTlkCnyX4gZk=;
        b=OoO4NovHA58yqsKrcELRIutFWP1dmYTGD1gI20Y0LVEyNZthBZ6bEs+9pngiQszSYV
         SFgstvBrPaoRvlznV8t64aTngBo2Y2kfbMtkklLPGzkN9U4CT9SUSXtqf0kl1FaYSKiD
         89qDAT156K6LP7ksca0OTi9gK1coKXzHrPdkS27TTh6lv8FHG88TcQFJyDbaC3Z7z9SJ
         s2g15dabm44ZhA5Kzhc1dUaiIoHdWSP+mvlpGENjR5qT82jU0GqEiIAZSycA5d0m2kZh
         l2/Mn1ByFFnnOrbB9VR8ctc6iLOXnV3ouoz2Xa8E8oO+kElLuk1WihrijsKaGOMCJwUt
         N7Aw==
X-Gm-Message-State: AC+VfDw09DnAcISuttSyyvsEY+1Zv3UwVRG44R2HUMQkn60NBRcurihZ
        +dJJSM3NsYDbz5kh/j8N8Kt7Cg==
X-Google-Smtp-Source: ACHHUZ5d4YwH96Tpn6LfKIxiZcp69KtZgmoa3BJZVXRNO88gwL/jKwNV6SF+0qAXwiCYWhzG65q3sg==
X-Received: by 2002:a92:7402:0:b0:330:a1eb:c5a4 with SMTP id p2-20020a927402000000b00330a1ebc5a4mr4047857ilc.1.1683128389782;
        Wed, 03 May 2023 08:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cd23-20020a0566381a1700b00406147dad72sm10232284jab.104.2023.05.03.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:39:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        stable@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
In-Reply-To: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
References: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: correctly submit flush bio on barrier
Message-Id: <168312838868.941317.975898202413701616.b4-ty@kernel.dk>
Date:   Wed, 03 May 2023 09:39:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 03 May 2023 14:19:37 +0200, Christoph Böhmwalder wrote:
> When we receive a flush command (or "barrier" in DRBD), we currently use
> a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.
> 
> The correct way to submit a flush bio is by using a REQ_OP_WRITE without
> any data, and set the REQ_PREFLUSH flag.
> 
> Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
> flush/fua bios"), this triggers a warning in the block layer, but this
> has been broken for quite some time before that.
> 
> [...]

Applied, thanks!

[1/1] drbd: correctly submit flush bio on barrier
      commit: 3899d94e3831ee07ea6821c032dc297aec80586a

Best regards,
-- 
Jens Axboe



