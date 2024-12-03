Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA057207A3E
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266591; cv=none; b=JBu/ArdydUM+GF03Uq3XHw93oylj7ZRSqLqlgW8lSXOK5TJ5flbSI783yaOA35FaG4OVguTwDLFyF7yveO7CvEBiEBeLa6FGWAFsPFRTDKiTCnWXCL6gZzc2j1mydpHgYqGfBoicg0EHk5xXzJaz/moa5rB4/BWnG64wXY5m6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266591; c=relaxed/simple;
	bh=9J3YtjJVaIzs2sqlqTmw9Ioc2v4jB8siZkMzuKRLfIE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qYEXK6XVgqVUQ/cto6Bp8A/OVozm6SPLRicBWk7khR6tleZliapVDLdAm4/mXPGUIQisRS8fSI1olqoWdgJl9SZalcmic/9b54HZNI/2Oy6aikM56UMnoeDZ4YJX3lZP3A9n5vTjDVQaljqsISq/MfF+3RbZatKT0WMMWPqPwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KA3rpXIt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KA3rpXIt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7252fba4de1so5369560b3a.0
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2024 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733266589; x=1733871389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNuRSE0qt5OotBDZPQRc+y7yttPjFAS0Rpx1zXr0078=;
        b=KA3rpXItETAFyjPwew5p1REjVcnq8+5bDecMBk3+CYYzviVr/D9nYIn92Z0ph6XvGg
         Ir9G5OXm+yT4kHkLIl4QBtv81V1F0z9M3ZFywQEsb2Iu87QkljSExfVAvj+/KVIOoAfR
         Ey0CgrHQQXA6g1phWixmwgRU1grS9dLN6MWiurHfFPxJhmqFJXD//VrqrlgHfP9eFBvx
         b1TBY5eXB+VhlkPh1m2AwQhDKQGuWyWc0PTWUaqpdO4mlamOAbQ9hJWqkNINygxqeBgi
         /nIwn6iUUjq9OzbNqJHxXILXT6aEJ7RD6lXkl4wigSgEGGH26bFoO3ynazxf11cAWLtc
         JuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733266589; x=1733871389;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNuRSE0qt5OotBDZPQRc+y7yttPjFAS0Rpx1zXr0078=;
        b=RcWyMeiw1ty/T4W2E3RXKQimz+y3FPjcyp7aYrinyGbrUQkcl0zaVLgfPWI1jDeQTC
         FbxSyIJlBt8wzM670WgugtDdUg4KmCEEHAQmVLekak0niCf8afoLxoEVfApnYS2mtKuH
         WY7O0sLv3low2FTBAs1JGGQd8R7rmkcMXQoao6juiK4EbkBQqGfVFQiAvu3Yt7D4HHVn
         8Nm7MR1BcsdG1mJ4Tdwjswoz5IYYJb+sqFmuvhJDIyPZDnPOHAqN/1/umOh4ihdBuCzH
         J5u1B1TVIO19JleDCVBUUvpB4xn/ESS/gMUwLnkSo/Y3ooVEAkA8dxrPhCwvTC9Hi0+L
         2Gng==
X-Forwarded-Encrypted: i=1; AJvYcCWu2l+lQtWhPh9B39oLb0SVAGppM5RLNHHyDw4WWhNkTIdNSM99EqLTxjXnjDoAJdB3T4GgHilU+tS49g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxwHKO5D8/Lh6Ja5dcOIaF4dgXjZ1bQVWTeye1gspxNsmr5Clq
	3KLH64SUy7wCUGGHYJe8vRfvjERLw70iKvmuhUJFNISHQXuPXpTsYnptDa3wMOk=
X-Gm-Gg: ASbGncuDAQGVeXXANV8eVpwWOUqjPey6SNrss5kplSaG2a4E7OZySUq5cRCGGtw2xj4
	G+FcYyY+0DQcakiEhYH+vZeBHbhOppNGRfavpDGA9PMt41H7Ndzfo556GA1/x1A02t7ViSNgAQE
	TRRQM0zEwCPPomd4sBVrUeTsOU3tyolrhy+VE5rDo/ZTvYFPLYsIVZSS99EYamUHePyc066egmO
	/maUOQc/OWiPKMrK3YMxr1UlL5mJoayPqyHCOyPOyVL5P8=
X-Google-Smtp-Source: AGHT+IFwbu5Mn9fY8ujvfbEmhblgpduelrIHva3SSxokjUMLrmvWEB884oPumQCB8f8AE8L3tnBedA==
X-Received: by 2002:a05:6a00:14d5:b0:71e:60fc:ad11 with SMTP id d2e1a72fcca58-7257fcb04ddmr5761701b3a.16.1733266589105;
        Tue, 03 Dec 2024 14:56:29 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:c150:9b72:bfcd:78a4:798a:3876])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541845526sm11049954b3a.171.2024.12.03.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:56:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 Liequan Che <cheliequan@inspur.com>, stable@vger.kernel.org, 
 Zheng Wang <zyytlz.wz@163.com>, Mingzhe Zou <mingzhe.zou@easystack.cn>
In-Reply-To: <20241202115638.28957-1-colyli@suse.de>
References: <20241202115638.28957-1-colyli@suse.de>
Subject: Re: [PATCH] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
 again
Message-Id: <173326658691.273410.3875499792580275735.b4-ty@kernel.dk>
Date: Tue, 03 Dec 2024 15:56:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 02 Dec 2024 19:56:38 +0800, Coly Li wrote:
> Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
> node allocations") leads a NULL pointer deference in cache_set_flush().
> 
> 1721         if (!IS_ERR_OR_NULL(c->root))
> 1722                 list_add(&c->root->list, &c->btree_cache);
> 
> >From the above code in cache_set_flush(), if previous registration code
> fails before allocating c->root, it is possible c->root is NULL as what
> it is initialized. __bch_btree_node_alloc() never returns NULL but
> c->root is possible to be NULL at above line 1721.
> 
> [...]

Applied, thanks!

[1/1] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again
      commit: b2e382ae12a63560fca35050498e19e760adf8c0

Best regards,
-- 
Jens Axboe



