Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117655398A9
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189707; cv=none; b=KVOCRZa+K23aGA+KoyhgcqBDUK9K++w40aZQDQ8QfeM7y6M9au2CpjnJysMIVAgSkMm/pOHbTJjjmUjrQ2cpg9v3KyIvwUSLtQkwD4M4dNpMEkhvZ8Y3ChfAatkU7vfhhAggFh7vv9Axjyg/rWwwKAGqRZvJ+Zi/Hkov+k/4Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189707; c=relaxed/simple;
	bh=Wl7hWPoxTOBlqq7vnQDQZQd/z2keZXJ4zCnVMCil4kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCkLOu+dVgZyWTnFDzYgqtFvINpLg+tV4Qedyot8MiF5HtifMhbApml0I1chako0LVtLhO2rBgZr91Xq6rUhFlRrnLrhCj2m5z4n8kHOVwjhJRndCMDpPoGiwGdLd+uxXdLZMpIBuUgea2U+V5G4EHQU3pUCYrmOyCn6PUQuBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pskg3RuR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pskg3RuR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso29050705e9.0
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189704; x=1788794504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rYStpApz59/NN9gdwKEzWwAQTvauo+N1Z+YjlKkOxKU=;
        b=pskg3RuRnkP6XyW0j/mGUjVSpFepIgco3Gpjx2rB618KCCUKSzwbJPkCqKH5nHJmrJ
         8Qew3s4fK2wWmMdfbpBn1l9lCOldFLnTiGBXYkc9lxkuQp7LYbKLjiKny5vUcQmfc7k3
         rIjw4bbBuSAWYIMSJdf/u2RC4a0Xb7tlmycWi5PtYsQ8A7397lgJ9RazHbK7RrL0eBHQ
         zGFrVOAUsi/PMwg1SHjxvaD9TY9bMzDYlz8qoQHNHSC8XyyySnhk3Do/4JAovbt1Jtf3
         O7klmtxsT527pevyWpiNT8UMAIPJpxUlbcGy19t0aEnhxuU/drXqigSXDozxG+DIrcwi
         DDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189704; x=1788794504;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYStpApz59/NN9gdwKEzWwAQTvauo+N1Z+YjlKkOxKU=;
        b=RI2sWfkwpkdhw6xOBHqqR6OqophC7P6VNXEubzJcvJmMbiDIaNqtETwv0e/e530Gdb
         z2GfTHlIAHz/w3QH2soKT+I7iEkrxJXXz5lR2TGUouhA4CHKa/55C0z9SXYfe0C1d2aj
         cGDJjods4Zkh/Ca2HaNQfpNko6Thf6Ofn5+83wITwKkkvnE6STUHNR1urDVVmDcxp2Uq
         AjnPzWGkVONyW+dbuELYXfMpCESo890SOc5IjqWWsd58OnZbsxHcQVIhepfh9Ku/iW8H
         LxWludAF9ESuR6BDKpqUrHsfn/WiURIYR4RbhqwTjyyvFA2OHFsPK1kWb3D/Xa5beZIc
         H7Iw==
X-Gm-Message-State: AFuF++nWIlnlai8HT8M6dOKi8rUqgBkWknXQ2zmPRM8F2rfw6qiUHF37
	aMroQB0qdJZ1xFV1S+uTR2dCWkftCyC5hiDRJWLgTq28OGBjS9sFRkpX
X-Gm-Gg: AR+sD13iylhJh+FJy6cE2waaUMokmy7oMuxIqjbaLxAPrOXPj5uhRCdPZ/U8L30/HxX
	ZfWwK1B/ZWFQmJam+cLqxR8HM9m16k73Q1MkKZuHXHkp1PafQeMWtajqVTtKxiP8WXyg2W9tKNI
	iWphtfLZBJ0F10mfyNaQ4dLe5RCFwT3Zc9eA6xJ9Qk3lH8x5kr35nJgMKjGF2AnEFchvcEfmfQw
	lcdncz8RdP80YGYSFBN2dpiQxrJ+JPH8eVJicYa0FzZBsdAdVBjMM7XPbepPl0n2Rj6fFLwQ8Ms
	fHPAbxF6Fe4iCFyqHflpC3UxbHOjGKLXpcvEYV4P8q4l13rpyTHZ5rRWfRVBQGzMbBG5qsRPpew
	YTIpTZH35jvYgH2uzerAP+pfkxJXIwZl6m6ZbjKB1fMS/1g5zi+JVnhh5Saqf/akP6EJYEwsSK5
	C2kFjJ0v4gzbknvv1+/m7CpKUoiFgZ7uzt1Au08KHgOwxES0n6EfLQdmZtdJclfBOFEhDwGVrsc
	Er4qOdOXK06ATK8Myvx13Ic
X-Received: by 2002:a05:600d:8497:10b0:49c:dc11:2b62 with SMTP id 5b1f17b1804b1-49cdc112ba2mr26489365e9.7.1788189703907;
        Mon, 31 Aug 2026 08:21:43 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm528166815e9.10.2026.08.31.08.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:21:41 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 2/2] block: loop: restore state on loop_configure() error
Date: Mon, 31 Aug 2026 12:20:44 -0300
Message-ID: <20260831152044.166353-3-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831152044.166353-1-ivanrwcm25@gmail.com>
References: <20260831152044.166353-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On failure after loop_assign_backing_file(), restore the backing
file GFP mask, clear lo_backing_file/lo_device, and re-enable uevents
before unlocking and dropping the file reference.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/block/loop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..838554bd980e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1123,6 +1123,13 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	return 0;
 
 out_unlock:
+	if (lo->lo_backing_file) {
+		mapping_set_gfp_mask(lo->lo_backing_file->f_mapping,
+				     lo->old_gfp_mask);
+		lo->lo_backing_file = NULL;
+		lo->lo_device = NULL;
+	}
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	loop_global_unlock(lo, is_loop);
 out_bdev:
 	if (!(mode & BLK_OPEN_EXCL))
-- 
2.43.0

