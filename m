Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE33C32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjAROm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 09:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAROlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 09:41:40 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463245898C
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 06:33:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id u8so17063012ilq.13
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV/bqJT0gVZWvkACWfZdZZBtU/ph+2jBiIeN5ghXaKM=;
        b=n3SEWKvZMrtu6BXBZWwuNIsCVRUCpTUXN0rOG6ISeO93P8PW5eHsTAdVEKJy3J/9Ht
         ZEqyHN/vantWbegueXVI1qUjY5BWOMsWsUBzd/8DP82H65mqhfCMf7fT0ZslUwTBix0K
         gTo1vBDup77kHOyB9CkSs0o4VQrIwBqYNK+O75G9P9R8Eks1X2mrwghcpBRI1Vf+7noB
         qQXs9t7PtlvpbzyWJCAA1EcVttgmN53X6rxP8ecpoRnnX5QPNxJgcbgoI6MTkBUbLoaH
         U7+Tn1TE4zr8iAeppFWyslTAn+vrhximYW/Gb9spXMMvAKjlGR8GuWlzqrl5X/TKcXHZ
         6B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV/bqJT0gVZWvkACWfZdZZBtU/ph+2jBiIeN5ghXaKM=;
        b=D/1U66KAlvLp03V7Mh4xJp8XBW56UYOWwMP47PoWTrxxn2iux0LaHGSm8RY2LKJMnG
         XFQWJUHifx7bzH30gYbmMIUy5gt/ISWodwe2eA36mfS75kLV3ZbNBuwk/sGImTCWrIep
         TR/6qyj1vOnZLshxqsPR3O1J6sh70AlWm0V+Fw/YkoXAVOTw+3bgcr28TRCFXGVz/5Rf
         5xc8E1NESQg/SdD4HjzHJeAG2CLpXZc2qzLCeuCbhtUnUf9BP/tcGIUIqbdwQ8W+AoON
         VWPwShPgzT80IM2tYlXPMsNwFCOJOyhzxW/7r1hniLl/PABAD2ULC04GMpr3WEC/iMe/
         rQCQ==
X-Gm-Message-State: AFqh2kp0WvL1evMEm+ChxBD0JELeQNwoVjecLoNaUuWm30W764lCtzS1
        voPT//qrSfAEtBI2Vn8ip4Sb/KhaHf2pUej5
X-Google-Smtp-Source: AMrXdXurdYq56S6XLRII2FFmbvU3TKa69cl6igLZgzY3Ock9zecoFcBozomK0bRFtQrsgcj+zE0MDQ==
X-Received: by 2002:a05:6e02:d4a:b0:30d:6d3f:59e5 with SMTP id h10-20020a056e020d4a00b0030d6d3f59e5mr1210972ilj.2.1674052384469;
        Wed, 18 Jan 2023 06:33:04 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m30-20020a02a15e000000b00375a885f908sm6801456jah.36.2023.01.18.06.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:33:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20230118042318.127900-1-ming.lei@redhat.com>
References: <20230118042318.127900-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: ublk: fix doc build warning
Message-Id: <167405238353.131182.3975035373952672227.b4-ty@kernel.dk>
Date:   Wed, 18 Jan 2023 07:33:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 18 Jan 2023 12:23:18 +0800, Ming Lei wrote:
> Fix the following warning:
> 
> Documentation/block/ublk.rst:157: WARNING: Enumerated list ends without a blank line; unexpected unindent.
> Documentation/block/ublk.rst:171: WARNING: Enumerated list ends without a blank line; unexpected unindent.
> 
> 

Applied, thanks!

[1/1] block: ublk: fix doc build warning
      commit: 5d5ce3a05940b3d72cfe8a6d22efd8e533f59d80

Best regards,
-- 
Jens Axboe



