Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5A25632
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733543649; cv=none; b=jQan0p8rHnGjR4FkDm/OCNCpD2rNIhwD1mNHLNtYWrVZhPjir9FabO6TJqF5wPdcpLQRzxpfJ5ZI5ZaK5tgCte1WetQ46PFZTOkNiBApYKNOPyR6aE9pJvYORIYQ+/bBitLlduZCHdBWwsJZpatY23Zy+bdQgAn2DDI3O27F0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733543649; c=relaxed/simple;
	bh=zt/AY19a9rS+2Zt5kBZWJReZRHJqEV/1KPhanIcRYcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtxJCG99EyisVdEgr8DdrRIQZrAps1q4nBEDIrRPlsNbw9t+SeKxb3V0nSDHY+HpQ4D9eAoJKmmUlEugfDrEz1wPd1e7yZ1w/xEpToZbxLzgPXTBfAf0+Nc/QbhQyQyX+/yPgBaBzGVUHkpnLigOZHcVNi0Jbsc1eiuI05ibvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zo388GuF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zo388GuF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cf3e36a76so24011955ad.0
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 19:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733543647; x=1734148447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnChk1JFxJG4/Y3+Tk/5Aeyux9ylHOYyGJ6VC7beF4Q=;
        b=Zo388GuFGBXuHQglkifGi0VAgd+pHm++3QLX4fCh8O2p9/0qp7LSVEEFNUL3cM4B0m
         d4ptAKc1xvzRJ3dEljLwz+xXNJnFXYpGnViyZvIe9SANFWthW+vepTRY/0NfmcolumXR
         D7+VYmpPSgc3r27Dq8w0xflqvv+X2bF7qYuU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733543647; x=1734148447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnChk1JFxJG4/Y3+Tk/5Aeyux9ylHOYyGJ6VC7beF4Q=;
        b=maGERHnJET6Aek7gxcqlPB1Fd0d5fKUXivPkWjZEIdxgxrTFSV6LoERYrAAUWCabaB
         K7mUnrX1RF5zWsnFygPFuu1O5+4Co7z2ImcCy2tGYVm/24O+6PdCoZSWZzZviadfsb4X
         FC3blg5u6iX3eyelkvikaot4mwhvwaq0q59uUhdOt8TzY6z44lL2XLLAD/6MKy1U5unO
         WtzSNMuZ6I1jfuUJrJ+oBkoTJM8L0cq770+m3KUDkDlJGKhRNnEwOef8lyyg/2aryWYd
         eR3300IzyB+9/c69rtATmCCT+zAZ6up17ui4llUx2E7tejbEiQsWNO/MC6kmFXm9nNL6
         +cEw==
X-Forwarded-Encrypted: i=1; AJvYcCVJs6eRYDsjMQeN9Vw6WXkna3/XfQxoMXtiNSMtiB0WPOSQuwZrqz0veQCG+k9R/AiPMFVCi8LLGN24WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhVQTXIqxE9eCvwU5O+Zvlja6UFArmfUhhYCTD+u6iO0p2gpL
	3g/tmVWTe9kIyEhcefq8fjq3lubRmZtrbaKde3+ZlGmxp2NcU2do/nzUSeyFnQ==
X-Gm-Gg: ASbGncshkKaAA6k79f2x3Wruzn1cKRIWYe1Au8Y5k2Xcs70wkvw58xOBp7ZaZa6w1Va
	qkNRLCwuc0s01IKgT9kTIuvhyU8Z34B+VIlbYCnWe9sCO57dpFFSpTXM5Munc6/6aCRa90vAx6E
	OlvhWov3GMK8IEgYGXbpNNUlJt+F3IsATeF+JKiJaplGrBTdoCNez2f/WKP8fyQOt9kvPXn5wYQ
	aFS8CvGRGz7DhtjYfyxIwVKqsO+wh7Pm0tIhBgWxajjhCalGglZIA==
X-Google-Smtp-Source: AGHT+IFvc2c4aVvUcqQGdjyvZcOJtfWvmVZSN/6sZMOxUHRpCVuiv5PO6AkRFXuq6PIE1zg6wjh73g==
X-Received: by 2002:a17:903:240a:b0:212:fa3:f627 with SMTP id d9443c01a7336-21614d457ebmr96715935ad.16.1733543647100;
        Fri, 06 Dec 2024 19:54:07 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1ca0:173b:2684:b413])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162bd6a645sm3173085ad.119.2024.12.06.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 19:54:06 -0800 (PST)
Date: Sat, 7 Dec 2024 12:54:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: LiviaMedeiros <9@cirno.name>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: make default ZSTD compression level configurable
Message-ID: <20241207035402.GI16709@google.com>
References: <7d73e19b-f264-4c31-8f5a-fb17b6bc0600@cirno.name>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d73e19b-f264-4c31-8f5a-fb17b6bc0600@cirno.name>

On (24/12/07 04:16), LiviaMedeiros wrote:
> From: LiviaMedeiros <livia@cirno.name>
> 
> Add support for configuring the default ZSTD compression level for zram
> devices via the CONFIG_ZRAM_DEFAULT_ZSTD_LEVEL configuration option.
> If this option is not set, fallback to zstd_default_clevel() is used.

Please let's not.  Then somebody will need options to .config c/d dicts
for zstd/lz4/lz4hc, acceleration levels for lz4, compression level for
deflate and so on and on and on.

[..]
> I also failed to make something like `echo "algo=zstd level=9" >
> /sys/block/zram3/algorithm_params` work in runtime, but I assume I'm just
> dumb and/or it requires extra steps.

This should work, but you need to configure algo params before you init
zram device (that is _before_ write to disksize device attr).

E.g.

% modprobe zram
% echo zstd > /sys/block/zram0/comp_algorithm
% echo "algo=zstd level=9 dict=/etc/zstd-dict-amd64" > /sys/block/zram0/algorithm_params
% echo 1G > /sys/block/zram0/disksize
