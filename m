Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7F1E890
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591292; cv=none; b=ph5ipbE9LfVmqJkypsP6s1K5bAWgRFk7+d0v6pNtfTFz90AM+nS/dsPyv15aEmyaURh2cLfy2UK/4pnd4+w+p0zuMXiG4r8GcUabY542jE+qHJ3ukJYc5bSXU22RdJyJqOO1cynSlb3pdCaOiIyghHIfVVPFEc/ekLh/S560wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591292; c=relaxed/simple;
	bh=gAhT4qjzzVO7gH8H6xZMYzKc7Qi23turOgX9/Q47LBU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=i8piZw/a3f9tptCahhJHMjGmjiNPt1Ugqsnbj6gkiitiwWpJqp2Yze24dl/rqGQcSz/D0bKTripmTOm3UyFDpmXTIisgnLcSPjK7/4LVv3DbHYEyi1oQQnSZLMAiBrGOsUUEpOeUC9SCziC+jONeZH0jOl+9OPFrs9RTTHcMNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HB0MwMk/; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HB0MwMk/"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bee01886baso48309339f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 07:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705591290; x=1706196090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnpT+ljAKyPAm8ysQyFU6nEF6rkE3TZI0/V0VGFrAgk=;
        b=HB0MwMk/jyj5TUqEev0fACXVuzpo5r2yJbomu3IMtejvFi+JZqpXpla1CKig1RjYPy
         PVvn5OEuVaB3iEkD7qcnFKAiwGHRCoo232Ete2bLY1DwYVg4Joybs5unvl7e40MlfStA
         E8Zhp4DMmg6dCRsgqy1xj8WtyPSZccudbJmczLeMebKVDVgLFa7l/zBrl5eAPNS9buJ5
         ua6nHw+C5u515CZvqxavZzhZ0JVQKooph2Rp2WjZa8tcKYKpfROp/ofiJtxcb7Hboyc6
         CdTkZlkd9kQjBq9aSpjo7mTStuATsvgv3/+xDYNvZ5g4crddl0cxzeT2NtD2U+PBJefs
         nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591290; x=1706196090;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnpT+ljAKyPAm8ysQyFU6nEF6rkE3TZI0/V0VGFrAgk=;
        b=M/IECz7ms82XDM7pNwe+Yh3q44wkpBvcYlPtpQFp/OCOWuSnvMwNkwi9vfG7Q1v1lu
         goOAWFnq1FtW4Y31G11HWIuTnONdeUMzbiSruZFcIjlUALA4CDxaE9B+lWr4nAH+yL5C
         KGugoxr29ceqfj0uPf0MwDSgLit/LEPI1x8Ym5Fi/7pCUHnx+kXZkDUG5dUgdTe1p4ZU
         qOP777MWbx8WLrcB4XIfBJvzx84HK/N9YnMa1rjDlWIU2jxMkBkuJpuPKEuKqesS5wJY
         VOrG9qB/MDaBnp5E1Z70Vs5zLMHnLO7af0EQWMQAcTuZoZTN5i+TNBesn4g2FAtSTWNw
         ZdHA==
X-Gm-Message-State: AOJu0Yypek43+V1YGEsP4jgUuxTqFE9PZ2Y2MB20GHoZQhFfgkU73bp0
	JLoZB90POcjdxCVdEt3lCaWNfHGjeA/pZfy2PnoG3kDtWe+NoVhTLW9JICgndFGYdkVBT/iouQx
	Vdxc=
X-Google-Smtp-Source: AGHT+IH/n7ANlPsCX/Ge5eGXLy0X46iUplDU69f47Fpn//8Kvr4Rpq1IPzEZBs//G5SpT3vwDHfHOw==
X-Received: by 2002:a6b:794c:0:b0:7be:e376:fc44 with SMTP id j12-20020a6b794c000000b007bee376fc44mr1855177iop.2.1705591290280;
        Thu, 18 Jan 2024 07:21:30 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a6b411a000000b007bf2dcd385bsm3129897ioa.5.2024.01.18.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:21:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org
In-Reply-To: <20240117175901.871796-1-hch@lst.de>
References: <20240117175901.871796-1-hch@lst.de>
Subject: Re: [PATCH] loop: fix the the direct I/O support check when used
 on top of block devices
Message-Id: <170559128967.861386.17373605187757527812.b4-ty@kernel.dk>
Date: Thu, 18 Jan 2024 08:21:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 17 Jan 2024 18:59:01 +0100, Christoph Hellwig wrote:
> __loop_update_dio only checks the alignment requirement for block backed
> file systems, but misses them for the case where the loop device is
> created directly on top of another block device.  Due to this creating
> a loop device with default option plus the direct I/O flag on a > 512 byte
> sector size file system will lead to incorrect I/O being submitted to the
> lower block device and a lot of error from the lock layer.  This can
> be seen with xfstests generic/563.
> 
> [...]

Applied, thanks!

[1/1] loop: fix the the direct I/O support check when used on top of block devices
      commit: baa7d536077dcdfe2b70c476a8873d1745d3de0f

Best regards,
-- 
Jens Axboe



