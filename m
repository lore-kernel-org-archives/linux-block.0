Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6A79CE
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640839; cv=none; b=B9lD0ku/a81kqw3Ur2o0yL/Hy6gQlAwSISTdBulYLoAi+XrVwk8Xf5mW0XW5rnmk4uWDdUHae8E7+8B2CprLbXvTUZJ8H9mdxXvvP4S7e4sCHLTI5VGlTalgetitifx1iGbP76ktFkOAkmvtQwnDBZ8cyJ+Lx46b6EE4pp0oZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640839; c=relaxed/simple;
	bh=lG4AstwQHH1UPS43Yj7vd1CcqTvn6WTYx+Zo+ITPMlY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BtrZf8tS6jd/OkeNInPI3NgRERh8SgwofaIzRaVWxBJAtLAPxMHymbhJ/xpkBvYyhxWOMT3ky4xApIJlunP6dzRmCXAdvrR5cmx12y3Be8b1D2L3JYHvGU6qosKjNV237Z+smgiGsQ50kBo4lWpakNAr1NV9oAFvpiaI9dA8e6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hFR16bk3; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hFR16bk3"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b3364995b4so349458eaf.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718640834; x=1719245634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKK8S55n49UmOkfkS6UU/8J6NeDkiHd5o0/R/Fqmf8M=;
        b=hFR16bk3C6kHDtctQYIQlrzSjRTmd2cjDbbrcyY+gNooE/jhi5FW5EbwwpihGwPTfn
         inKWxW7xwqpeAgNg/JDqgr1rqpYUtTLTy9Cdx6WJGsmT3tDMsZgNdwIMGOtR6s6YYh9A
         UBBNLsLz12UtROPyZKWliQ1y8etoz9DwuxPPR4HgkwbUQgGG+ocHQnGFguSebycP739A
         tW+XmjvJChKmZ4o08WGaLcEa5DZeOyF/ZTias3Nuu0cExjC9xwLDKBZ782vHMsdFP1T5
         /g81OS1ifxAgHP+g0+/+tAiZJJN+3/ObTadfCyqWYQ/gGrk42AvFGGSoY988BgVXmmQQ
         wizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718640834; x=1719245634;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKK8S55n49UmOkfkS6UU/8J6NeDkiHd5o0/R/Fqmf8M=;
        b=QHew6ESJuEe0lOelrWzgTqpo3WpQ4xeMvTdvocQWN4stHhFqg1a9xFzGH0PsAXdWan
         BwZhQRwT32K/QI2gbX1WWF20TjjrUu57hO3nWGZYUo3B6vXCCdovRGoPcW+47PRa5kcU
         FxUAJcZZCVMKQFNU4ikcsqi+J3XbI7C5h/2+iXh3uKOlQ5lsNa2TFAdTc/ohMFOwKvwv
         yokYMNascpbMp1Yi/r/n0spH5axk7VovcqebJMzTCJ9cH2LllVxhrFRLiSF0ikJnclAK
         obAj6DJzT4mJmZbmnCVCn8g0xkB18v498WbGdzQtHGSNYyzRkVPDVW1zel0+APL61EOU
         jS+A==
X-Gm-Message-State: AOJu0YwBHsWfMnk6t8lrmSOUMvDkc1kbhiYx5JeJwN8IrL1F0ekpWLDs
	fAAfB/qOED179Bpktrzdo+1PB5gSMsqqZawYHL9mqhYV+KdYCI4QgreBIzsOpFDD0TqIErjJqjM
	z
X-Google-Smtp-Source: AGHT+IHLJNEZjKK5pYPuEc1TlFmZdp5Ybayvjx5nlDvKs/xjDa5MMuGGnM2vMx4+ps31iq1telunvA==
X-Received: by 2002:a05:6808:150f:b0:3d2:1dfa:3d1e with SMTP id 5614622812f47-3d24e8fa976mr12547187b6e.2.1718640833729;
        Mon, 17 Jun 2024 09:13:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2475e5072sm1530334b6e.9.2024.06.17.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:13:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240617044918.374608-1-joshi.k@samsung.com>
References: <CGME20240617045649epcas5p1763924a49c5182f30a9ae3ea013390ae@epcas5p1.samsung.com>
 <20240617044918.374608-1-joshi.k@samsung.com>
Subject: Re: [PATCH] block: cleanup flag_{show,store}
Message-Id: <171864083272.5782.11471098439782133450.b4-ty@kernel.dk>
Date: Mon, 17 Jun 2024 10:13:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Mon, 17 Jun 2024 10:19:18 +0530, Kanchan Joshi wrote:
> Remove a superfluous argument that flag_show and flag_store currently
> take.
> 
> 

Applied, thanks!

[1/1] block: cleanup flag_{show,store}
      commit: b83bd486b43d2b7f10595a9d7a52d41023eaa9c1

Best regards,
-- 
Jens Axboe



