Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170666;
	b=0LzJqZz0VaS+agcwHwgJAJ0cf1fiUbeMBkRnuULLjWynPBaOhR+xr306JijU+MKTMGL4
	 d3prqHouBYrxQZvubQubl2HFJYeaFm73AO0lTeddhaR+RHBEvx2NTG3ux75OzPpieqX7Y
	 Gv42q+pSj5xPa/v+SUVkG+3eigUXK19ygnhk9n5hi6e+Rf25QrxMDId+Vlp/BV3cOKDi2
	 oOSwshEWD4RdHu8bSyfz4+LqQdRUvLnvKGDJfQS2jmpSlRx7qBc5JiR5vtR5PM3Ue7uRV
	 M5XbLr9kcAvFe8h27ucYvKKAxHxWQu7FH85sEnvqlSMHcV40WUeLSwfiVpBd898BrHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170666;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4NvHKXhj5jAm3S6feuHHzXaGQeaH4gvsk2BBP8dDlfk=;
	b=yXDuTKTnMdQ+ZvyoTYT4r76Bt7plTmgENkUz4YWTzasLrwxsb5VEA+VmH2nKNXD2BQdB
	 edJ9/M+K0PBllTiwkUGT3PX6gBfnG2JIFe0DNHswmJAxtbVc5xKR9j77czWZuVflLt55r
	 lxjyMWOD9w/BeKQqJtLXkuU6tmlqB8M0qmfhqCEEmkMx5dSPNaXfkcFpXwbjtlgJRA0uU
	 bxrKYcRoNintB10UlckNodlK9lBMmROQHag4mSRH35pGcBswyqhBsHNYJjfeCvxqzGTNA
	 z2g03U+2NczsucNC3G7pPREyWbQj9qfKg0iwEkFABJGafftd3UskIZcTCYMjIKnZiNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pTABLHA3;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87FB606A325;
	Fri, 20 Nov 2026 10:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C87FB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pTABLHA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=pTABLHA3DMizer+6TGFcFFOQEYD5yCYbfcxUXLtwzuCNVcdNUFTEYQGts+wpGdzTho5wslE0KZbYB
	 rQNaRoULrAB+fBC0cm6hRfRy2up3jS2B+cmuLGAwIovc4axtbwgx2G1dlEl3Uk+7j12xPWCcT2BGY5
	 CdSW2LbAGvqa8wm0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36b002162a49-f4a51;
	Fri, 20 Nov 2026 18:31:00 +0800 (CST)
X-RM-TRANSID:2ee36b002162a49-f4a51
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66b00216348e-223d5;
	Fri, 20 Nov 2026 18:31:00 +0800 (CST)
X-RM-TRANSID:2ee66b00216348e-223d5
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: tongzhiwei@cmss.chinamobile.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com
Subject: [PATCH] block: fix divide by zero in queue_limit_discard_alignment()
Date: Fri, 20 Nov 2026 18:30:13 +0800
Message-ID: <20261120103040.610-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


NOTE: this commit is worked completely by LLM

Commit e924da7d6622 ("block: Drop granularity check in
queue_limit_discard_alignment()") removed the check for a sub-sector
discard granularity on the assumption that lim->discard_granularity
is always at least SECTOR_SIZE.

That assumption does not hold for every queue: a backing device can
report a non-zero discard granularity smaller than 512 bytes.  When
blk_stack_limits() stacks such limits, only the non-zero granularity
is checked, and queue_limit_discard_alignment() shifts the value down
to zero and divides by it:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:queue_limit_discard_alignment block/blk-settings.c:645 [inline]
  RIP: 0010:blk_stack_limits+0x1105/0x2d00 block/blk-settings.c:916
  dm_calculate_queue_limits+0x70c/0x1510 drivers/md/dm-table.c:1823
  dm_setup_md_queue+0x199/0x4f0 drivers/md/dm.c:2618
  table_load+0x4fd/0x8a0 drivers/md/dm-ioctl.c:1661

Restore the check, which was originally added in commit 59771079c18c
("blk: avoid divide-by-zero with zero discard granularity") and had
survived the move of the helper into block/blk-settings.c: with a
sub-sector granularity there is no meaningful discard alignment to
compute.

Fixes: e924da7d6622 ("block: Drop granularity check in queue_limit_discard_alignment()")
Reported-by: syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1288484b13bf6af3620d
Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
---
 block/blk-settings.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -643,6 +643,10 @@
 	alignment = lim->discard_alignment >> SECTOR_SHIFT;
 	granularity = lim->discard_granularity >> SECTOR_SHIFT;
 
+	/* sub-sector granularity: no meaningful alignment, avoid div by 0 */
+	if (!granularity)
+		return 0;
+
 	/* Offset of the partition start in 'granularity' sectors */
 	offset = sector_div(sector, granularity);

-- 
2.43.0


