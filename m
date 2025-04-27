Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BDBA2D;
	Sun, 27 Apr 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745769830; cv=none; b=TWiXnvYUIUle3kf/blattsWg+TPe11p7rLa1Gc6Fxc9fAExBQZ/S93a1tm3O8ugK7pEm7gaf2n/sMwhJHMGnhy0RRedYiPvSisgFz/VhzOFsZqdhVR5KXBTCoqNTmw7SMy4aAZoxGqkwo4xoAKHUKnorPshHOpFweD126E+EbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745769830; c=relaxed/simple;
	bh=eIm4mBS01cWxJ5HUve/5Q6CbXrYS9V5HjYj6Q+TUTH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTgm4o5ir/zT1WNgKh/PH4cnYIqDgG0OzWL4J5/SSyQIpqHMkkx0nrpQRVL+90AFjX4cmtcWeT5LrSCJ+1n73mbfPjWaaj1kTSkxOIf0GdVqEIbFQgUvlR6KBCYMqNl1J6w0PjUT7xEe4dBcRv64e5D+bjrl/5rhJCfDCJ/lbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a01:e0a:3e8:c0d0:d84:340a:c5d0:109f])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 348CC410DE;
	Sun, 27 Apr 2025 16:03:46 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:d84:340a:c5d0:109f) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+3291296495fc970e4b1c@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Sun, 27 Apr 2025 18:03:41 +0200
Message-ID: <20250427160341.70153-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <680addfc.050a0220.2c0118.0c71.GAE@google.com>
References: <680addfc.050a0220.2c0118.0c71.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <174576982659.11010.9679614948215740987@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/block/bio.c
+++ b/block/bio.c
@@ -691,6 +691,9 @@ static void bio_truncate(struct bio *bio, unsigned new_size)
  */
 void guard_bio_eod(struct bio *bio)
 {
+	if (unlikely(!bio->bi_bdev))
+		return;
+
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 
 	if (!maxsector)
-- 
2.43.0


