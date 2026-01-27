Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02D35C188
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525820; cv=pass; b=SkQ1pS5mR3VpprPG1QiMudf4+C3Hn+JZ7J+thsm+GuGXJQpI5/aSeyNnBAOEff76tsKQ/CrbeD6+7/zBD2SVb3wDg/zc/3fYoIAHgjVsROLpE7T9uJJ9+0ua8Fp0ex9Ys2XrOxxY0k33OxmSjHhqxQYrDr52aTBH65SeMwlvVSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525820; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULszpCLD6XfvOyYN0T6IyiKAsxwGiOXjoTpWT3ZwfTzkpuVQCi2cCJX/hiHVA9r340qdZAIU4cQKVFS9FMuZ0b7fz8nwM6uoRShmqM0Cd9nz0Oa0isWNCo3isqI6FmZZXDsnm7NrcMd5SVgQEqwt+QOFgy7pGK/zsCDRfQtPo1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGVcs7J6; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGVcs7J6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so9840342a12.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525817; cv=none;
        d=google.com; s=arc-20240605;
        b=k6MZ9S42sU9GUy8vFWlkFrAuykT0nSMC12xVn94zkJiiJYAtq7SiZdcx7s/7yapMWk
         OCXsAj2d4xY3wAg5iozlP1mQK1wPEOp8fKeAQ6mWrPjilgSa8LwIsU7/N/ofJCmafB1N
         aUpyH7MZIwMXwDEo6hV/vLEWAUsiWsK0RjbU4oonEgAs8Wlt4O/byYwMh0eHjEzyfIsA
         alMiQjRfctLGEna2plZQ4wtRWjoBoneEZuNd9QFLglrehVUUvT/YrPdeEz5kGhcxgyyX
         AiPLhZLG1pGjlbRQLgEVcxRs50VzKPYXhjpO4qOX7e5ATF7YJkTsfy229WvuJiqiUzMs
         AxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=woNLJzScVKwmeoVd1XBmFhrq8wvhxaQBtHMlbzevh1g=;
        b=Sj3bLDspQ0VAC30fhR4arHdQZHU1Df+p3+m/3cXyWYd03ZYSwI45ctQC89sY5if3LW
         uEuhULqDvwIO+GVI/5dvdXE2cPGcOGYnQPL+uD+58/QUIky2zUe7mrI1x+iabv/JXTVB
         OBIjSr69vDsvORYVaVr9/X5skZkcswdUaZ+TNwsnRkm31cewDH5vKNYyJx/3Z39UmkzU
         7r3B8c40HiydOFADwbNssO3DurEGqKpN4svhyMRIJcyQv1f8eLCluKnPbIikEJDYKZNf
         kQvegeVkGo91vx8KSbWghgrYw9sHcNwD6Gq1uwLy75t+jowkRm7DoJ5kf8CYYCuyqS5d
         3I7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525817; x=1770130617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=MGVcs7J68ktxy9ICcsWR2V6AWM/FCmhb+JcVHOsy8/1lUYI5u3hh64Txijg22Mj8yl
         hA1dS/XvhOQRCr5Xyc7CFdlRyAmbSDTR/11H1W0wDhAlx7dEfQeW/xFkm35QSc9eHkMd
         b2bGDbcKeUCEOmOE1afLn+OgAJtmAHyRX0Tx8vLkOSvf9uJM7NPbi59Z8LKoYER1Nilj
         t6mswqQSR/B8gnzXgSLSPYcSpJZHfclekhaAiS4ejVnXEJ+MVaDYz7df0tKLfETq6q8K
         /X43u2T21VhlqAWxcEhbfo248SQzs9o18+fLsRThiKULs92JUMU5Mc8cYcm32+sUFEts
         Ha9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525817; x=1770130617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=EMulnOiU3OE17LaAA4P6q26GSWPd3iNt90yu8CtM9p9x9eVhcBUqExuM/dVAmNVomR
         z5pDTCpU3r32CRJZ+ZQljYCS2sKva2cADmVhv4qAu4eeblhBiIdQGKqyQn/DTqcLvnHL
         RdF+you0DccHImsJzQMsd61BXVH2ek4HvKekc4ZJCPwACpbjkcho1R6YkwQXSnlXFSmG
         eg35J8Z0j+wzaM31LWHpsJDSgTEsJHYnfNeg/ZCCm3YzDFzrSfJSrr24Kftdn32YZKSR
         gomDRe9cjPwJnex0FRld8qCCDSs2q6Hd7SnMj8Wnm3nrhRt01/edd+tT0Hyc0lRZV2F0
         j02g==
X-Forwarded-Encrypted: i=1; AJvYcCUt4y1sh+i1x4RrfN+Ijn6TdpJ/payIFGFIvbQMJERLtKy6CvSk2lnKBnpHft5u2Mo3VC3fHO+ZAvUXTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48OTlQhD0f1zyJ3kEKmprWVJxOfHShb0xQeQLqlm1r51aYIJM
	tCez8FFoQ4heFVzA+y+w57WECGpyNAV4SdFmYdMM6UUuBwD8uVuLhfbrQNLNJu8m0mSSYJquFLk
	iAy5/LCZ0xbfdZNyJW7C2ps3ndoy4tg==
X-Gm-Gg: AZuq6aKEbIvqVMgHtJaC9Oijgxs3cy3JPFaGyNO4Fd9i3ZV9wG8GLHcNfSEpb5aEPVd
	oM86D6Mu3D612SBNJU3uGgNZCzL9GjbtDW2jBp6u5djKxdwpKVpJs3aWM/lL5ZkxgyYKvIAnzqP
	3fG9N/5YzU2ZBcJBav8Tw/Rfo2v/9lRmJJYBO6IS82aCEht1IJz87unfmZrFUXc0TQP1WHGfIPu
	i7Io85SM/OXdxc5cpExQd6WekMDTKOupAg3xH7srGLaluUDyjm79g2yPZD2EDXaSLCGLWW00Hyu
	xSa9MIcuElqLq4wR9W+gJRmzdNdnNmXAXFvEOteyU4bcfzl8Om0S+PrgIA==
X-Received: by 2002:a05:6402:13d1:b0:64d:23ac:6ca7 with SMTP id
 4fb4d7f45d1cf-658a6083d59mr1404674a12.20.1769525817398; Tue, 27 Jan 2026
 06:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-5-hch@lst.de>
In-Reply-To: <20260121064339.206019-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:26:18 +0530
X-Gm-Features: AZwV_QiDlPiwSdA1exwb_wyngdPHkJQcFo3xsAtPq8Ggx0ZleakNb4Ga8U4ZEd8
Message-ID: <CACzX3As2YHwiBXwHBTh-QHTc9g08V_tkBXqUsKCin8UfrgeLuQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] block: prepare generation / verification helpers
 for fs usage
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
