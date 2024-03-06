Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FB137933
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739331; cv=none; b=g35OTsV5cSyAbv8bwTaqB2Nvj7xVNtP7+IKb0sacNN+Vgdqx55/smZTYcI9K9agXqB033e5gWrjKPv6tsyUhlPhxuofSXHwCJJ+Ev1vA/eaWBi5Is9fF1ry47V9vMMWe1A2cmieFTdEkg0VJgAr3I6Ai+0fRU1uQvMr0awm1lBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739331; c=relaxed/simple;
	bh=dZsHluELpxThA4ufzRXLg1tsWuDW0EQo81tF4SvlUgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DCq4DvVeEYEBdpat127wgsGDCglJBj/2CD8eCtr/KdfRc3rJIiMJ5b2h9UZMHqv1DfB6skrT9v/bTPlZ0vsbwFeJQeejZixwPNwWWpdJxMfo2WKn6EeEs+1UfayBXBRWbyrOmsJgAPEAFUy9iiX3mhtkqKCXMaOKnkSaZwq5J0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qs21YGN0; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qs21YGN0"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35d374bebe3so5646385ab.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739329; x=1710344129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSdm3xCNOw5L3H2ytBNDBWUHcL57v7ZuHcJR5VEh1eE=;
        b=qs21YGN0dtshHxBrRyAEeniJksLrWeGfp8udtJJbn1A3j7eW87/aQipDtUHdVM4WAI
         ktjGl7lcT05fjMw5MQN3de1AynoKhv7JoHWCdJpECdV4aAibNWU4ztUqauEFYJJCOkCO
         gDkd+WTEsQ/jiqQx3ZUJNWUe7cbs8JwYtc5HhZyRcyS+HWNTr5B8/iu3HY4NPWMELVcf
         Mmw7cR8OstCgjdwPh9ssqv5Hqg3zLBVtFHHd3Vn7IjlNm6RKRZp/AGgYiDiAeoLtdTRL
         uTrIVTS1p7bRt+gaqptVChRA1k04mgKDC8w1SzLVk/A08JpG6O4AEKV5+u7D1rHhARRU
         PNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739329; x=1710344129;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSdm3xCNOw5L3H2ytBNDBWUHcL57v7ZuHcJR5VEh1eE=;
        b=aWIPzNOdr/mnNaxkmCP+q9ePj0s92u9MBKP9e8lxvi+HqvGfZXcvaH6O9YYcpHbdgm
         63pFNUU5dHMN1GQsNM9ZBXskgdM3WUr1NhFam9q3yfZ3XvA54ozie3c5F1y2LBom0e6h
         c2GX/hUNoruJe4Nl1lsh9hayybDjbVqJdSvF5iqFJXAuFz1waFh1DzDDHJdFM4hieLXI
         m4XtYgX3vMhdczunoYM67a34FhJgcRbCHgVbij/QUcOVv2rBcfgfmnSldKdndq2EVgmF
         yB1QvfeGat0O+Ewpj/43iUoih+e3icEWYZIDZPBS4QY2pxckioseiG0z3MMYVGcLCPrg
         9Y+Q==
X-Gm-Message-State: AOJu0Yyp7zpeneJRFhPXioB4737N9YBgFI/f8KmrewjFbqH09CWT6ALp
	htYv+XG1omXstQsfUeoBwKmZHn7ybaliljexX6tBbDV95EhVEKvyKw4zUv++s54=
X-Google-Smtp-Source: AGHT+IEZTHfIPT4859zUUwoBO7opktZe1dXZGddcV+g22sdFWDq2aD+qE5us/9CWULIsvAEGwxSDkg==
X-Received: by 2002:a05:6e02:152b:b0:365:a792:3749 with SMTP id i11-20020a056e02152b00b00365a7923749mr3880459ilu.3.1709739329270;
        Wed, 06 Mar 2024 07:35:29 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li kunyu <kunyu@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306101444.1244-1-kunyu@nfschina.com>
References: <20240306101444.1244-1-kunyu@nfschina.com>
Subject: Re: [PATCH] sed-opal: Remove the ret variable from the function
Message-Id: <170973932758.23995.16246146995676914461.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 18:14:44 +0800, Li kunyu wrote:
> The ret variable in the function has not yet been effective and can be
> removed.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove the ret variable from the function
      commit: 5f2ad31fbb18565645f121b413837f260748e963

Best regards,
-- 
Jens Axboe



