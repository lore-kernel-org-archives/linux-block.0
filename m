Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A51D0178
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032611; cv=none; b=Fzd9l/QCn6FSsFcDT/8cV2JlP20a5SAiyTyU7xKK8FrhCr0ZHRlfaKz3yflVhKWNSr0u+pn0IUopM+4+xwphdBjlk3Irs5cUp3jrBzq6y6Ulqzp1vzQ61fAP2ZnTGXbwTkHfVs+EJbcrzYocDxYgHcY/8vBiGtmFHR43YuEqgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032611; c=relaxed/simple;
	bh=xt3wwJ5NvMUdDjRlDMBZlIbezTTufL+YSlr1ll0hEbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I5yuvkdx3Pk2HWpMjWKDHU8sLO5I1BX3ZvHpSVR16KAfVXvr1r1CaSkkNtJZZ12giTf7m58vShywZj+cvS0t0VdUOj2EZ1N4E1rvO7KGbGEMsAWILt1PMYHihtyGH1aUfyVf+JtEfm/gtLsyfm+Uzycq3ZFdUcRzl3tz122d3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uOHOXRD2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uOHOXRD2"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e63e5c0c50so2157964b6e.0
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732032607; x=1732637407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEf9c/uvehCZKaiwpCrurz3/B7XiwSAC0XMxl2FMkDc=;
        b=uOHOXRD2X/Os05n6t0N3DupI/K7bKZAtujvcnG0Aoc/rg32fu3nKA8yRcgS5IAyqTa
         TX0j99Ryy56HIHN7E/2OWfW+7lKu+uspfC7+qDnu8vP2qpeZGCPznlIHGIF2/IdlZrRF
         eOvK9dTo7RA1VmaIFFdual1DBqH/65/ru0/phvnZrMi1Wjt3Ue6MGAjitR4SiFWmvE6M
         20dHUA8eT33HWSFxoANx4Rfoxj9Ue8y/aQ/V6dChjga/wZpsnFacS5RJvKOm9T7Clw+Z
         0JN5+7HcUxxT/HdT6Jg5O5Lix5aSxcmQE28qPCIyEwsw4oCpcY0s59CVJ1y3o5L9LN0T
         mQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732032607; x=1732637407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEf9c/uvehCZKaiwpCrurz3/B7XiwSAC0XMxl2FMkDc=;
        b=eUV3J7mp/OK6zdRmzTUVbvVxqLWsAxXGjXG9n0NM+mUmX1n17CUiQIbQV7WsKP07gJ
         NAHgaQ2flaeIB/ARXKE05H8aqLdT7hCcqq6GiWLjXoWJ7TBRa6hA0PX4dRkulOgAXP3O
         s88cX5qQa+CtGPLONeE0XZIGkyN9uLqQ+G/vAIre8NbRlWdHSHrFqLdIoP6Mrjo8cGZ0
         j3SECwxs4ItUk25IusKqwvKsLLIhHLD9+Dp3RaWcZ1V4/IA6Aa8h0EC90z5+tBnH0pYe
         7yfKvJZssMxCVGPmwoiBhyxyurq1xPLn/pguiOMP2aVtKa7/Z/uuuTUADX2PkBQUH7pJ
         iIeA==
X-Gm-Message-State: AOJu0YxWkYZvvsPBMhGzjFDIRbbe1pJ2WU8vEpnfbfF0NKscLmU1HcJt
	dip28PJKnP3ZkTo2fU4RdYHH03KNgXv9PvpB6hrTcQT5oNU5vDEJOpZYEedYDSDXQ5CDiq+hh+O
	pjbg=
X-Google-Smtp-Source: AGHT+IGWFAtDTseLe1huKjpZLLT5A4P2xr21wzta5UFPYSkfiz0dKI2snEN5q/zucE3JZunk7omwfA==
X-Received: by 2002:a54:4e90:0:b0:3e7:e19c:5603 with SMTP id 5614622812f47-3e7e19c5606mr1701963b6e.3.1732032605753;
        Tue, 19 Nov 2024 08:10:05 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd1066bsm3636923b6e.13.2024.11.19.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:10:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241112092144.4059847-1-john.g.garry@oracle.com>
References: <20241112092144.4059847-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Drop granularity check in
 queue_limit_discard_alignment()
Message-Id: <173203260485.116632.783314521194431781.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 09:10:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 12 Nov 2024 09:21:44 +0000, John Garry wrote:
> lim->discard_granularity is always at least SECTOR_SIZE, so drop the
> pointless check for granularity less than SECTOR_SIZE.
> 
> 

Applied, thanks!

[1/1] block: Drop granularity check in queue_limit_discard_alignment()
      commit: e924da7d6622b72f9eee78a3aad3e75b859da341

Best regards,
-- 
Jens Axboe



