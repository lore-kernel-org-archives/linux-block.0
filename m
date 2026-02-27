Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AD24A06B
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198713; cv=none; b=sTho+BUw5dU9X/hDtmpf1CP3Yf+CdhjDyPLM5E5WWFsOjhXQsCW9bdgZucjP2tvVmMFmXbV1jrGHtscXx9ipfwEbuyq7iLf2Fyl8bS2m+ql6lELyjbxDOsvBT0u4Yj/h35UvfAcTAncxg7DO8Y3qD4j0mb6BhrKLMO45ehvzzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198713; c=relaxed/simple;
	bh=KXcTWENAAi6rryDqPczD27csZ+RGzcGrtgq0IxR0iM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liEPcDjVnK3B2rwtkkCvn/6GzDeqhmHPL08sH45C1BhtZ6GvO/3GmhXYOQLfIy7QMlTb7UyQZIq2VdoGtPv5Q6WoI4KY1eKcQAE5jVQRgfKzErRaKUmk9W5eVLMsiBuLPk2opsokrZgGhHfb8yBSEkMtSD1Pg6OJ7CBQY3eXgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjqR4Lno; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjqR4Lno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF1BC19425;
	Fri, 27 Feb 2026 13:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198713;
	bh=KXcTWENAAi6rryDqPczD27csZ+RGzcGrtgq0IxR0iM4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mjqR4Lnoj5VcRGrq4eat6d0xHsoFKQIsogC7wqdaKVc4ctKsYX5godCu118kh4g3W
	 YKMVoYx1HwWxUNqG4HzvZ72qyJ/Fa7oyX5PkbNfxNZuphFTPPV3gSNJiPKN44oakkQ
	 HwdPqZYflwjfT1+UzWfofbuQeBrxhXJVAXjeUsZ+uneCIx3m/fd2QpzwJ3+j7GoAjK
	 f4DSkg4ivm+urW5CttWwlV9SWxteyhScgM/ZAftP6SMI0V33Q5YQe6yyI22QekuRV4
	 fGraZKXzWuP6MqpUOPLwtCjORNWRSP2EnVoVKa6OJwIXA/0t4AnVkLzR0h6pmD4xoI
	 nrLc8nf745P7w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 8/8] Documentation: ABI: stable: document the zoned_qd1_writes attribute
Date: Fri, 27 Feb 2026 22:19:51 +0900
Message-ID: <20260227131951.2464150-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227131951.2464150-1-dlemoal@kernel.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation file Documentation/ABI/stable/sysfs-block to
describe the zoned_qd1_writes sysfs queue attribute file.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 Documentation/ABI/stable/sysfs-block | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 09a9d4aca0fd..900b3fc4c72d 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -886,6 +886,21 @@ Description:
 		zone commands, they will be treated as regular block devices and
 		zoned will report "none".
 
+What:		/sys/block/<disk>/queue/zoned_qd1_writes
+Date:		January 2026
+Contact:	Damien Le Moal <dlemoal@kernel.org>
+Description:
+		[RW] zoned_qd1_writes indicates if write operations to a zoned
+		block device are being handled using a single issuer context (a
+		kernel thread) operating at a maximum queue depth of 1. This
+		attribute is visible only for zoned block devices. The default
+		value for zoned block devices that are not rotational devices
+		(e.g. ZNS SSDs or zoned UFS devices) is 0. For rotational zoned
+		block devices (e.g. SMR HDDs) the default value is 1. Since
+		this default may not be appropriate for some devices, e.g.
+		remotely connected devices over high latency networks, the user
+		can disable this feature by setting this attribute to 0.
+
 
 What:		/sys/block/<disk>/hidden
 Date:		March 2023
-- 
2.53.0

