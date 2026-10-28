Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198677;
	b=jYLiZ179RsCiYkjUJQ1CymcZMTin5LjG/VMpgHiQQ6bICdYwQwg/cvl5MPtCkTgMj+1c
	 bUmakF4QckKU56frA/tBtsYdpHB/v4pZcZAxzPa0n+u9bTIzD3OBgcSsK0lwIjq22p3BE
	 Z72f5xXF4m/hmaxuMNDQU+i5TNHpbB09CfBj2w5W+5dTklHYczCH8aCphyVGjke2YU343
	 b4WMfmfBsWC5hf9VfOXchPKM2HRf89zHmIaiG1PWsz0xCqInLzXG45Hqjdq3bt9f1AJsy
	 24dH8hHzQuntoy0RI+dFfSdPm1Gzl/tl1q4FL0QICwfDQY7eO0oPGhUPj9wyxsTcq6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rvJ1fUlivktH3LqoxSlM6u4BF4xnGolZnqlhjwxR+Hs=;
	b=KAgT9yOg/aPW8ghKulT2H6n8LgAG4piUSq4hrGRJYSU4+9pdsyA8Fty/X0L0DAdS5Duh
	 y/OgQb9dMh5z9eZhpOQ9AeN+A9Is5PTQ5He67Bl97NoG2l825cEfHTGwwivAja548Kc7b
	 GHtL3eJmJ6oEfLEiv4SRw7/QO2N75LH62l1oGSpO3p+ck4cWkbevmsC1O9eRm2phO8Iyp
	 u5oU7wGljnA2dt+UMCOx+yXZUsXheoPkGlwEAp49LVKx1G16wXoJB1pzN5GsFc1p+0ZJB
	 56rMW/RNWB08H4HCd84+ZZR10Lr8e/cmkxv4MfTeeUF3zF/b3aEyE/J+xKhcJH5wnQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4BVhqBn;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC81606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEC81606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4BVhqBn
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-7143451981fso404570eaf.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198676; x=1793803476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rvJ1fUlivktH3LqoxSlM6u4BF4xnGolZnqlhjwxR+Hs=;
        b=n4BVhqBnxlpL84hdhyWWE8TXp+uB2emmvWUwUaOIogeXXYpnWyQkUY+RC/37N6Qm1n
         V47Li4WEgv0pGcyhpmNcmcHde5OF7/xO9lAJ3sDPxJtCgmR30iQlbci+nLwqozwem14y
         0H2rWAEF8J6tJRWllRDiOKHMbzoGGqU7vW5FCqbf6R1x890lN9L6VObwnWf8wzMYPx4j
         sLgPInJ8B6/H9jIoo4Ab/wNd3bbGL9K8sO+AqnpmPy6Vt8utrG/MNXgbO5f3q3ya4uNc
         PiXox5eCfQq+fq6NLKqttnr78XucKzvkKL8spscOq1pxghp4xgv3ZAypQjQL8mlDyx8X
         4XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198676; x=1793803476;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvJ1fUlivktH3LqoxSlM6u4BF4xnGolZnqlhjwxR+Hs=;
        b=xuy8ghdWhBSrN6nn4YGMX3wFNQBkrIdVpqbn1a7H/UPvDIY5hzm6NfdIDl5Zt9w/UG
         dIzfRui/B3NZr7aTahtbQHN1lNHsJcPoSVdiloSJwtjmK0lsVVIB82lM11xb2DmgfeZj
         XHasNdV3qJUitVSSv1NcJ+M+3eZpWZDufx3FBr01Me7mnw0UCqywi7mpm42AJr6q1afH
         2nvDnnePRXCOJdJdCUpNxOWI5MBU6latBiDC3N0+PC4EXDtz3jkdgofu0jJiurEgk3T+
         VIKnLkHr+0Cpyr2+gvZxeRUVJktp6KB62lSML/Ku4TYzsEETL7Tpdh3SmdZunnXhCbYM
         uIlA==
X-Forwarded-Encrypted: i=1; AKwUvBz3+V1f07ZPhdMawmAzXeOcGbDJEKxqv08ixJFcSxOJyJjaDnyEGveNA4d99HwAiA5vxYBmmQRoDfJsoQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIqxSPg74WoEe7aoJMkD0mhq+kbjHwYd0o5D/Oo42k5cEDATZJt
	u2hVMbvVdXPeZYOqT5ITMaHS+WtzU1i+/gJkRV10BJOY/pzynFWT0uP+
X-Gm-Gg: AYBFou0IPuF4wd1W+U5CSCPH0a2rttrhigDEnSahcCXPH5NBh6geFI00TQIiza47p+K
	Ago5F7xbVCcOnHyT6m3OrsKmuTCXw2OHDnJUa/6uT+BKAK1WAPfgswJ82GMXJmMX2e/OX/ds7U9
	8dfNfCPyZqEktHt7sbYg00Rvc7YnTbxd+toY2lZJsmcy+O8rzbATgB67lJ4xQPJmM7zRoNfPeLG
	5vOZZ7AtanzqkJo7VaFgdpnXQIE1vmwEY7XqzpIQHuFVWITWnJZgTeZoqCAKKMX7dx5vYkVxVZv
	ZgI0yPgV1A0yftpVW/osA2lIW+6EcM0HtvNNl6pmJb/aE7TjNE1l1ugVrQO1K0L4dT4jWpPvnAn
	OcHNNAwXjAQSUxsIxXqQW3Ecy5K2l1iVGl/ObMSokQ2MncfIqqfmtd7n490dPuKDHyuBYM6qBlf
	JGAGE/sJ2B4MaofLNr/9N3PNcC6kecjXGnMs52MAq9rCk88aypvyXwWwbHutLUf1XsRVtHZVr8f
	hT7y7uspUZn6w7a+PtWxtMozMLR3NghLHGVAGcisVx2IsPf39HkEHzLZ0yHH2X8LTwtu6Idx8kS
	pOxNJiMpiQICunZMvz8Q49U4Tr8ApXM60iRxPLBbAtql25Tb0HtGOC//NZPF1WvWOWOn9IwpsLI
	48O1+1N1FAa5gzTOLef79kFuRoGgfcAMS1iM=
X-Received: by 2002:a05:6820:162c:b0:6e0:fb60:d5b4 with SMTP id 006d021491bc7-713eb554b76mr1546800eaf.7.1793198675625;
        Wed, 28 Oct 2026 07:44:35 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1f83c972sm1734957a34.9.2026.10.28.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:44:35 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:44:27 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	csander@purestorage.com, jholzman@nvidia.com, omril@nvidia.com,
	ofer@nvidia.com
Subject: Re: [PATCH v4 2/2] selftests: ublk: add rq_affinity test
Message-ID: <auIKS60fS7TSlDWk@fedora-laptop>
References: <20261028131829.45803-1-yoav@nvidia.com>
 <20261028131829.45803-3-yoav@nvidia.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028131829.45803-3-yoav@nvidia.com>

On Wed, Oct 28, 2026 at 03:18:29PM +0200, Yoav Cohen wrote:
> Add UBLK_F_SUPPORT_RQ_AFFINITY to kublk's feature table, a
> --rq_affinity option, and a test that writes and verifies data on a
> single-queue loop device with rq_affinity set to 0, 1 and 2.
> 
> kublk pins the queue thread to the first CPU of the hctx, so submit
> from the last CPU in cpu_list. That way rq_affinity=2 always takes the
> remote completion path.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
