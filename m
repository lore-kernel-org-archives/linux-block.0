Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FC56B95
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047817; cv=none; b=BCu2fB3Pr3ygk1Rdz8pIn4cI9N5TN+IDGvwp5EOGQ12fjKog1Ydoz7kDj8l0Qe0e/o/hy2aEcjlDjENBGEJ1LIJ9pd9VCdbtobVdGE6jD2Ub0SvehzHJHBwyopgICevL1emmgF4clU/SJuI3ed7dNHgUo3Ohkh2tHcOvplmRASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047817; c=relaxed/simple;
	bh=/4YkSTRdE7M7Xu8XMpog4hak/3PlwZ+3b3bqKoB55qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usFZtWdsFks47iMvwqRRV3Gdziu6uLBuUVku9MKzgGZdl6ars/OY8qwApcscKMsw3eMBXeypXaNKX8iiPdY4SB5F8RyYqVr+YlhQxtxVSwVOkfyUQTuYG9oeoLtql2HzIHnySuM5kYahE/o9j2iSUGzq10jhKlRmgG/k1tyrgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PGVqg6pX; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PGVqg6pX"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-6e0f43074edso3305872a34.1
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2024 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712047814; x=1712652614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc5qKirKkUEsGA81ePv/IEQCmdT5wmxUd63NYwufXHA=;
        b=PGVqg6pX2i8bDe9YZ1wt+ROkmooz+OIQQkoUp6QqTud2NrbhSJihFvtaBLO4Nb38wR
         QgLI1MZTkP1H5QWRNainq3fv7PcM1+6gApBwjOnC2MqYXJtRtzP2XM8bl9p+yce9Inhb
         hT/9jQfUsEkqAkg5qxx8IePJwuQ52FnJdQan8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047814; x=1712652614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc5qKirKkUEsGA81ePv/IEQCmdT5wmxUd63NYwufXHA=;
        b=Qs92iXGV6ciWADVSkqxipkT+FOrz30eMPJAwmBY/4KPCi4VsyM4+xnxFdyF29YHAUS
         3TL+RWw09rdubHco1eKmaTOZZ/z2mC+ZvefX7LyP1EBvNB+Cr6MF1DQeyKdZg8iidz5B
         Oc6t2hbI9MwYPDsLbFXPLxPKpziqoJ7gcwDZbXWGuxxlwfxvS3SouTEJkoJWlhwmjK12
         5QUTIZumxOy0/N+SV5vjaid60dxl42jFvMP6GbKqIY6hTzHCcizpSk2pDwG9kyX8y0nt
         gRNTXAiQWymsTPpbknAC85qsng+JDhAZA1lTJAKc/yxTbfMeGXyWjacKy2waAu3MBoKX
         dMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWERSvUX86Gvtf+UG5EjU0RLNQBQY8xxTqhM/dQpXAVebXiGRXIjX+W7IWheYQpkKGjK6Kz0XXNZe6fi6zkIuY2Ce5lu3m1/knT3kA=
X-Gm-Message-State: AOJu0YxfL6O0fCbDlwIRGtNLn+AaZH450nRvjLO8e6PmzaCa9qgOKS+V
	89x7VRYnlpLJZXLhPox47x9jhyYaJVAhYgBKXgWELcMKpkOqD5cV0eOsWa+AIQ==
X-Google-Smtp-Source: AGHT+IGAeogQj7OWBty6lfzImr9aptLfny9tqOJXUIZvSX740VF/rVNywUCKCnybxk/NBzbcGcioMQ==
X-Received: by 2002:a54:4004:0:b0:3c3:de8b:7bdf with SMTP id x4-20020a544004000000b003c3de8b7bdfmr9601570oie.57.1712047814503;
        Tue, 02 Apr 2024 01:50:14 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([152.65.205.51])
        by smtp.gmail.com with ESMTPSA id a5-20020a63e405000000b005dc36761ad1sm9193042pgi.33.2024.04.02.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:50:14 -0700 (PDT)
From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Min Li <min15.li@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Subject: [PATCH v5.10] block: add check that partition length needs to be aligned with block size
Date: Tue,  2 Apr 2024 14:19:55 +0530
Message-Id: <20240402084955.82273-1-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Min Li <min15.li@samsung.com>

[ Upstream commit 6f64f866aa1ae6975c95d805ed51d7e9433a0016]

Before calling add partition or resize partition, there is no check
on whether the length is aligned with the logical block size.
If the logical block size of the disk is larger than 512 bytes,
then the partition size maybe not the multiple of the logical block size,
and when the last sector is read, bio_truncate() will adjust the bio size,
resulting in an IO error if the size of the read command is smaller than
the logical block size.If integrity data is supported, this will also
result in a null pointer dereference when calling bio_integrity_free.

Cc:  <stable@vger.kernel.org>
Signed-off-by: Min Li <min15.li@samsung.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230629142517.121241-1-min15.li@samsung.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 block/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index e7eed7dad..c490d67fe 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -17,7 +17,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
 	struct blkpg_partition p;
-	long long start, length;
+	sector_t start, length;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -32,6 +32,12 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(bdev, p.pno);
 
+	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+		return -EINVAL;
+	/* Check that the partition is aligned to the block size */
+	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))
+		return -EINVAL;
+
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
@@ -46,9 +52,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
-		/* check if partition is aligned to blocksize */
-		if (p.start & (bdev_logical_block_size(bdev) - 1))
-			return -EINVAL;
 		return bdev_add_partition(bdev, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
 		return bdev_resize_partition(bdev, p.pno, start, length);
-- 
2.35.6

