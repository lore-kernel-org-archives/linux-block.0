Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DA2989B0
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646069; cv=none; b=QvmFkJGtGa+ME8vozZQi0o+EKo+bfakQ7rVrO1Xe2YFE6Un8i+xcuEkZMnxpvl5GWECcG6AgO925YptD5H6XrOux2IJqHsrR2/EhIYy/4WvVvUAmwwRuBu4a/lHWlWNFJSFurSLd9if6thaG/GKlJDJAuIkHTiNr3TyR5jY79Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646069; c=relaxed/simple;
	bh=cioRfBElDCSyVci+xEwbEBQRLEC6yDAx0nkXFhT7BxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev8QLRuwDQ/CSXWbxRS4gle0Vui8ZxKgpNwMD52ZLwCFx8Wg+d5D8MD2FPmJRgcoj1zTzEkqiWVq8cr2uYbtXJTGZX+Xzv5gbcGcGWUUf8pcBmO+d3ewsK/mrEClLnhw7UnwAN1qQ/fgH6VHdDrdhxh7uHotKtq89XfBRKYNf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oXPh9tsj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oXPh9tsj"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD0z6HwXzlh2r7;
	Fri, 27 Mar 2026 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774646061; x=1777238062; bh=csd6q
	nAdtIdMORboelzn7ZrNsg1I79Cv8/cZX8kLYTs=; b=oXPh9tsjMnp4FBC+vLGRA
	S4Z/OQ9RX9s0TqPt7k9VviBn7IxThrUKVXrUlUip3cNxE93q+qlQzrPAcZ63BOPj
	7hjr8fD8t0PmiOJ4WOel0/7ABLM6+NdekbQpfWfXZFF1o5Rur6d4cNRvTxVBSkQf
	4EVSx10HPbCZ3964bc6uY5KHBxN+U+W8Opu4v4YXzGi0JEZ48tLYS+QKD/OwU+kB
	pasSy/Ab04iltfj/4BS6lwPjmxe7uNX10Ux9GyVLwYhieMcIfMpXBj2IZ1fLkoZF
	FiLTN154g4FwUw4zi8OdaWdAnGlJ4zSyMp0abMpxwxt3gUpKC7E+zBEZbubN9dNr
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UOVpB4wBf03T; Fri, 27 Mar 2026 21:14:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0p45TGzlh2rl;
	Fri, 27 Mar 2026 21:14:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 6/6] scsi_debug: Support configuring the maximum segment size
Date: Fri, 27 Mar 2026 14:13:46 -0700
Message-ID: <20260327211349.2239633-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260327211349.2239633-1-bvanassche@acm.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a kernel module parameter for configuring the maximum segment size.
Reject invalid max_segment_size values.

This patch enables testing SCSI support for segments smaller than the
page size.

Cc: John Garry <john.g.garry@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1515495fd9ea..7e5e171bfcda 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -915,6 +915,7 @@ static int sdebug_host_max_queue;	/* per host */
 static int sdebug_lowest_aligned =3D DEF_LOWEST_ALIGNED;
 static int sdebug_max_luns =3D DEF_MAX_LUNS;
 static int sdebug_max_queue =3D SDEBUG_CANQUEUE;	/* per submit queue */
+static unsigned int sdebug_max_segment_size =3D UINT_MAX;
 static unsigned int sdebug_medium_error_start =3D OPT_MEDIUM_ERR_ADDR;
 static int sdebug_medium_error_count =3D OPT_MEDIUM_ERR_NUM;
 static int sdebug_ndelay =3D DEF_NDELAY;	/* if > 0 then unit is nanoseco=
nds */
@@ -1041,6 +1042,26 @@ static const int condition_met_result =3D SAM_STAT=
_CONDITION_MET;
 static struct dentry *sdebug_debugfs_root;
 static ASYNC_DOMAIN_EXCLUSIVE(sdebug_async_domain);
=20
+static int sdebug_set_max_segment_size(const char *val,
+				       const struct kernel_param *kp)
+{
+	int res;
+
+	res =3D kstrtouint(val, 0, &sdebug_max_segment_size);
+	if (res < 0)
+		return res;
+
+	if (sdebug_max_segment_size < BLK_MIN_SEGMENT_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct kernel_param_ops max_segment_size_ops =3D {
+	.set =3D sdebug_set_max_segment_size,
+	.get =3D param_get_uint,
+};
+
 static u32 sdebug_get_devsel(struct scsi_device *sdp)
 {
 	unsigned char devtype =3D sdp->type;
@@ -7366,6 +7387,8 @@ module_param_named(lowest_aligned, sdebug_lowest_al=
igned, int, S_IRUGO);
 module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
 module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
 module_param_named(max_queue, sdebug_max_queue, int, S_IRUGO | S_IWUSR);
+module_param_cb(max_segment_size, &max_segment_size_ops,
+		&sdebug_max_segment_size, S_IRUGO);
 module_param_named(medium_error_count, sdebug_medium_error_count, int,
 		   S_IRUGO | S_IWUSR);
 module_param_named(medium_error_start, sdebug_medium_error_start, int,
@@ -7449,6 +7472,7 @@ MODULE_PARM_DESC(lowest_aligned, "lowest aligned lb=
a (def=3D0)");
 MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> fla=
t address method");
 MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=3D=
1)");
 MODULE_PARM_DESC(max_queue, "max number of queued commands (1 to max(def=
))");
+MODULE_PARM_DESC(max_segment_size, "max bytes in a single DMA segment");
 MODULE_PARM_DESC(medium_error_count, "count of sectors to return follow =
on MEDIUM error");
 MODULE_PARM_DESC(medium_error_start, "starting sector number to return M=
EDIUM error");
 MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=3D0 -> igno=
re)");
@@ -9539,7 +9563,6 @@ static const struct scsi_host_template sdebug_drive=
r_template =3D {
 	.sg_tablesize =3D		SG_MAX_SEGMENTS,
 	.cmd_per_lun =3D		DEF_CMD_PER_LUN,
 	.max_sectors =3D		-1U,
-	.max_segment_size =3D	-1U,
 	.module =3D		THIS_MODULE,
 	.skip_settle_delay =3D	1,
 	.track_queue_depth =3D	1,
@@ -9566,6 +9589,7 @@ static int sdebug_driver_probe(struct device *dev)
 	}
 	hpnt->can_queue =3D sdebug_max_queue;
 	hpnt->cmd_per_lun =3D sdebug_max_queue;
+	hpnt->max_segment_size =3D sdebug_max_segment_size;
 	if (!sdebug_clustering)
 		hpnt->dma_boundary =3D PAGE_SIZE - 1;
=20
