Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23A1925B7
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378174; cv=none; b=OWszOwzAfRJ7ikw++dI4Oe41eEWDodkkewfK5IOGC779k2AipsnFhQkdUmME1KeukhSAFuAeGytDJK7wZJH4w147Nka1Kui3oVFoDL9NArvTYcH7z5cccbeHtuGFYzzcx93H44oc+aOrhCWB6j2OOL23G6n0swhALiTvbS8c1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378174; c=relaxed/simple;
	bh=tC3NOAHdyGWJ9YC7L9GT0qeaqFmOP+8AUkRsrxreNJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pP9qQSQboZ3zrwQ7m0OK9BPgTXwVuanwS4jRRrFFFw1cHVzQDLPrCW88Mn34utrVz20y0C3CxO1Nc6FSVKK99sOqJNzcW/UxcS+5R7g+Au7DeN4PfauzkJ+ONVVCKWnAEgfSyC1amAtdIK2kYZnSxGGBAg5Kp4pVuRxov82o+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OKjB3Dkc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OKjB3Dkc"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5130832aso2322114b3a.0
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729378172; x=1729982972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDLCgCpKoQkTM91QDaTYAvubvHgVNTOrMhO6FkwucDg=;
        b=OKjB3DkcR56DH7HV0QfvZN3byOpF2jwZVx+4fVpIpCS2awbOTkrwTIL/Lc6+/YoMo2
         AS83wlg5Hi25b+1LTuBB65yc7ZQX+qapnM7eWcCYi2K7QTl4kofch6D62B2tZB7VwBV7
         DN6YMvFMH+Ru8U416NqEX2Q+GMgUVXG3lOWWQDWa4byAsodntOzh1A0POttqK91cnVDe
         gUlaimhRZ6QLrO7xfmjBmYhzksWNmVoCz3/DY2s9j8FieqQRpmD6aeQ2DRLt0snh75zK
         WIVpZYyHq6wvOgWtYyjdfm/bUaMUFMCv/bIw/GacBQw3aBYUh/0Mr6Ew2vgRALyIbnWt
         NFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729378172; x=1729982972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDLCgCpKoQkTM91QDaTYAvubvHgVNTOrMhO6FkwucDg=;
        b=cPw31ZdjT0kfwySLMvMiWlRIypmPMCgjvr9jx3a2s8iPsSWOZX9gzQe7VCBEb0Iyu8
         VDjPV4bwLQHzP1P2IqO9WMBJXg+KAsIrryS6DvNJmKZ7bOCz5V+J9aDmRxGxvwj13baa
         MSJQlz6544RG/dq0M4vmzMYwon94XuqI7xf6VYCOPiTEO5gdaFtOO9/Q51h8CwLAiKtM
         6/TefJbFlV8eJ85GnpjAUhnIYliq3AKUSZDBiLe6z9r5bjVnXJ1H/X/DXPD95n/dg/Fz
         dBGZonMMawbhtIlGDfPVxsCmG8cP52NuU0JtNrxZIyNnVME8+w+jH1exDEQWKOGumjv2
         R69w==
X-Gm-Message-State: AOJu0YxnusNbAoAsMhbVQAiCBSa7BeBKYZScsJeGIBIxiTHEuUICOugH
	dsqTBMWCUSIPbIcMYSeNeX+sfHPwFisEuvEcQXgrBThzP4nbc3pVJlexLmx6q4s=
X-Google-Smtp-Source: AGHT+IF/fPfuz7cGAAVIxgF5EhKVKUkBOPcwAf5DpKAxdXccPkrAnIOvx5aD2I3mbdQgdcPPznndNw==
X-Received: by 2002:a05:6a00:1792:b0:71d:fe64:e3fa with SMTP id d2e1a72fcca58-71ea31e4c3amr9768365b3a.19.1729378172298;
        Sat, 19 Oct 2024 15:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13128c2sm240091b3a.33.2024.10.19.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 15:49:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk, 
 jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org, 
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de, 
 martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org, 
 ritesh.list@gmail.com, ojaswin@linux.ibm.com
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Subject: Re: (subset) [PATCH v10 0/8] block atomic writes for xfs
Message-Id: <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Date: Sat, 19 Oct 2024 16:49:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 19 Oct 2024 12:51:05 +0000, John Garry wrote:
> This series expands atomic write support to filesystems, specifically
> XFS.
> 
> Initially we will only support writing exactly 1x FS block atomically.
> 
> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
> atomically 4K+ blocks on x86.
> 
> [...]

Applied, thanks!

[1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
      commit: 9a8dbdadae509e5717ff6e5aa572ca0974d2101d
[2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
      commit: c3be7ebbbce5201e151f17e28a6c807602f369c9
[3/8] block: Add bdev atomic write limits helpers
      commit: 1eadb157947163ca72ba8963b915fdc099ce6cca

Best regards,
-- 
Jens Axboe



