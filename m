Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FD3D3B8
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088182; cv=none; b=P3wMUgfEQRdtZew6EyIQAkp+zJDmkDD8duoEJcf+A9OGfdS0ZE1q0stBMVey4ma453qPlvdqUNhG2K5lBTjN9lyPC7Y3Nv/gY1Kd4Y0onL1fuQW69vR7+sZcAAjssfg7NKzCcKU7oXCAJISRcDLDt9oL+pmPpPyjFKmrAKS/Bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088182; c=relaxed/simple;
	bh=vvPyWurBo1cDiI4Jzf4ikaeHBWD8dgf8GWD3nVR4VFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hJz/+jhAzhAIt6VL6csO4GiwoXaWLYZ6/CUDzVwnv9CDB2CQniLRYay+gJ1rDJascbJGiCfsohsrzvYwxyTqRDQSypxgoE+cf1EJMs1+ogrUS/EknkJUU6giEcgAWXWsbSo81MADWITsLPDP1Qr5TcOL3pZp00sa7LPMYmvmMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JlcAOH9p; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JlcAOH9p"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so1000945ab.2
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726088178; x=1726692978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrTXohKcakKrQRTPyeH9GKgEPlzRAt7rReHMH3Os6Ec=;
        b=JlcAOH9pP74UwrP/9/L887+msAjPyxFJlQMMUn2emDtX+c/Dk8K8mwTkmtRr4Jp68x
         x7/Fs96Pix5lHDgRUDVnv0YEh1lZEhmD+uoCpXT8AxjlTwjoT0ucmbut0Z58VTChcmc6
         VtOYxARfAiXtnH0akN7rJ4lcdo0bPURXoAaBgidZ6QQWKOwCslcKsKs808FiFgO6Yjnm
         Rp9ybmJXCYVCPVbd57WCjQ5OMMpj0fk7P1cX6aynBm0Q3gQnjysRqas/8cshzdf8L4b/
         7r20tS5jTYgtjwlX+fOBvnwa7XRLCJS0JbbCIWTVS5YeM23WMa1Be3ARFcoH9t5jbqrV
         afSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088178; x=1726692978;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrTXohKcakKrQRTPyeH9GKgEPlzRAt7rReHMH3Os6Ec=;
        b=iwghoOeHiMgodE/KYZwoIeGmMYbycLXOqA2P2xsZPqwDwnbifF263kZW2DH7bFFOf8
         M7Nzcgc0Ln71t+gxKj2uPsByxxH/ErGObi39KvCeeX56c9qcieWjrAFA44j+8vWBzWKL
         dRm0suRo6HLmWLXeu/RLf2NUHpkd22vdrRA7jgsC03Sp9zxSysDVjAmPZaPUxe704Ow6
         ks56/JLnMGrVqw9CF+3nbqjyxQUxEyPucKe/QQYnnMNyc1VNRaiUOemmnxSqLXJH55+M
         UmyWWhy63i5UUFoihv+Flfh2d0xt84gRIdzDXdD1ldk9l9k7L9ZdomVyq4QcBZT/z85A
         9ytA==
X-Gm-Message-State: AOJu0Yw4plkppUXKyXZLeEpXDbTBoZM6QVxzcdlBsYHquiWJtMvE98wi
	RSrA3syZYl4Fs9E8KZyV2Gk9TpCXhF5Th2aWFIS6M3O6X02oZg/IAluy7DKPAMU=
X-Google-Smtp-Source: AGHT+IEgwQDEReBSmpA8KGOX3f0oJGCv6xIznGiS396TC+iHRgbq+1WnmI8Rk/FHeMfnphmW3bXbwQ==
X-Received: by 2002:a05:6e02:156a:b0:39f:5abe:ec17 with SMTP id e9e14a558f8ab-3a0848ae910mr5243255ab.3.1726088178466;
        Wed, 11 Sep 2024 13:56:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05901614bsm28154175ab.83.2024.09.11.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 13:56:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org, 
 Christoph Hellwig <hch@infradead.org>
In-Reply-To: <cover.1726072086.git.asml.silence@gmail.com>
References: <cover.1726072086.git.asml.silence@gmail.com>
Subject: Re: [PATCH v5 0/8] implement async block discards and other ops
 via io_uring
Message-Id: <172608817766.420469.12723014445324806563.b4-ty@kernel.dk>
Date: Wed, 11 Sep 2024 14:56:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 11 Sep 2024 17:34:36 +0100, Pavel Begunkov wrote:
> There is an interest in having asynchronous block operations like
> discard and write zeroes. The series implements that as io_uring commands,
> which is an io_uring request type allowing to implement custom file
> specific operations.
> 
> First 4 are preparation patches. Patch 5 introduces the main chunk of
> cmd infrastructure and discard commands. Patches 6-8 implement
> write zeroes variants.
> 
> [...]

Applied, thanks!

[1/8] io_uring/cmd: expose iowq to cmds
      (no commit info)
[2/8] io_uring/cmd: give inline space in request to cmds
      (no commit info)
[3/8] filemap: introduce filemap_invalidate_pages
      (no commit info)
[4/8] block: introduce blk_validate_byte_range()
      (no commit info)
[5/8] block: implement async io_uring discard cmd
      (no commit info)
[6/8] block: implement write zeroes io_uring cmd
      (no commit info)
[7/8] block: add nowait flag for __blkdev_issue_zero_pages
      (no commit info)
[8/8] block: implement write zero pages cmd
      (no commit info)

Best regards,
-- 
Jens Axboe



