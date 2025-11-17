Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDE32E692
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392992; cv=none; b=llPrrMdHKE7HbG8RhdfRfI4+P4CTexPY8T6h2Z7B2ruqhF5Dc4GqT9vHYqiO254NdisSuXxx0pWl86LkV3qagoj8AN5aJYRHke2cRvpd92k9FVZx4FOHytd+mIf0ostrXua4VE99ybQ8DLbAvfPCfJruXujWSf3GzSsjRl9Kc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392992; c=relaxed/simple;
	bh=S1G0GAs6f4Yl0D62HHVdSpqM59XoL6Ln97F2TLqvmAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t1OZkyUvenQcLGm74rT80hDtt2h8YpoLqXbYx3Q+VkYk6bEAn1bRXB1odjTFebBAiQ+LanLMLQ57g6XHvgmeG/8AagGG2xUddk5JIF8hgyP6NiJpZhv3UNmBS46QdJtzQHMgd5+wA5ObchTBwf9Gwc1BPJT3zQt3yKmsiUaOuo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CQ6no4D8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CQ6no4D8"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4330d2ea04eso17383385ab.3
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763392988; x=1763997788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWqaiG76JaK9k3Kkgqv5RCGqdtPShqXcVrgiohomNNM=;
        b=CQ6no4D8HxJ4/TQQttY6NN8OB+I4gluWN7bq7+nD7WXhmBesfzwsy6da+4HPpFydk0
         uKsV+E6LrZFBJ2ewysduFlR+pMag8dDuSvhphZGtL0iWmf0eQyIr6jO9KZ5Q5uDqbB89
         o8cGuK2qGFwK9xf8rQTxr5L1Qi1tmyrCqgqi8n3DVUyDTwP7i98PqUFjvDYTyxNqpAIQ
         4j8vpYPbtQqXiFUY6fAAH1roG2QBsYlsJsDL/gyJk4wXVsjRl+7V1ngNzj+4vn2dh4ic
         MdMkSbWFtJZn7vR9MRl/Ti1q6BtdNsnaofF5dAcvpm62yGJoAIoZKRoCSXfkK+Rnu5Bs
         b8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392988; x=1763997788;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWqaiG76JaK9k3Kkgqv5RCGqdtPShqXcVrgiohomNNM=;
        b=BLnz96IxVeCP1gxVKJr3ijMUzL+tdYl8bGHZ3rrHbdp8tIY6/E04xZcwVNoMYWDCH6
         L88vfn1j1NK1tioWigQw+hu5rcNzFxr0EYe6LAaIBWsq8v0g+ofswiXtvQpNoxEoVczY
         pN3abdBNiPOU07T8Mzj+qpG7PyqtwFqbyd6dje9nrT37r+WwqEQzmdnd7pcxa/hXX+33
         F+EIt1ZM/ShWdSuRSiAhpP3EfE0SR0Ajt8BtzUPXfLy21y10SYzMxG7xJdHkp4m1cEJS
         3Gtt73XTUQBRMTflMrifFqeZkDJMXtK3uEOVshG45cydzzBzCDIDn1Bc/I5v5P2b3PLs
         udjA==
X-Gm-Message-State: AOJu0YzOFKQUBMc99uxYeARyeEi/ZGgVaR9i1LH90sCl2KSMQWyyjNk/
	vs5C8dDKi+7r4X+FOysUq/rgbIIhAJxBINvue4cNBNNHa+59dHhdxBSlA2X8JfSpklna+MTeNhc
	G+HmS
X-Gm-Gg: ASbGncta9+KPP54NhXUrIvvY/22rhyzEu9xxCTs6rQ8x8g/bhac2ATvoQBeDs79OU+2
	Y9sDUthiqufMJ4Xarx8QTDcZf+dWJ/1UGkY55MIrqk97ejSDJ4iQ3lKHXVi9J3poH6RBlN/wtLA
	ZvrLneTkUh46uBCTOFKazekWJapo8nkPpW3R27o7fAKxNacGiCGXgGHyT+anqEbMBnsel4/RtI4
	EIbJoDLjnnSAWfeqNpTmNbA2woXgvnTbn+R5zw5jbeD7Tj4wp49t2RI08tSYlQq72AlZuxRndHU
	Jc3/iHTj1Ci7Lh1xZpyBK6jIrtIJoQcZofuKUi14WN0eNrM/ASidRkS7OEI+bu2JojdL99jN0R5
	EVAqjx2yxIpW6gQ/1peC2vTvHtSEt4FXRLBnonPaMTZ0zxkBOAg9GGjmxYJRP87TNXlAIOCJC0S
	QHUw==
X-Google-Smtp-Source: AGHT+IGhsdorf02dVpLr+4v/8H/wRl7iTBgSah6CtzidPU2Hte4GSgJBU1s1194LBvI3toWkd3aArA==
X-Received: by 2002:a92:730a:0:b0:434:96ea:ff5f with SMTP id e9e14a558f8ab-43496eb0125mr98576525ab.40.1763392987762;
        Mon, 17 Nov 2025 07:23:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839a49bfsm70008055ab.24.2025.11.17.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 07:23:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Rene Rebe <rene@exactco.de>
Cc: Denis Efremov <efremov@linux.com>
In-Reply-To: <20251114.144127.170518024415947073.rene@exactco.de>
References: <20251114.144127.170518024415947073.rene@exactco.de>
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
Message-Id: <176339298658.103650.14983967433115454330.b4-ty@kernel.dk>
Date: Mon, 17 Nov 2025 08:23:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 14:41:27 +0100, Rene Rebe wrote:
> For years I wondered why the floppy driver does not just work on
> sparc64, e.g:
> 
> root@SUNW_375_0066:# disktype /dev/fd0
> --- /dev/fd0
> disktype: Can't open /dev/fd0: No such device or address
> 
> [...]

Applied, thanks!

[1/1] fix floppy for PAGE_SIZE != 4KB
      (no commit info)

Best regards,
-- 
Jens Axboe



