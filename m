Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D221C9EC7
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592600; cv=none; b=nS97k5ZqN6ADqBYg5QIvxNe78XSji+0EGPb5/6Ym21X5cH3yWrNUytBr1JI5qrIKlVtGPVhuwu2T4rtg+QdyBGVULW0qNK+sFBkrUO1jzddrXFd31QGRFYXh24zWmJPiZduIRdHLilh6qp8cIes9Fy/CkPtBDRYppKDEMUR30OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592600; c=relaxed/simple;
	bh=848nm0ohXy+F2HyJmHqLg9sTXzaU4Px6SKTmynJ2E+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GAS50uahXkpTmwdtc182q3BzerOSl+xzQR0LNSCAzVN0UyOOPgmsoy7lvDYmBy782L5XnXaq2dV77eMt1WGkOtiAc0XeJDJ8JujWotQ+9Ad6n52Au+V1p5mdTurK3tdZ7MouItpwWbQi0FuhD67feReSYJzKtQcA2BmuirljLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wsnlQMzm; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wsnlQMzm"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25cb022c0e6so113092fac.0
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719592598; x=1720197398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnAY4vIH5ynp04nDhzElY6h/MUY8SJM8BPqCHGK0vEs=;
        b=wsnlQMzmD36CPuecFn5sArEa6jTNrnzPTpOJTyK1NgcasexqvjGL/vb6uiodsuddM4
         hBPveo8r6H4wPnDdZhz3iWm6/Ii5qTvYk8gPJtCnxMyUkLtViVb+FhPmcL1LGrRwkPB3
         i82//ROcQGwOmYdBfKIus7PXQJYjEj5LPEgvDe0KkmxZ0aMJRdLy+z6EiPOpTDMBiibE
         iSSL3kpa/7i5yoeVJrT2GWaFsdu+ejrS5tR/GWLXVxoVq41NXnzhbXx1/VK6Hj5P2fEY
         M3u4boiKFoU7fIptGi0n/cz9VafU73mgd5V2q6M6RGy0FCcI3WGLNA4TmgcSoxCQGJ5E
         FZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592598; x=1720197398;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnAY4vIH5ynp04nDhzElY6h/MUY8SJM8BPqCHGK0vEs=;
        b=TSSanSfbDS5oNOIzMFkDASs4dJKLVTVmbIYJb2i7ofTmauehrNdoCKnfWJnxh7uH8q
         9qhMfZPT6hGktF5jf6YLNuG8ZXuxZBdtNSbmfuMnttbJuo2N395Qn/CPAjZhTH43KLAF
         B5RphyQc/3r+D0L35gyyJxIPkNI1c8wlCRDW9RnqcuAJVvDxP2q8if0GVhulpCu5eYOg
         WNWVfypxbHgW9Nr4QYqpY6H4bRuSumYxVRl9ezMmXEXcTDXzQl2SNmt8wWbBx2SfHMSY
         DDpZmgkv1b+o+DelrO4KwRjbRUYGQFK9hyRRnYdYVJdKLwDmWw76WxJyKWDR60oTAhJF
         qw0A==
X-Gm-Message-State: AOJu0YxdHEk09tkRvC5LsvEVah2mHZfQSx1z3ePMBKaKQF8D4WrptLDu
	66WdnV56Vyrzmej+2veghXWhexS4D8pKTUO1mWGjCqfK9zmidMVazz8RuEXQt4A=
X-Google-Smtp-Source: AGHT+IF1MrSPaFiGv7Y2jPWgbALIRZ2SUkEg0PmUnWlYJ/496Gy2rOo8kkNnUQk73i3Swv8ZaDXuJw==
X-Received: by 2002:a05:6870:5589:b0:250:826d:5202 with SMTP id 586e51a60fabf-25cf3f2d0bbmr19603325fac.3.1719592598381;
        Fri, 28 Jun 2024 09:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e15f608sm503255fac.1.2024.06.28.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:36:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 Ye Bin <yebin10@huawei.com>, stable@vger.kernel.org
In-Reply-To: <20240620030631.3114026-1-ming.lei@redhat.com>
References: <20240620030631.3114026-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 1/1] block: check bio alignment in blk_mq_submit_bio
Message-Id: <171959259700.887658.13351594054149607736.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 10:36:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 20 Jun 2024 11:06:31 +0800, Ming Lei wrote:
> IO logical block size is one fundamental queue limit, and every IO has
> to be aligned with logical block size because our bio split can't deal
> with unaligned bio.
> 
> The check has to be done with queue usage counter grabbed because device
> reconfiguration may change logical block size, and we can prevent the
> reconfiguration from happening by holding queue usage counter.
> 
> [...]

Applied, thanks!

[1/1] block: check bio alignment in blk_mq_submit_bio
      commit: 0676c434a99be42f3bacca4adfd27df65edbf903

Best regards,
-- 
Jens Axboe



