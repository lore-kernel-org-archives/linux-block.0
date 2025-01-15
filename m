Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27A1DD520
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981231; cv=none; b=idrjwTySWRt9kHCJ05AQOScFrAGz94hS88eUK4ooD28ryiRnBaA4Y1Nd0QsXtmat0BAzF6TykKBifIOqI6YYSdaEl3wy5iIQBYpUM9iXhrGVlz31JKwddOWtomjifOyEmqFmvb+abVANMy/+kmmmtSMkZvwkt4DuGq7rzIRdUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981231; c=relaxed/simple;
	bh=sN0I09t5+4VIk54P5Q4iVxRAnAfjcZv7g5EecMQO1sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StVBeCE3hH2CwQG65b4blz4q6UvzsD86DL+bodKxiF5JrVP3orjfLbJx9L3sEEsh3eTB3w0HiKQQrc1RfMrU7+sHhB6HZwMDy2kO8z6P1GbjgNj1Qs+Z9E3iFkKgBMHWWdhaPhSLKMh/xaoqmrqJ177DmYSS/qA+ZVmS1O/5ICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Rz0Xr7BD; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Rz0Xr7BD"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLj95Cbjz6CmQyY;
	Wed, 15 Jan 2025 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981225; x=1739573226; bh=o60G3
	w0NbtF4/aQV5VamjBXkULtyPdmW2grUeoAUUSE=; b=Rz0Xr7BDVsXNhZPPzud+d
	5nO8O15R3cHSEGBpd/OTCQMVREp8Ws22eVEtFY3kq1wIbd21X1/PufjBPxqgoVfN
	E3rtjLDNl0lzm+3VfFxtM4am47MQpUWSuN8PEups7ZuJfhZV8wWZPjXMK0D7IvR7
	KDUfHGYSMKOxq3KpOCHT5Tu+KrKcVOGgvCzKEi1qiDLpuSlAVbzJ0DtWk8j0UylD
	W7P4swF81bQh6o4t77m/7/rewsVbLSl7wrLG87c373+Zf9jszYFxziim6lGSd7BH
	r23VITyxJ8UF41D/DcESCgTv11g933mEudr5y/mxGq35UL+tFaAkK52MeLI5hU8h
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id L18z9L71kr5O; Wed, 15 Jan 2025 22:47:05 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLj20tpvz6Cp2tZ;
	Wed, 15 Jan 2025 22:47:01 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v17 02/14] dm-linear: Report to the block layer that the write order is preserved
Date: Wed, 15 Jan 2025 14:46:36 -0800
Message-ID: <20250115224649.3973718-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable write pipelining if dm-linear is stacked on top of a driver that
supports write pipelining.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-linear.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 49fb0f684193..967fbf856abc 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -148,6 +148,11 @@ static int linear_report_zones(struct dm_target *ti,
 #define linear_report_zones NULL
 #endif
=20
+static void linear_io_hints(struct dm_target *ti, struct queue_limits *l=
imits)
+{
+	limits->driver_preserves_write_order =3D true;
+}
+
 static int linear_iterate_devices(struct dm_target *ti,
 				  iterate_devices_callout_fn fn, void *data)
 {
@@ -209,6 +214,7 @@ static struct target_type linear_target =3D {
 	.map    =3D linear_map,
 	.status =3D linear_status,
 	.prepare_ioctl =3D linear_prepare_ioctl,
+	.io_hints =3D linear_io_hints,
 	.iterate_devices =3D linear_iterate_devices,
 	.direct_access =3D linear_dax_direct_access,
 	.dax_zero_page_range =3D linear_dax_zero_page_range,
