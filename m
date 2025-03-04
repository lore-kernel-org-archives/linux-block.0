Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26146290BC0
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102747; cv=none; b=EAglg7OgOh8TEvOlR5aw5+qYN8489AMKMzeMNHPAf3x89wqKGSuPVEBQRhxRxnFrXTz+SuR+OG9lRHx+9+oZ84ZuJj6X3RFVo+fKZhO0R+uNq8Cca8DbUlFgQ7wJeGco1gvwcis0SLFnzoK1xNJ2wX5AiSQEW33z1sNoCl7m1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102747; c=relaxed/simple;
	bh=uEBo2XwkWIu1kEQdFfc+UP0MGpzG764Wn7p6Ra7wCqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kvm/pNRcxcST0YpLK24Hn9AP5SPquE6fp7S2seEuk6kVVyILGGfWHskjDR/TFOGqJVUfEJzVkdHEEC5vE2qlLtkqCtS5z40yCJCbvIxdZcBL5IkU/3zNfePjtnAIMZd/PZaNDuYXgkALx24R4M+I9N2Y1kgPuoskFCGZ84qwua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QgTw9Ucc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QgTw9Ucc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc6a6aaf7so17339265e9.2
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102742; x=1741707542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhMHstYP/DAcPBOLk4EEWApjXQhALePsm/Er/3v899M=;
        b=QgTw9UccyVFux+Vzt527ZlRdEEyF6sGd6zoXTXS0p45mPX9AzYejJpkn2vqR7TsLpx
         R52dwdvY571HVzEMMaFSL6H9goHxavWIFiL7FS8K4VxUFvHSP25zU1TmLdfEfitFzC/f
         GOhvhPpio+foB3nG1G2wj7z+mLTUKtvGH6AWSQqU/qr3INofgfHz4uzZFWBLs9iyqDjz
         74STZli9eGyHQlKwYEG5OBAf59pLUHkhdvJPlNhI2KW2uoj/q02A0L2PmPwC/F/FjAhw
         81qFOHe8SDmPP1exWfvOrNvZeNPqe+yRULlrBJn20zOSzMnvO9GUr5RRcGrpnLLR4cF1
         V4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102742; x=1741707542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhMHstYP/DAcPBOLk4EEWApjXQhALePsm/Er/3v899M=;
        b=MWeYvoO8RtcVCfRZH2D75PtTuSRNK/FjPTbDJfCCnhhLiKZq2opOe0+miDcIplfx41
         Y1ZYpMfK/JdZzIQsI6vV3jT18ADesg4bxp/U+lzwcuS87FfKCoSEzLnpFFhxbIsYgY7M
         7lm9E4n2XK4EuZ/k1Rb5mj3MayvwXRSwOijqHJGP3pzsNPrKl+ybHUNDA02tPbe7HOi9
         XQVJD2YQNzns4NhhUEwA1U+Ug1oXmNwCuhmwz71sGQey0ZWFSdDPNn9eHTbNZD/nIWvF
         9PgEi9Fzj22LKO8aDDK+Y5md+fI8Vy8BLv61qpAD+eWtxzyfqFGuLYZwTB/JoYCAzl4Q
         iQyw==
X-Forwarded-Encrypted: i=1; AJvYcCV8HVPtxg9WG5dmBByMZV1vAjjzOq/UYvAKPs+yJJV26wSD/0IsNf1Uf1p84RFPlaxelO5vQ2Tn5zwnHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQibYHMrUlk4ySH55arr3lOD/f30DUt4z3QVsVpaIMw7mtkCRD
	Up5+q4SN9guiukTm3bbDEl0XQneKaWXqVtmU+E+Te7zQRo9BLAOB5ae1I8+R+DE=
X-Gm-Gg: ASbGncty72yCP21CDRoihL/XW4k9B4GgQkLAWmnmRUaPTGbb4Uq8KTbHJNtfeKHu+Ar
	po8Yz63FrRhD7NgL/JHebLMkaUP5uol57CEHmtMChXCd9ZlxTuZNuDT/CouHqB2elKICiLty5zU
	Zf9mycZEhT9BDJwlAAYYtzLjOFU0X7jud3/3w8fThqyXsO8pu7jsD2+tOEQAFDEANfaU2UDzrXm
	tT7h002UaIEnE2sfbiubQkOu9KVixeL359xJ3JftSvRW/HHRtMkBeBgcCjNco/YrQTphME+tB4/
	fUAZg8VdT/DiixQuF/+Y43NhL1TJqPfJA/ksBTSbM6Ga44Y=
X-Google-Smtp-Source: AGHT+IGgG3j37XPpBlw8fV8aejT9Y282Zg84Ylxu78/13gmSg1k/Grk33Ygxi04T6savqD/zyfoG5w==
X-Received: by 2002:a05:600c:478a:b0:43b:c7bb:84ee with SMTP id 5b1f17b1804b1-43bc7bb85bfmr53809865e9.2.1741102742506;
        Tue, 04 Mar 2025 07:39:02 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:02 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 8/9] cgroup: Update file naming comment
Date: Tue,  4 Mar 2025 16:38:00 +0100
Message-ID: <20250304153801.597907-9-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This changed long time ago in commit 8d7e6fb0a1db9 ("cgroup: update
cgroup name handling").

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17960a1e858db..561a9022ec100 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -619,9 +619,8 @@ struct cgroup_root {
  */
 struct cftype {
 	/*
-	 * By convention, the name should begin with the name of the
-	 * subsystem, followed by a period.  Zero length string indicates
-	 * end of cftype array.
+	 * name of the subsystem is prepended in cgroup_file_name().
+	 * Zero length string indicates end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
 	unsigned long private;
-- 
2.48.1

