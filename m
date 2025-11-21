Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803C33D6F2
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713104; cv=none; b=Gn9mt/+/pfH161Kms4lpYKPfnkfPZbLWEq4Emu4lwGYZrjAmSJXOeKXzgpYDYDvMDrQdwG2dmKUs8ztO8C2+hUHV8WTRL2tLmPdNL8bWb18Rj8bgX3VjITvEf9Tk+cTVs/2y5SKoorr1jlgJvsx+bIUowEnhQzYp86ZpoNMwwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713104; c=relaxed/simple;
	bh=GyhI/g6BT2jDyrnrno9j5u6Y8zL8PZ/BqiyLx603u+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFo9SxjNdCh/XcaEv+X9/UhWdAJgipX5bPvUvCYnq2y9ngNSXQ3yVDcz/gglkd3uWnFz3c7eHAiGDy885avnxgxr/bASypISSrKHEPWRsigRRCDlr8rP5PTidPdqx4EDdJ3oJ1t5Hte9aEEXLNrn5zHXBeNun9iGoCMdSnc7LMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeyWgAVJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeyWgAVJ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2a45877bd5eso2695313eec.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713101; x=1764317901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXggH0+b8/rP3aYBPWiHo2+gkYlGyUfzMd+zPzEVv4o=;
        b=LeyWgAVJr3fMFjr8U4oXey8gEbanof7tLmE6YJnsBE0QZeykEGUxp9+1/5v18RfM/O
         vdO6ZyHA4yKGVly6Yg08nFY3nbFWe0yega91tV8d1PcEPVsOHduLL70LPDD8aWmuo5lJ
         WrW55oflyjt6pmPqRehbq7BkUaeJ9A3NjPrSXjfhS6pOUre+pu6eoAl2Vu/GWqdn/BR7
         wBwN+5ctemDSUEUX6cyd2iXn37wTuG41V0YPf9v5zS70E4h5WSuJ8NQ9Z5iaLLfwYFjC
         fYTVFR+rgqUNcHxFedzbdK2AUo/QVliOgwyKhbr4LKF8TObANBd/z/wKUZoL9u1On9le
         XK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713101; x=1764317901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXggH0+b8/rP3aYBPWiHo2+gkYlGyUfzMd+zPzEVv4o=;
        b=VTrX09X0OtQtmqnknxnzPKaQyp6wdXgAuLuC9nmjcdd7k7SbNmdTkdHMPGYV6ZvDrP
         gtoYQY8a1qQLX2rOPUGxjhcQ9sxTmoLF5Q9ZjDoJOSPa4MB1OwnFspzqk/q9g0pIGdEK
         arFyqUZcWVsqUHqG6RUD8j97Hd6NjLm+HOOF6kfKIuEAKx+806ia3fRXSrYCC8MZfnz+
         WicsPcadOVIT6ss/Qnkwkh+KENuF4RjGHR4eJxlUarn5E3cenolfLxuOJDzLKOvQnyiv
         XUQzqXD9R9E5x3A9rt9JBZcnqOoKTM/B2musiJ+ZblqYAEXpcpBLahIZuNaI+nOU5uhe
         bqqQ==
X-Gm-Message-State: AOJu0YxfF9ekGVni+C3fvKstqdehTi1QKDiBhLaNHDR8IlnWBUXGF7Ik
	Mw/ufFOIvnX7Cq8Yy8rAePj2CSjx1mfZ020ADayB3r6sqvvJypqKl/Nk
X-Gm-Gg: ASbGnctpvJvFJt+m0iozKirbZqJt8ZQG/QMSvxZj6iIoauZCddkHbXoErdMMUV3vyqf
	KseM+T3jeZnwQ/c+5i4B+xvtrWJfl2OGbN+CuM3NE6b303+zIC03LjiAJI9U57Z1JeH9ePwPTUH
	KEEhk0dpIp8NGxCnS75qMfs1Z9NAqoQXBuEGP7IhyP4U+FA9GXnM59y1dB7srKBSZcWklq5NR1h
	hcKkTenVWK3eHHDMFf6r3v39BDlBicv69uuOL+3tLig0ImIs5BCMi3ahpGq6ZYONbX2E0muKY9D
	/JNx/27sPSMsqPSTwM3ig83hMlAuBiWMz0Hjmrpnzht22GdeL2f5AtsKSoAbIa8xgR+i3KMoobD
	XRseVUZFbMJdo/BtBVNVxISwzVtaWtq4ffWtn7lOpTXMgPwARF0mGXOQ7+FJdKitb4hj2EKhU/c
	ToUQUZMl43cptXqqP7pt8Ww2j9/TWQh+FEBjQR
X-Google-Smtp-Source: AGHT+IEZ79TJZoTtjlwZLisOIZ0dGAr2lEGHTXQQoCt+6eH8PV20aIRNYUKQ7CDTkbiFuInj7IJvjw==
X-Received: by 2002:a05:7022:1e14:b0:119:e569:f86d with SMTP id a92af1059eb24-11c9ca96a9cmr324319c88.10.1763713101474;
        Fri, 21 Nov 2025 00:18:21 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:21 -0800 (PST)
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
Subject: [PATCH 5/9] block: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:44 +0800
Message-Id: <20251121081748.1443507-6-zhangshida@kylinos.cn>
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
 fs/squashfs/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index a05e3793f93..5818e473255 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -126,8 +126,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			if (bio) {
 				bio_trim(bio, start_idx * PAGE_SECTORS,
 					 (end_idx - start_idx) * PAGE_SECTORS);
-				bio_chain(bio, new);
-				submit_bio(bio);
+				bio_chain_and_submit(bio, new);
 			}
 
 			bio = new;
-- 
2.34.1

