Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B62E5D37
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276913; cv=none; b=gZY2E5iaWudm6jzu8+aIAJkKEitxPIf5K7dUUbafzu19Htg4P3sy9P+WomNtk2tKmXPBPgJiQtXbsMv9+VM1gxEct7P06yrwKBvujKXAxKodTvdFQiUiXCAtH4WMuMYNxDPVpQw1Nl0wK5Ecthb+1hvGqApqPg1fzydvUCkHjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276913; c=relaxed/simple;
	bh=giKHTviWEHfYII103LakGBoGmVJy2k+Rl9WotluSNLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eavdiHpMGxiRilQ4MKLTojAqCnlyrTtq+g3OgLkByfKXqNdiiaL/oURP+a//NMuPszd/xPywyLWxxGNrjTLyAGfM3KKjzOfD/4WVHu/Zrwr+gXruHDP1c4CzgvJNMqJHkgkfiCMUUamPl57dQtfhBfzSzRSvY6uks/u5JVx26Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AlpznUI0; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AlpznUI0"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c3Ss96sbMzltQMR;
	Fri, 15 Aug 2025 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1755276908; x=1757868909; bh=rNtyE8dw3omJM/eYSJKLiENivRufU+GeQvi
	PEBpQ2b4=; b=AlpznUI0heHqg/7uxFZTBqEMNytcnWEvq5MIU7hxZxqw+J+1DCI
	+dScLfmV+zF8bnrHUwdYaDpxjjUCJv1q+Qj2ts2UQq8478NTxC0Nx6zcXSlrUTz7
	+blTyzKTQFGffG10poZ9SSBCal84PUYp4L4w7Pl+xyIEqR913TQhhkdqiHaGZ9lx
	VUIJey1zdTNis6888vlXJ/5HA+NwsSbrdFLIomU5tDGSkPJ58AVX6OrKQDzE2PNO
	i85S8yjCrag6DCCCoE30QyZ8MIUI5V2IQ5hc5Ir5N3U49DJty6PQmHM1W3N9dXis
	aeS99cTsYLpK6+IrbhODLpMZwSX+f1xTjtg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6sDYVxxr-ObH; Fri, 15 Aug 2025 16:55:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c3Ss63RdQzltBD5;
	Fri, 15 Aug 2025 16:55:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/5] Remove several superfluous sector casts
Date: Fri, 15 Aug 2025 09:54:38 -0700
Message-ID: <20250815165453.540741-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series fixes one bcache bug and removes superfluous casts of s=
ector
numbers / offsets. Please consider this patch series for inclusion in the
upstream kernel.

Thanks,

Bart.

Changes compared to v2:
 - Fixed Kent's email address.

Changes compared to v1:
 - Rebased on top of v6.17-rc1.
 - Added Acked-by and Reviewed-by tags.

Bart Van Assche (5):
  block, bfq: Remove a superfluous cast
  block, genhd: Remove disk_stats.sectors casts
  bcache, tracing: Do not truncate orig_sector
  bcache, tracing: Remove superfluous casts
  block, tracing: Remove superfluous casts

 block/bfq-iosched.c           |  3 +--
 block/genhd.c                 | 12 ++++++------
 include/trace/events/bcache.h | 15 +++++++--------
 include/trace/events/block.h  | 34 +++++++++++++---------------------
 4 files changed, 27 insertions(+), 37 deletions(-)

