Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7992FC76195
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 15:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCVPRQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCVPRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 11:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971361333
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679498186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4u2CT5wMe/Tjf/89+NQ7Am9EIQ+nUvsxDzbHQDMK9yk=;
        b=AViw/ykZrbvrcw4GYedkmR/82amPbFutuhiGFX2wWAqbz45Scvebr5PvsKuDabfvPRjNUV
        OFJFr2f/Tf1Nj8pvfTZkFi/t43fuUiGFZvwNk9IjdI9UcZ9Omsvz3QtdjzXUYy/K0Q3Wii
        E4IJaZK8Jh9wPNexqX/W4bGDmKECdAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-L0zDUIh6M-69sAWATJZT7w-1; Wed, 22 Mar 2023 11:16:24 -0400
X-MC-Unique: L0zDUIh6M-69sAWATJZT7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A49D28135AA;
        Wed, 22 Mar 2023 15:16:21 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 522A21731B;
        Wed, 22 Mar 2023 15:16:20 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, rafael.antognolli@intel.com,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH 1/5] sed-opal: do not add user authority twice in boolean ace.
Date:   Wed, 22 Mar 2023 16:16:00 +0100
Message-Id: <20230322151604.401680-2-okozina@redhat.com>
In-Reply-To: <20230322151604.401680-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While adding user authority in boolean ace value
of uid OPAL_LOCKINGRANGE_ACE_WRLOCKED or
OPAL_LOCKINGRANGE_ACE_RDLOCKED, it was added twice.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
---
 block/sed-opal.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index c320093c14f1..d86d3e5f5a44 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1798,22 +1798,6 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_bytestring(&err, dev,
-			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
-			     OPAL_UID_LENGTH/2);
-	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_bytestring(&err, dev, opaluid[OPAL_HALF_UID_BOOLEAN_ACE],
-			     OPAL_UID_LENGTH/2);
-	add_token_u8(&err, dev, 1);
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
-- 
2.31.1

