Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3333CE84
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713102; cv=none; b=FNsXg4xK/g+ELINrPtBCBSJJUQ4lrQ8rokWxSwaCJVm4N1hBFw+zAckO/Kwj8wro4HQy9X7IB2y8CqLSrbIWQYwxPRyxR5MUZQ7Fufn68evlaDJ/lFOgyxJPjYOGVOIIFV6Nv8sFjdlcvW68uC2UzJDT1S1yan/n2Gg0w2nO9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713102; c=relaxed/simple;
	bh=tcwWQ/Mm+gFAO+0q/5/zfPas5QNJ1LyCpxuvQ1Cp8pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSAmq7Yy0I99kdJx4jRtQQzZbLJyvuj+r+7fxejKQYO55cXTHnLIyrETw+zDUv3ui9f1Nr+F8gBFiuWDxONwYe3Y5PfSQdF2IeUdBpZ3V8mSb2w+MBGQrv6dfP6rj1FBHhioTGKxvWCDQnh84AmNslzMiiUU39oFhAEv3fhaZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIVcx3Nv; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIVcx3Nv"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11b6bc976d6so2581270c88.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713098; x=1764317898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=;
        b=bIVcx3NvV0bj4eNSTfTRNgLnPBiaCDvfB0wwNrrvpPKaYynPiUOeUxxWJdq+KTh3r7
         5GyE+WU9pmbaUxfiJWJju27+u2Yo5KXyMRkHf9KnWcIyi2x6wNJcqrTP6oqF54KqVZDf
         Odxc9EQ9oqkZZPW9KkeKwKTM7S9jRjArzgTbVOEXitctqlzXooX3Aswx7LiwsVkC4+yy
         Sykn8jKqjIeM859oEE5vOEeU74hyxIKZD7uoJqLdGdmWma6t4/30eIDiAwb43NN3B73I
         sKUGIXo/yhSwiI0tU2oiO/sG77IwCgXUB2X7mE1RbsNslWcz+rYGX+AkWI0W1CxCw8mv
         vgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713098; x=1764317898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=;
        b=tjboylz0Ibq7POfT7OfXP2HJAO0rJavZc70ZTcKGniVXil1s3llJx2+Kfhw2r9Nl5J
         IsJN5hbelWLSCNWQ9XfxPzv0vRUCcdrKOo9YCOceOJJKls0c2Ij7V6SFrU+Bfs/pCOQA
         aCf95qwQZAb3OtmtctFnk9XbmiotaPrd6jHqugMIl2Zm5HAaZKrUvei9es9GzH3MicJs
         Rwf4NjT3/U4dSjXhWPGjqS+m9uUFUC3zDXxvgA13WfYxrEakfSImfFkQLCCtb/QPp9uL
         d6ZINwZ+uQ1NFR0hFOhPOs+xHaammoCOu7skttsYNmTotfZ0lwNwEf4emAS5e/HvkOrT
         Yzpw==
X-Gm-Message-State: AOJu0YwsyAHVo9u79lfgMAzvzWzp8Ub68vn8LG8e95NbN5X8Wji/jstO
	LWprSww+SQ3hs76tb7nITnheaPOBkiG0vUBA9r6zei9J25p6Kz9Llcue
X-Gm-Gg: ASbGncupkJfQAz0VfAP6EKPJ1FegGHbGXMFTcQzKpBAwKgdw2PRPJwv+4WHZtX03mZy
	w/AaxhLUFvLmRS4W7zfWKbk43MBz2oJ8HH1u9uEwJH5SV5SyH9IZc9/6lfJLRNQRcX4eYzOH38n
	TlBAvgYnIvREzYnhY0wdjHPms4AdSxTYJNbjjPuUdpQdIc6PrDdwRU9bjSmO5eBdyw5DAIKA6xL
	YOX4m0m3p62dpw/DtMSiMsBbdITw2HGQPUnTd8Fc0pq5WSUegkvDT9RC+vmtq11u1xkL00pb82D
	nSBo4lzaykB9UlWQLiglzAyd2sQ6iGzOuT046Pf5Ylc/JELgZgCW5pGiigJvD/0s7+wumSCNIeo
	0YRjryWqW7p6vebRvQLdEcUMn70ScitbV+FFsb8fwFeSXHfENYZJBHglfOgvb9fF/pRDox/cxgh
	PSwRJRt+bFjyVf5sFmqh+whsrazg==
X-Google-Smtp-Source: AGHT+IHOO8G/RNP4+N7h+q+3n5RC1e80lk0gJCjZ+Jmb8LlUPm7c2u0245iVMv+KJKdve3qFM22yaw==
X-Received: by 2002:a05:7022:ec8a:b0:11c:2632:b7c1 with SMTP id a92af1059eb24-11c9c8a63a8mr515277c88.0.1763713098073;
        Fri, 21 Nov 2025 00:18:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:17 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 4/9] xfs: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:43 +0800
Message-Id: <20251121081748.1443507-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/xfs/xfs_bio_io.c | 3 +--
 fs/xfs/xfs_buf.c    | 3 +--
 fs/xfs/xfs_log.c    | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index 2a736d10eaf..4a6577b0789 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -38,8 +38,7 @@ xfs_rw_bdev(
 					bio_max_vecs(count - done),
 					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio_chain(prev, bio);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 		done += added;
 	} while (done < count);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 773d959965d..c26bd28edb4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1357,8 +1357,7 @@ xfs_buf_submit_bio(
 		split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
 				&fs_bio_set);
 		split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
-		bio_chain(split, bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, bio);
 	}
 	bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
 	submit_bio(bio);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 603e85c1ab4..f4c9ad1d148 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1687,8 +1687,7 @@ xlog_write_iclog(
 
 		split = bio_split(&iclog->ic_bio, log->l_logBBsize - bno,
 				  GFP_NOIO, &fs_bio_set);
-		bio_chain(split, &iclog->ic_bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, &iclog->ic_bio);
 
 		/* restart at logical offset zero for the remainder */
 		iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart;
-- 
2.34.1

