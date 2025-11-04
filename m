Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4A25F99B
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260661; cv=none; b=nmQ7/IjzJNLeMAHhIQUDhDaP/02ZjAS4YpliMG17rro7oi8OYF4VcXpgDs0k/pqD2sjFBj4dWzB6dftSrSDUDvlOMZ9bV7hpFIxTPnNWiGqG7iMbxDCSR+hWtIB577LHyql65S9k1TzSbMqktvHM33yINJTLgDPY64WQfo6McuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260661; c=relaxed/simple;
	bh=Zc/y7/iyuhzo73FcQYuGWiCMqi/pQGpHb9Cqw0BNl8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSlfhvTqOE6s80tMrefYl1btAlARAbjlXBNP7A0GllXGb9KpqHzqrZgeLh19rviYRHyMBly2lM3jYIP1pGMN3Wl/72ivrjNqFDjEqEk8QnGAshV5+wULuHVyQwJGeyruuLv7TxIA+p/o8Sih/MAFxzlCsSUGvCPpV+XsKcvhbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5hbyQCf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5hbyQCf"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781206cce18so5848191b3a.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260659; x=1762865459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8asDZdZ/5ha36TqW9viVaU035nISljT2hMRnvK4GxFQ=;
        b=N5hbyQCfZj1/OGGI72+GgKXdJ08+1645rRmavy4TlrZ2aP3Rlsohnd6HUAPJeV2/s8
         huUzE/fcj7DETBzdWOTAXqAdzp+rAOIAeluflpmfy2Gicx1lLMqmNheoEioy/GYaYx6u
         DpRK4O9nnXzCvXmOn3AI6pvQ3MbmbF0ONYLiM559v5eiNlnhKPmApca2A7MMPsO/abCf
         pDe7+v8QvbGsSuhhBFIMpreLlmHZZAed15xwJTRQLONTuArUROzG1cH+l0IGOo64Y5fw
         US4ppbUNpttTtn5/j04LmI/UHogRXNbcRaG1ZvP/127r3viM9WVnX/o/BsldFmnN98ha
         6RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260659; x=1762865459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8asDZdZ/5ha36TqW9viVaU035nISljT2hMRnvK4GxFQ=;
        b=RXjicrfT2rvHk+ZVx6jl8hvz6V8tz2jSg1ko6yK71j9nujZfKNFMHA4JZ6D8mQA3qx
         7Sp4KfHegOn+DTMh8ohN/5KerC9jGnNFFRFx6BMNcfyK5oCGGGvFvGDIdI8C/oTGrpmc
         mqc8oPKfxhqqZ5oO4npkc9lcwYYf8zuJSsKqQyuqQz/85nMRf/Zp/ehTzGO8M1D+bmHY
         /kKS9zgIs+B1lpS2pYQ2GAXXw5wX6XSVLat0KvZ+6ToqFSCtX25oar23rYXLdEcGJ50G
         YldVFZMzqIcR/+joQaDfvcFLZtylBZm/6xmiycPtuMioz4exaBfcOMDQqdlWo3Vbrbnf
         h8VA==
X-Forwarded-Encrypted: i=1; AJvYcCXFNDk5DT/2j2G0ZQFijFJGh7dWk/y9J7PJ2Ov90J6BlHF6gFjCIgLFuj9EssWmwWqhWf9vMRNKLLh9kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIT+pw4oV+LGrGDy9u4bcjflZRwzA4mP9JFbLjXFshNbIItXX
	NDk/P/zLaP1v2bgt6vdUJBjbCMHCsh6hSMboyFsKoWW2EV6bIua/TTm0
X-Gm-Gg: ASbGncuFOpZGfTNoIV2cny/n94M8ytqiUypDvcnSLacPpKrJ7G8y1OyzL4Law57RKFO
	bJL7nYubN+drlW37YYmcszpomQgmS++1ZtdiShjTTOa6WlBcsSZ0PoGCEsi6/I0nLvqgVj8UY63
	dX76j+AUaoTeqrTr44JZr6ZhbMisoXqFOw7CmxPQpAsKrAUDHxNOoXkJk4gRIG9W8IXkl6Cq6OT
	ZuLNX4BptlJNucGkdrQeGWBWfPQJJPag5yVBdgeIApLDhAKadQ6DehOQNZe8FswjyIpgzcQv/iq
	u+98NBIGodBIj+m7eZbhfQZUPuTOtxuB6+8mH7Tnx1vorFCA2yLkHMH3js2cfDmLMTVysB4gL+X
	LkWNm4qsFvM2TDDnvlGuS1u0AP6iDgbNrmthgiGV/m98YZMOl3Tos4WSztpkJn3nRb+Eay7Q6Cv
	APICMkDrGFRkIB5Yxg1dQD6VZqAazyDwaG3OH3OP2+PbMp+nyQmqKYJY9L6w==
X-Google-Smtp-Source: AGHT+IFSneBnWTt2VQT9MEymny53bGd7ZCTNmsINIZkl0njlmgUgoGuMpFK6R9EKutPwtc1t3a4fcQ==
X-Received: by 2002:a05:6a00:1988:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7acbf0b9e3amr3856752b3a.1.1762260658993;
        Tue, 04 Nov 2025 04:50:58 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:58 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 20:50:08 +0800
Message-ID: <20251104125009.2111925-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
opt->blocksize and sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/isofs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..ad3143d4066b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_freesbi;
 	}
 	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
+	if (!opt->blocksize) {
+		printk(KERN_ERR
+		       "ISOFS: unable to set blocksize\n");
+		goto out_freesbi;
+	}
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
 	sbi->s_session = opt->session;
-- 
2.43.0

