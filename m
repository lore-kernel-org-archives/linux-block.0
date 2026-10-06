Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8873A7848
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281011; cv=none; b=GTcVnkau5ygNiRDdYZofCvT6iJ9QFyEWi++EcDczg9fX/PtC/DIsDK9OUwaKUUVBp5RJkzSlhDnpdJJHVudjOj/+wwWqNmtbVUtudyNWCc4OPZnGhik2LmShLaSi8r0NVXFXCsDO/D7idjYktV+pDgbFYyg8rvZCfbCXBjRAw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281011; c=relaxed/simple;
	bh=4yADt5rjladWeKpuNOSKS3cLtKhVa7EPDWv8TcMsBeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZNUxKa2bweu7iBejll3Ls8RYB1yy3SFZxEykJOKomnR8wgNODD4iXxd8gtNs/PJQrlJsiHOGIBmNBADndscdviB6P26ndqMufzYkxcioGVI3y7YiwW7KabsSFbbzHpMdCY9UK0VigaHDxVgb04d62rB3sKZb1RDqQSH8QDQwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so5109695e9.3
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 03:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281008; x=1791885808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVXG+Hhha7ESqpwxCWCC5IkRzxzgl7i/i73esx9czc4=;
        b=cO2OnkZOpJDNAC74+SMp9W34rrEVlxGROWkFoVubRf11SpetbmBqOtQ/FE1/RHj+jH
         qknnB8kPyFxGtL1mxuCXmCzpP+iivxde0WfCNFCv9a3u5vPlJKcWw7zY7aAjAi+akuuO
         GYmdWGHPVE4IetH43Vm6Puy+WJ6UUoGzvyd5XwQWVBfrdHEPrO6kJyDex0oGp4QBeBVY
         lR1X8iHS04SStJPOB9FUaQ4O/5Dg9ww745ZA1nunJ4v4DZDpEIkmZ4113jVOgXB8es4o
         rtOD7up0VPbZGlLKnqzzWJuKDzFo1Br80XoTAKNdV5z4uSeOR8zW5NAt4bC9qhzosj4H
         q7+w==
X-Gm-Message-State: AFuF++nWkRXAbgNNAjtP31T23hl4nfNx8jH7Onr5WPj9iFi0GzznPrpJ
	OHl0fqbll1eA13D4w61VswAT81Rkib2kszKPzPrQ8rsoIyMK/BVZMna5VvJpC73vCY8=
X-Gm-Gg: AYBFou24drZgCMIRK04xgoKy14fi0lS1U/WuFpvojGFVmt7+cDstcboX+/kBS5gLk2z
	OnOPpi/TXfBM88l12t4TNf4mbvH2sk/J2iDJ+Vf1beRPJtPdf5I4EXH0ycZlb20t5tz+xUmpiAs
	nObSa7YqR1DIzqn7KlQ1q8dPm9fL8HbvWk4uF8il4FtGayVPUZzIMUAK23qjZ5vw7WkvYc4dOMK
	rV9/wReAKL+jtkPUWD+6reFSOubW6/nW6sQGwdEJjNNB6qyhgeJuib0ZmOZaoK8LNDW5KO7O/Vp
	tOMEYa0qqpGezEd5bFnwd8i2XkcOVt6wzAlDQeBqVpB4t3G6rUHteR60rKIpGgfrbI57QKFCvNo
	EufKB0sLWHMczr+Zq56sMpdaYOl7bu+Ke/+2mNpt+fcsKXJkkr4/Tqaq9FGO63jgGsmTjXlih77
	BKHAXNLp2oLZMX4s2AZNKal5P9/gkjBSyyavQtrkJEWPDhMK+HIjkl5NpA8ug7JlNNW3L+vESQn
	PxfEUekikr7yO1TuCdRD6blfFM=
X-Received: by 2002:a05:600c:4e42:b0:4a0:2867:d8a9 with SMTP id 5b1f17b1804b1-4a17b558ba3mr12102095e9.30.1791281008098;
        Tue, 06 Oct 2026 03:03:28 -0700 (PDT)
Received: from white (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a178daa062sm61246235e9.8.2026.10.06.03.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:03:27 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [PATCH] floppy: fail the open when floppy_revalidate() fails
Date: Tue,  6 Oct 2026 14:02:58 +0400
Message-ID: <20261006100258.1871870-1-efremov@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

floppy_open() ignores what floppy_revalidate() returns. If lock_fdc() is
interrupted, or __floppy_read_block_0() can't allocate its page, the open
can succeed without the disk check.

Commit a0c80efe5956 ("floppy: fix lock_fdc() signal handling") made
floppy_revalidate() return -EINTR instead of going on without the FDC
lock, but the error was dropped. Return the error instead.

Fixes: 4a6f3d480edc ("floppy: use bdev_check_media_change")
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..85eac9adc385 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4052,8 +4052,12 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 			drive_state[drive].last_checked = 0;
 			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
 				  &drive_state[drive].flags);
-			if (disk_check_media_change(disk))
-				floppy_revalidate(disk);
+			if (disk_check_media_change(disk)) {
+				res = floppy_revalidate(disk);
+				if (res)
+					goto out;
+			}
+			res = -ENXIO;
 			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
 				goto out;
 			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))

base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.55.0

