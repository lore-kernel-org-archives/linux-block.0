Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EF28B7EA
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406940; cv=none; b=l2yvjtQGcn7YgQ6HdTPHo9UT/L+2il7DGWYsQeojo712y3MhC5OlOxjFTDaQ/jyeG9BW0vQgLqYStknQzUpwbFwXJLGQ0M3FmypWdLa1IWHmKbybX1bKcR4g7sAtiVEmgDxVDB6nUZjvaGDWLhjrcsLuFaquakcfAKrL3V0cJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406940; c=relaxed/simple;
	bh=MIUxfeIlXsLJb7D1x07khmxiQaV6FMQZLzsNI6cDMOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIX7S9zsVhKzizBpEptHkyyZM45oL9XHk0W4GvFY0nXthJyt92DuFU18iWKcriZckMvIbdnsuJ3yHZERSjw3eIuWO4Ex0dwrXlWsFZzN1gSyxqCojZ88BQop1TkH8UNafdLfneoCnWBjAFS3+RUNQGh55FJXOwKzLrLvyVASSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWAD7FOh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWAD7FOh"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so3371960b3a.3
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406937; x=1765011737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=LWAD7FOhwxa9hK+N/TjbMpaozNTbYaOFlFfBFIkFx3IRXMvFPQxK0dBvqeuprMX8hQ
         WtWIKhyhJdL7tgKbRz4kjA9XtQ0xCyuZ7Us8cRZuTSRdyYizUVED7L6DNAzm15FBB5+X
         G5asqaq3DDVlM/G0dBAPwI0DSmb1ll6qtEwsg2iCDXZi+WJJDMh8w+iMQwrmlH1fUp0M
         ZU8ghg2rx/1HT1LpWHFAMP66d0PvkRhjwjyR9UzTcYnZTtVjAi+zUY+A8WK5JSkbXJwd
         i6e5F7qsIkGgfsqQ4oj8zEgP7PtrSoMRVbyWUr+snjj7SZqW95SR+gLU9WacDEe61W7m
         +8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406937; x=1765011737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=KGvlny5D+97nr2wD9J1oMhoTKkTaIs1wLu2xIKtsr1VHJ/+dAOJfhvgQKWRFaLZIr7
         Gy4g4BBLy7vwqGE70Xm7pFnmv/11LLn6XWr67dTjSRX33ALNM1vsNqlRdqCujHMWTBAB
         FJMuKHWHPzrZAvNU/djFzawHcS4cNPPFL7+Idy1yBFBy6wRVZCxqzlQOHSX5mAfszmgI
         JGQNhSle594s2+DeTHMeNrsZvRES61q4q7Pdy5GHnp/j6g8gaTxaznhEK9zDHHDpGzL6
         XcTOSq1rOmMCLtm48Hz6e3xt+AFi9KyyJwuIFyLyVqWrCYS7PF4PR58sPhKZoR1nkQc/
         OcLg==
X-Gm-Message-State: AOJu0YyBVYGZ0xMFmzmk9uKiVEslmSZJm0NzLJrXgX5ebVqrK72fO8Ez
	55DSB65b/kB4rZyIykMLLm9R5hPpQYHOAcVejIaHKUE8zttGEnvpSa4V
X-Gm-Gg: ASbGncv4dzQXX97nF3tw2TWDKRbkknvAvqF1UTu16NSI0MiH/x85dV4Yed6dfM7nlt9
	YKbYGKUvVRLc373mKvfZHFXSc3av7SIfi5A+5wTqd+0cLrF1fCUwVewlWcjfeJrkirqoFFH/Ojf
	BNiHqxUM7I3QHsjQZ21N9DV1OHn2f+rHO793IN/8Wg1l2Cdf7yl99fVleo/FLmFDoL1gL4iQYgy
	oj6+2321uX0jG1H9rZIAAMVc0WRhDdYe5iYkC8jo0k1Gf/fKtZEbaSiZPhzssr6hBpTzK6L3jNJ
	ycFbbbjnqt42NSKN5orKVRKMkk9nPBj50ylUsv5C5uFX/tTAWahnLsPcvu0bU9EnV+sxxspNiYq
	5k+A/2isLPyKrYCxc2H26ZwGwcBrZRNdSp2etrL8q1FtUNT1/YGUqufkXjKrdmGv9ZJW7xixtnB
	g9tE6kBUAdoOVPXp3KTluSgPcImJw3OkU4WkjJ
X-Google-Smtp-Source: AGHT+IHpE1uuYkahAmmHKZA5JS6JfSHwBl8orO/VCsXf8iMEXJ8J7PutjW87+hKd6ib1GUoYGhEBPQ==
X-Received: by 2002:a05:7022:41:b0:11b:b1ce:277a with SMTP id a92af1059eb24-11c9d8482b1mr17984181c88.28.1764406937164;
        Sat, 29 Nov 2025 01:02:17 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:02:16 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 9/9] nvdimm: Replace the repetitive bio chaining code patterns
Date: Sat, 29 Nov 2025 17:01:22 +0800
Message-Id: <20251129090122.2457896-10-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c3f07be4aa2..e6ec7ceee9b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -122,8 +122,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
+		bio_chain_and_submit(child, bio);
 		return 0;
 	}
 	if (virtio_pmem_flush(nd_region))
-- 
2.34.1

