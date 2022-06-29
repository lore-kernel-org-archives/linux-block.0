Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD2CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiF2XeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiF2XeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:34:01 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B634B89
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:38 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id q140so16773450pgq.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwLSdUc5ySm4D5ORtRjAHfTdi/7Iz+JqLeYNvZTeiY8=;
        b=2Kr7o8YQCzRokJQmlXAEIyasOarklqhw2+ofrDzo+a6kPsbl7WcptR8ysIBO/0fFUK
         lTb9G3pXfHEmlIybpObPRCxb7u/Buhax3JNcuGXOLla6GsUffK8NWY+PQHIx4r8NJAaq
         IPMXPR3t0RTMbCaGtcRBlvPWq6PNhjwLZB9lfMvQ2I6jquYDv40gg7nMiTB5JFHcOebh
         dkj8o5Za8d1+mmb0BQhrSebOUpsbWXlO3sNspb+LI5fKI1gKFRZ1WW0l1T7rhoEX7Vgu
         7zEV8Jgc263j+jMI4zDgu51dd+p4zFA+ZD84nBWGUhQbFPwpw+i9fm02eDUw7RdFPnjd
         8MlQ==
X-Gm-Message-State: AJIora+y0Vp8OGn9AqAcr0xAquujqzhdKbolCE6Ee7foZaWUz3Iowt24
        i8NqcA5x7YrBk5FICZyNRB0=
X-Google-Smtp-Source: AGRyM1u0/eTo+D7ZLhCi/bGhHs/cRih/CuH5r51zbIWLZwi/VZvV9OIhhRL1zWT6iFZaVQt+fRWMzw==
X-Received: by 2002:a63:242:0:b0:401:b84a:6008 with SMTP id 63-20020a630242000000b00401b84a6008mr4900901pgc.100.1656545608976;
        Wed, 29 Jun 2022 16:33:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 63/63] fs/zonefs: Use the enum req_op type for request operations
Date:   Wed, 29 Jun 2022 16:31:45 -0700
Message-Id: <20220629233145.2779494-64-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/zonefs/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index 21501da764bd..42edcfd393ed 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
 			     __field(ino_t, ino)
-			     __field(int, op)
+			     __field(enum req_op, op)
 			     __field(sector_t, sector)
 			     __field(sector_t, nr_sectors)
 	    ),
