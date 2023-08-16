Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A61C001E0
	for <linux-block@archiver.kernel.org>; Wed, 16 Aug 2023 15:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbjHPPfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344293AbjHPPfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2023 11:35:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D42684
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 08:35:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso8751075ad.0
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692200108; x=1692804908;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BSe9V42ZjtjuXMIoDT4hSOqjzajl/G7+W7al4NwnG4=;
        b=R7Rs2/sf24gsIDZjlQms+eyYWUz2/0CJsU9RFJ7Dn5+4oSHJw+SZ4vULdGXt/O740p
         Z5pttQBpbrgVNR14qcT+K5wP3bHkQ0U2OwQ+aTClIilJuhULK8ybnmTmTWGLFW8Vc6d5
         p2Znx7+NeXxe6tm8Nhhr1j8yfcQ+cWPpbjo32j2CITs+y17/P2GzZ77WoP7sT5j1cKjd
         gIQvVAjlObx+1yAWu+eb4fmQUlep9m6FZgnolzzMTpA5F94OGDkW3zt4e86O8NLOZszo
         2ef5K6ENGEsPGexdC4bL1RB8xv26qddXtFckemTOpFqftR/zecI+unwCzZIlrDr2aR3v
         aRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200108; x=1692804908;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BSe9V42ZjtjuXMIoDT4hSOqjzajl/G7+W7al4NwnG4=;
        b=cA3KFfOPxCjRz7pcf9mWsPARZuYdlPuZA2iO8IYAW34SqNMUJHrhgmW38KK6kSgCqe
         7kM/lzPz/AV4Ief5/LkZw+ht5rQGF2dxW3eFuRHyaxeGX96Z+qowbm9cJyyels3yPe5G
         LIeczB73IXx2gryBCSUK0NCG/aBEUFs+XZuS0O/s/ebRDNEvkzs+ACx+07miKed4seK2
         Ul/A49Zk++QtO/HRIVCN6m3qLbT+PpBvWl72tAHALeij67tIiTaqgZxqLzHuOqPeV1/Q
         H+UqPtbL7650bSkKO6lo+WLDmxeqnp4i6QkGNu0GnUFi+ShNmgkPw0NZR/LZl3GPqd9A
         LrHQ==
X-Gm-Message-State: AOJu0YwhGwJgG2Bkw5LmqlRkh8q451JntgXpbkqyNHeRMJwW36IFrpWT
        jDO8go7Hc0QIn/CZBRlAJrsMzw==
X-Google-Smtp-Source: AGHT+IEtleHAvQ8fA+Y80krT+tushpsxY0E++kAgT+7p3iSw4XZ76AS5edOAH3O749HA0GqFhekZxg==
X-Received: by 2002:a17:902:d48e:b0:1b1:9272:55e2 with SMTP id c14-20020a170902d48e00b001b1927255e2mr2607209plg.3.1692200107704;
        Wed, 16 Aug 2023 08:35:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b001b80d399730sm13311779pls.242.2023.08.16.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:35:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
In-Reply-To: <20230816022210.2501228-1-lizhijian@fujitsu.com>
References: <20230816022210.2501228-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH] drivers/rnbd: restore sysfs interface to rnbd-client
Message-Id: <169220010662.516163.3901210902059231374.b4-ty@kernel.dk>
Date:   Wed, 16 Aug 2023 09:35:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 16 Aug 2023 10:22:10 +0800, Li Zhijian wrote:
> Commit 137380c0ec40 renamed 'rnbd-client' to 'rnbd_client', this changed
> sysfs interface to /sys/devices/virtual/rnbd_client/ctl/map_device
> from /sys/devices/virtual/rnbd-client/ctl/map_device.
> 
> 

Applied, thanks!

[1/1] drivers/rnbd: restore sysfs interface to rnbd-client
      commit: f4283bc7e38ac89d0c6c0ae188464d3769bec098

Best regards,
-- 
Jens Axboe



