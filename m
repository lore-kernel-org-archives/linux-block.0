Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94C7C43334
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 01:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiGDBwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiGDBwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Jul 2022 21:52:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F20265D
        for <linux-block@vger.kernel.org>; Sun,  3 Jul 2022 18:52:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l6so7288478plg.11
        for <linux-block@vger.kernel.org>; Sun, 03 Jul 2022 18:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=jlzlpgII0GMrAAcd80jEjz8oGoZ5GrnU6PvVA1R8yiU=;
        b=MYYXsp8jAC2jQkXxVBBk2SO7EwRKNcTY7kYo7/skmDGuXmdwyAT0gvwHZWCXje7cAC
         B6nnjFQHlUGvudlJXhvdVlqP6Nsp4Kew/8mAJYyBOc1p+/q7bzbpK4W3il/2Y3+t5S03
         LWyanopNF5HwXVqFtX1qjj6OXrrt3NfD2OCHcUn3dOpz3ZzAvyVRE6zC/hUvbqVgQqVm
         KAVhBRF4DTmKZomm8A2Tm8Q4Rx+U6fkp2PBURN3VITgCS3vNf0D54WbKQiI1bTxc8uFb
         dqaR9Mr57/QaVSxA+/8iLn+UfdF5Z/D2r0LYBEL/Bp7UNVRP+mQPTdDzjL6XgWkMvQWu
         QqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=jlzlpgII0GMrAAcd80jEjz8oGoZ5GrnU6PvVA1R8yiU=;
        b=oGOmWVndFwPfokK+IlydW4hS5X6FiWppm3a1BYQwlOBg3G4LP3j68QnFj728OPnC9j
         0fWMK/fXY6BLLnuHGGEKfNA/XbfSBV6dgy5qQo0Z5+WS78rhZJdnUk83zCIuiUCWSkcT
         SbQN2RT78a/O7uZlV1oZFnu5hr2gQ/X0A0JSQqLBCZni3rBz4kKa8k6ZJL5puJ31B2ne
         5EoLCtuiKgc89lO9gHimfUFzLN3q4M7bEVbQUyrFgWfJnR49cPZ336EMXlzu4D92OW2U
         bl9MNVmvaklKAjR7Bq7wLGnJTvJI0hQFcY97YLTQKehjp0KrXt9EFgss/xV39NL21Mx1
         Ge2w==
X-Gm-Message-State: AJIora89FkpvWIv075ni0PznB/3qsyaJgHKDy3FsfwsC2u0kSlsGd9H8
        PVZZnGs0KM6r56LukmpscoPXGw==
X-Google-Smtp-Source: AGRyM1tRZqWWSoA7w5kCfY6RHZ4HXSesoWpucMZNeORgv0J2Ql9G6MZYfmR/ZucTXPWg8lBczHzA1A==
X-Received: by 2002:a17:90a:db96:b0:1ef:8c86:eb09 with SMTP id h22-20020a17090adb9600b001ef8c86eb09mr735043pjv.22.1656899527674;
        Sun, 03 Jul 2022 18:52:07 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a174e00b001ef8397571asm1609430pjm.35.2022.07.03.18.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <7c4d3116ba843fc4a8ae557dd6176352a6cd0985.1656864320.git.christophe.jaillet@wanadoo.fr>
References: <7c4d3116ba843fc4a8ae557dd6176352a6cd0985.1656864320.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block: null_blk: Use the bitmap API to allocate bitmaps
Message-Id: <165689952697.1306443.9051111172793553499.b4-ty@kernel.dk>
Date:   Sun, 03 Jul 2022 19:52:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 3 Jul 2022 18:05:43 +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> 

Applied, thanks!

[1/1] block: null_blk: Use the bitmap API to allocate bitmaps
      commit: aa516a92584eabad397f0a47597b20754521c876

Best regards,
-- 
Jens Axboe


