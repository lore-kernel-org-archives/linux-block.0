Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D718871F
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304202; cv=none; b=op7aKIONNkhIRp56UGIbt6WgwkM6l51/SIcTuKFhf85RGJNhZ9IhVtFQ2GQD7KbIJvWDwPHx9LEXKZsvTc286JuuZjGHhei58075sY/Su5U3stKatBbNsUBS2GsIbZHSVv2tA1eC/FdTUe8LZpoTt+v3EqjfpBmwM2hGKM4GF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304202; c=relaxed/simple;
	bh=cwmYhdMUD2R1J86Sy5yjXaqEbjH7RgxdbKcwLEhK5cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzCLnmpW136XBnZBXOc+XAKn7b9nUMuvKcNV0G3Xk8h3iGckh5LY9KLNTDMr0riNGAM60OH/wULeJCCyNdbbF4YqAx0OV/nm4MY0oEAHZBtHgGhUpK5HmmulXMknEvw/fwhMr13DBkA/cEu1sygTUgRQfnXZGz2+tZc9lcigutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPzzUIfz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPzzUIfz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jl1xym7acN97Sj0fQ2BxDKrs9MeWg3nUaNqe/Z9HxQ=;
	b=cPzzUIfz0A4Dd6apYgHqAoDt32/c6K990StxFksUVQezi2In6QEej7LaEmTFaVgSfGuk02
	JhIJuqnl/c3+tn73ikHjtBc6jr1hNRxmV98FYqQFDRhaoJaW+QyLnLvgfpLO/O2s/IyjJ0
	PsK+P4rzyHLSHOGugG7bN536ZME8ojk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-3_S0Md2yNGCN5s8rI0kO2A-1; Thu,
 05 Feb 2026 10:09:59 -0500
X-MC-Unique: 3_S0Md2yNGCN5s8rI0kO2A-1
X-Mimecast-MFC-AGG-ID: 3_S0Md2yNGCN5s8rI0kO2A_1770304198
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7804D195609F;
	Thu,  5 Feb 2026 15:09:58 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3584180066C;
	Thu,  5 Feb 2026 15:09:56 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 5/9] sed-opal: refactor (split) IOC_OPAL_LR_SETUP internals.
Date: Thu,  5 Feb 2026 16:09:28 +0100
Message-ID: <20260205150935.238137-6-okozina@redhat.com>
In-Reply-To: <20260130162527.570255-1-okozina@redhat.com>
References: <20260130162527.570255-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

IOC_OPAL_LR_SETUP is used to set up a locking range entirely under a
single authority (usually Admin1), but for Single User Mode (SUM),
the permissions for attributes (RangeStart, RangeLength)
and (ReadLockEnable, WriteLockEnable, ReadLocked, WriteLocked)
may be split between two different authorities. Typically, it is Admin1
for the former and the User associated with the LockingRange in SUM
for the latter.

This commit only splits the internals in preparation for the introduction
of separate ioctls for setting RangeStart, RangeLength and the rest
using new ioctl calls.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c | 73 +++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index a8d18afb3eba..502ff9b0940b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1518,7 +1518,7 @@ static inline int enable_global_lr(struct opal_dev *dev, u8 *uid,
 	return err;
 }
 
-static int setup_locking_range(struct opal_dev *dev, void *data)
+static int setup_enable_range(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
 	struct opal_user_lr_setup *setup = data;
@@ -1532,38 +1532,47 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 
 	if (lr == 0)
 		err = enable_global_lr(dev, uid, setup);
-	else {
-		err = cmd_start(dev, uid, opalmethod[OPAL_SET]);
+	else
+		err = generic_lr_enable_disable(dev, uid, !!setup->RLE, !!setup->WLE, 0, 0);
+	if (err) {
+		pr_debug("Failed to create enable lr command.\n");
+		return err;
+	}
 
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_VALUES);
-		add_token_u8(&err, dev, OPAL_STARTLIST);
+	return finalize_and_send(dev, parse_and_check_status);
+}
 
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_RANGESTART);
-		add_token_u64(&err, dev, setup->range_start);
-		add_token_u8(&err, dev, OPAL_ENDNAME);
+static int setup_locking_range_start_length(struct opal_dev *dev, void *data)
+{
+	int err;
+	u8 uid[OPAL_UID_LENGTH];
+	struct opal_user_lr_setup *setup = data;
 
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_RANGELENGTH);
-		add_token_u64(&err, dev, setup->range_length);
-		add_token_u8(&err, dev, OPAL_ENDNAME);
+	err = build_locking_range(uid, sizeof(uid), setup->session.opal_key.lr);
+	if (err)
+		return err;
 
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_READLOCKENABLED);
-		add_token_u64(&err, dev, !!setup->RLE);
-		add_token_u8(&err, dev, OPAL_ENDNAME);
+	err = cmd_start(dev, uid, opalmethod[OPAL_SET]);
 
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_WRITELOCKENABLED);
-		add_token_u64(&err, dev, !!setup->WLE);
-		add_token_u8(&err, dev, OPAL_ENDNAME);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_VALUES);
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_RANGESTART);
+	add_token_u64(&err, dev, setup->range_start);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_RANGELENGTH);
+	add_token_u64(&err, dev, setup->range_length);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
 
-		add_token_u8(&err, dev, OPAL_ENDLIST);
-		add_token_u8(&err, dev, OPAL_ENDNAME);
-	}
 	if (err) {
-		pr_debug("Error building Setup Locking range command.\n");
+		pr_debug("Error building Setup Locking RangeStartLength command.\n");
 		return err;
 	}
 
@@ -3057,7 +3066,12 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 {
 	const struct opal_step lr_steps[] = {
 		{ start_auth_opal_session, &opal_lrs->session },
-		{ setup_locking_range, opal_lrs },
+		{ setup_locking_range_start_length, opal_lrs },
+		{ setup_enable_range, opal_lrs },
+		{ end_opal_session, }
+	}, lr_global_steps[] = {
+		{ start_auth_opal_session, &opal_lrs->session },
+		{ setup_enable_range, opal_lrs },
 		{ end_opal_session, }
 	};
 	int ret;
@@ -3067,7 +3081,10 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
+	if (opal_lrs->session.opal_key.lr == 0)
+		ret = execute_steps(dev, lr_global_steps, ARRAY_SIZE(lr_global_steps));
+	else
+		ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
 	mutex_unlock(&dev->dev_lock);
 
 	return ret;
-- 
2.52.0

