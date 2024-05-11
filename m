Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C67446D2
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715438463; cv=none; b=tbX4mB/ijQmaP+mPQ00Ja8T/nElpigDVk+M2p8OZwLgOU5g1kT/XyTvWlG3uGqmVtHZIt0DdDemo/5r4m2A563TftMPOZ4Wu6QtB4kdxw1lbdzlZpDaupht0Kaug5VFd6wvZ9EXxLGHLHVvAoYEwKXJkfK3s7Q2S8KpkF9bH0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715438463; c=relaxed/simple;
	bh=uFbayNP8tlmrgyrYWRJpsoEqIhTLFlbzSsDoTDeqG2M=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ct0mETwnfzOklAKmSJHdEmCT0qN2dZ6eHqpQnK8oLu2MFrByQWU7sNzpBC9wDPfuQ8MUUKXz9Kjy5MLXvFpNyPDYDwU29yXQzmD9VK3Rdpv/r3FHKU3c+CXiHLvyZeY0iAdCQLL2P9CJNGXja4XWGCCnpSKtRITspwvYLFIodd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2DKqA63z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2DKqA63z"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b4b30702a5so780448a91.1
        for <linux-block@vger.kernel.org>; Sat, 11 May 2024 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715438459; x=1716043259; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8xMxoqfjymUxzsSwbW1/RDR8rD3KSFSLAjaPfJE7Cg=;
        b=2DKqA63zG6AAkUwfaDhC5KYT444NvDnwFpbae2UydCgnQ0F2erjovrsCIvCTA1PLM9
         KPH1CUb7uFecxez7/BMiXGywPburrR+0IZe8Uu4wrfNb/p0i0KErTIPvyM6TnzFNIZwq
         cl8yYgTkx/vQOQM+hh65X+sO1q1XPzvos800zvwemhlKSLG/LfFbiw1sCJw5sUCWD3aO
         0DoM/AF7FkgL8ntW51TJygPhQsTmFp4q1zG/yyvGXwYo3Ch94816kf77auaU/xgjfSOj
         rr9wpEsReWFYN/7TrEEHv2kcJzukR5X7Ybci0agVnXAyGu6FSUHCwwrSbh6FcTXtncrU
         ZqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715438459; x=1716043259;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x8xMxoqfjymUxzsSwbW1/RDR8rD3KSFSLAjaPfJE7Cg=;
        b=dSJ5CEZVEB5Pd4CcqOMwocOXfIyJQzsQw9HUbUDud90b+RPjqJHrHtM0Ae1JPjAP07
         q+1k5qCUgBTYJnpYH5NCAAGNjXtkUxGd7RDvXj1HqOdhZomXqB19kz+waQdcJ6+M+tnV
         eXWut/IokpbTcJgT9WQY2350v8+FsIo8oeQvWFF2npMv3PwWOWYoNlzPZLD+QPP9ostV
         mQJPTDMwIcDg4ENk5GeXG9vJHYEDexTL5J9h3I+BIDA4S0Gmy1TITKx4VOGUOuZju3le
         GsKchQhMbx+ct2Ewf+zHqj9oa/4ObIdgu3Lczb+sZXBRmExEkWoCI0jP/8NFefFtOwiV
         f4dw==
X-Forwarded-Encrypted: i=1; AJvYcCWqxBQ4757SfLgIy8F6BH0clqJl8f3q8GCrasymEpYGMdOrGfJIVcxhjsHdvxxF22cG+IRg4Q+B/3MCJEOOECiR8XRp1mnqoHbhwbI=
X-Gm-Message-State: AOJu0YzXYmdl97sPdgIEg6jkh15HXlDZO93daISuVok8kKx2Yrf+nRq1
	5PyMVeEA//tntpIcF9DZ7i8UaBcoCtf/DnTUOwkBnKLW0PE9tLK4Kk/hSkL8yxeDJTT48qtaFFI
	/
X-Google-Smtp-Source: AGHT+IFWAonGJEy38mhpMhJiQ48B5y8rPZU+Vndg9q1HrVsHXNKQ1gbBz4lSF3Ut7RY9LS1pGLEVDg==
X-Received: by 2002:a17:902:d511:b0:1ec:ac3:3109 with SMTP id d9443c01a7336-1ef443f27eamr67970125ad.6.1715438459016;
        Sat, 11 May 2024 07:40:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036710sm49500835ad.198.2024.05.11.07.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 07:40:58 -0700 (PDT)
Message-ID: <379b841f-210f-41dc-a44c-f1dc3197e10f@kernel.dk>
Date: Sat, 11 May 2024 08:40:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ublk_drv: set DMA alignment mask to 3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

By default, this will be 511, as that's the block layer default. But
drivers these days can support memory alignments that aren't tied to
the sector sizes, instead just being limited by what the DMA engine
supports. An example is NVMe, where it's generally set to a 32-bit or
64-bit boundary. As ublk itself doesn't really care, just set it low
enough that we don't run into issues with NVMe where the required
O_DIRECT memory alignment is now more restrictive on ublk than it is
on the underlying device.

This was triggered by spurious -EINVAL returns on O_DIRECT IO on a
setup with ublk managing NVMe devices, which previously worked just
fine on the NVMe device itself. With the alignment relaxed, the test
works fine.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 851c78913de2..292fa2bdd77d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2176,6 +2176,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		.max_hw_sectors		= p->max_sectors,
 		.chunk_sectors		= p->chunk_sectors,
 		.virt_boundary_mask	= p->virt_boundary_mask,
+		.dma_alignment		= 3,
 
 	};
 	struct gendisk *disk;

-- 
Jens Axboe

