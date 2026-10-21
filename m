Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575253;
	b=RRL2WDbN2c0Ls6Y+Sz7Qx8l1fA0c95bhbRXs2wO8KTvJjsbzNoVNE3nUCSmXni6M3DdD
	 nScsalzHlipmsDHw1g24muNJwbg7PAdXYdSyzzQH1ex1w8lQwqm415+H1TvySmigp4MMB
	 xxGbrDNTJ05Xfnf8reWIoefCpZTPsmH4SU4prx++/o8UF71E/tCdvfHAS/pK/vs1oe79o
	 W3nXzxKrClqtrmIS65u+HesOsvnq17/2CX4gJEYsab2KGZu43gISQdyexTDic9sW1pQct
	 9w32Pe/IUBhM8YK6Be5Z6y8DLbmc1sbEqvxLeFtgNxmXlC1j4cmg5mYQbdkC80Jhb+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/icW9de2yPi45VA3VGlvd36JSdYTaM+DvBNccOsQTwY=;
	b=F0vLLUTZchERVQlaUen0vikbZOXqOIDyk41DOFzW5TtHydgCli7zevd274zM4QSHeTO7
	 m50J56TDYtgPgMN1XAcisGBgJzIsuz8+OQsyrV4feXyMXya3nNyJsfAtAZlfNRk0Wn9Wi
	 J6dxKMG8fGTeH4i9Dtppn2mnf+YnyNryjOhPL/VA5XeOTYYLaI3fK+xckJu3eeDisdTZl
	 u2IHq9p8j23o4AaZn00mPUA+C10lYcp7yVofHj3Wq0aXkJWesFAtwPdMcGhxhky9DS5F1
	 Vz6ktRpkeRBt2V0hV9puG9Nf/pnXvqXGQ9lEzj2HOELPj9XtSfJEtsS3j9ZNuokbx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gV78xjk8;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FB606A31E
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 09:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gV78xjk8
Received: by mail-pj2-f6.google.com with SMTP id d9443c01a7336-2e987949882so2853015ad.0
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792575252; x=1793180052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/icW9de2yPi45VA3VGlvd36JSdYTaM+DvBNccOsQTwY=;
        b=gV78xjk8/82DGacL2DayycVIorrceekLo5SltnqN48dOsqJlMiSefW2t/j2EnbXx7B
         hloTii7NO/EdN8mMnY7KyuMm13T1MDixIyyxkZLdg4/I70KntgADmkG8U65ol2r7rFzL
         wJQiYaKiRIf6EVhDVkZpW9b2kGm5MBmPcNHqOqtHLRu3eEFgZtaiIqVslu+LWuhbhE+Z
         6Vw97IDR9Ms+HbHv60lBqrIVQRN12C/oeLFOrDvelkJ2Z++TiidSwabvbIzx3OCNj+um
         3KQuCVcKYoaemtj9XnzOhe7SFD70Z2DlFIY5o5eLs1XtCq72Zvc+3V4nN8/lvOx7sfT+
         FE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575252; x=1793180052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/icW9de2yPi45VA3VGlvd36JSdYTaM+DvBNccOsQTwY=;
        b=b0U6ULOsMoeCIjJ2owiPdZP4bEYi09xySO1V0jUsG2vFcBEsRuip0z3aG5Ub3DbGx9
         8up9VBTnODC/krL3FIXn8MxtUkofEYTEjFtnM0NudvoihXZLoVpR1D2W7CjFiliVjmrN
         jfJkoz2QXKWhPk1rVuWNqktCbZoJSIInJuyhMj6xfoRm1ErSqfMVtYQ6GPlZw8fZqDL6
         LenieEJB0rmiHh3FNFadv6CQkutMMIDN+gOIyYAA+r5pZ4Y+BDC640PGfRcDje8Amium
         hIkFC8OrGrP4Ugc+v1BX33x40EZ8ornaP+SNp9PWs8cOY4W9K4YBMUCmEET7BWafOgPI
         oC6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxkPAPwduQKvEqM49qBLoNBXf2SKKpIHK9OmkeV82cLmt0B9GWTqkuFSnaqr0wjn7dlxJiC/ohELAcp2w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKUOjtbqMsLyBRfI3+pv1WH68loEmWzCLB2Qn+CI9XLFSCmFc4E
	65zzo4Tj5H8L2IDpp3yxzPXF24RV0Rk3Vg0hfG6CcIuZtMez90gP55thXQkG2zmqBsk=
X-Gm-Gg: AYBFou3xpDZgnDRF3iaERDVcYUv9Lbjwm9Za+uds81SVAeb+7VYAWjHUX4EApgEc3mA
	prw2VAkZrudkLma59EQr/n+5B7t0J0m/3dQonvk3SZ+E31wH0fQwRpwM3dY1IJh7ThNiKbbPNbF
	hIghHBpHfC4qvY75O4qPRaASd68j6r0b1Zr7h6/jh+liuZ7VmTXMXfnUIELuBSTNVZocDnTWTyq
	EJ9to3dAe/S5/kPIgKoO0FTDnTi059yJtv583b2JkgFbooitW7KhOHlp2FsqeDYAStkFB8EC485
	QAjbWnUWn7vXth9OvX5kDAZ+mZRTZuEJICPSyP80ehLXLjDeKV+Pauiwp1ucQepAjerAcTPjDgc
	QmL0Ngjp56V1MraSA3BTX/u3tBimKoU5Pwujp1hbq9buyHm0FxAguBGZ+MSGOLQHigKduoLxKnY
	Vz4n9KlxOXOELnWDQYV3mUPvWOMbsMaqXT+pxNaEQwXFCl13XfKyX7BHgm43ATrgZwxk3PvmecG
	oNWIycIU2Ry07QyBBxuWvnC0MnCaC8Ym2gr73iUio6wKBBIllO6fdL72dTiZUbQfCCxsJkMiQKv
	lDoKyrKxJP3Q1fSeKe82lHOnNRpeScy1SFITb8gxs7B/+8p6
X-Received: by 2002:a17:90b:3bce:b0:3ab:2c2b:1026 with SMTP id 98e67ed59e1d1-3ad86f794c7mr1272615a91.34.1792575252058;
        Wed, 21 Oct 2026 02:34:12 -0700 (PDT)
Received: from HXYG4FPMGD.xiaohongshu.sh ([61.8.202.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm3699898a91.7.2026.10.21.02.34.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 02:34:11 -0700 (PDT)
From: Zhenxian Ma <mzx199711@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: hch@lst.de,
	Zhenxian Ma <mzx199711@gmail.com>,
	syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com,
	Tal Zussman <tz2294@columbia.edu>,
	Julian Sun <sunjunchao@bytedance.com>
Subject: [PATCH] block: don't take i_rwsem twice in the direct write fallback
Date: Wed, 21 Oct 2026 17:33:32 +0800
Message-ID: <20261021093332.17334-1-mzx199711@gmail.com>
X-Mailer: git-send-email 2.55.0
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

commit 2fec4fd97cc3 ("block: take i_rwsem for the direct I/O write
fallback") takes i_rwsem around blkdev_buffered_write() in the direct
write fallback.  commit 1b1be9ea4e34 ("block: take the inode lock for
buffered write fallback") fixes the same race by taking i_rwsem inside
blkdev_buffered_write().  With both applied, the fallback takes i_rwsem
shared twice.

Drop the outer locking in the fallback.

Fixes: 1b1be9ea4e34 ("block: take the inode lock for buffered write fallback")
Reported-by: syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bd975ef54294bec73f0e
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: Julian Sun <sunjunchao@bytedance.com>
Assisted-by: LLM
Signed-off-by: Zhenxian Ma <mzx199711@gmail.com>
---
 block/fops.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0e4c42c8b74f..ddab4940d76b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -809,13 +809,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				else if (!blkdev_dio_fua(iocb, bdev))
 					need_sync = true;
 			} else {
-				ssize_t ret2;
-
-				inode_lock_shared(bd_inode);
-				ret2 = blkdev_buffered_write(iocb, from);
-				inode_unlock_shared(bd_inode);
 				ret = direct_write_fallback(iocb, from, ret,
-							    ret2);
+						blkdev_buffered_write(iocb, from));
 				need_sync = true;
 			}
 		} else if (ret > 0 && !blkdev_dio_fua(iocb, bdev)) {
-- 
2.39.3

