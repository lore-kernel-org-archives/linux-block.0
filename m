Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C342BEC4E
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680568; cv=none; b=a17/yUXtQmZLJPztCC5pfH8mlaTDBgqmrHQ862DRPu0Nw9jyZtrLGpmyQaByX9agyZxb1TzGJ7eq2qmPc3QCinaKffyBklmfbTS5ga2zlFu4jug9TqY/QoN1rhm3EHm+CSkdyuk7qv/m1Iwe2cgrJPHVzDeXCcjfSpi15GhX7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680568; c=relaxed/simple;
	bh=ZVwR0lDZ1JeXE+Vv9EagO+ugL+8u6ZfEk5aUIo+HEHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WfdY0su6LWg8hI/t5GuYuOZNkNaz3kI6L+pufPr40uc1Db4tDeCie7zYoJXtLfd1mxWYVxKtpD8uyi0DAkcL7bUhGsXWXxljPJWD8f749ZiJ0TgjCI8eKn4O5be8TpEtgi5xIym4XIknALDLiZEvEr+65yG1BSvWIx/GQX1y3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rPKGj0T6; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rPKGj0T6"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so5122518fac.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778680566; x=1779285366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlaC58JGvqtP5FlmX08wg2pbp+97KCNDXwY5G3OnRgo=;
        b=rPKGj0T6KzqtsQS5oiUalo9Wjt9r8MqVqFJP81z/7AZbYWTkH4+LDGzOeH/ywrt+aI
         CTv74UA+oLsZTHureYzu2xflN2qDYUdSdLYcPceH/0PJtEfPagVZLsviWAqaphTP+lS+
         TdL10LLatqzGxuFhSQ3KW24uuSo56VPMmKE/UN0oq+xD3tyGA6crHsMYoKvME7oQ1/48
         gJqH3k5eUkKesRV4i+m8KUIsRkQ1zF5vLU9eUe5Vdp2zVnYaxaJ24ecJg6xBVQGj2AuH
         gw9m+81sGlaMXQS1tbgWkp719RpNLoM/R4t2uYminQdXtm4WvlanJYYXB0zwNiNxlX3L
         fVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680566; x=1779285366;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SlaC58JGvqtP5FlmX08wg2pbp+97KCNDXwY5G3OnRgo=;
        b=YyUtTdfQM3AuFcyUPaB/dwuAM+WdaSYwuIeB27l+rJ+98MMuhUKEp02/fZViYhjG+k
         aUZqqV3oLkEk2H0uOoaBiXLlVhrpIA5ygBeaUIZaia2QrJD1bZs9uIEyvGcQjfAt2/TR
         G7HtGHpXX7Ykdn2QIiH5nZwtQbJZ5+6ay7FB5GCn867W7744qjqBRy4tEj4SHi2YL7tj
         coTOsFVYY3zw9wNd9xgqnCTuNdHtCvv+XjCa8e6F/QLigNx80NTMjuWrHnyLypCDlcLB
         bCsDH+PixVBbhxIBvyt6OVDNROz4aWUEehmSuVelMKvxysBWk4BXXX0sS3mQqzOrV06x
         09xg==
X-Gm-Message-State: AOJu0YwfMsxuG0i2KtcWy0VAj5pv2AI4waYAeO5P0OSzghHkVv6bi1zi
	4gzibhFYOvtuSwMjhUCmrXt1DaN7zDpyyDFVJvZctgjq0guXpiSZrpnNDeb5TASjq8M=
X-Gm-Gg: Acq92OFft6jZrJw4uMsF7zhj38ci67bga7FpyaSXUmmEzgpZqz5n/+PhzndAg0CS2pu
	EDsRnMqJK8DFl82p83+v4/uEVGsX0cFO9F+l5JsVta9BN8CRxuw/42TmiUZ7WtYM4ITdZYeMWCh
	EwUOu9wU8uakFj16pgMUOS4oaaj2EnVe3YZEv96I65wAVVSJXndrr/d9dqcLzfXV6dL1aPiJ9AS
	vWvsHedFvvhIFff6ZfLw9Z18mPiUUov7qY9mT4Z1FcyGFcxYbbOgQKOuw0N7tkPTZ8jmK42V5fR
	M/y2wUYMksaesCcdE/6BlRiIsfvtmC+7uBIxuFXXnLq9eTQbJruHswnHj/HMmhiSZZoKCReSnZq
	rFIWfnYaTfxBMfhVYkrnxAC49V8fVC/opcX77aJfrw9KeKlktBLQ2liv2SbA4qlDh7eO1NMUB51
	XBHbpfFw/3mZOp0xBqSTLcp+I/SUaZDq9dqlpPIWo39nR688ZEL/KnyHAMSXtV3XcJsvpDhJ4Ex
	oCn
X-Received: by 2002:a05:6870:5e4e:b0:41c:6bf0:677c with SMTP id 586e51a60fabf-439ce04b350mr1842864fac.2.1778680565843;
        Wed, 13 May 2026 06:56:05 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439c0954a81sm2962187fac.18.2026.05.13.06.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:56:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260513111129.108809-1-dlemoal@kernel.org>
References: <20260513111129.108809-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: fix handling of dead zone write plugs
Message-Id: <177868056492.400295.13447967272239066438.b4-ty@b4>
Date: Wed, 13 May 2026 07:56:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 20:11:29 +0900, Damien Le Moal wrote:
> Shin'ichiro reported hard to reproduce unaligned write errors with zoned
> block devices. Under normal operation conditions (e.g. running XFS on an
> SMR disk), these errors are nearly impossible to trigger. But using a
> "slow" kernel with many debug options enables and some specific use cases
> (e.g. fio zbd test case 46), the errors can be reproduced fairly easily.
> 
> The unaligned write errors come from mishandling a valid reference
> counting pattern of zone write plugs. Such pattern triggers for instance
> if a process A writes a zone (not necessarilly to the full state), another
> process B immediately resets the zone and immediately following the
> completion of the zone reset, starts issuing writes to the zone. With such
> pattern, in some cases, the zone write plugs worker thread of the device
> may still be holding a reference to the zone write plug of the zone taken
> when process A was writing to the zone. The following zone reset from
> process B marks the zone as dead but does not remove the zone write plug
> from the device hash table as a reference to the plug still exist. Once
> process B starts issuing new writes, the zone write plug is seen as dead
> and the writes from process B are immediately failed, despite this write
> pattern being perfectly legal.
> 
> [...]

Applied, thanks!

[1/1] block: fix handling of dead zone write plugs
      commit: 836efd35c472d89c838d7b17ef339ddb3286ffc5

Best regards,
-- 
Jens Axboe



