Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E101DE3DC
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848946; cv=none; b=Zol7YMdNBAhtOq5rATjYBtByMoRWSMzmMFcbqVQ2BSsJp3LEUjdMP7fqMxwn85reZQ/Ns9cbrmAcYSMI7H2ssBf4llLs7qmC1Uw6O1Pe5T9Y+xbghOIqaqt3BTqA8BXmEogL+8D8PsKZkV2AGgetoWqRiwq9tdkkQh1hPhWkwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848946; c=relaxed/simple;
	bh=eHawWjolnnb4XoIIn3zlbs3myX6M6+hpJdeyBWH1HbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jl4JLeRl4JortmAD0nm6JJbylalQA3hwfYDv2qt4uBhuugwib89fzdvmzej2gzHsojiietNbyJtRorVZz8ejKL2FezmV4Yn7eyUeKsC/OdD86pFb6JxNP5i9TWp+emosJOiK7HA7d7UQRBvCyJlO7+/vuwGC72iRbEFNSxTybm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=QvdU7LXk; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="QvdU7LXk"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771848942; bh=eHawWjolnnb4XoIIn3zlbs3myX6M6+hpJdeyBWH1HbU=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=QvdU7LXkWU8Fm6joVpLlxD/BLjZyztXPFPtOeDnSAIbMJ6S9VtyM/LK80oVk7BYvB
	 HamCQ3gm+/HWavZfVHW8paD+3u2UsYzVLkXiZRuDb9/Gd5oMpP0be2oeRIA1v/pn8k
	 NduuvhG3HTcdF5X/JrXiEGtGA/kMMqR4Vh7d3hmvliwhXLfQ2iO7Bhc0WHSq9bhuCd
	 mW4WzvXShKuL+Z6fj67+lAFZtKvUHfdwFSFog2wsRWFz2Msbo69YYbsi0KZdQbhJ62
	 6ixSKW/Jrd9D6/LuMHgtENMg79xt3qXlQB6+QPOwwjclolCH4ZQ1IHq2DNw24PkUrg
	 7DZ1GQpHmbOacxwvZfxeid1V9QGdebC3+3FZPUq9p78e52/+6fIceiotWf3Qce4+T/
	 XXqAK9eZamGwemhaI/vSfeVXPZlEjq1L1f59/gxVgIiNipoOmdmOvroMjhIQe6CGtx
	 NV8MoMGyh2ETbM756Pay1fIA9szUGbI+9+4erX1BI2gBOcfHNX/3iYCTP58SThK+gc
	 eKtJ8CqmKQEYxc2FX8RAk3QyMj7VbztJhuVrnev+bQ6VhGhBvRGTLzEb4BfGH1b4Xp
	 0Tw1CKZ2fSHhChpkZWd4CcTyQgVFCI92dBmzibKUxUdx2wmQD3iIIXm1JTFki/Yq4k
	 JJTXEyk9CrUVnAYeDnCY8kBQ=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH 4/4] selftests: ublk: cleanup kublk.h
Date: Mon, 23 Feb 2026 12:15:14 +0000
Message-ID: <20260223121515.3296983-5-alex@zazolabs.com>
In-Reply-To: <20260223121515.3296983-1-alex@zazolabs.com>
References: <20260223121515.3296983-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arguments are handled via flags so
remove unused no_auto_part_scan bitfield.

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/kublk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 1faeccaaecae..3379e49449b4 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -79,7 +79,6 @@ struct dev_ctx {
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
 	unsigned int	safe_stop:1;
-	unsigned int	no_auto_part_scan:1;
 	__u32 integrity_flags;
 	__u8 metadata_size;
 	__u8 pi_offset;
-- 
2.43.0

