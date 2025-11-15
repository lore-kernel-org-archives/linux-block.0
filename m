Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691CD283CB0
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209205; cv=none; b=Effot5tdXllDzKzIMMWLPmPGDvkkqrqlR5ZUHPwmg/4fdunXLQoHCN3ExkTHtGHSH7p9o/FFQXopmX3/0UQCU4yBzPWLuYuQx56gqRNNV2uTLItHna9gmyHdhYP+wyNlea9W4QAItKGqpfELR0NFgTgug70SY4isnTzI9Ap4whA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209205; c=relaxed/simple;
	bh=unAU9uAsip7tWQFwi7uxy2YVjiPdG/vwwDj9LJJ3JVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7FMOn9jBYm8OLfaDNo6kynbBwyA+y8NFAzAWY1S0tVcJz/YiOItkwMLdb5ri4ZnyP8HyBMsb8NJuqhGe0sqvpAfabJ72aefO3WI3XJ4f5Jl6ci/1DeNapgQ9hz1KsZXnHEcfmO3yE6r8ovTv3H6VHyTSE9itUH23z3j+vQPTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBxbiDLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBxbiDLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E6EC116B1;
	Sat, 15 Nov 2025 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209203;
	bh=unAU9uAsip7tWQFwi7uxy2YVjiPdG/vwwDj9LJJ3JVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBxbiDLogccr8aCDnh6F8XCm/i7GgfVRZfql3F8uE82r6+V75oqNRi6lVUXfViztN
	 UJaXdwCcuyEvlXYgTFC2noYzM5XChaQod+Pgo3wGYj1dvtr75oH2L8dTKeUnS0Naw6
	 BxLmHZvZI24N+eG/tec9FrGwlDkp7dNcomgpiqRZWyPyVctSw5J51xi28QOlFeQJDk
	 cfTMvq2JEgkHw9SwPSbysY/qWW7o+tHW3AY0NZm0Lde0pWcPBDrBMZiSWP1Wy9hs8L
	 qlWzdAdZoq31IIPkhRFqO8ZojHx6kkLpoe72BnWYCkrKRUfyzyLU9C+77adzKmsOiQ
	 OQtffVEEk6Ttg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] Documentation: admin-guide: blockdev: update zloop parameters
Date: Sat, 15 Nov 2025 21:15:56 +0900
Message-ID: <20251115121556.196104-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115121556.196104-1-dlemoal@kernel.org>
References: <20251115121556.196104-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Documentation/admin-guide/blockdev/zoned_loop.rst, add the
description of the zone_append and ordered_zone_append configuration
arguments of zloop "add" command (device creation).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../admin-guide/blockdev/zoned_loop.rst       | 61 +++++++++++--------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index 64dcfde7450a..806adde664db 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -68,30 +68,43 @@ The options available for the add command can be listed by reading the
 In more details, the options that can be used with the "add" command are as
 follows.
 
-================   ===========================================================
-id                 Device number (the X in /dev/zloopX).
-                   Default: automatically assigned.
-capacity_mb        Device total capacity in MiB. This is always rounded up to
-                   the nearest higher multiple of the zone size.
-                   Default: 16384 MiB (16 GiB).
-zone_size_mb       Device zone size in MiB. Default: 256 MiB.
-zone_capacity_mb   Device zone capacity (must always be equal to or lower than
-                   the zone size. Default: zone size.
-conv_zones         Total number of conventioanl zones starting from sector 0.
-                   Default: 8.
-base_dir           Path to the base directory where to create the directory
-                   containing the zone files of the device.
-                   Default=/var/local/zloop.
-                   The device directory containing the zone files is always
-                   named with the device ID. E.g. the default zone file
-                   directory for /dev/zloop0 is /var/local/zloop/0.
-nr_queues          Number of I/O queues of the zoned block device. This value is
-                   always capped by the number of online CPUs
-                   Default: 1
-queue_depth        Maximum I/O queue depth per I/O queue.
-                   Default: 64
-buffered_io        Do buffered IOs instead of direct IOs (default: false)
-================   ===========================================================
+===================   =========================================================
+id                    Device number (the X in /dev/zloopX).
+                      Default: automatically assigned.
+capacity_mb           Device total capacity in MiB. This is always rounded up
+                      to the nearest higher multiple of the zone size.
+                      Default: 16384 MiB (16 GiB).
+zone_size_mb          Device zone size in MiB. Default: 256 MiB.
+zone_capacity_mb      Device zone capacity (must always be equal to or lower
+                      than the zone size. Default: zone size.
+conv_zones            Total number of conventioanl zones starting from
+                      sector 0
+                      Default: 8
+base_dir              Path to the base directory where to create the directory
+                      containing the zone files of the device.
+                      Default=/var/local/zloop.
+                      The device directory containing the zone files is always
+                      named with the device ID. E.g. the default zone file
+                      directory for /dev/zloop0 is /var/local/zloop/0.
+nr_queues             Number of I/O queues of the zoned block device. This
+                      value is always capped by the number of online CPUs
+                      Default: 1
+queue_depth           Maximum I/O queue depth per I/O queue.
+                      Default: 64
+buffered_io           Do buffered IOs instead of direct IOs (default: false)
+zone_append           Enable or disable a zloop device native zone append
+                      support.
+                      Default: 1 (enabled).
+                      If native zone append support is disabled, the block layer
+                      will emulate this operation using regular write
+                      operations.
+ordered_zone_append   Enable zloop mitigation of zone append reordering.
+                      Default: disabled.
+                      This is useful for testing file systems file data mapping
+                      (extents), as when enabled, this can significantly reduce
+                      the number of data extents needed to for a file data
+                      mapping.
+===================   =========================================================
 
 3) Deleting a Zoned Device
 --------------------------
-- 
2.51.1

