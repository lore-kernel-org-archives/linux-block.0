Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AC353A81
	for <linux-block@vger.kernel.org>; Sat,  5 Sep 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788614999; cv=none; b=X8rQYHdK6+eyFHsniazB1ybKYPB358l5fB9yWkz15ayOGr2lTmETHKj+DqgAVTr7y04Fler32WlGxyA7DSjp7hn2gW8EYmFNQR3emFFfrhGnnnW/lvvxSgU4LKbIIXccOdJ5ac7dWD4Kk5fS/kXlY785ZHJR6cF1RXTiKbMSXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788614999; c=relaxed/simple;
	bh=SltN6IXvVZySJLNlF9QjGwMOqiRfXZapoOtgvjPGYc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/iHstt5+QLhlLrIFJhDZURCBzMm3Cl8SGN7ncM1MvIzN7vzqBb5E0K+TKG0wbhMxMR4yt/sbQ/yxZUHmnu+IHBKU+oycyv8utY4QCvnO7uIa+JvzeH3PdC9XHI86Gzy/eOaWJuCF2u5MgAeQwOaR4mFS45bAkIYHy+k/ztb/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/J8uzzS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/J8uzzS"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1383674a12.3
        for <linux-block@vger.kernel.org>; Sat, 05 Sep 2026 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788614989; x=1789219789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=;
        b=N/J8uzzSJHC2Y/zhuamwIuQiBr4fSCcySVSUF9pnuntkDLlKk2Y9EKBp/AokxqGDPN
         UbQT/iAatYPG4beX3RLt0yDg8JVt6vhojDfY6mMzpa1ERZGQ2BdD6hDKL8L0rj+wnKtu
         Czdvqz79AACcWPMgqv6wKAuqv5WLff+ZScu9lWzD1toFlLG0g7xAkDaveofOKYzNQF+x
         PxN7W2L0wBdi5Cic/8nk8anc3d+wU0s84hobz1YaWwBB1njRaIwPw2htpKMaylz1T8Sl
         IPbbtBnM4VssRsZBIamvjvSsBwFTWxhX9iAkDMLtnOazGl2TNRHsqxtrH68PzBBypbHN
         JNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788614989; x=1789219789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=;
        b=Fq54C+C1Y5d5UbnP/OczrzYZuG0ISiOZRsJiVedn/GJPBLaf3smYmSCnMnNMICgfqe
         L2BbzVUAGuSfjBpPdwAye+OgEL1iBvNqUC/KrhhIZXUQCpyyQMcDXJH1QDTjsxtEtX1s
         OPwPGLsKOiEj/BzAH+o2bUqXC05pXRcnwVIVvKAD6WEZSznJxLM3Obm0Ia+S2/yfrH+0
         FkE7SFJDHCkdk8qbaPuEfSka0N58S7OetgJfdwiZOV1PPwoRRAWq+VsTIk4HZkkZGZuC
         0Vzi3Qndd13HnempkqSiQj05VPs5oJV9hSD9qaKv2FjMijHgW0HmQWhdJ1zcdgbDgEWJ
         rARg==
X-Forwarded-Encrypted: i=1; AKwUvBy1C8ZWBLiDXtUlarObZ5WmPIuGgJaZu2Dy/xkSjVmd7NznhifBopsenuoqieVHBInYi6jXsAEa1kbjCA==@vger.kernel.org
X-Gm-Message-State: AFuF++mp2tgRhPyTG1/cUINg33ALxur2cG4RN4B6lhymZpsr24XVus+E
	pRSuauUZ4SazBGJjyeQ12+ZAMoDXACMw558//Qr+8GJ+hri8/CA7mXXv
X-Gm-Gg: AYBFou1Vl9yK4GiBJ5PUcQ6k7ljsg12aH4bhBT+eq1p0D4GQDNlQfGtpVwSyX/U05g9
	vs5P+BVS59AtoG/MbyOgZiFD2wCldZp0qoImrqLV/6VQSQ33J1BoMuc49BGemGKD5StEXNLhzcV
	5PHCw2dDDHViNiNuKlvPqFL8qPUObWd05fEKnALcIscsVgfTiKSk780t+N2f4LGA+gYTdSEOH/X
	SjW4E2/uFvttGEX8h6KvP87p2NvwozWfaKyT+GS4HCCvPsriVSawqJaAJon3o6QKxNELhcD6uuf
	GYXmVPMBqHkTyqkI4jzeJQsrWHHVs1UF/PDsuRs+G3NOu0T76mTKqwEzdBHiKGjPX6Jsle6MrnS
	qSH+Maosz4qIkBLg2jLzVGdzhVscTBq2r3E5BwKboh3TM8Me558wyIVtbeRM+NenkXyew614CHU
	rBUeB1KS6UpAfffNaQsHsp3YSQduOqNSZ1fTz4ChhcXCqKzVylGBR+K05BAB+J+DusI4dPjR/4D
	RjkcioV4BLJ64UxngxHrg==
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39b2614df74mr17583898a91.1.1788614988974;
        Sat, 05 Sep 2026 06:29:48 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c397b1sm16146499a91.8.2026.09.05.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:29:47 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Cc: syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
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
	qwjhust@gmail.com
Subject: [PATCH] f2fs: handle NULL kiocb in write_begin
Date: Sat,  5 Sep 2026 21:29:40 +0800
Message-ID: <5fdd4d960a6b47ab7cfa6ef0f44fb575fc45d1ca.1788611415.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qiwenjie@xiaomi.com>

The address-space write_begin callback is also used by internal callers
that pass a NULL kiocb, including page_symlink().

Check iocb before propagating IOCB_DONTCACHE into the F2FS-specific folio
lookup flags.

Fixes: cd5bc4fbb900 ("f2fs: enable buffered RWF_DONTCACHE")
Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
#syz test

 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e816c9349a..63625ab3f1e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3890,7 +3890,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
-	if (iocb->ki_flags & IOCB_DONTCACHE)
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
 		fgp_flags |= FGP_DONTCACHE;
 
 	trace_f2fs_write_begin(inode, pos, len);
-- 
2.43.0
