Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F16307486
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527108; cv=none; b=i9TCRTZcibtQ+CV4ioArrIxryJ16GHS4uCtlMsIEjouBKL0UafnT//43JdHVdfBl708ZXadvZzPB272qOQu7B225PanRRFgjjmL/M5l0jAnkzh2BWN33UqjZzjlIN+mq52Didh/rpp9VzlsUCfKf6skG2kjg063X8wbSG7OSkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527108; c=relaxed/simple;
	bh=hbabhs7smhC31r5M6RYgKgO60+4gpCySXz0v674VsCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHRGjEkQH2+C3Tp642UkgNaKMC2CowtmffMgIA6UbMiFez+djCoFCl/oihslWQ4brTRaf3oZwSJa4F1epvPYgN7bL90izPAowZQ+ZxTO5lOnZOj9P3Ki26utena3dxUaVIye1zjgAKDdcfrz3xLDYUSVFmuGoQtd6iZ2/aEZxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa6RWKJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa6RWKJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0051C19421;
	Wed, 19 Nov 2025 04:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763527107;
	bh=hbabhs7smhC31r5M6RYgKgO60+4gpCySXz0v674VsCc=;
	h=From:To:Cc:Subject:Date:From;
	b=fa6RWKJNIY8jRJP5ALvw0WGk0dfx22pA7ribNMP59utbOfY6hQgR/9csTSUEZXIjZ
	 JrH53Z18R1sczsLs5jsl9My3NCE2k1hvN5O585B+rUUSggRyXhCzSyeApM6xcBeZN5
	 2q/Vod0fxcKilbQ2Bd3ciQtkDSL4216abMvQZfPmuYfo8+zvW87qwzwyhiPWhauER0
	 FMwdQiFf/zhXbv3cO2zOOkW3vZYUui7Aw8AB9cn3fGKoYCBAUq7s/PreUiXaA9AU4i
	 yHi4Sjl83zts88lKkZmfPlfTRNvPN7npH279mrp9JEwhO66tjW1SpU5t0Zy3vYFP4c
	 3jGgGIbBWeQSA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: [PATCH] zloop: fix zone append check in zloop_rw()
Date: Wed, 19 Nov 2025 13:34:23 +0900
Message-ID: <20251119043423.1668972-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While commit cf28f6f923cb ("zloop: fail zone append operations that are
targeting full zones") added a check in zloop_rw() that a zone append is
not issued to a full zone, commit e3a96ca90462 ("zloop: simplify checks
for writes to sequential zones") inadvertently removed the check to
verify that there is enough unwritten space in a zone for an incoming
zone append opration.

Re-add this check in zloop_rw() to make sure we do not write beyond the
end of a zone. Of note is that this same check is already present in the
function zloop_set_zone_append_sector() when ordered zone append is in
use.

Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>
Fixes: e3a96ca90462 ("zloop: simplify checks for writes to sequential zones")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/zloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index c4da3116f7a9..1273bbca7843 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -448,7 +448,8 @@ static void zloop_rw(struct zloop_cmd *cmd)
 			 * and set the target sector in zloop_queue_rq().
 			 */
 			if (!zlo->ordered_zone_append) {
-				if (zone->cond == BLK_ZONE_COND_FULL) {
+				if (zone->cond == BLK_ZONE_COND_FULL ||
+				    zone->wp + nr_sectors > zone_end) {
 					spin_unlock_irqrestore(&zone->wp_lock,
 							       flags);
 					ret = -EIO;
-- 
2.51.1

