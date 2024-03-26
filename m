Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C891F60A
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474152; cv=none; b=Vsci3+RwwF8Tn/dNOhuUYlGq6vK+uHb8gEsoXzqIAHFawEFgUEFgDSSDlInwd2Hyck9ovHd+Xae/EcpmcwzezZYfuZivVObvfk1q5UWH44Z4pz0owQ6laKvHCVpXJ8MXWjFof7r8qOYzT/0XXwgYSGJm2CGeg/armaQaP59H4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474152; c=relaxed/simple;
	bh=PmT1bXaEGXuYIXmNIcWK7TaM3XWK/lYGtLFo9j2ydL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ge02p+ToZviT+xKxEDPgNBVYTKluUgJTMEEPRBTG97Wv5nQ18acK4HxzWtZOQS0BPKeeAHzeg0arDDfqUhmyEUREf424azZFjqfNggOz6oBnMNDnm9iUnyeL+GvGrXkGt4lzHPahqNqXTwCC4wE4WJ0gpVA1iTsEu4nKTKjBGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AcbC3N/R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AcbC3N/R"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29f6b6d184cso354918a91.0
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711474148; x=1712078948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Vi5BLiHhEJ6zwu2yudGVDTTaXeANZZRz/gw55tufE0=;
        b=AcbC3N/RJWIwAhMJ5WIl0mqs4KB0Bhcczt2cggyKlMPl2KAeRWcBFTtWBGQtIpMwTx
         g7Si1mKrfmcjfgayIayTTXLRBAkgWZFxZTaHVhbZWHt6iGXhZYU9IQmvGX/WdoSFQUop
         DTvPcHs37cbcugUCO8nbhqznAMvzJIKweTs393xBGNpaJ4afD+QKGqyxny43qEVU2urt
         SESrVDYM3/Qrlj2X5HEuP9bScWpyxWRudVQ/MD0D+Y8TJ1baovbLzABJc9nHrRa7POEP
         1hmeeFAC5/0uH2G/Rl/jOjWJKmU0bTOXu5BCBeWoPFBP8nnZcKEfwZT/kg52Wy0MEAmy
         SEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474148; x=1712078948;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Vi5BLiHhEJ6zwu2yudGVDTTaXeANZZRz/gw55tufE0=;
        b=vPt5Levyp2l9S1CmYa5ka8gCpkpcRcfP5eGGz0FbJT0ljmNL2iTJo3SW3huExT6BJT
         CvJANf/8nfQORzAqptqZmIiAMp1O6V+IKgTLr/NLzk6dAzCwi5pxfDlGfEL7JZcGyqLr
         0bTI701v/hclz+wj3D6dwtNgwNZb387QMYv44ueQfrHj/v3JQx+rXgEJ3sMN617CONIU
         i73id37oIKpEtC2SZo5mZr5hmSnBqudl0PSDrDg0LnXNppNw0Akjg9fyEqIGOjGY70MS
         asDaeLYLPihNOShPMOMSKT/S0uUTxrMo4XBFApFILzpsYeF6M/Ub5j23pmOC18GUueIB
         vgiA==
X-Gm-Message-State: AOJu0YwdkASmZVXs7CATxQz5oudfc7BNWHrjBkrCQOmnWbjuMCr27wLb
	G5EJS/0fUI2SLJJ7mgXrDIAjoZppArD/ju6iaXNhsSzzsN6OkE14druvZ7UNZ+nRpw8aLl/yHFy
	V
X-Google-Smtp-Source: AGHT+IFr+f+0NSJG/2tvijpvSqIrvMTS6fiJeOs2YSIjZ7991QfAPN/oXpoiBe7dOi17pkaDI10F6Q==
X-Received: by 2002:a17:90a:7108:b0:29b:f9be:6b51 with SMTP id h8-20020a17090a710800b0029bf9be6b51mr9258592pjk.4.1711474148345;
        Tue, 26 Mar 2024 10:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:163c])
        by smtp.gmail.com with ESMTPSA id sl3-20020a17090b2e0300b002a0304e158bsm7534394pjb.41.2024.03.26.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:29:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240326060745.2349154-1-hch@lst.de>
References: <20240326060745.2349154-1-hch@lst.de>
Subject: Re: [PATCH] block: don't reject too large max_user_sectors in
 blk_validate_limits
Message-Id: <171147414761.366972.8993940739344220182.b4-ty@kernel.dk>
Date: Tue, 26 Mar 2024 11:29:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 26 Mar 2024 07:07:45 +0100, Christoph Hellwig wrote:
> We already cap down the actual max_sectors to the max of the hardware
> and user limit, so don't reject the configuration.
> 
> 

Applied, thanks!

[1/1] block: don't reject too large max_user_sectors in blk_validate_limits
      commit: 038105a200689ae07eb9e804ca2295e628a45820

Best regards,
-- 
Jens Axboe



