Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E33E776CB
	for <linux-block@archiver.kernel.org>; Mon,  2 Oct 2023 22:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJBWCI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjJBWCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 18:02:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72105BD
        for <linux-block@vger.kernel.org>; Mon,  2 Oct 2023 15:02:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so2568635e9.1
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2023 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1696284124; x=1696888924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiMrasdnuQ2SWeRoyfYCQmrkYywDKeyE1wyCVnsAHC4=;
        b=YVqrqOQBsG+Tdhm4TIyqysy35gd+sBKHEyi8LF4QBaZHRvzKFoarVCCxpngNCSF+vX
         8ZJGBl3ErmdG1m2wQMOMvNNZPapyzLM3JnktYPZXDW5m/XvwRel4aVeHPHrs+GZfe9k5
         VFdscI+HuCjzcsY4gzNyWm+kotLT8d9rROh5Hb38x5GdNDS8FGBW2wF87OwUDy+sd5RO
         e5ZUqEMkGV3FwPP7baqeR77fY3Asx3v71GbWwKkst5J4DoC7V6X+tmPfhZi4jmyg1A/8
         ywfHHdl8D4JPFhBMm7iXOxAWNsAZpI7jJwV52E3HOVOMUK8CF/Ko3Y7cxMcwymH5ZCkf
         JeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696284124; x=1696888924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiMrasdnuQ2SWeRoyfYCQmrkYywDKeyE1wyCVnsAHC4=;
        b=BXn+CdOR+MaM6iLz1OowkRrdccCC07M+1ZCnDKRgJMnsoHAHSKmSILUf9gRJV7m31r
         CWkXnlZJ89yB6qXzTUgvtsZVL3ZN2V8lnyngTeBqicC4KIBrT2O7huCt9MEsMTDVxL9W
         dA1mcJ7mSlw6vJzWtlLgb8vnKQXBmA2HsQlaGcJd2g8RGN895+R9geVtnjx+WaX+U6RD
         V4IwBLpBr8eL+eUk5NS2wCqe+FxvCdShyJF3Bwy/sR3lfjlhJgjgT4RJlI6g5FrQCme7
         0foFn0JWmEhRNaS/fcW1xEMM9ne3D7hCV+YhO5ki089xWpV41F0YEXoy8q1ODFZS7pw0
         oHoA==
X-Gm-Message-State: AOJu0YyjKnjGLxFlZavJbd0psB2t64CDJ2CZCC8WxabcV03VlRAgF/3u
        dlja2q38kkWQkFRtNhHods4P5w==
X-Google-Smtp-Source: AGHT+IGAw4h8tjJtauk3l3lTE2tQlIPV2EYWrd7fnDza7Z/4636E6iBPLjVoXUPbZQM7BFuDxeQihw==
X-Received: by 2002:adf:f10e:0:b0:321:6486:d008 with SMTP id r14-20020adff10e000000b003216486d008mr11217543wro.25.1696284123851;
        Mon, 02 Oct 2023 15:02:03 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c5-20020adfef45000000b00326dd5486dcsm6757397wrp.107.2023.10.02.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:02:03 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: patch for inclusion
Date:   Mon,  2 Oct 2023 23:02:02 +0100
Message-ID: <20231002220203.15637-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please include Joel's patch below, reviewed and signed off by myself.
Many thanks.

Regards,
Phil

Joel Granados (1):
  cdrom: Remove now superfluous sentinel element from ctl_table array

 drivers/cdrom/cdrom.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.41.0

