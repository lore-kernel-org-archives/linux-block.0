Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEF238166
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804642; cv=none; b=C6G/CbbNF6U4LZBF0Ccd8bgVV9ISx8Ml9bdif3xzRbbKSKwPV3CXA9A3X2EFe9GuAkzKE0n545klXxysofZ703agVK8A0dKtgpEAUSE5vZVU78b8j0mclWCa1yWk6jSioXRnX4ayOiG0mfDhz2HQb5XedWLyS4RMYLG/EvBZQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804642; c=relaxed/simple;
	bh=Rs+CHfz2pEdJ9ZDzoS58n/HTicuPIYuGFoXpeFE643M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R6GBDqddWPeTtkAEXkm/+qQUxdu7w3FCwO19G5t4Wj3KhKKQOjkTZ5FzX/L9Ag0kOd994HlVgY5E4029UXzw4rnTKdjuDhWtMbi0vkUZOGG+1hHmYeOio4Q3FX/SeWZEvFCPUcuITip87u1s3uEfDZUh1rlq1KD5ryJWbnxK22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XmY22dUP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XmY22dUP"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cac8243bcdso1411216a34.3
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767804631; x=1768409431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSTQ4KUiVWxTX9B5UYC0FohSYWYTxrtxwk0QjL7KUTM=;
        b=XmY22dUPlJDG8dB3YdW1TSOXup+kUK8A0j/nJmah+afBZ4Y72ho0RET/laxmWoJvrY
         A8PoSL/fB7q2h0ty9QUrQ3ErhMC79adufhJ0HnngjHFTZE8OpDYIdXqLX8pWS9xxFE/b
         t5lheXspsCkGor6djZobbFX0f+UmvK6ceLk5xv6SmxcaS4nh/jz8KYpLA+hQHmXGpgv+
         qUgdZrqjWaaUxIe6/kkOa07HQsTl0ARxpaCbD1HW5TnNqUlJTh8ZFwv4gqVO100Vsgia
         j7mcAGrY71DWsNyIOCGZolOdegd8FyPKS/8/abu2Yb439RuJVGimrJVXvBz9zLjIY3ku
         m/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767804631; x=1768409431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSTQ4KUiVWxTX9B5UYC0FohSYWYTxrtxwk0QjL7KUTM=;
        b=ZWOClvvjDSR9JROV32b9CUj6U63apNQedlvi/yK4dZTUOc8wQVhtlcyLUWbD3Xem1O
         Xpe6iQJqUXeQQpHVSyXabFkI/gciDs9PMo2AHj9o663Ln2ExFZWVXZbAaE5hNXDjpjY2
         +XeBc1TXJ4j9FpFFaYwCT2+lNdJNolHg4c0KN/dU3Fud2WoU7Hxjf6ykUcp+CvNf4Gp8
         JT9gtZD+RJ9rGQAFc2zON0gOm4y8c4nP46eIs2qP+dsZxiJwqdorAvwaPULrEXohEs6U
         ZBQQEScaHRz/CeanZRxgcR7M0RZGXpLovBhFTbVJ4zG0dcFy8/lkS6YDpPMaX99jxise
         kJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCU475158wZzzDNDN3lJaouVTOY3GdZBoPDiiJYcA5FEkgH8oqB77zk7T3arfjmv/PK1Gc3xSqqdEe8Jlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94LcI6Ua2cQXO8i+lz4C0jZCVcrAewtx8Us/6nDlSF0zSevg2
	ovZw5HLp/PxsVAvuz79KeujNQfGI+rZw2aECIyrMLjEaG4iJPbupgvNj8xpTErsWW+k=
X-Gm-Gg: AY/fxX72dmwGJowsMr4shg1Uzj5GpmrEWGX3rloptpRwW9aIxzKAkEPf8sNHxorVCrc
	ZR9t2MRqA45pP7rb+jW9tS/zPkevnjbGzaiDTTxuv29gFsINLeZWHLTCrPoYhr24R8dfG2UkWJB
	sYf3fM8hFHmgmW5GqZBgtjk0TO1dST4uWVOsH1tKOTQ5NPqXoj0Pj7z5ZwQ0g5pw9Ht/pmE7R28
	ix743MvPqJVtr5RPC6X3omMbz9RTQBFKcrxWiDE51WNZcBQj+xbu+PQU1OhpSS1S8qp4bNJ9CrR
	rVHhV6PknoKZ+dPPhjptFKet0EAVg9WDHNEiqvVpCSllu3u2HTuqQp7KxANfxx/utVB8cOlbQ6+
	BlYfh5VyXDpCx8QYIbpkbh3X1VJiL1vI6Pzhbf2dgSCNL8SIVgg8+WUhxLqmCb4c0Bx1zFlp7D1
	eBqjXRQhWNXAQp
X-Google-Smtp-Source: AGHT+IGEPBCTt7sZXurao3XnNt1QoORRbvvUnmqRem8cMfzEqzLO4Y8vE8KoMsGJYRw0936GVdeCDQ==
X-Received: by 2002:a05:6830:2706:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7ce50a0039bmr1540987a34.1.1767804631140;
        Wed, 07 Jan 2026 08:50:31 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4762eefbsm4012413a34.0.2026.01.07.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:50:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>, 
 Fengnan Chang <changfengnan@bytedance.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: rcu@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
Message-Id: <176780463002.77199.18373913031463054048.b4-ty@kernel.dk>
Date: Wed, 07 Jan 2026 09:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Jan 2026 16:56:07 +0100, Mikulas Patocka wrote:
> On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
> virtual machine when probing a virtio-scsi disk:
> [    1.011641] SCSI subsystem initialized
> [    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
> [    1.015983] scsi host0: Virtio SCSI HBA
> [    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> [    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> [    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> [    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
> [    1.024688] scsi host1: ahci
> [    1.025432] scsi host2: ahci
> [    1.025966] scsi host3: ahci
> [    1.026511] scsi host4: ahci
> [    1.028371] scsi host5: ahci
> [    1.028918] scsi host6: ahci
> [    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
> [    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
> [    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
> [    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
> [    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
> [    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
> [    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
> [    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
> [    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
> [    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
> [    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
> [    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
> [    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
> [    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> [   16.483477] sd 0:0:0:0: Power-on or device reset occurred
> [   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> [   16.483762] sd 0:0:0:0: [sda] Write Protect is off
> [   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk
> 
> [...]

Applied, thanks!

[1/1] blk-mq: avoid stall during boot due to synchronize_rcu_expedited
      commit: 9670db22e7ab4aefe2b2619589a47fef9d3e0c7e

Best regards,
-- 
Jens Axboe



