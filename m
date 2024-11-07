Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B9218D86
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018971; cv=none; b=qgKtn0NPIq9tcjHkEotVkhorl5pDdWa41+wXSgpD1I2T2WRVoBd049O5d/5be44/KNEtJM4gRA7AUyyqqrJAhkYI+JsI5uvkZZdMcPTb8Y+xyiAhBNTRHRQ5RF1oMIQfe1x6cV06ke+76B8QgbTw1FlNuElaGhUBglBEC4PpWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018971; c=relaxed/simple;
	bh=cW1JRi52uYRqN3pBwXic/eKBubfFHcWzTPygZi6rVPA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U5HXm9xf30XUag/r1h05DEOYDSVf0N9vuAiR+uLntQReGVHa1wc2VJNIFqrsgsMkdYuh9J669AWJbmeYekMn8pJHW9z62URbqD/iXpc9h6BCG74NmWdkKq2bFI+ubVtbUgqx2xIQWc4qw5krihLngFIH1GowXsPhn0w0812bXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IafIjaQy; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IafIjaQy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e604425aa0so979510b6e.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 14:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731018968; x=1731623768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBHM+FEdMCaOubIVlzkwhfmcpaZiXIVqQjpHHSzhD24=;
        b=IafIjaQyyhnXEAost1sbFGCnPjDyN7PQJkMKlL1fQI0wbOl+DAcA2m3TN/P2ormsIS
         X98lFyDL51HOvUsArQqJ6lBOAnuef7gpREmfC4FtRMLfVOVpoNDnxUrZZBmyNhVVaYOw
         tZuPTTvj358z1L5yee/6X+inssAbyJ8yCDRbBXpEGUcr87rjzIgNabrOV4NwyCiv5jeP
         BqQ6MMTzePl1T8WM793rzYB21avW5ByFuTpPpIh3+SY2CCVtvuE5bchyUzZ0OS7o9TaR
         X+ptufTXQvXgCW1XmEMFMJqCZrFU02dY8PRUvzLRKMeJmQQmPMrOQQzc3wPODtWuRuMt
         JXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018968; x=1731623768;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBHM+FEdMCaOubIVlzkwhfmcpaZiXIVqQjpHHSzhD24=;
        b=IZXLO+nw4hZFviIeG6z1/xXmqtTblnnv94sqoFDFSFGEdbMMx8yanT0hNQ01SRdRKU
         nkde7Brd32QNNVU4b2IV1CrRu4NQmC2EiPRW8h9QNppNDhA7qktdHSMYK+eIRzUPlCCA
         GPXkZR7hdb+/GEAVESgvRVmJaA+qr26EB7Ojqd39zDb5AbUTCVdgVm2XKcFfmEiEiq2N
         AnDf4oq1E5NQ3QMXWg+PkrZbb7r+hj/so8X1XEWGW4urgWNq0u9juEUw3AIeCpyUr17/
         Vow7zj4QIkMVW471aq7k2mXai1/Nbryfdt9sGwLWSTq427N7RVTCrDBxMfmQlc0j72Gi
         R1ag==
X-Gm-Message-State: AOJu0YzLLhAnHxz97AattYGK1Ctu59Ulq2wemN98oPMkWdewfZgJngeD
	LXg3tsmaihvd3izImJklRQBLKelNSFxc/+JK6SO2uQukmJoFtlXwdu2xVxPVhWJSvOjZmGidPKN
	POrE=
X-Google-Smtp-Source: AGHT+IGsqIkSG+a2jUulrc/8FMnSgOowWs2F2SoCc9yXrMYFST1H8h1+4L1rIPsCl7xMtaknUNdoPQ==
X-Received: by 2002:a05:6808:23d3:b0:3e5:f4f9:3280 with SMTP id 5614622812f47-3e7946a6dc9mr1085108b6e.10.1731018968502;
        Thu, 07 Nov 2024 14:36:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca4fbfsm457821b6e.24.2024.11.07.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:36:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20241107064300.227731-1-dlemoal@kernel.org>
References: <20241107064300.227731-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2 0/2] Introduce bdev_zone_is_seq()
Message-Id: <173101896695.1015163.10309678782925812727.b4-ty@kernel.dk>
Date: Thu, 07 Nov 2024 15:36:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 15:42:58 +0900, Damien Le Moal wrote:
> Allow file systems to safely access a block device gendisk bitmap of
> conventional zones to determine a zone type by:
> 1) Patch 1 - changing the gendisk conv_zones_bitmap to be RCU protected
> 2) Patch 2 - Introducing the helper function bdev_zone_is_seq()
> 
> This is in preparation for use in btrfs to remove the btrfs-managed
> bitmap of conventional zones and in zoned support for xfs.
> 
> [...]

Applied, thanks!

[1/2] block: RCU protect disk->conv_zones_bitmap
      commit: d7cb6d7414ea1b33536fa6d11805cb8dceec1f97
[2/2] block: Add a public bdev_zone_is_seq() helper
      commit: f3d9bf05140dd242cdc33c431489a853f2bc1b67

Best regards,
-- 
Jens Axboe



