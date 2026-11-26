Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728229;
	b=zNOh/mpHh17neO4OtBbDJhcqNtyr9NarLgYPjCXXpBjrnBdFtHEjBzWaNapbVlq9Emsv
	 SP7RJlcRH8vIIE9xdetIRbUiCV3DPiX61hGVMXXMdaVkTAdrcRaMal6ZWyFWF4EOf3vEd
	 cSm+G6EJZdjX6WGXnJa1UdZeQBiqDJshiy4fQgSrjWvj+4VFMxu1LJUcH02GNadLfwnWi
	 x7tAelU5uE76gy6GeEJ433wv3bv9qrCAe5F+Nw3mlmtiGDUPjb/UDKJWHbJsWqFFYBgox
	 4qLnDfIdVMqONFsH1sQocE51cjaBDl8uWPINrr0GXsAPeZNpz+PXw0GuDC5iMLHpHIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=rysfOqHTi3HDxlfZmHCyYvGlB2t6DgTRM6PGqr6d6Tw=;
	b=k1Q14NkL1hBSzDdWSgtee3voZZBDR83kzGAOYqmH1Lpc4lZ8b8+xTuLGj982MbnlUKh6
	 /BziVlff7Z5CY0HkopjzKZBcn8lW+flWQNimL81lobQmRtTKXIRojWF9yxoHxESuGrnQp
	 VG9v4cF33GrnRxfk6LHTefqzEx6kvFkxS9dkSaFvq33jTQN9e0swWvsWsXf+z4Y6bID10
	 ndEMRAb1sTtwdXLArdPWrAWNZNcID6SNzdWMKkbSG6ewhfpQ7s0xuABtQlSJvB1kItcmh
	 5zL1pTrRt7okU65sxyoePM9OBEE5gwgP36D71tzFb/onZQH0yWct7CrjSE+MOKJKQYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="hYscgb3/";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCC606A31C
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 21:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDFCC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hYscgb3/
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a0f79047so7922497eec.1
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795728228; x=1796333028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rysfOqHTi3HDxlfZmHCyYvGlB2t6DgTRM6PGqr6d6Tw=;
        b=hYscgb3/G9jm9R09Kie2ghmHAMBLic3XtciJqrvs7tM5Y83znCimn9LHbixy7nqHPR
         evRJ5rIISv2u85xMG0BJU+7HX6T/qr9mgw6Flk761RxmcF6aDn+AcebzyfvCoI0bzzVB
         kRJmyxU4Ry50SOCMqRH1udULs/GEEa9x01xGRDdkcsYKlumzXt85VldKP2IfzBagZ5Q+
         LKvg1tA0wYzdmaQ5EQ+G6lj1HsxIgSZmyO+vwzxcUGXGvGCFFixM5cMz1VuYRPMw2Ix6
         zURJVBWn4XaqWld0FVsCl4VDva64LKJeoRnxpo81c/P8r+8WzMvEawJdTzshshAXg0y5
         rvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728228; x=1796333028;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rysfOqHTi3HDxlfZmHCyYvGlB2t6DgTRM6PGqr6d6Tw=;
        b=xbh1lV+5RaBSOYbRMoCeJ+iARCrSFz+x2k+ur5JDR5Bu6l1HUphcCbxZHmKgWF4jh0
         tsDCgTAASEJH+gcOlt51Z6xyt0xgip1TDOd11O1XDeqkuR2CDETs3Ja7hKl8TBDykj2u
         0k7KRpVHJahUZwhzoIdnskb8bQyRvHOUsE+FwBXiAI6TXKcF7FCzNxA7vRzSXjUwM6AW
         eKDPIStHjmE1VuNSLlKDKDKEl+nhz5wm2OHF3vPH+TTeFeDBfpFK1Oq9PEuedlxSSLRu
         5TvT6HDu5jYDi4IpTIeUFnk6b9F8lOfR1/JRdDR+ujfGk75b91qO63wcI95KLUrep2sr
         9Q7g==
X-Forwarded-Encrypted: i=1; AL+hErHl7dTQ6PpqOxm9lST1iysvXksNBZKQu6/6h3Ybgb9nsfYjmE9UZTDnOrc7T2d7Axa99tivRBQEqh5lyQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QO9MLNVdesvFHU0g6Q3oahf74eI3UHrZZXMno+9TChHAUXRXD
	4ZKKeJTH20Os0HC85Hu+3mrloRlzYV1wKNcec9BI2Za4AcqGhbWcoBBxxHKNzRSQt66jnTNXPmM
	9tDPUJvRRpINIZtaS0RH2wQ==
X-Received: from dyrp21.prod.google.com ([2002:a05:693c:69d5:b0:36a:e67:fbc2])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:87d8:b0:386:b896:319c with SMTP id 5a478bee46e88-386b8963d3amr11732259eec.35.1795728227530;
 Thu, 26 Nov 2026 13:23:47 -0800 (PST)
Date: Thu, 26 Nov 2026 13:23:39 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126212341.916839-1-nilayvaish@google.com>
Subject: [PATCH v2 0/2] null_blk: stop using page->private
From: Nilay Vaish <nilayvaish@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"

null_blk records the index of each backing page in page->private. v1
only switched those accesses to the page_private() accessors. Christoph
pointed out that the index does not need to be stored at all: it is there
to work around radix_tree_gang_lookup(), which returns entries without
their indices.

So this version follows his suggestion instead. Patch 1 converts the two
page stores from radix trees to XArrays. Patch 2 takes the index from the
XArray iteration and stops storing it in the page. After the series
null_blk does not touch page->private.

Testing: a memory-backed device created through configfs, without and
with a 16 MiB cache, on next-20261125 with lockdep and atomic-sleep
debugging enabled. Write and read back 300 MiB, four parallel rewriters
followed by a flush, discard of a range (zeros there, neighbours intact),
an ext4 file copy with remount and fsck, then device removal. Same
results before the series, after patch 1 and after patch 2, with no
kernel warnings. The out-of-memory retry in null_insert_page() and zoned
devices were not exercised.

Changes since v1:
- Replace the accessor conversion with the XArray conversion and the
  removal of the stored index (Christoph).
- Bart's Reviewed-by is not carried over, since the patches are new.

v1: https://lore.kernel.org/r/20261124033630.832566-1-nilayvaish@google.com/

Nilay Vaish (2):
  null_blk: convert the page stores to XArray
  null_blk: stop storing the page index in page->private

 drivers/block/null_blk/main.c     | 146 +++++++++++++++---------------
 drivers/block/null_blk/null_blk.h |   4 +-
 2 files changed, 75 insertions(+), 75 deletions(-)


base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
-- 
2.56.1.839.g22a8290db9-goog

