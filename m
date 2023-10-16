Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8ECDB474
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPUrs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPUrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 16:47:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53245A7
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:47:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-325e9cd483eso4826320f8f.2
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1697489262; x=1698094062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO8iW+Aewu5dyhHhxqYtvkVfM0D0owqLsE+KQIP1q7k=;
        b=yCbnmADcIviPaFt/1DSKt6mgS78EhpYj8U9r+gF2fQBhcsNJCCmg0kemuDNR8+h/Dl
         HxnCGQB0Xh2N787uUldsM1qCzkm/2JKrTBw071Yl0OfuZqhSAQkI9QqK+TDOOJwjRgC1
         V8rBgBiVAfBZI0F9jKQ2AoRCJmSeqp8LZYoUz2n8NKcQHp1MlZOXdAwYvfYeBmd2vJ2b
         pQefJVy3s7BcUBemr8g8T22JuyeIBC9ink5h5OPF+HD2I3dUACLmMype9faXkTZ8Vh88
         77ahAYWomi0H5oYZetXOH2xiXhRr3SmVIcFsCpUmqrzs4NP+VR1Evz8JxPC/LCkSZ68b
         VqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489262; x=1698094062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO8iW+Aewu5dyhHhxqYtvkVfM0D0owqLsE+KQIP1q7k=;
        b=fGwa9iYsaUliXWK0W3X2YELk+p5dRH2b6UFLcNeTCPvBb6TMocs4ycUKp3ZrPLM/3H
         djVf0uFEmH4Hwhu/32pfUIHJ9QOsPkeFO7Q/94cH00wf1E5YokuGkK4Eerf1Uu+TrLaA
         75hACf4XVM+hXEtzHhVvQXxaGOO1Ya9VlIufPNdMxgiCOB3Tf2GzrBip74eTIdAJBx+b
         tkezCXTHa57Rq8nMUeP5pK267q7bdoYq/ZMUQAICxPmH0aSLqlUDZqqyeD61iUzK9KOh
         EhPSxXeqOTDYhrACBg5xuOv/uD/AxhA/9llG/7SS0z3raZlGTZRoGG7zw3fQbH1liprU
         YqIw==
X-Gm-Message-State: AOJu0YzTuk00ZaH788h11fKlSIMSaPltlmW0Twm9dNJZe1HvFn5NlzBc
        S1DCVX2OuL9oKHsb+UCliCL3tEwypsbvzfvz34s=
X-Google-Smtp-Source: AGHT+IFGAp4thw4ojnPO4RJifl4w8aPC0pdev10N6Hc2N9uBar6BYqoneUbKjBD9Z/WeBYY6SqwTow==
X-Received: by 2002:adf:f608:0:b0:32d:b2dd:ee1c with SMTP id t8-20020adff608000000b0032db2ddee1cmr438603wrp.5.1697489262403;
        Mon, 16 Oct 2023 13:47:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g15-20020adfe40f000000b003217cbab88bsm124441wrm.16.2023.10.16.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:47:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: cleanup patch for inclusion
Date:   Mon, 16 Oct 2023 21:47:40 +0100
Message-ID: <20231016204741.1014-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please include Edson's cleanup patch below, reviewed and signed off by
myself. Many thanks.

Regards,
Phil

Edson Juliano Drosdeck (1):
  cdrom: Add missing blank lines after declarations

 drivers/cdrom/cdrom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.41.0

