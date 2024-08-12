Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA817D34D;
	Mon, 12 Aug 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470744; cv=none; b=Ju4IifJQBLx6QbH7Mojti/5nGMh/IKKsfryW7npSg7A0VU9MBJW/OMV2qMwzlZp1W0Qg0mzGMvYJHrnWbUqrNL/gRKEe9vh9wLS9BYbLzx06UE7fuuPPT2DIsQIKkWDSwxVpF3vm2w4WytArIEQivNoc7RLQK26T5ejQSN+JjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470744; c=relaxed/simple;
	bh=1nykpV20XzUyh1xghYDzTzIRKc3dX90aa7aq40fZ6iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYvCdaXzwbxDlQcVmWRJGkfjr/bNqaS/nXKpwjo1XY0LIyEzvgWYeK3TLeC8XyohTJ3KWHUvwpI/XRDBEQUn7F/0p3slMEeHd7ZT1xrhcIgJPJCM6Zssc6hd79t4VCTOnzkV6JgwgtdS780WAVeUAkrcpKV/UrDyZtjKxkYiDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=rdvzS5oT reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="rdvzS5oT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ExUwhfh9phkCbbYOnXzCUwr8Bo5hwWP+odZj9PhevEY=; b=rdvzS5oT+ybPlKqsblXfZflCUc
	yL8cJELY5LfnVLjER++4v8mfqpFeoFCkInWE/NH1Pbjf4JfIBu0fQlJpzVaYiJQE5FyVdulRqOsJJ
	GvUjvI8bCPp7WTPVJsggz0INvLbd3BQ6IrSUgWvFU/Xhmxn7hcnEVrY4he+jmECksIbjByiOJiq1j
	19V72j1hAVGLdnsTT/CO+boe2HmqHXuuMLT3GAXAGg99+ROMYryy9YDknYkR2cpTnB34wSlm+GICl
	9AfTQZu+dI7lEY5UTuhbfDhHeL6lvVfurf5iCnjUdj83+K3Z+XiQGyQJcLYpWaWAy4Uf0bvkfouEc
	xS+QY3Fg==;
Received: from vc-gp-n-105-245-229-160.umts.vodacom.co.za ([105.245.229.160] helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sdVT6-009Xv2-1r;
	Mon, 12 Aug 2024 15:52:16 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sdVBW-00000000VEg-3N10;
	Mon, 12 Aug 2024 15:34:06 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	Eric Blake <eblake@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Eric Blake <eblake@redhat.Com>
Subject: [PATCH v4 2/3] nbd: nbd_bg_flags_show: add NBD_FLAG_ROTATIONAL
Date: Mon, 12 Aug 2024 15:20:40 +0200
Message-ID: <20240812133032.115134-6-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812133032.115134-1-w@uter.be>
References: <20240812133032.115134-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also handle NBD_FLAG_ROTATIONAL in our debug helper function

Signed-off-by: Wouter Verhelst <w@uter.be>
Cc: Eric Blake <eblake@redhat.Com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b2b69cc5ca23..fdcf0bbedf3b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1714,6 +1714,8 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 		seq_puts(s, "NBD_FLAG_SEND_TRIM\n");
 	if (flags & NBD_FLAG_SEND_WRITE_ZEROES)
 		seq_puts(s, "NBD_FLAG_SEND_WRITE_ZEROES\n");
+	if (flags & NBD_FLAG_ROTATIONAL)
+		seq_puts(s, "NBD_FLAG_ROTATIONAL\n");
 
 	return 0;
 }
-- 
2.43.0

