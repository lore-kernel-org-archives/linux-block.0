Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29223191BE
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187865; cv=none; b=SGtZ9vp1KmU8xoL4MeZ3QOvqKnGNOqUlB9leYj/8bcA5v3n4L/EPrXQtoaHu7L2FhlQn4cmBphBzrpRhESBGbTtCo3VWnFbOgITCuGJu+pjFlFaLIUAjUa0AoA3Oxa9GdATP7TonkUf+fUbFQDEktX1IuFS2OXdHT5k6Lf/W1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187865; c=relaxed/simple;
	bh=QVjhfMLQHjrgRMPIbt314bhjxXbir3hpnY4sM9EUf7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAos0Y0e8eTICYq2RSv0/E9n22h1WGjx2yxH0m2ddBcrKlzZb3oGVeY9dxIqtsnuqH22JupaEBqCuj4dK3fk+5STPjxIrNPQexpmv3cW5zpjuBiBI2RGP482Xw8rNTbTSCLB6fPqvIE7xiJzQSkD4csFZ043qHLoOAlKAY2Ly9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH7pNW8S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH7pNW8S"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so3264146a91.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187863; x=1762792663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=QH7pNW8SAuWCcpu2daZV09uu+CFTRMkLcdcWJAW0UeJSEuSJlwaRBYt/YgLI5NmcQH
         kfPkY6/8Tgqa5/gZy58iyZod+5CPh5mX1jpJ7e9ylPRyfYjwrdL/S472T8m29GaCNx0W
         k4plbKu6hIAwj/w2hEred51nHm+zlexs9EawH0YlRwENsADxYnkQj9spOcWNo1nQ57qY
         8qRbxK/BF/QHtievxBYdW3FKAb7d+gWQp8WzaY9m5Tespp77O3yO6/itim3nz8iBwScj
         jcjKgzr94GDHDK4UTXOdlg5HPMI/CMNZkrYrtp49wf+Cqwpt/2+Ne2rapmDeNey5J9Mx
         jojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187863; x=1762792663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=h9T3RohQfK41lZLu70SQX5jOALYtP4ZFnfsqcvMC9R7lhYLJHHLMVxhrXOg8JxEFD4
         pbARMIMdwFDiA5N5UCp724KupS1kWXoA6V8XBgPM9OC/id3dXVs2Sn8b8vYpJQe97X+l
         YUyZDj6TdTXoYAAvIO/H1cszPecLpd9H9Es+brO6TVU0jFX+CfCvb0Bo7ShrcsVhri/9
         9TQsmCm2rx4htdWZfwbuG/xfO0oDGSSb/VQfzRyCJChqhd3H5ckXvx5cxrRo9KskAKsK
         Q0ylMws3GEgxr72U1t9mS71dhIUKu+rX/WLyR/A0JH8FEK6GTiYpUq1KxhN2MkiovR38
         HkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYFLyoGelUQTl75blivs6A/6e+ozm20XbY5t36j0+7OlCVBJgEfd9qIDLqXK103CO0vd7Yd+g2VFv1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjbmntEKYatFa2RrHRfH+bRRmsth1UUWKy2klwru93dk/eGgK
	Bid1yP1W6y5pIVxT6tc88xNTxnCS78CNtmEPSe7vOoXhd+xvPTbF4dal
X-Gm-Gg: ASbGncsEr5IlC1G7JA0Wefrvk/eqOhCQPFWJiEB6hDPBkmpLSqXEgLMBqGEndtJMI/C
	5VxD/Sv+U5X/pVQlOYMrd69oQu+3hFOiC8yfYaOdUwEiyQg2qE/810lEktTHrn7Duor/2TPuvm5
	snF1qQtO9BkVrvZWgT05GzNyNo4D8t+7yECaDcYzzxLVP+MjxmcmNhFq6zIKWgpEHWq8bLIl/3Z
	6QapZudFCmqfNQ61MLgogMWLPnoiD1P7SI7jHDJ/zLEenpOLgOMvPwhNvWSBClwQ7haKuQIZo7v
	0HgWxn9HJvxtEQAcqoZrA38OAQFaYfOphWtHJvh4vVqWd9AtnJnLq0B2JNuZ/R2SJm2yjgD7ePe
	N4qRMBiWJs1wCGrr196SwPlcew+8lCjJ4xOLYYSJTBdw++jpfpYC27m0DqKBiOqxiiVIe7J04th
	YK6oo4FhBxN1jp8aY8
X-Google-Smtp-Source: AGHT+IECJxJ0Plit+Zuu+BbgH2tIvI3CBKHwwvZNXR/2OazArhNb7Gq0ds9hJPADl9dr5Rkhlt0Zdw==
X-Received: by 2002:a17:90b:5150:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-3408307ea84mr15540031a91.21.1762187862734;
        Mon, 03 Nov 2025 08:37:42 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:42 -0800 (PST)
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
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v4 4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
Date: Tue,  4 Nov 2025 00:36:17 +0800
Message-ID: <20251103163617.151045-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid the
filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
for sb_set_blocksize()")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/xfs/xfs_super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1067ebb3b001..bc71aa9dcee8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
-	sb_min_blocksize(sb, BBSIZE);
+	if (!sb_min_blocksize(sb, BBSIZE)) {
+		xfs_err(mp, "unable to set blocksize");
+		return -EINVAL;
+	}
 	sb->s_xattr = xfs_xattr_handlers;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
-- 
2.43.0

