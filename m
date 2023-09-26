Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F11EE3F2A
	for <linux-block@archiver.kernel.org>; Tue, 26 Sep 2023 06:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjIZGn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjIZGnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2023 02:43:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20082E9
        for <linux-block@vger.kernel.org>; Mon, 25 Sep 2023 23:43:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso1447248f8f.1
        for <linux-block@vger.kernel.org>; Mon, 25 Sep 2023 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695710627; x=1696315427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU0wg62lr2xNjaScPCD+4bLIPZbMjKJ/swUkKHzUNCg=;
        b=sGrWUYCBiJQXmND1bAGvoN10uLNOTnG11fEoheFBpk27R0lxWcpSQNdTlIlXVuA14U
         j/L3o/m8qZpvMybFzIi9laK32dHgcJkrKALWQ2EsXorFZi9fh6Ky57J18JTY3saEk2Pu
         Btn/+vtGoGc3mz8/wdghRydCI5VJ1F35fZjz7czh0ktRxrOYkiQj+vzX9xRriUtLChLU
         CwFU7z4zoiIH7Qp4a1UKKCXo1GKTVYzKX72lfLkuUTre2YFro9MjcxggtOzajsoaxElH
         6Nr5/vcno6qXT/WXHJZRtzWcKozd+Yk/9wnwsfRjVfHC+CeWv8gRs4UjID3sUIEMP+0t
         tofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710627; x=1696315427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU0wg62lr2xNjaScPCD+4bLIPZbMjKJ/swUkKHzUNCg=;
        b=qF1YZ2d1afPJSiUdYVvpTw0D2yHP7wZ2ROaqCc1LpissGntU4VyZ/fByBPnPPr4Tza
         4NdqY8w6DMRwuOVLJdOdl/hE9esYAmpmC0lZlVzavf9CwHAJdF+MW0vrV6EsipeIxAfR
         pHLQdXSGiiJ5ecu5SnZ89j4ak130hnWiiON/AIZwSANmVahgLCXz1q7aor0bfCnEQRUP
         61E1t8QYKr05k4a7fDQYvlBnVODE2INYfcFeu2iIfoTsohq3jVpQdMnfYEzR0wiHtGVW
         R1tpSgBJcBjApk4FXSM6BYvD2m/5QLfPOG/9vwFiudRZRUreAru4m4wL5DJzSMMyabuL
         dIaw==
X-Gm-Message-State: AOJu0YwVt2o2dEE23tduH3BbvT7EV6USg/ezFZxXo4+VU/TmtprMAfjw
        jmU9kwVQhadZ7pHMfGx9Uy8NSA==
X-Google-Smtp-Source: AGHT+IGDVncgjlr1M8g8f5L3NQijHmN4vBIf89YmGQkfQudDtKc3xid0isSrBgZT9hJ0XdBtdMlXPA==
X-Received: by 2002:adf:fc89:0:b0:317:7238:336a with SMTP id g9-20020adffc89000000b003177238336amr6910141wrr.5.1695710627495;
        Mon, 25 Sep 2023 23:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b0032167e49619sm13758109wrw.5.2023.09.25.23.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:43:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20230926005232.23666-1-rdunlap@infradead.org>
References: <20230926005232.23666-1-rdunlap@infradead.org>
Subject: Re: [PATCH] block: fix kernel-doc for disk_force_media_change()
Message-Id: <169571062634.577707.15764939880513654865.b4-ty@kernel.dk>
Date:   Tue, 26 Sep 2023 00:43:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 25 Sep 2023 17:52:32 -0700, Randy Dunlap wrote:
> Drop one function parameter's kernel-doc comment since the parameter
> was removed. This prevents a kernel-doc warning:
> 
> block/disk-events.c:300: warning: Excess function parameter 'events' description in 'disk_force_media_change'
> 
> 

Applied, thanks!

[1/1] block: fix kernel-doc for disk_force_media_change()
      commit: a578a25339aca38e23bb5af6e3fc6c2c51f0215c

Best regards,
-- 
Jens Axboe



