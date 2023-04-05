Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC76C7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 11:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbjDELNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjDELNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 07:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF610C9
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680693186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpU7ep9ElvLCAR/KuV0Oh0L2HHJy0DlvrxHze5zaUeU=;
        b=Qe0aYPrSiXKbhM4+u+41ZY231Gl+jiFmYn1YG2S3RqZTOCGqTpg7/nQJ2YJrDBplVdpIDP
        OxIMzMWsepqDhTrSkZNV19h4eVtzg6yJHk+224e0c32yLBKqfKoWhLl7UwDQVvwOxbvLb8
        vwnBVl/5CDQI+NlsfwFnrlZEjFWmU44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-21vyxs7QOfaBwarYgf3fLQ-1; Wed, 05 Apr 2023 07:13:01 -0400
X-MC-Unique: 21vyxs7QOfaBwarYgf3fLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D847101A550;
        Wed,  5 Apr 2023 11:13:01 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D462F40C6EC4;
        Wed,  5 Apr 2023 11:12:58 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/5] sed-opal: do not add same authority twice in boolean ace.
Date:   Wed,  5 Apr 2023 13:12:19 +0200
Message-Id: <20230405111223.272816-2-okozina@redhat.com>
In-Reply-To: <20230405111223.272816-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230405111223.272816-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While adding user authority in boolean ace value
of uid OPAL_LOCKINGRANGE_ACE_WRLOCKED or
OPAL_LOCKINGRANGE_ACE_RDLOCKED, it was added twice.

It seemed redundant when only single authority was added
in the set method aka { authority1, authority1, OR }:

TCG Storage Architecture Core Specification, 5.1.3.3 ACE_expression

"This is an alternative type where the options are either a uidref to an
Authority object or one of the boolean_ACE (AND = 0 and OR = 1) options.
This type is used within the AC_element list to form a postfix Boolean
expression of Authorities."

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
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

