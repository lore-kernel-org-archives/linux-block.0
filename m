Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D813D260
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365107; cv=none; b=GNAYfpOPMcjFCS/3RhbWB+YcbHKKdIwXXKCi1lYXvvTbwUITAiEXJFnHX8lQwOR+KtqMBOFcbAb6eY4C8ZbzKPs7SF4c2FJm+huUKG48KV4GUQcvXM86EGIDK4yqFAR8rKg7OkfX7i6cH8adGr6aoV13JI1SQyPFdnQRfasoPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365107; c=relaxed/simple;
	bh=y1s9g8JMQaHSJ4n26wscCGHs2lvTNYLTQzw/P8zNfFE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lgsbhc12vSLFr4ONyxTKiePAjWQqE8zFyz7pmHW3hMYDeKaaadHQ6EWIcD5czbAtKxrSB+ZA61G4s948cZJcr/HEKGkRZPeRZ+tjkqoJZ/N6YhxKGcsE2Fh5/SCSWgRyl+bnc/C0iiGnM0C/unzJFQVYCibREVkkEV+hHxbsOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3cttNw2A; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3cttNw2A"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d9c78d108eso16062539f.3
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713365105; x=1713969905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3imiXOhpbNzRxvj4fv0vsBxkQ4hjyHoSIAvra1r780I=;
        b=3cttNw2AhaXTe/R2EC86qEnaP3jC6iiEZPOjOp/z4wcF18bpD1GjJA223GtYxl1bnP
         EuAnzs5hHFmn5XTDkhGdDtW19tsM2gsedv56jYFKRrPobq8lNg6GX0ivT1JzkfE5dNH7
         ccIi+B3grcgQ5gn44W/b480cxH1mBTrpw97BXoZh+z9ER7BkimNnPu3lZdQmh12iNYG8
         YAqz34HGLGDYen9ywTMSkiuF0wwaTaRv4JMF8PHWdaY+eRD+7mJdBN5hegE+ReGplEA7
         ltCj6Md4q9BesWaqf0GOc6y4evHLJRFvADxTKt+RW5hro7LeyxeiLXIb5t/tCmfmbdjd
         nIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365105; x=1713969905;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3imiXOhpbNzRxvj4fv0vsBxkQ4hjyHoSIAvra1r780I=;
        b=gGv27L7TnT6A8VhBaLKEdMLOGfkfzWGxNr+wyECXg/mBSNMJT2t/4sQyu6c9fM7T1j
         6OwVe9kyWI+WmTmLeTJmxDcNLklFCt/tEjlcj3nTggsi0q0R8S5BmAYvSGLtgmyaRfi+
         sWDYHrL/FNKGoXXeqRjNQ3QOFgTJgWnGeAlyJgyOmmoi0yZHCH62z3FFakBI14cONY26
         74X3kks1y9zZj+bk5PUaTW7SEdc6U8yhjjNomNcpGK8Y+pCID52W5PaGdOxTnxgHnSpH
         NVqfpji5hKxNgWuyEibvtWPilE4OkPgqwdqyt3voolJu75f2tVygw8XC2Jv6XK0UHGhL
         +JVQ==
X-Gm-Message-State: AOJu0YyY1QYvyIyCzosM+uyBqaTZZMYe3jjgoW8b0xPaS23OBtiKsoDi
	Lj035rlPda1VOfRUXHA+rLr+SYKhXD56M9JfQxCiqi+L8Vqme0LFoQ0YumVjwFy9zvBB0lg00c1
	a
X-Google-Smtp-Source: AGHT+IF0fdXNTAkJe0fRhzf9wvKPogLBbJtbaeMkiaL/Yy1YZ3LxzMQBRxxj8FFwz/o+EVr6wvaCXw==
X-Received: by 2002:a92:c14d:0:b0:36a:3ee8:b9f0 with SMTP id b13-20020a92c14d000000b0036a3ee8b9f0mr13764398ilh.0.1713365104702;
        Wed, 17 Apr 2024 07:45:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l2-20020a92d942000000b0036a373e3874sm3727881ilq.78.2024.04.17.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:45:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>, 
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
Subject: Re: [PATCH v7 00/28] Zone write plugging
Message-Id: <171336510373.151809.107599732887371811.b4-ty@kernel.dk>
Date: Wed, 17 Apr 2024 08:45:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 08 Apr 2024 10:41:00 +0900, Damien Le Moal wrote:
> The patch series introduces zone write plugging (ZWP) as the new
> mechanism to control the ordering of writes to zoned block devices.
> ZWP replaces zone write locking (ZWL) which is implemented only by
> mq-deadline today. ZWP also allows emulating zone append operations
> using regular writes for zoned devices that do not natively support this
> operation (e.g. SMR HDDs). This patch series removes the scsi disk
> driver and device mapper zone append emulation to use ZWP emulation.
> 
> [...]

Applied, thanks!

[01/28] block: Restore sector of flush requests
        commit: 6f8fd758de63bab513c551bb1796a14f8cdc40d9
[02/28] block: Remove req_bio_endio()
        commit: c0da26f950a355ef3540ca8d215351e1ed4cac47
[03/28] block: Introduce blk_zone_update_request_bio()
        commit: a0508c36efa838b16aa93a23e3583d68d3ef6c33
[04/28] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
        commit: b85a3c1b7978f942fa5bf8cfe22b6a6aaa49d3b7
[05/28] block: Allow using bio_attempt_back_merge() internally
        commit: dd850ff3eee428b4e1276bd51263dd937643ba19
[06/28] block: Remember zone capacity when revalidating zones
        commit: ecfe43b11b02ffeb24c203af7d3947417d412cf7
[07/28] block: Introduce zone write plugging
        commit: dd291d77cc90eb6a86e9860ba8e6e38eebd57d12
[08/28] block: Fake max open zones limit when there is no limit
        commit: 843283e96e5a3d8379579ac13ce9cbf75522ffde
[09/28] block: Allow zero value of max_zone_append_sectors queue limit
        commit: ccdbf0aad2523ca133cceb22ce0f8306730e7ac3
[10/28] block: Implement zone append emulation
        commit: 9b1ce7f0c6f82e241196febabddba5fab66c8f05
[11/28] block: Allow BIO-based drivers to use blk_revalidate_disk_zones()
        commit: 946dd71ed87dfa8d72f1404f906e1ae413a62d0f
[12/28] dm: Use the block layer zone append emulation
        commit: f211268ed1f9bdf48f06a3ead5f5d88437450579
[13/28] scsi: sd: Use the block layer zone append emulation
        commit: 1846f308d66f9c9a9c4f20df530dc77e57e3d92b
[14/28] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
        commit: 11be0cb5fe25603472831f85abb32f0112239238
[15/28] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
        commit: b66f79b706f0cfc09bde8465668428eef188a94c
[16/28] null_blk: Introduce zone_append_max_sectors attribute
        commit: 997a1f08b4d4283687477470bcc256dfd33ba9d0
[17/28] null_blk: Introduce fua attribute
        commit: f4f84586c8b9c7d5312d6f8fb4db1e12f2b83c27
[18/28] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
        commit: d2a9b5fdc16941243bbd8b360cb6e4fd62f41265
[19/28] block: Remove BLK_STS_ZONE_RESOURCE
        commit: 63b5385e781417e73bda3fd652c2199826afda6e
[20/28] block: Simplify blk_revalidate_disk_zones() interface
        commit: 9b3c08b90fc212de58c34621d83e74977170b2cd
[21/28] block: mq-deadline: Remove support for zone write locking
        commit: fde02699c242e88a71286677d27cc890a959b67f
[22/28] block: Remove elevator required features
        commit: e4eb37cc0f3ed8971c50dddfbeb35a799e5b504e
[23/28] block: Do not check zone type in blk_check_zone_append()
        commit: bca150f0d4edbf02002efa3309bb8e8c9d6596c9
[24/28] block: Move zone related debugfs attribute to blk-zoned.c
        commit: d9f1439a30d607f7bd06494ea2a63018b7d46380
[25/28] block: Replace zone_wlock debugfs entry with zone_wplugs entry
        commit: a98b05b02f0f1f9f4a504564070af208b70214d0
[26/28] block: Remove zone write locking
        commit: 02ccd7c360b1692da164842f211d41fab7d83adc
[27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
        commit: 97abee507b4b71d43dc1c1d3de4739db2c86c0ac
[28/28] block: Do not special-case plugging of zone write operations
        commit: 99a9476b27e89525cef653b91e542baf61f105d2

Best regards,
-- 
Jens Axboe



