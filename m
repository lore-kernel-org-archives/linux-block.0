Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058137418D
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079345; cv=none; b=qkxPpHPjBMG1ZgYXJKJuDuvKBjTXta1BkjhYqYpDSk/6Y+KkjaAl1RTodSzziegb9qjmQsDe+xI5gscN7d1zx9J9I52hq7IOrCgkPV5xJqUeJ3Ig3KDFs6SkiBtQ92Unv3oL3+WdEXVumyfK70a9D5gbBHLIJhzOevAOeUKO3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079345; c=relaxed/simple;
	bh=gfksIiGZJ302/W+L0dS66QU3mYT6wSH5MOhEaecZftw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML7RiN2nr1xVEqJjrWPaZzk7LbMfOF8KybrQUDJRt5Nl3gxnOBBxZfYXI5wvAuf7XKoSr8intMPxC2a4uG4fhI/wa7RXgiOo4NJQTCqCoIQrj5umIQiasUBk2d+NNiQ1IUsEL2xxcS4/sQ96UvbCj40VHNrhHPjPpYt7Jkgln28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLcaCq14; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLcaCq14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB7C2BC86;
	Thu, 26 Feb 2026 04:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079345;
	bh=gfksIiGZJ302/W+L0dS66QU3mYT6wSH5MOhEaecZftw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sLcaCq14nD9G9Huv4DggOpWm6R9lLRZTddEe71aoEF7TisjXAo3M4d52NMozL5zEv
	 Lb9Qwl8nFTbXHhmxkbu3lewLH92dLiKCPpN2A31JWIE7aUDo4GNZ/flfGN72ku+jc6
	 OSOBTIa7zwLgYqmKWRWOAvF/fSMNgUiTVtkcXiwm3i05Nz5BzYq6KqxfX0pb7SWlFu
	 3s0nyiliCQzCrV1DiJfPFTNHtVai1DozquSuq950D0E4/KifoxsSYgTyEHH5LNM5e0
	 /PllaHQZTuDd8cMtR6sFOVsDXLSa1yGVOgtEUmEhxNVafr/YTJtci8PSI+92v5SJxi
	 cNWIzHeZOhSgQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 7/7] Documentation: ABI: stable: document the zoned_qd1_writes attribute
Date: Thu, 26 Feb 2026 13:10:24 +0900
Message-ID: <20260226041024.2154806-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226041024.2154806-1-dlemoal@kernel.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
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

