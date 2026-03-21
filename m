Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7F274FFD;
	Sat, 21 Mar 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774082183; cv=none; b=t/yc/hdGjme0O8ptdPDPntQp6sMmI5rkG5siYXgAp0qBXMUmOnrJJv/scJSsm8w+meek24RNf2C720NIdlLUdDY7eWpDCYmDW7Dkr6wlcTo5Es2cf94qvrAGBF9AtBUyieNlpI2eeqUugILAJPmEZMM8nEZLC/DtVhDNC1Y5MW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774082183; c=relaxed/simple;
	bh=ZTViAiiA+XJBFMMiVDA8D02frQmFJZ59q8N5GFh7keg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YDisINiq6/JfB4zDu41//buVsdLPlQpwyBisMt75k0dj44MlIWXcgc9RYETIxy0we0Crjdx2139hwyHiv916d1LHifvGM0mHwn10L634MwfV4wAimsegAuqI5OVvrhl6j2/K5ok7BVzQXlUpVYOgtpuWolS1KQ+BR59W6xRC4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=B4tci7oJ; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="B4tci7oJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774082176; bh=4hIrFGGd1lKPhUI0ePYRPdK5b9tVv8J4wvKu8eitP1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4tci7oJ00IiGpm4sH+zsDQeqBnbVGP8PQQac8n3FASNMHKhbbYK/gJdvEj4EHN35
	 o9FURNvV87FYsSOlVgtpTU3zU1QtdaUFgj+eZ96uAUnVlvKMPza9/Gmi/ot6JWvtsG
	 Dqf/ttDDIr76HjdEsmN29iqpF+kjCwVqM1OVF3QY=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 90D8B8B6; Sat, 21 Mar 2026 16:36:13 +0800
X-QQ-mid: xmsmtpt1774082173tpyikc4cv
Message-ID: <tencent_B483B24447B77B776C66D11362A37BE96505@qq.com>
X-QQ-XMAILINFO: OcN56dxiYj5T+5aX1PQJgzJMbSSN+cVh44qsFWHFr/UAdEFD7URAm3HopIwypQ
	 gGjbvbDHUosTxWEzmZ/ENdcsa9WrBeBaQf/AskIxnut6j3+1zf+DZrKx+vaW8ZF7tSo8UD1W5Ggt
	 BkG5mrdUbiuod7E5d/KWfreBF3P4RLQ+1VbprRgKYUnsWu4IPCq9q7YEFupEMNUQVrd2GebDPrGp
	 G6qoNZVrfQrt9u6PFynjZRwO5j+9cnwxHOWrMbISKlpvRxgiRu44obYern81464YzNj4FAa/7GRw
	 BB3vX/XfqBHfw/SRf6JlioqQtwOumyF3NLoRU6TFpsi7dW4uudUZ7IwAHTY7MB/f+ZqmzUjykuOl
	 Tr9lc9TmwMyT8zdBWdjmYRrbyl0dBcgG7QCgzQDU2QN4Arc6rhpjLBM0vIQDbIARwWHsbv6wu+yy
	 Ay0fWAFhsADPwN0PCWkdgIV5AgpJxSBO6dF3E5IRAsbP0pd3YQWdvhJ1VDO+FQKKgtC8XlIkCkmg
	 rgsEkF5rRPR/jYEOMvVccUoWFxDP9TurqSgR/JUg82Qe2hR9AIS4dsXHcwEyU4h6mENdm1fqWP3t
	 tDK6sO2CdVqb1jKSFXXR5ghQGIsa+yqFohAQEJl//J2iP7bhww7ivaU5z1Y7V0QdTeno77roJ52V
	 tfS/QsK/R+upmEoJNm7/dmZTTgT+p0QJd2ks2jzQDD1zDiDD0lLqL1FmxNnANToBMba/vjfh/NaC
	 eltLrU2BnKflQ/5Q3gVC4TSHs6Vhp3oN1NVkf4f76i1uQYXJ7HUtrzg0b4Qi5kRuzuchgJ/xfkNw
	 n+A0I7CdGtgVBEQH0QiZ2c+P0Vm+/vP6ioXYW6lvYm9uMPDK5fgyiYKNDFNP5FCVxFZ9zR7FvAy/
	 hG8tCU08Difo06pV0QlBwwxDQ3yPwrsCLKx/zjqip+cQFOgCdUXnyOBqF7EMFQuw/zYiI3T0kx8r
	 1GZDiHh+857G1oT9QBp89DDx0JCCKfRjttxgj3up++BU1Plc8TV1morpJAoELnkUVx3ruZDNNAts
	 eTp1bNuuCYcKsfFZGNNlXcSwgU/p4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] block: mempool alloc fail due to insufficient memory
Date: Sat, 21 Mar 2026 16:36:14 +0800
X-OQ-MSGID: <20260321083613.350744-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
References: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a failure check for mempool_alloc() in the slowpath.

[1]
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:bio_init block/bio.c:214 [inline]
RIP: 0010:bio_init_inline include/linux/bio.h:435 [inline]
RIP: 0010:bio_alloc_bioset+0x664/0xc10 block/bio.c:593
Call Trace:
 bio_alloc include/linux/bio.h:373 [inline]
 submit_bh_wbc+0x22d/0x650 fs/buffer.c:2816

Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
Reported-by: syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09ddb593eea76a158f42
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 block/bio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 5057047194c4..0a870979bd41 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -582,6 +582,9 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		opf &= ~REQ_ALLOC_CACHE;
 
 		p = mempool_alloc(&bs->bio_pool, gfp);
+		if (unlikely(!p))
+			return NULL;
+
 		bio = p + bs->front_pad;
 		if (nr_vecs > BIO_INLINE_VECS) {
 			nr_vecs = BIO_MAX_VECS;
-- 
2.43.0

