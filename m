Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AED4B0481
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838556; cv=none; b=IXBDsUhQ0X0JejlkR7sYufJCbnbt4nMtqyPxiPhoft+haZAoRyKpaCHVVErTFKCZtc1xuh40aLM26m1+2K05+kXA+eP0vK3YIvk+MMfHQAbONsUxR7tsmov8RfK2wYAuKjFLUgPiE/OVUwZBD130hoG40LDazuzCS+3S3/gBg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838556; c=relaxed/simple;
	bh=Zn196x3d0wSbtWFOR3OG78ZF+/Asp+o8YjFe7MCRVsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ap+Yj7GXD1IwwmufdvlLV2n1GT/knQ4JYpNlqvxca6XBFiIBGJUAWNOmBKD9e3zNr+rMisrBQm8os/wzAmHIyQ23m1sV1lDlPMsm5sDwMSXF2QqqTXHnQ1DNaNwJxPgRrKX3UrLJHvwgqwAoGwbqp7jy7xVRmzkRm7AIeweLuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wSoJAT0A; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wSoJAT0A"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a071495be0so1205066b6e.0
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838553; x=1787443353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJhIT00Xk3opxRkWaBfTA1WZjrUVFx52bT+h0b6nSS0=;
        b=wSoJAT0Au1f9WSli8HIkadOyJH/gYD6xSBAlKopfWN1lFMBx3Mp2Pu3iktgJNzfAIA
         1rFje03ZtDeNKBakBXTO922O+L/zZ2JxTEoGwMr0qIwqIzpuBZV9zrTXyOiQQgc8ZWrT
         LlWXZg3TTqCpiU65EwJRflJ3NrBxqgBRJaHln5BbaGz3zlLRFJogRR+DkURYJv05naXq
         8t9vBiVUSIWvrkHobSwshJ+1p2r4+0p/K9CZWGIOhPywGvz7rvi3HB94mYS3E8JU2pme
         GmEouddb+46mIrDhV7Ly/xQkurEAECGQcMyj8TbtAexzxS2FL6mmtcEBQm/Rwyiy85cn
         hyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838553; x=1787443353;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJhIT00Xk3opxRkWaBfTA1WZjrUVFx52bT+h0b6nSS0=;
        b=K9yOKhYRMiY50PM4RQ10VcMgIekYgWq/H7TSDi3OTDE0pGPqxS6ncOrKi/deFkhtmZ
         B4HRs7O+ExYAdLDi7i6AjIlfbC6dVEs3TEn/gWxy6PIadJyMBpHlBT1Hoph165KT7IJl
         3ZBS3Gq7birHjK8Qitn5bZ+40yx5xG0v8y/7P/SrX29l6WH2He4fATwcd+9xSgnOyZR+
         V/XlIOvGaQc1dNvjjcwSXYkjOsLu6LyKTjMYts7IAEzMuMDuLbe5gVrOnloxJcfDAsyl
         1CaACPclw5nnMZRE5tfxM7YPccvmNjue+cZH8ysKE6WNA7/ITxrfsWhF2lfrYDFkiPuQ
         3I7w==
X-Forwarded-Encrypted: i=1; AHgh+RprJ3lQL193uM6EqVfTtcYpGRTAMJn2jodoDkMn1+u+2345c3eqm235ejkGNeS+3m+s6kN/sATCMaMtTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynauIXjAk915Td4C6jhWE9YEgmDHsZRFbt6a5bAS+vqAla/Pg/
	I6iL4fi8qGIaE9TFD2cpJwMS6mnMkYPyQAkjnC0G9aMN0jnGevF+4kSUwlUvmM638oE=
X-Gm-Gg: AR+sD10f+qYRIcyvY9NyCO3YqNq4agvasHcBAsaneWjbwI/Z6/bstMQKH9amTc+8RU9
	ARX3zmuSD9+kGqZV6WdUfGHC7XSaZtF1pYukrBdpRsKA0gzOextCR1Emt9Fk9gL3Ibdu0tkURBu
	WQXWO2H4Bf6P5Pma2ZRos0Y+x5jKpO5IDiCI878appmVDAYQBe8pCiCFEgF7DSLIdFpXh86a+fT
	J91mbaBiezNS+s60Xlc4F9Ofl67eLbkXFIf7cdWyigwdCO+P+FEcMEsCBXlAl5roFGDgIUIeezA
	aoE/vty8RYZpdwxrXJWSmnaZdF5lBlVGXmm91LTISPbO8ZI6ypnCUXrmYEMGITI+v+dKZHnCbHa
	ruoMC7eVn11hH3nZl7KYaXJDzVzfN98EFFgeGWOHx0VVBCd10f7W978VT1P/J5IBMeswkFdEsTb
	rl5S0Iyywibk8CL+Mr1peLcQOYceYhV6M0NWnMGIZ2jgH67fMB7UJc8DUt4tx0evUc2aBIl11ls
	bS66g7Lz9LJ4B936AGy0Y59RFsuvl0n6gKlGMOghP9b2sc+cpV8u6i2X77g4w4P
X-Received: by 2002:a05:6808:3190:b0:495:eb9f:53c4 with SMTP id 5614622812f47-4b241726af3mr12183258b6e.9.1786838553218;
        Sat, 15 Aug 2026 17:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Rik van Riel <riel@surriel.com>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260808114239.69167f68@fangorn>
References: <20260808114239.69167f68@fangorn>
Subject: Re: RFC PATCH] null_blk: fix UBSAN shift-out-of-bounds when
 zone_size is 0 or overflows
Message-Id: <178683854966.1984298.9103781823601303342.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 08 Aug 2026 11:42:39 -0400, Rik van Riel wrote:
> null_zone_no() does sect >> ilog2(dev->zone_size_sects). When
> zone_size_sects is 0, ilog2(0) returns -1, producing shift exponent -1
> which UBSAN reports as shift-out-of-bounds.
> 
>   UBSAN: shift-out-of-bounds in drivers/block/null_blk/zoned.c:21:14
>   shift exponent -1 is negative
>   Call Trace:
>    null_zone_no drivers/block/null_blk/zoned.c:21 [inline]
>    null_process_zoned_cmd+0xf76/0xf80 drivers/block/null_blk/zoned.c:728
>    null_handle_cmd drivers/block/null_blk/main.c:1455 [inline]
>    null_queue_rq+0x8bc/0xe70 drivers/block/null_blk/main.c:1703
>    __blk_mq_issue_directly block/blk-mq.c:2694 [inline]
>    blk_mq_try_issue_directly+0x3f4/0x880 block/blk-mq.c:2754
>    blk_mq_submit_bio+0x20c0/0x2a40 block/blk-mq.c:3208
>    submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
>    block_read_full_folio+0x7a6/0x810 fs/buffer.c:2463
>    filemap_read_folio+0x12c/0x3a0 mm/filemap.c:2510
>    read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
>    adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:357
>    check_partition block/partitions/core.c:143 [inline]
>    blk_add_partitions block/partitions/core.c:591 [inline]
>    bdev_disk_changed+0x851/0x17a0 block/partitions/core.c:695
>    blkdev_get_whole+0x372/0x510 block/bdev.c:751
>    add_disk_final block/genhd.c:412 [inline]
>    add_disk_fwnode+0x24b/0x3a0 block/genhd.c:606
>    null_add_dev+0x130b/0x1d70 drivers/block/null_blk/main.c:2052
>    nullb_device_power_store+0x240/0x380 drivers/block/null_blk/main.c:501
>    configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
> 
> [...]

Applied, thanks!

[1/1] RFC PATCH] null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows
      commit: 95491fb05105b61050cb623a5e0227eb26aa3525

Best regards,
-- 
Jens Axboe



