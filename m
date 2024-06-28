Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69D7BB0A
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606971; cv=none; b=o1ToQhcVY3ER8u7Q12iZwWyXeyT3bNTAeXrsWm5vDeXpxtCSd2srN43iwg52iRXUL/bNTeDeAvbrreuC3UmBOGeb4DW8IkrfjRHZbMyPHPeG4cZ9iWmYBYOuHBezqXTQ3mnSzR2OI1cCEytZW79PumEWgXqAbAtrYZ3jkOAygJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606971; c=relaxed/simple;
	bh=2K3dQB3zpbRSQ4zNsm2kr2egLTbsrKEaC+HcN9qfUYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ljbP/xNkAHjywfE7YmRoSxIFq7tGv4f97a9vF3GSmwEkTGcNzBNrIBkRN+zaeW0X+zkXwkduLSbTIwuPMpZOWvoZB/I5Fhk3I9K3cxIoaiexiVrUM2whlbxvt3OFTW8kPyVNwU5s9GtQLWJiqGzYBTmYn1lfHYPYKYxqISLnfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yNUB2Ncs; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yNUB2Ncs"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b3364995b4so85194eaf.0
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719606969; x=1720211769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l0qovf4jTVxYzo2d0+ddTKgfILRCCXgo0o1Ulo6Ekk=;
        b=yNUB2NcsuUo9AAjBGJ30Z/C5gP4BG/PE2245Bc4XiMD1X4HPlihN/4UgsNhUezL4rW
         QAbNjahKDm2mv+U64uMrNxRuIWrxFd68XF7rZR3KyKc8IT/thloY8VDYOqyYKynHDk95
         KHR1ZEdtaluaq3qQ/zsHx5vpLOFXuQJudp8C/C81/TgJo10wh6o9AqZZaAlUU+Wyyc9w
         VFjk5NlgHYFgdStBK5JfJpMJy8y8BnFAC6E3yNPik0aJNO0Ml6At3GgMVMJyZRUOXgCN
         Fs5HRHMCQUmtlctRZq07LBsXe53/QrfjatQWDRYIuaVYRq1N6vPL7ujXBfhCUNkbHcti
         9j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719606969; x=1720211769;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l0qovf4jTVxYzo2d0+ddTKgfILRCCXgo0o1Ulo6Ekk=;
        b=EqJ1YLHtcJZuUgsX9nc4+2TjGtqkg9hhyD8faC5ECnJqv9PSui5AWBqwIiN9GRxWsY
         GRjlNp8xc/VoDfWKH+aqhwe4t16Ft8Z7wOfdutm0e++QPmhZwKirEErmDTNi0kKEjCkC
         1dhklhJ4zBh+44epISK06Z7AoLYlBQpm1Oh4yinYxr7jEt6JMAAa9KirnhKER+5vZOSN
         TIuhfh3Wus5g6DsGhoeNNUjXC4ALitTEROY0oVTkVM8NcvPelMKa3+MyLzq3Xhtv/vvj
         Ski/XsUG+OtV2IXciFhZurGqccMIUPVlRVxlYRcs6XaxHj5AP7JveY4fN1xbDTusWYCK
         y3sw==
X-Forwarded-Encrypted: i=1; AJvYcCWHrs6TrZOkotlyihdo+djtPQdKO8XAUIhjM+TR0vu7ZWBs8D3F+i34NK7quvszM1kRa7BctSQiwg3KF6I0ELlm0sMqyr4gJztu1Bg=
X-Gm-Message-State: AOJu0YwfTK56WcEckGBrM/13qGEXCEu8RGG5dcPkAhehL/7pxQ79uZUv
	eKkgLWYRCSbtFo7MuN0MkN0UAc+qZm6VIW/eDZtXDKVmC0/eSoYOeNbkQDBZDamDzNkuq/EEPHh
	fM0g=
X-Google-Smtp-Source: AGHT+IH4WazrWMA1Jhl7+Mv0AnHm21EMJQcJF3b3HRLS4CUfPejixBcFUyOtlBC/ESyNwt5bq0+QDw==
X-Received: by 2002:a4a:c186:0:b0:5c2:25cb:e6c6 with SMTP id 006d021491bc7-5c225cbe811mr7965464eaf.0.1719606969571;
        Fri, 28 Jun 2024 13:36:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c4149c37c4sm367003eaf.42.2024.06.28.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:36:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, mpatocka@redhat.com, hch@lst.de, 
 kbusch@kernel.org, martin.petersen@oracle.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
References: <CGME20240626101415epcas5p3b06a963aa0b0196d6599fb86c90bc38c@epcas5p3.samsung.com>
 <20240626100700.3629-1-anuj20.g@samsung.com>
Subject: Re: (subset) [PATCH v2 00/10] Read/Write with meta/integrity
Message-Id: <171960696798.897195.9522006867615686131.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 14:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Wed, 26 Jun 2024 15:36:50 +0530, Anuj Gupta wrote:
> This adds a new io_uring interface to exchange meta along with read/write.
> 
> Interface:
> Meta information is represented using a newly introduced 'struct io_uring_meta'.
> Application sets up a SQE128 ring, and prepares io_uring_meta within unused
> portion of SQE. Application populates 'struct io_uring_meta' fields as below:
> 
> [...]

Applied, thanks!

[02/10] block: set bip_vcnt correctly
        commit: 3991657ae7074c3c497bf095093178bed37ea1b4

Best regards,
-- 
Jens Axboe



