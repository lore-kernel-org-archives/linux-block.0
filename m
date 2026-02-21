Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91A310763
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634973; cv=none; b=jirJKHfSSHeOX90eeuCOUJSH1SF6PH1ndtHEwk+JLwI0htFdUPfCyL2vbWqozgmGr+VRsBOJcn59IXOYzVbUQRljbhYdJSjcvDsEG4XKFSdzszr1u0S5oymlp9x2ZOK+UM8MXX5VvDtmCAzZpzVHd3iUNlVYojJosdvccPYZkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634973; c=relaxed/simple;
	bh=9+piLGIlhGikW0UE1wJQj2lZ9YaxsAw0pRW8O+OD9Ow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbzzmQ3EdJI+Rtt3qrJwA4R423lp0qxcvT/ddCaOGje/KHmDIdK10IH4gJUXuswhE3FXLBiExqWaFvYZeDh3f0jXPJ8CvDacytBWZuuqYsM3fg1uPnQIxRM9iDx6ev+gY6P2QNVgVRHFtJVPJx2orFFpOCTkJoXsmKE51fPWJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVQdyAdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVQdyAdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E390C116C6;
	Sat, 21 Feb 2026 00:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634973;
	bh=9+piLGIlhGikW0UE1wJQj2lZ9YaxsAw0pRW8O+OD9Ow=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rVQdyAdXO0yDj7r48rua/+PQzQPp17aLfW9mSVh/95EbAy8yH0085YJb0CH+uiPRz
	 6xju7NTDRzOpACswNdCUk62T9aPYba7srbRfeTDED9yQb0u6v06PXYljDJdATqKp3s
	 j00UgWJ45UbN9uEO+euoLnQPk5BBbyR1sV4tnsLfnAF3FJaTFVogu0AvrRiz2W9ver
	 8HjJue9MUjf0Ku21jGhvMinro6W8pP0rRHBl+YK74AiXRXtCWdvN5z+orzurvI23di
	 ER6r3c7XO+F98U2dilQPz3fGW4SNV2kw0QLzHjrO5rWPjhL+oBnBn7uaCw2pSdnFOo
	 1XfN53iQureEw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 8/8] Documentation: ABI: stable: document the zoned_qd1_writes attribute
Date: Sat, 21 Feb 2026 09:44:11 +0900
Message-ID: <20260221004411.548482-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221004411.548482-1-dlemoal@kernel.org>
References: <20260221004411.548482-1-dlemoal@kernel.org>
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
---
 Documentation/ABI/stable/sysfs-block | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 09a9d4aca0fd..bc3056af5eb2 100644
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
+		kernel thread) operating at a maximum queue depth of 1. A value
+		of 0 is always reported for regular block devices and for zoned
+		block devices that are not rotational devices (e.g. ZNS SSDs or
+		zoned UFS devices). For rotational zoned block devices (e.g. SMR
+		HDDs) the default value is 1. Since this default may not be
+		appropriate for some devices, e.g. remotely connected devices
+		over high latency networks, the user can disable this feature by
+		setting this attribute to 0.
+
 
 What:		/sys/block/<disk>/hidden
 Date:		March 2023
-- 
2.53.0

