Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A9C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEWJRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjEWJRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:17:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDCB11F
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:17:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f6a9131fdso659577466b.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google; t=1684833449; x=1687425449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Evdstnt+fZo+xq0sG6n9jZlSoQpDRSGli1+1+HmpUO8=;
        b=PnYOwJG1++jjnSRLyZ+XXt9gySJkJxjqebKiDUDHBOmCchnmXNB5a+RvVScIuwL967
         bKh6xKW+Q5cvv1H1fQMTZMH1i+o3YXKmFqQqigbN7MomMz631Mm/0jkOceURgFj7rlIO
         jNcaq99VWU2YxZVuFkRhYdQq+bbIX2RXbr6jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833449; x=1687425449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Evdstnt+fZo+xq0sG6n9jZlSoQpDRSGli1+1+HmpUO8=;
        b=RRcCUKPdjqw4yobYyaAeiylHDvVyuabkQdaEl9okkNUPnWm3j1oKlix+j/a9k0y1mK
         GZ/9RCrWO8Fz3itN/zreZLaDV5YlLq5coRf8TKyBY/BjbGM2xcxPGXH6znsMAEWzEUP/
         hA+KyglM09nHQUGj2pG2gnh4u9igiR6hwreLJDCEvxQp0eVtZcZWpCPgaqgNvDZqvCad
         BATq77ADo502e4BusCwUOBfMqSnn5hEpXcssnURa9ZVk3D9v30axzKI7juKanxkQrBtw
         1821EgFQRrIETa3tyIKViU9T4W1ve0LJVwOXTX46qXHnhEYrmhlJHCpAjOybZBLp1+Wf
         CMqA==
X-Gm-Message-State: AC+VfDxQwKrqiNzZmybeK4GuqNdGjEkYKFzR3W2bhJ/tplxsp6sKqDYi
        8f8JHlGHPW8wmxzTMHAzoLKg
X-Google-Smtp-Source: ACHHUZ4iT9f9F/0RNORNFfSPrn2dimqu5j+bYxzVynCCaK2bASqNb6PiChUoa5qPNoivkOVDQRPXDA==
X-Received: by 2002:a17:906:da89:b0:94e:70bb:5f8a with SMTP id xh9-20020a170906da8900b0094e70bb5f8amr11721372ejb.66.1684833448729;
        Tue, 23 May 2023 02:17:28 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-93-70-85-51.cust.vodafonedsl.it. [93.70.85.51])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7dcc9000000b0050bc13e5aa9sm3800762edu.63.2023.05.23.02.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2023 02:17:28 -0700 (PDT)
From:   Paolo Valente <paolo.valente@unimore.it>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH] block, bfq: update Paolo's address in maintainer list
Date:   Tue, 23 May 2023 11:17:24 +0200
Message-Id: <20230523091724.26636-1-paolo.valente@unimore.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

Current email address of Paolo Valente is no longer valid, use a good one.

Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebd26b3ca90e..0c8e6537d6e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3542,7 +3542,7 @@ F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
-M:	Paolo Valente <paolo.valente@linaro.org>
+M:	Paolo Valente <paolo.valente@unimore.it>
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
 S:	Maintained
-- 
2.20.1

