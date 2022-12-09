Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C7FC04FDE
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLIOxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLIOxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:53:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197705C0E3
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:53:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n21so12035035ejb.9
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROtOQl0iT4Ua6doSdkwJJ3Gv1mhqQe8GXYrZrg3slxM=;
        b=ApPRBy01ChJFifDOnwbdnwBSBF0lcYWMqjlMTXz2jhF6/5ANYo14gJvPrTt/ll13S4
         K3w8+TcexOTVeUactHN1bzHljJf8MB3pj+7s2l9W2X2B/rqVw7CJc40bdYAb3MWRWG0C
         rHtrkO46Y6Pi3pN+lpiC3pLYeKw3zGiL8SXaOISfar5nXi0rY5xvNycjwkcZdn40uzix
         IWIZ3TI8SQjhDOrLC2SXzRmEbOO9d2OljNpN/2gfa7/RfgkeBfgclr9buadIgB1EH0TY
         RXQT5ehbonldUCPsY7sbejkfcY2jU8HE86oKqZI8WC68NKs999tNSNRAWzzFHs0YHQPn
         Tv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROtOQl0iT4Ua6doSdkwJJ3Gv1mhqQe8GXYrZrg3slxM=;
        b=B/kii8PcnpREDY9RWK2dSy5VETjgL1nv0ZBGZib93uhG7u5oRn60QN6WtD5hC56Nc0
         4BuxqGOnklmt9oVVcnbk4F70EvSFXXQ+AnMA8pGQWWbgHNSMTXg+nb0SgW7qH/PGzX9m
         /cgY1En4s83ukEHnpC3BdPLahbA3pu5907sSxDT2i0C2nW6dEiIjEssfmjZV2zYpOF8m
         yuqtICQRHvvVmpZysDWBsR3+d9aeZgSz/LdcbM/5mdbToJT4bNxcdLsSQnAZq0K97ecK
         /I5XJm3co5SpCfca5b105d5kKVV5xoOPLUFH5K54uw7svW9YNCJ0F6sk8CkGJaK5xMVI
         CE5w==
X-Gm-Message-State: ANoB5pm94HYEqenw9PCneOilMsqVzRspeKu/P8XFUwM1QDHQ9WnWiOLW
        1JpssuXc35W/80RuRyqsVkuUiA==
X-Google-Smtp-Source: AA0mqf4FR3/rLj1r8DduSRH9Ahrzdkej5gCrltixWaV5Ldqq3If0NcyorWhWwageABZaLWMi1ZsSug==
X-Received: by 2002:a17:906:1115:b0:7c1:1fcf:266c with SMTP id h21-20020a170906111500b007c11fcf266cmr5039561eja.14.1670597615707;
        Fri, 09 Dec 2022 06:53:35 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:35 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 5/8] drbd: remove macros using require_context
Date:   Fri,  9 Dec 2022 15:53:24 +0100
Message-Id: <20221209145327.2272271-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This require_context attribute originated in a proposed sparse patch by
Philipp Reisner back in 2008. Johannes Berg had a different solution to
a similar problem, and that patch "won" in the end; so the require_context
thing never got merged. The whole history can be read at [0].

DRBD kept using these annotations anyway for a while. Nowadays, on a
modern unmodified sparse, they obviously do nothing, and they are hardly
used anymore anyway.

So, just remove the definitions of these macros.

[0] https://www.spinics.net/lists/linux-sparse/msg01150.html

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ae713338aa46..edce1f7ac2da 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -39,16 +39,6 @@
 #include "drbd_protocol.h"
 #include "drbd_polymorph_printk.h"
 
-#ifdef __CHECKER__
-# define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
-# define __protected_read_by(x)  __attribute__((require_context(x,1,999,"read")))
-# define __protected_write_by(x) __attribute__((require_context(x,1,999,"write")))
-#else
-# define __protected_by(x)
-# define __protected_read_by(x)
-# define __protected_write_by(x)
-#endif
-
 /* shared module parameters, defined in drbd_main.c */
 #ifdef CONFIG_DRBD_FAULT_INJECTION
 extern int drbd_enable_faults;
@@ -774,7 +764,7 @@ struct drbd_device {
 	unsigned long flags;
 
 	/* configured by drbdsetup */
-	struct drbd_backing_dev *ldev __protected_by(local);
+	struct drbd_backing_dev *ldev;
 
 	sector_t p_size;     /* partner's disk size */
 	struct request_queue *rq_queue;
-- 
2.38.1

