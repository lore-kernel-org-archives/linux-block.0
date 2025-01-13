Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3B23A0FB
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779659; cv=none; b=HPZKukboaPjkBhvvFLgNurmHgACsWh2VuRr+OLosOFN/8K2Yv3mL8wJq/0E+Epn9yS5BYmpHwHP1Vu1uUipi+ofEBlaXR/GseMFL4RSRBtpBG2RZufxlHqp0iywCMem2WI263MDKb7J4chNL7LpwiXFMjShnC8msVDGCQDOPyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779659; c=relaxed/simple;
	bh=p0BXD1cDpGkYrf+027N1x1VbIUDOfys+SPBpQckVTHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GGdOewmFw7gzBXUCFEaMpaSVwEJWN8iOmqF1CgPes8jrxUdfWnFtVjlKO+L09sX3UyxYfUIjj94mqe3KMX4ISOemiphdbFjRHgmO1pJSpagcvrd1sa+6GyFID3SLO/SvXyZHEZ3TOlKgqdwR5fU4ha7/4USbe+HvkDoFSyGzi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WimVseVs; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WimVseVs"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ab29214f45so14030445ab.0
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779657; x=1737384457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUvOyHS2pnkd3Ntgdf/L4chMotMUTDYlGPzi1HeruzM=;
        b=WimVseVsy6vNKsi6RB67d7OrlNFJUxbpsOqGJIGwT05sMlSsMETQCtjN391RNNbmlp
         uXWzidEtV7Xjcuhymkfqqp5KZ4sgL+WVNRDHrkhedPOo+0ZG4k3mF6pfNIICuAnDHgGc
         9ml4g9CPdVhFOj5c2CQs26QqoVJKtKIc1qvCU3hcFPXpT39ASoB71oznyeVAU5BhAgES
         yQGWHhMlRUsbs9y0MiB6Ufb7qXMqMt5N/iJjmAzSumDYaGCf91TXfd3ysak2TsDVvVT4
         u13aFqGTEIxbtD5z0k36XGY9b0fTEctqWo5z/nqW5Y0PvknoxZfik89xtx8QmVKlKeD4
         BeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779657; x=1737384457;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUvOyHS2pnkd3Ntgdf/L4chMotMUTDYlGPzi1HeruzM=;
        b=IsjhkF7wiT6uCym/oAeeTQM0oybTobWARmIlu4tpwbqbzfMj1b0NqWpKXb0AiOlFUr
         l0KWxmOSsqXbLQ+tONqYMVYDQkNCjRBBW+gkQhosKANvG25V6mzdkLmh2hPug5oQajXr
         a2/IF4hqgRaGPqTm/2m8D4upcfndsNw+ClUH2CNEBZDQDfL9PtE2pdq1JOE5vIfP6kJZ
         rGrStha0Cb1WFbsNhfLuEsfjuLl+nXF2FIy9fYFPgARZnYXVPJYPCe2kOWi3eOQ2mmO/
         saapd3ihkBH+pGk/0c73Qb1GbBf93p0CsNyrVPlI0OoAA7qxPBSQGStx0MZSgwtNrOrz
         i3AQ==
X-Gm-Message-State: AOJu0YxvwDrdhbpeKShbnhfI68ONLmpjcyJeY7QE+6QJ57Vb/GPilLto
	AtGg+B/owfGVWV0Gwr0PEMAnK9hJVgTsYqLE4jcUy9Mk5RR5NDMsWE3J4+4XiVBDdx36fbOPeL+
	z
X-Gm-Gg: ASbGnctpTHGdHve1lz1THpFMm0Y0DCY5pDlJskmFR2sUGNxpJIMu+BaVANtHI4iGGlH
	ql2ZzvGo8svBvTcCNH3KFMvFXB5yiFV1acrTKWctf00tWC24xpRF6e4Lz7zRFU/22Ls0sSfFmIO
	JPIha6BDcZnzJhTgzTTtdT5AXrLv4lBND9cDLYGn3pgky+Q9VPQmVngQTYbKH5XnnzBwhSxM5i6
	RZ1GYNBFaMuDuCqsONvZu2xN6yNq+MtXee0kkCgldpXHMo=
X-Google-Smtp-Source: AGHT+IELFBX2GUIlb67NreyyDTsoPhjczmus0/8OGSWz1WzZnOmyMqhnn3ZIOEmxmdQnJqW3qfAUug==
X-Received: by 2002:a05:6e02:12ef:b0:3a7:8720:9de5 with SMTP id e9e14a558f8ab-3ce3a9a50b3mr149381185ab.1.1736779657277;
        Mon, 13 Jan 2025 06:47:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459e9sm2768810173.118.2025.01.13.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:47:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org
In-Reply-To: <20250111062736.910383-1-rdunlap@infradead.org>
References: <20250111062736.910383-1-rdunlap@infradead.org>
Subject: Re: [PATCH] blk-cgroup: fix kernel-doc warnings in header file
Message-Id: <173677965645.1125204.5023386216499075491.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:47:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 22:27:36 -0800, Randy Dunlap wrote:
> Correct the function parameters and function names to eliminate
> kernel-doc warnings:
> 
> blk-cgroup.h:238: warning: Function parameter or struct member 'bio' not described in 'bio_issue_as_root_blkg'
> blk-cgroup.h:248: warning: bad line:
> blk-cgroup.h:279: warning: expecting prototype for blkg_to_pdata(). Prototype was for blkg_to_pd() instead
> blk-cgroup.h:296: warning: expecting prototype for pdata_to_blkg(). Prototype was for pd_to_blkg() instead
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix kernel-doc warnings in header file
      commit: 4fa5c37012d71f6a39c4286ffabb9466f1728ba3

Best regards,
-- 
Jens Axboe



