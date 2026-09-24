Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268173D0919
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249334; cv=none; b=cB7EM42soQ3RkKx2LA1+RI9MkuSRWbB5YFuRoBC/R85DuHrFQvvSX7wbgwmDvzcGBN3c7x0SSlW0jT4yXudyox+jQU6BAMCYt2UdIqzPTLprfByo2ZyGq9jLTLHkkdXe/D414Hmy+//ZfCb9ei3mJuHsjUWFDSjwOil58tHZLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249334; c=relaxed/simple;
	bh=9q+9njbl5fGDnCjt+CP+V3k7O4J5TEC5Hn04Vn4F3FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeK1L4cJRM40zu+c0XXl49btyk6jm21VNNzSDolDiVZL5A7wwJM/XTkK+egddALqVC9GmfRELkLTd8rQRDuWoBL4BVxrLjqas5AlQHqkLQcYjx65qT8xViIwI7U77nQBIsIRNkuRPFkud8+m9/JFrDaH8y3jHRdIc4d//+2NRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so268681366b.2
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 04:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249329; x=1790854129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuSFDBweOP7pWzPIqUP/KjNZXgPolc/RJ9LLzLh1/A8=;
        b=wzprtAIkldQsCo6RMwn64oAM/8oXk6NHRPoPbUIKLCXTMLkyTIPs26OYwjwhKQBn/X
         A928DX5OA5kUTXoUywcdl8jI8BenBVj+F7u1cCUZZVGRNU9pBESXj1MCRKBE8YDE8Zif
         m43S+BccfGC9E3TxvJqYQIavjn7hChnC93ITjfS2sVHpqjR5hdsvq5Z9J+ZxzK27qN88
         OGK+3n1kSQSZeRnUDBiY7SYllicE1Z6i2QqsZMpHHtnlFChp+f+29HuXjxg2jk5Hni6s
         Akp+kdPZQFGAx3F9O7hXyq95VJeaXpymONGpjJtd+luCwx3gybGop5iQnAV4FJg0oRR4
         lB1w==
X-Gm-Message-State: AFuF++n2GBrxkRH4x3jfIP2gBxHOJd2pQ3Qzzwvc1gQccOfegBp5RQnp
	wkDA4QbHH8mzkqm8pT4G938hMMK2Ycyio6udRU8hx62AY8KADD9GO6WqtH8a+sIoOwk=
X-Gm-Gg: AYBFou2RslzxNBjgTuOwy2WC51x0+p6ZU01r0o2xQ8O7xcmvajk0XHP32DsJ++X73ow
	iaxHXTLpQTQavniouRbwyTHrjVtZB+07VIq9zNwg5G09IYYtuvLt0yBAh22J90KHRYzQcX4XoEm
	3Et2oyghuv97i8ehitHzHeXqwtNOutJnhuggsLap+6yok8QOwggPzo0k5f5ZobsfKO4rnfVQmPX
	hdk4AThhUozOwIiXEuDDR8Wjy3jUkB+Sz0uHqFLVWHBbfEFehdWPyzEgyW7o6MlLsFwzslNxiFu
	7g3d8B2UbFKR1g/Rr9aYIBP2MsmTTOB/xx9mUHKJpbnN4+lM6/vaKTEsiuhUOqlrrG5IS6VqZ2m
	iHjqY0BcA9tO7D9hBLhZ5u1aF9GAZm644bIKLku5nGBIw0k+tOaBGYrLwY3eJXzqjo1Oxg1eJtL
	aPo/PWMnhfe26PFQmNuCQBBuj1R/GXLZe810IpOspgwC7LxvAMqHlgUqNRbmQaiwpg2ShxiA==
X-Received: by 2002:a17:906:f597:b0:c29:448b:f5d0 with SMTP id a640c23a62f3a-c2ac25d513emr197041766b.33.1790249328602;
        Thu, 24 Sep 2026 04:28:48 -0700 (PDT)
Received: from white ([5.194.185.161])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2aae5c6022sm284374166b.14.2026.09.24.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:28:48 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>,
	stable@vger.kernel.org
Subject: [PATCH] floppy: return the drive state flags from the 32-bit FDGETDRVSTAT
Date: Thu, 24 Sep 2026 15:28:25 +0400
Message-ID: <20260924112825.3525931-1-efremov@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compat_getdrvstat() copies every field of the drive state to a 32-bit
caller except ->flags, which stays zero. 32-bit FDGETDRVSTAT and
FDPOLLDRVSTAT therefore never report FD_DISK_WRITABLE, FD_DISK_CHANGED
or FD_VERIFY: i386 fdutils (floppycontrol -P, fdmount), and other
32-bit users see every disk as write-protected and never see a disk
change. The compat code in block/compat_ioctl.c copied the field;
it was lost when that code moved into floppy.c

Also declare the field as compat_ulong_t: the 32-bit struct
floppy_drive_struct starts with an unsigned long, and a signed char at
offset 0 only lines up with its low byte on little-endian machines. The
size and offsets of the compat structure, and so FDGETDRVSTAT32, do not
change.

Cc: stable@vger.kernel.org
Fixes: 229b53c9bf4e ("take floppy compat ioctls to sodding floppy.c")
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..569e8823dd3f 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3601,7 +3601,7 @@ struct compat_floppy_drive_params {
 };
 
 struct compat_floppy_drive_struct {
-	signed char	flags;
+	compat_ulong_t	flags;
 	compat_ulong_t	spinup_date;
 	compat_ulong_t	select_date;
 	compat_ulong_t	first_read_date;
@@ -3785,6 +3785,7 @@ static int compat_getdrvstat(int drive, bool poll,
 			goto Eintr;
 		process_fd_request();
 	}
+	v.flags = drive_state[drive].flags;
 	v.spinup_date = drive_state[drive].spinup_date;
 	v.select_date = drive_state[drive].select_date;
 	v.first_read_date = drive_state[drive].first_read_date;

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

