Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE0317144
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688493; cv=none; b=XQDoiShFAcrnKCTHTYvrlmZ4uK0yXuWaLfPU+kC5Zi4lnnW7iWEZKSbm2o7UOvzGQPSmpZ/SfpE1pX6P7h1EjagF+LghPpAchz+26+zvnxD+4JiKjNXks+IoeIv5OoVpPlqGb/u8GAUUZ4z5srwEMFGgzlMwPrnrqd3KCWkylKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688493; c=relaxed/simple;
	bh=8WWVxzQ1LaPHve/Jabl894pYCgCdXyjICCff4OnQ+Dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XLYVpN8ej1xS7IeiaIsY4BEvmncWtLVizgxEdTi2qa3V8u7+6X4gsz73SNBZfaQRJmiGqos0OaK93KsEK8kfLtdhPYBePd+8IDh7ChZMaC1jcWfeId4X6Z5g3RDtwE7gXv1tRm9QFMslEPi8KRIWTg79lGCkgkYN1jyuIRl0UM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=KClq+B4E; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="KClq+B4E"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-48633190849so914738b6e.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2026 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780688491; x=1781293291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPMYH1+yKTmi3PyTjOjkXhGjsQpcsbLfW76mLGIPIBE=;
        b=KClq+B4Eg4u9RK8S4KygQC2/u2r0dGlL3umLUzkopc3E2ZIWyRDDkVT/GlKtP8nOk0
         poz346DfeQiLh1PV5QEgqjrFTlu+zV/PGHSXE6Ebwtk5gFRlPK9BvW76XDtWX0cNKI+Q
         icEgdUqlM+oLY04pUvlGiOmHLKUZnPQmqXJt6cnCOlqqhyrZzDTh1gel7iBnLbg7NtxL
         Cj8VrlnyIvftmFEdCbNxbVXskhHCdNaxCQOCrEjtjD4k1md/S+DslwIvvqNXQitnkDio
         bNvUI8W3OI+fzKQGQNI5GUYD8rGRZci3swDyMujrQzBtLUa8y5v43DV33L3/rRxN17IO
         e24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688491; x=1781293291;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPMYH1+yKTmi3PyTjOjkXhGjsQpcsbLfW76mLGIPIBE=;
        b=cut/tlgSewDoAZzUZSvays+EJmKp+ZOYSanyrZNpmBdLYJI+3ERTlhkJJIXNG6Br9L
         ogMvNCaSwWQee9cucUrPqCgo+MXgRoaNul0OvwmRtVN0aSaIyZ7UoWG8e9WahDTpN/LO
         4NBB7QbdSAuD15I5PV3boWMJchyOtXSKUPCDXoSldpfsKDcX+BMxknE6kEiCm00E+xe7
         X6zrut975m1sMVuzxpnakICCn9UbxGYELIoeCwvAgcny3+MmqVXA6kY9FsxhKEUUjT0F
         F72VoxYDcYVy/miwd/tyJwxn5LhP1SfOm9CZhfYDNe1OYszfIlaJTLpi3nSS002uohXu
         SCKQ==
X-Gm-Message-State: AOJu0YzBGsbxp5SJjWLqmQzqDVOPIszLo2jHsIeWl2MVAhLO1lFiXHyg
	M951KPkw0EslMg6kKBBwSSFYneZIeQd70noVaP+jPnRoxw1Up8en4yNdjyuPF2sL0qs=
X-Gm-Gg: Acq92OHtg3cDTHbl1Sv7JmJ44KOUe37nOJs14toOs5pLGYOGR/Z2JdgmioNWH3n36us
	LrHIkQTqyLXUiJKIIKOrZ/4unSUY7nv4xyl9QuPFBkbGuJGVZbJdrDZBZWc0aAoWFF7+VcriFp1
	iToECNxoLS9u4kddeB6gfo3PDBjGMKjEC1Nbh8RNXVetj/086NrY52cHRcqHWtS03XLXFSuvuCz
	fNZaVyY2qq5bNULEy0l4KUuIyonfbiTOytxdvhwpuUm4UToT//4ojnY1ZwHIdFkS5M1KRoemc3D
	jU02Y4prWKBZ1icplG4HONG+7C950ZDjuwJZ1l3KOFrtCFSrl3A0ozppd7YaZz6ZAVl8CfnutmV
	vVf378sBCIU1sjO2IqRPA6wF3Zn1tfbOepiYRJmKp91JragfHM2W//ZZhxmuFTJsMCICJfqwZ/x
	pe8t5IvsYKDXc5dz3/hXEf44k9PjZauroqFrvjv/d0HxoPoNXN85x8mIe4LgYiSzrjXgEu34/8b
	ORI7ZyM9xSVfTxM53p3ws6LUA==
X-Received: by 2002:a05:6808:344b:b0:485:5950:c00d with SMTP id 5614622812f47-4868deb0b7fmr2907107b6e.26.1780688490682;
        Fri, 05 Jun 2026 12:41:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78dd7b9sm6681945a34.15.2026.06.05.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:41:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
Subject: Re: [PATCH v7 00/14] Enable lock context analysis for the block
 layer core
Message-Id: <178068848902.861993.7353710518545536099.b4-ty@b4>
Date: Fri, 05 Jun 2026 13:41:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 05 Jun 2026 11:00:53 -0700, Bart Van Assche wrote:
> Recently the following patch series has been merged: [PATCH v5 00/36]
> Compiler-Based Context- and Locking-Analysis
> (https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/). That
> patch series drops support for verifying lock context annotations with sparse
> and introduces support for verifying lock context annotations with Clang. The
> support in Clang for lock context annotation and verification is better than
> that in sparse. As an example, __cond_acquires() and __guarded_by() are
> supported by Clang but not by sparse. Hence this patch series that enables lock
> context analysis for the block layer core.
> 
> [...]

Applied, thanks!

[01/14] block: Annotate the queue limits functions
        commit: 08d912bc44dab63f2637677712d2a0b86922389a
[02/14] block/bdev: Annotate the blk_holder_ops callback functions
        commit: 3033c86fa1a8bb31d0a13738fe8c5f9e5bbaf98a
[03/14] block/cgroup: Split blkg_conf_prep()
        commit: ea4f575e72df0fa9e4b3f57a6f48c1ae81fac7b4
[04/14] block/cgroup: Split blkg_conf_exit()
        commit: c574c3cc368d68fff465e5fc811f874d9235b940
[05/14] block/cgroup: Improve lock context annotations
        commit: 9865e416644292124865dfc8a4ffd2b8e6764242
[06/14] block/blk-iocost: Combine two error paths in ioc_qos_write()
        commit: 6a7717a2df6c01b2158979f311ddf4cb35b8987f
[07/14] block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
        commit: 998cda78d4e364f75e576ba715a2533462990aee
[08/14] block/crypto: Annotate the crypto functions
        commit: 73bb2480e3eccc6cb2419691c9e60dea9dc6d719
[09/14] block/blk-iocost: Split ioc_rqos_throttle()
        commit: 1ff85a387947890938c05cfe22041dfeef3098dd
[10/14] block/blk-iocost: Inline iocg_lock() and iocg_unlock()
        commit: a255026594e9b7eea24c12d2bd4acae0c11eea94
[11/14] block/blk-mq-debugfs: Improve lock context annotations
        commit: 131f14125a1840d393c3dec8910483e3fc3daf18
[12/14] block/Kyber: Make the lock context annotations compatible with Clang
        commit: b4591b91526ef53eedefc124221ec1a060bfbe54
[13/14] block/mq-deadline: Make the lock context annotations compatible with Clang
        commit: f10b2de2af28f90c9d1a0774a474e5c4e4d222da
[14/14] block: Enable lock context analysis
        commit: 5f0777166e3eaefc02ec0e381658f510f4d068ce

Best regards,
-- 
Jens Axboe



