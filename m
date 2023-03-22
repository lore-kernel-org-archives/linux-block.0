Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080D4C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 15:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCVPR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCVPRZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 11:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF0637E9
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679498193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wfgq/UrOQ+FXB6uVDoOSSkC9I0H95kCaru/cGDylRrs=;
        b=g7MF4HGrpln4LKpZgFz1GkEoHMCuKOEftEhjCMzTZLDVAcS0C3JpyLQFORtU2Ygl1lpkDJ
        teUnY/W3fgDJCL4ljLxuZaOXcm9P3du+7T7swMMG7zNwaRiRDa57l80eL6Kuts1u1zDY8Y
        9QtIftcaF7nRNUygo52hy1fv9SC3lAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-bQRWq8rKOP62uUUuK_QyWQ-1; Wed, 22 Mar 2023 11:16:26 -0400
X-MC-Unique: bQRWq8rKOP62uUUuK_QyWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A063388B7A2;
        Wed, 22 Mar 2023 15:16:25 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78C5551FF;
        Wed, 22 Mar 2023 15:16:24 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, rafael.antognolli@intel.com,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH 4/5] sed-opal: add helper to get multiple columns at once.
Date:   Wed, 22 Mar 2023 16:16:03 +0100
Message-Id: <20230322151604.401680-5-okozina@redhat.com>
In-Reply-To: <20230322151604.401680-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refactors current code querying single column to use the
new helper. Real multi column usage will be added later.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
---
 block/sed-opal.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 1ce61adc732c..27abed4d60ef 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1149,12 +1149,8 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 	return opal_send_recv(dev, cont);
 }
 
-/*
- * request @column from table @table on device @dev. On success, the column
- * data will be available in dev->resp->tok[4]
- */
-static int generic_get_column(struct opal_dev *dev, const u8 *table,
-			      u64 column)
+static int generic_get_columns(struct opal_dev *dev, const u8 *table,
+			       u64 start_column, u64 end_column)
 {
 	int err;
 
@@ -1164,12 +1160,12 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_STARTCOLUMN);
-	add_token_u64(&err, dev, column);
+	add_token_u64(&err, dev, start_column);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_ENDCOLUMN);
-	add_token_u64(&err, dev, column);
+	add_token_u64(&err, dev, end_column);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
@@ -1180,6 +1176,16 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+/*
+ * request @column from table @table on device @dev. On success, the column
+ * data will be available in dev->resp->tok[4]
+ */
+static int generic_get_column(struct opal_dev *dev, const u8 *table,
+			      u64 column)
+{
+	return generic_get_columns(dev, table, column, column);
+}
+
 /*
  * see TCG SAS 5.3.2.3 for a description of the available columns
  *
-- 
2.31.1

