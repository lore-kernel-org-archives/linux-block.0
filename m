Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5772E339D;
	Tue,  4 Mar 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107985; cv=none; b=JZONJcngvsbvUcyKSP0TWd8ublp1k8Kz5XyGS5ONEqmIM7vNicnd4baq9tPpRMEFLM9jhv2NE1UQkFIJJlEgm2tIas9DqgWeLDrSHkNLpgH4GseB1ObbfIlatzGV8q1lAEBND67aVC19CZOOxdJOjPhOFfUF42gt7qwZHepaGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107985; c=relaxed/simple;
	bh=gplCaX+VWzq5DdsjNfptvfyOwRsNpfyecdkli3hz+E0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlAyiqYtP6Jkz20qkchUScvpfRQmH/8qMzCCCPNpg9m1m+dOONHR/4A35coFYtJ+ZYTDm/5o/156P7me4g3H6dGqd92iGLEwM+fRIb/0liMkQPSojgVjAiq6+pkISubxvXoWlT/5Hu0HiTaQttP/5wOJd9dHU5yqAhQsEb0apx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tpVim-000000000mq-1eLc;
	Tue, 04 Mar 2025 17:06:20 +0000
Date: Tue, 4 Mar 2025 17:06:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jens Axboe <axboe@kernel.dk>, Daniel Golle <daniel@makrotopia.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Douglas Anderson <dianders@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Lingfeng <lilingfeng3@huawei.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] block: partitions: of: assign Device Tree node to
 partition
Message-ID: <c0b234511303c2efbbff336ed4d5bb993b54f16b.1741107851.git.daniel@makrotopia.org>
References: <8cfbf225bcda906df0c89dd18ba07ecfa17123c2.1741107851.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfbf225bcda906df0c89dd18ba07ecfa17123c2.1741107851.git.daniel@makrotopia.org>

Assign partition of_node so other drivers are able to identify a
partition by its Device Tree node.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index 4e760fdffb3fe..8b82f9f396866 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -48,7 +48,7 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 	u64 offset = of_read_number(reg, a_cells) / SECTOR_SIZE;
 	u64 size = of_read_number(reg + a_cells, s_cells) / SECTOR_SIZE;
 
-	put_partition(state, slot, offset, size);
+	of_put_partition(state, slot, offset, size, np);
 
 	if (of_property_read_bool(np, "read-only"))
 		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
-- 
2.48.1
