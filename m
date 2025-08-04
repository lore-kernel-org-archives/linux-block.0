Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD41F9F7A
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321006; cv=none; b=QDyWQrANXzDVAAShYnIoUyu94ujITetuFodge8PSJ89mQ1pNfE9O6VExNcI4I+mf5zKIme0pMSP0QTFm1QCa4rNZuGdpw9iA7lYDuAcCfn55fVlOHV27KxVp1B4c0EHMQKiveMQ8oj4rany8GHggOLeT43t9U5MkSk4iYtxMNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321006; c=relaxed/simple;
	bh=nFoSWOWXDMGmzTUxtwhpB70Bmfd3Anx6RywJYHcDP48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dD56y2CYX7PxPOaLNIkXXruqKLSAb/SmBuXlzGRbCMIp7ZNnlABOb3ZDS3eTsRb1+8G1nV896b6Sy4vihSnEyFo6JfGrj0Fv62MPZ81iJ+kyk3C8mmpCu/DxE+eM1tlYsfEVuxTlXewMrftya86u+eU40Fb7QjEEoTj0oMJHeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kntd5a7H; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kntd5a7H"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e40d16e218so29086675ab.1
        for <linux-block@vger.kernel.org>; Mon, 04 Aug 2025 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754321003; x=1754925803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqdX9vSM7eNyAqBUevvRqDXoCJdSwPaqgVdWOxEJdM8=;
        b=Kntd5a7HCZ60vQ6jKwe/HzSfHEUSH6Hqsgr/+yqEQeTb7GCwkCeEzLRUAFLFPswcXF
         NXrpcquIAMfFBASjwo0qpvrMO/6MTvUBpg3KtWEWTiEzgoc3PxhLAx57pcNfAVzVoLer
         8e3qTc76S3DOaeKyI8A/J9cEXvZP5BB+mMTgYMZuonBLsFdOgI2MCZ7kSOCvm6F2qrYU
         2x12QJSQvnP87XD+TiJVEbVo5EhvfMHxQMeXWGHvX6vHoEXlV3R5qmM4dGYVecJT/e2D
         4xx7zVCzAf0ijgboihfEAzlGJnYTO1ByygHksGrhjsWEF6ljT0+bOW/LRKG1X6rx4R8z
         q8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321003; x=1754925803;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqdX9vSM7eNyAqBUevvRqDXoCJdSwPaqgVdWOxEJdM8=;
        b=e6KeEm/Yui68vTHNn07RfVuxgeVPJcQcdBJdAjxf2Yv2asSTVyPDqqSVPkjz4ovkg5
         j0yNA2oknDdbrUORhZu1lV8mT8whI66lNFkFqGFdYrI5OmcXi9YkGWyyza2YqSQmlap7
         M5DJLiWiL/zIFAe1nduYNchDIhuKamqrg2ROubgf8p4NlVlDK7KPHlB1uciLaDCZhlV9
         NDD/1mfWwwps+hhykLTuPH8M3ebw4iw2aiTb3AnsO0H4vC82S2OWb8npsqia2+kMESM9
         d8MqvbshwAvYaREdGcfDCc4UkvXWXOqwj61U59KIivdTYw0MPQGkhbk2/yeVf6WywqrD
         ce4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTsRK9vFRLxoJOzO86a9Wz9wSx6IjDKZiEDHvne3LExnxg1QzFscwJ4gOWxkr13cBEwUa342nYyxv7yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr97OKaBDM+DQadUEcmZgtXGsg+/181CPJjIWdjBoVfeOokKNT
	84o554TO4a2+o1E48WpbWr4uwuVHnCsp8CXwDiO+H1Mz6bsKldGIu7fNlVetWNA1ODVRhlVAj6c
	Jpn4z
X-Gm-Gg: ASbGncvts8vZ/Xbmyx2KG/O40nYJSwORfssxg7itwyElC+PZYJ+OLwJwzm3SkRcdqQt
	8vCwP9dE2cZ6QxAGsIv0eUXTWzEgc3CYvBuZWiFa0L0DisRLgdz/evBIYWw/EyXsGocGbFh0SRn
	l5JyvhArbi+vYiIUY7kdl1StRd3rorC+hsz6ZxzvVqiZLVcRb08EWDjBtQHMTTxVg6nX8J7Vvgm
	XmCGwDlWoBky2PkE35P0d8Z6rhEZGAsWJR8GIO2IwoZvkeV7wi6W/vG24cnUuqaLZSPKNWaOy6Q
	7pQEAzb1BQIAXLh4dzXFXGLLj57Tn9R16iKbR7MRQt9emQJDv8ZsplsYGg9vZBLmw5tltTDTEcN
	uIuS8EbFTINpm24sPQldeXoaF
X-Google-Smtp-Source: AGHT+IFO/lBsZcG6giK2HvXNUrdqdWnLNJxiI9UMe+z+3+FeG+OeKUvDv52bgS1CZJVtM4/52xm9Ww==
X-Received: by 2002:a05:6e02:184f:b0:3e3:e732:aef6 with SMTP id e9e14a558f8ab-3e4161c8834mr200857775ab.18.1754321001188;
        Mon, 04 Aug 2025 08:23:21 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e4029a1553sm43241475ab.14.2025.08.04.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
References: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block, bfq: Reorder struct bfq_iocq_bfqq_data
Message-Id: <175432100029.20578.5554580525847774271.b4-ty@kernel.dk>
Date: Mon, 04 Aug 2025 09:23:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 02 Aug 2025 09:25:59 +0200, Christophe JAILLET wrote:
> The size of struct bfq_iocq_bfqq_data can be reduced by moving a few fields
> around.
> 
> On a x86_64, with allmodconfig, this shrinks the size from 144 to 128
> bytes.
> The main benefit is to reduce the size of struct bfq_io_cq from 1360 to
> 1232.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: Reorder struct bfq_iocq_bfqq_data
      commit: 407728da41cd6450cec6a4277027015a75744d56

Best regards,
-- 
Jens Axboe



