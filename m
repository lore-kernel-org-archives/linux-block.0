Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769345;
	b=igpNV1XT4bRZL14JNbsfa9FQC5ti33P/9cctpD/LsMCikmlQZ4C3+HMgFpx6FdRds1tr
	 XLJoqIzlpx/SKRFCUKMxirz88Z8fUqLQs0VM/3D5apI/wuaVYmJ+9TbVQ8TjozJNC6sRL
	 NJDP8u8O1zgOwIRITnzuhA7PjGQhL5sDmCBBskr7q7cDCqpLARyOUhf2Or8N3CMSk3kVC
	 51JevbYLEWJy/6vBLVJ9w4I8DTbue0le3UO5plGP/L4QlWpobsubAFQ6+GJ2E+Dte203B
	 KIIj1niQB/VZ5QKKSz9NCv+2ul75qgSPiFb0rz3N4QqgMPeNSjERxTGl/Q2c/Oxtwpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
	b=OeVvdJY4sFYLxn4d57FmdlL1o0Hv/Mzm2kLyNE5e4tNisGAv64kpvgox54RqyLUqs3ck
	 8RD0nk/TrQplXXzx3TckxYX++iQQ2ZIqheCDeDMtn/1482O+aeaqMvkD9M9hyQBKN7cSS
	 dRRjx8TgFW1hr1hVfY7TVz5R+hHnU/LFurIBnxJDh2zjTHcDPJew33CE4N+8S3NNg+rtj
	 ws09Yz4bsvWp7SPE7pRJt6QD/ruJKlyQGvqkFYTwO8iQGxbPt8X1dX3h+vySB0bURsebh
	 ekMQ8ED8fhFaIfPiWywKZZzL8qmitqh/HvW74OuvwnF900y33ad7FmEfEd31BHvJpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlKEPsN6;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803160A261A
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 08:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3803160A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlKEPsN6
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so3811924b3a.2
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769344; x=1796374144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
        b=WlKEPsN6nJuR2Bu+idp8dGyZRPA0dTvBOqw9ir8XHq/esz8TCNoRZzWCCfgiIxWKxp
         mXXhTb4mgFPAmJ8sp/n3uaGPIZlTdUUlT8GNAgQ0qc10P3N3znUKHKbCjnhYkHrnSFMA
         KZfmwQP1fOX2q9RgaM2z9/AZkAI+ooZYTo+YseIwhh1dEoM+2iyn7slWgMt7oHZGSupW
         Un6p8L6PpxlR09mtmrZF+f+jnF3io/Hg3iNG8mdvPe3E1jSgz7Dv1lC124+XkRCNG+ij
         KW/t5SDj27pEBZtsl3D9kx5oQbdoZ1vw+h09IUYJux8VTUw9HDfQcM+6jMHnNpS0eS56
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769344; x=1796374144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
        b=p24ZgR2DQEKI8z0PxwchZv+Umk7iHi+tYJ9j4hen8Dr1o13IXfL4ND0YmrgNmkkNGd
         2or1epfTETrPGXahqqw8mMro4eLKIk7Q6STs07RFMhYGoDexrZUtqjayeGNKvRnWLE4R
         +6FCl4a/0KQKqCBMw9l4e0gtOMMvcpteOHQMqqGcnX4/DsSImcs8mQvrjr1povWhZTBG
         oCs3Pv8cSPcRo6HxDlR0nj72Lqmw8ejEwzPe/aP7mBiVh3t5LW34itTMzA1U2wKxa+Rx
         Wfdw+UhoA6eFsK8QcngeYCDFJi/Elb3REJxtgoExftWowrzyUjYBWWbnCkfdVXhsRvEj
         ddZA==
X-Forwarded-Encrypted: i=1; AL+hErHFhDP4qVn+9EaPn/5Dri9dzaF3wNwOzAvu+TnxS9XHSyD37U3P5pgnJzWwJPYjQEJ2APXg365NqcJ/Ag==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+TDqZuH9tJEdBau/Mxu84owYj5+yjGTPTAOpZdaCiJA0LDcpY
	dakynPyYh3ylL05xFZu1Vkht4PEXBJNTgLUFH/4kR83KY5eSLis1GYRo
X-Gm-Gg: AZFdTZdixc3+X+OJs9s50GFiem6YZcbvWni4ehfSjd+RDFD1L732x2JiUUIcstKfwwI
	oOcdvWPmChb9XujCqD9e+hwRJ/4iCDJKy9HjnifVon/b/vCg3m2dcWosZV32JBqovEn6iqyS14j
	MHsUjOi/K4o6LIdwnWf/0Mt/19ZeFzUtKmmeDh7w13WhDsV2FiS/+9vm4KYLqQGo5H/SmnEBVpG
	G2i7VXP6MA3+t1bAIxRZKginEBoqTmmTOOtiamAvLuD3B3OWjKq9dceYYRU0aAUPzwDSLIZ5RLP
	wHYz5yvbWZZiuPvjXWvkVQxqZFkmY9kJArXiExGP9VwSi6V6nHFNwghZCQjuKM21Fn1U4tlXeql
	IMOFgFISLFwHLIGkp7UToLPBynKLUV1UrfNI5eQfZTGYb/hOYf8vxJOOE5RuxGlRjSFmcZX67Sb
	MZ9WYVTRYtsIAxU/uV9xuKhuvG+OdiOFQJXWG4z+D2BTRSAvnr+we8h+D5TK9oD/7HN0l2ilW1I
	5VqO6YchdH1WMvYuylQ6eSU83Eg6IGXgciFQRSQyXAekNo//Sj1jKbKII+hLQ7Wz8bt4xhz/6bB
	WikzGg05Ssv60n4p9TM2kfSJE/nMu6m1CfQNEAdHkKs2g53vWKS2iWtVSXnAwMJptSp6CLdAmRz
	HZpJ1FRrhqKo=
X-Received: by 2002:a05:6a20:db97:b0:3e9:176f:ab86 with SMTP id adf61e73a8af0-4014bc4b23amr26347756637.44.1795769344544;
        Fri, 27 Nov 2026 00:49:04 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:49:04 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com,
	syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Subject: [PATCH v6 2/2] f2fs: enable buffered RWF_DONTCACHE
Date: Fri, 27 Nov 2026 16:48:45 +0800
Message-ID: <cfdfaea72b21b8abf58cb250495150d92e73beda.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795746008.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com> <cover.1795746008.git.qiwenjie@xiaomi.com>
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

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for
IOCB_DONTCACHE writes and advertise FOP_DONTCACHE.

The address-space write_begin callback is also used by internal
callers that pass a NULL kiocb, including page_symlink(). Check iocb before
inspecting its flags.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v5:

- Rebase onto dev, using the existing fgp variable and preserving its
  folio-order handling.

 fs/f2fs/data.c | 3 +++
 fs/f2fs/file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 37d74afc8b26..f3559c27d44c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5622,6 +5622,9 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	unsigned int blen;
 	int err = 0;
 
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c80dbbe76f8f..571a848c6af5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -6274,6 +6274,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0

