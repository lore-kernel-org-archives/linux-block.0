Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C44503C
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255996; cv=none; b=XQCiptNrFmdHt43uTeu9TI+BS8QAKxLfRm/BsDjlYbuvZbWQeyZoOoyiNA0o+D/Xs0md8+QImdPCuPxpr4tP0M/nZoi6HXeBn1yVgxS0Mw+D1NebtGEfLuPIdqzMOCXto18i9kV7CxtFrM+kZhpxNq3wQY5Yl4ioTQQI+DN5aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255996; c=relaxed/simple;
	bh=OqWeQVvsUI5YBiAgMDyrQoAEq3yLGhUFkHm8BLPS2Fs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d8Ejvce7hSFVsQJmB//6TUEaYEbimz8GseNE97kiFemiIgm9Hx92wofssWYZ8e5x/EqhEQD8OuReFvEP/apftEK5BrXrX0fefLz7oEIt/n4Gw+t/L3qv3yC58GlWfeyYX62jeLBfxx35iY1g4NH/BCnPMV/t+BEVYo3SpZ++aLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=whadlr0k; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="whadlr0k"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so599351a12.0
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719255993; x=1719860793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt+XckMCgwoVkrDTdIIAkFkXvtaQX7cPyosJFtPFqoQ=;
        b=whadlr0kvhqTaKbQM8AGDkG/FGpNcNOrI8SEKOZA7muT5soiwQr44qIGR4CmeEmmcE
         yPC/aYTPXdUfGMbOvWT0luM1gz+F4eGwUeY/N7heNhgVuhVRTxDKntHLAQ7uvZaWzeVq
         nETCqMPoIpCOI4cUuBI7ZmnVXJmzzPykm2eYJgOnyrRAwQKS2KmcaBNxqf5CrYjIlsGa
         kgqH9k2iCKXbNwGadn5o4x+T+4/Mikz8g2wOjCLpoJi68pDUe1s8+jsv56Zr4xIRhL6g
         HRUY/LQaB8MAbiDbHzeaDYW/+MjVWcHPLF6IrD/L9XBcanDmqKE1KqyQB2i/xGsq9ZRl
         LWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255993; x=1719860793;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt+XckMCgwoVkrDTdIIAkFkXvtaQX7cPyosJFtPFqoQ=;
        b=otXyv9Dekvg0gT/+2thsvr1nHFIcp5bWIAyHwIWQk3rCbHO5G9gTcndC/0H7STAaju
         MZzr0LEOXe3AKE/T89QOxkB9F7X2y7qAozKqNRse76MhpcrxL3N6ZXYj7RoPcMGoiACE
         EhX8Tcu2cOPzvfMNzycQZ+WkGOwVTxwV//WsKPBolQB3xDC7fDmr+NKwrwTS/XhE10tm
         IgoiiUXBJJwjGoik3L4r7tjldXoFKXKZAY+JLTmJ/T9Tu7Tqfut/P577G2RUolSn1QhJ
         qa+rVV76hmdtrPA5JV5O9laUP3sfvD9gmLpt0WAzGiyRQENbykt+P6G7dkXNswtURIdc
         Jupg==
X-Gm-Message-State: AOJu0YwjHeOIdiwixcuASD9L8SnH/lAyws819qM1KyELHmMHL33JfHiK
	3f1IziDclFm5SckJUgbP/o3DGBb6H7y4RursvcD3Og5XlsrUQ1Bv1a/PtAE52yM=
X-Google-Smtp-Source: AGHT+IH6KRgxuAO7sJVn3jqgvuwaWMZ+ajh8iY1fyJwVrd/GB7OmWgccJmKTQ6x/UE8c1viA0sBjbg==
X-Received: by 2002:a05:6a00:8604:b0:704:23c3:5f8a with SMTP id d2e1a72fcca58-70667c4e286mr7053907b3a.1.1719255993169;
        Mon, 24 Jun 2024 12:06:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b364680fsm4972107a12.5.2024.06.24.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:06:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20240624173835.76753-1-hch@lst.de>
References: <20240624173835.76753-1-hch@lst.de>
Subject: Re: [PATCH] block: fix the blk_queue_nonrot polarity
Message-Id: <171925599216.326063.1788159845342471524.b4-ty@kernel.dk>
Date: Mon, 24 Jun 2024 13:06:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 24 Jun 2024 19:38:35 +0200, Christoph Hellwig wrote:
> Take care of the inverse polarity of the BLK_FEAT_ROTATIONAL flag
> vs the old nonrot helper.
> 
> 

Applied, thanks!

[1/1] block: fix the blk_queue_nonrot polarity
      commit: 44348870de4b8f292f97b84583a298d66fbaf738

Best regards,
-- 
Jens Axboe



