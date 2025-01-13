Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4323A0E8
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779598; cv=none; b=GRtKpbUopmjIU0pZnC3PI6bnH2TW+SZF7jLOdQaqeTesPhvYoYpWYH+OPuL9HFeQy1uDwMLdutZ6j1mNIvJU7QJi1Bh6qyFKiqUDXtdmK8pLqsaUi+u3REw1CTpkxG8wznT+RXeqRiViVWbWxqXZCzYLcbOL1XeGSLRc8Akbp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779598; c=relaxed/simple;
	bh=XXGUeMNtduH3jfxFczrGU1LWJGWgOXZPjvIRPPr0lYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N0ar6Fdv0z03eeLheDMUCy2zVUdifXN4FGf/yGVwMVM00pMeqpjL3p5m/h3+Wx66KPqJ8gt0IwZJ5U2tjO1Vpzd1p0igPmhUjMODjM6WQnme0PlOn+X36/ChKApbsuSlFQ6vjRag40G9P9fwBV38ETjMq276NjTRfCmaaX8IO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pgjGkx4G; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pgjGkx4G"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a777958043so14873755ab.2
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779595; x=1737384395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtiliJx5j1ndYsGGG1phZCTgLfHL0dKhOHKuSNMEi48=;
        b=pgjGkx4GNkW/XiewWGEc57VNPKfuId0k27A0UWkT/FcCS9f5sYilL2PaRvGm3smbfB
         hwo7bgC4W73NYUxYRQNQR3XTYemFSx1DRcp8Adhvn+07bQNk9AgTs57sRwMPbn27CljT
         x+eIDeRKaezqEBM4WnAoWdS0T/rjjSRAQv9YQhrZUAqgrioBl6yL7bNSDJUG+IOKPaTf
         0EtTf52VNkrsXbiYhwG0GqYEWSMKNeZ/ntmLUs2gXJJpT2G0Y5lL8P3jjfFZZYACjVMx
         nbws4sQOG0+L+d3HxoKulkeCr5n0vRNAoqE12b+kZmyCf6rNJ1Xktb+vMR0g6BKVuYGS
         2fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779595; x=1737384395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtiliJx5j1ndYsGGG1phZCTgLfHL0dKhOHKuSNMEi48=;
        b=nHRnjCrOYMsInwiwZPCjOGFylbHs9W5vV+D+D8DyYdcXAEUFZU0Ko++/f8TldHiVWu
         CZLQv2n0TwSeXkptDsbI5iexkUO3FZgdlbiKgj1tL3FSTV1pbccrme6KRGvqFCYne5fE
         YHUK/vMRo2CtSPOWcidAVV+LDM+QORuTnutWkcqMFLCfZgkKtoOR5ojRD4edlGBTtRiO
         OoCmG+QeNPd14IWaLHL2vHkji/rydHYYR7P/3FmA7Ypa33rY8O6/MlchlUde8fVAxk/5
         50kVLvZoCF9gl/OhHgnUZVZ4tsqK4m210E27a8ZJasl/KndAOwYbTtU9K5clk4KewhxW
         tCUg==
X-Gm-Message-State: AOJu0YzElgtMt+ZkH0AHwVX2TaTbSbzuVLLxwcPrpknzeM6Y4swYQUdR
	7jO8xZpVHCoJ2S2GUCOn5hEgfzJ61e13QEV8w4QTFVyNBgcPqezEOzJFaG9uzS8gtrG3NtOjWCx
	k
X-Gm-Gg: ASbGncv4vuNAYNB0tL231YvubaVMPYpPcZsSe9U1b5huFN1U9z/nJ0NsdPZEVTEPucF
	gjhruOkHA6d1taFrVU7dNOhlE4kQ7qodORbcTmQpU1AuImu+QQlcnSlSBak+tNyKeHBA3U8IGAc
	Yfu8lfa3lD6dK4H26fepjMrBceRzruyrafsVVFtWpv/Hi5flY4z5L0Z1INH8xRGMIXxUCN3bjp5
	OA/C7g0CnHdK7WraxBMZkNEnfFcMbp8NOzlUG4EOHXdRzs=
X-Google-Smtp-Source: AGHT+IG0orvDT8cdI9Iol5E8H6Fk+RBM9aLfOujcJ2s3aU1fEULaeNBcgCbArYSL0EMHC0H2PTp4Rg==
X-Received: by 2002:a05:6e02:1c2a:b0:3a7:86ab:bebe with SMTP id e9e14a558f8ab-3ce3aa5adc0mr141968405ab.16.1736779595612;
        Mon, 13 Jan 2025 06:46:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7178d1sm2790840173.95.2025.01.13.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:46:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250113015833.698458-1-ming.lei@redhat.com>
References: <20250113015833.698458-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: mark GFP_NOIO around sysfs ->store()
Message-Id: <173677959482.1124551.14407464395957705701.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:46:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 13 Jan 2025 09:58:33 +0800, Ming Lei wrote:
> sysfs ->store is called with queue freezed, meantime we have several
> ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> memory with GFP_KERNEL which may run into direct reclaim code path,
> then potential deadlock can be caused.
> 
> Fix the issue by marking NOIO around sysfs ->store()
> 
> [...]

Applied, thanks!

[1/1] block: mark GFP_NOIO around sysfs ->store()
      commit: 7c0be4ead1f8f5f8be0803f347de0de81e3b8e1c

Best regards,
-- 
Jens Axboe



