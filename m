Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143505;
	b=RYbethlEpjgQMk4mnmjaRuIT6nwGOSb+0bSjyH7CCT25yUL0TRdVfkNA9XO0zcgmtmBw
	 Emht0SsZiLb2/ZMsey8WuoHIkeE+++7pDog1qBtZCS0DcFd+n7gPXAtOz1OnosZwRZDSA
	 50cwPsoM5AI5jU7BUnqqG2ZGQVIAUiomP5HsQBYoij7SsJ7bjTvjMXGVLYIakIjv1OxsS
	 JtBgvJVk7h8hMqgd8QQS9pvSJ2XHQ6Iti3gHQdaaMdNVxpjnPTRO0UBeYq75DV+3/u4AR
	 tHDRNSs/KbKhiwI5i4NTKtOdrrfvEKCL0r6D8pCIHlUPJqK54kjY7n+vkbCOJoSJgfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wBWPAIqvIDVApxQAhC8lxyajSPGZTusmtwDLAKdJnvw=;
	b=VPpGWkXu6e9JZsPHeFTKrjVilnEYrldCe4HlirYrK7cKJhpQzklxfowP06TWaDJ8yPkP
	 gv6yhPWRaNlQHCl15pB6przADSF7HXwVcMjz+qBHxZ6aXxZhtmhBQgQgv2SZuBrasFHzM
	 MqSL94XPLQtU7pzyUNaMyoGcISf8oUhbxC+lNRlxybs4aaF6cc4dMAXDaAFNq4RdibRy4
	 7m3WIbMzWbXuWYMVVklRWLrEOlHAAB9pDzrsOpEjHwEvsuvGEtHrITybqwnb2+pPK0Cz+
	 InJwmSO4sNbIGmPgH2v0zoITDO7ba6byDs9Er/UOiFjJSDXr25JMt32n7sDJs5bC+cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LmLgz8N3;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F4606A338
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8F4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LmLgz8N3
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so374924b3a.2
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143505; x=1795748305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBWPAIqvIDVApxQAhC8lxyajSPGZTusmtwDLAKdJnvw=;
        b=LmLgz8N3WHtNAjhkY/vczV1KNXtxy4JPW+LnTtOzMBEddzS/D7/S9+beyQwErjT0my
         0Di6lSga3zgpttKLH5Iy71kLa0ff9/DVNQQsME2JLI0h9z6AWf9E0hLJkaXcLxzhSQ4Z
         5ffDRYNTH6NeIAtE/ZKuknjgGxDLoRbn2peLQ6qYtLu9xkWJGxioW0FvhgmQWOZuWXcn
         4PWwP2/UjQ7jMk1YeuBWMkapG4gdAIKW/5HL9YwOiUUMoWPBGsrDVPmKDsDOZypin1vX
         18pmJyhBKXnnBBaMDhqrzpknmmfQYnjvgRqrW4lHlIGe951uVqcE7cocEkCLRmsx6iW+
         HmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143505; x=1795748305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wBWPAIqvIDVApxQAhC8lxyajSPGZTusmtwDLAKdJnvw=;
        b=TJ0DFGS7ehKgp42u8BwM9CRc14q8j7LdHMnzMZrd7zCtr9kA70FmO/6KMb3EF2Oyhq
         qoGB5WbtkVM7GSfCxtE3Y+/IstaKJhaEhbEix2eU6Srnk9XlvWasPCMHn607nexx4XkO
         CnFpgAjx4mwxy59RDbhyBqkHzJGmOXgI8EGKOHMlqOTGB6Yo/SA1DUXX/jg9dDzei31T
         cS3fOBfUOVmDT6HmTUZALlwX3PBQqpiBs5Xo3vj3EtxEqyLItwqBWG32Y3N66PHNyNYx
         cexEz51HaBWyauvXxeL7H5GiWgeJWZK+1j9n4sHb5QOxV9gE7RneTZfNJ/qQaki+cSV/
         jKSA==
X-Gm-Message-State: APuU4Z9AHc9niagZRONHXGXMTanU7QEOA8/Nv61KunSiY8JtRTrBhAiZ
	NEZA6uhpym5KxTucCUqw1+EVQgnQFJtOeyZnKFgG6+Z/+rVzSDA/eNAIJXocsnfZJnANS2mVvq+
	wnHCXW22mn7rDB8eX7YUXgC573fpFbV5hjddJng/nYNRkXs7Wqlk3zzxYoQ==
X-Gm-Gg: AYBFou0QuF7z5l2pDlzQZubkT0WJuVArZWevgApKpnGt2v+iEcHZ2kcHy6jrY6YjAVv
	0D/8iulD2HIdidaRAtDa0qkmwY/evXqNu+zXlwbvwxqLsp0mfS9P/LSYp+UB4SLwCsPTE86wLrS
	uCI2MayscAZH5yPvc91hzNr8nbmXM/WmnBSLwzoFzoCqWEVRf3bxv+uFtkVPaQaCGvG/41+9zhV
	39bs57th5cA38iSxaOVQZQQHWrAcR5ksHvs51TCWqTz8chdmPRYi+dI153GzXnUO4mt913sFZZy
	pouUYPM04OrMPBkhxgKBVDL8gR1WWqLRlOubpObsDT0yYE3HHIE91VGkRqCPsGjCU6liggeuTUR
	ScyX+VI9AXclFwKDQDpWY1irleYLqkERTJy1WPD7I7GMupxdxyTbXIEV4jvuI01GhivzTjN63xm
	TZi3s0AezDlVOSMsvU7LhAmSMEgSKJ7NwmCAeJPTTOBpPmYCOzF7uWOZFyl6n2+NRcfcMYp8kOA
	+oYx2kzW8sI4yU3O27kSNnlwaQo7H3rv7/YKIkz/laveDcGjSTFCRl84o6TuAcoMev9xVO1RVxW
	BELw0IMj1ardrFJkLvcfwoalAZW2naF4nJqLcA==
X-Received: by 2002:a05:6a00:188f:b0:882:fafe:9874 with SMTP id d2e1a72fcca58-8c87bfa59edmr1487082b3a.31.1795143504791;
        Thu, 19 Nov 2026 18:58:24 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm749647b3a.31.2026.11.19.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:58:24 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [RESEND PATCH v1 4/4] block: link request queue debugfs directories to tag sets
Date: Fri, 20 Nov 2026 10:58:06 +0800
Message-ID: <20261120025806.1065295-5-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120025806.1065295-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
 <20261120025806.1065295-1-lei.chen@smartx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tag set debugfs directories use numeric IDs that do not identify their
attached disks. Starting from a disk's debugfs directory therefore gives
no direct way to find its tag set configuration and CPU mappings.

Add a tagset symlink in each blk-mq request queue's debugfs directory,
pointing to ../../tagset/<id>. Queues sharing a tag set link to the same
directory. Create the link only when both debugfs directories exist.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 298387607049..78a91a1095bb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -644,11 +644,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 
 void blk_mq_debugfs_register(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
+	char target[32];
 
 	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
+	if (!IS_ERR_OR_NULL(q->debugfs_dir) &&
+	    !IS_ERR_OR_NULL(set->debugfs_dir) && set->debugfs_id >= 0) {
+		snprintf(target, sizeof(target), "../../tagset/%d", set->debugfs_id);
+		debugfs_create_symlink("tagset", q->debugfs_dir, target);
+	}
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
 			blk_mq_debugfs_register_hctx(q, hctx);
-- 
2.43.0

