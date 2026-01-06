Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A063A1E88
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702516; cv=none; b=OLPGhONuWE5qTYLgQvSaA/T9GOCu0djcAJlDe4cpkRrfQCbq7ifCFT/3wzw3H+tKY38GL8jk9Vc7R/A94D1zYaPqqIGmYrhPvnH0/zjkRSutnlfK/CxcHs62Rqw6tynZbajQR+auu4SH/xAEgqMqQzpTdwVCwj6yejvH/KzzyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702516; c=relaxed/simple;
	bh=q8XxwV0f3T8GUgvVPjIeIv1ZqGRZn/3KRNHQFBqYHaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NV8LVnOAgzjTSgmZBPW9nPdohsu0lyqiGkM4C5K7IJh9W/b1AQL7st718SPRD7hV9qnu3/b09mtZWG4dE1b4kKrE+23sgY8JpSKMFpxz4RehTbK3GFrKTBH2tekNNOpkOk7VyxWpJeNoHSwvAoH/yGsBr6v8+N1/MxdhzIC74UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DDn3aYCd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DDn3aYCd"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6cc366884so545685a34.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767702510; x=1768307310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGy+CLSLHRsLD91PudYdXZwmMIMcdqnAL5MOO2Ykibk=;
        b=DDn3aYCddio/krTLyQqnnaw5PK7BP4MyC8UOgBbyF8SOlxbr75lGXfyCp4+vZOqpkI
         cIaTuIp6Y3CdWEgKWdgTZW5JERnzzOKYw/J/tFQJmt7jgUJ1tRLZ+I9vDq2j04aFzyRr
         NL2w7goQD16X2nA2IhppPYg/bBlRLxxM9NNhNElRXc8QtDkuJpFv9smmIam7i4dXivfp
         5mULb9Ggtj+cHXaW0zWNvGasN3S4AT89fUtGRZmDAI6ti3w+7Io2RK1gAF4+4WkX/lbt
         UQoju9BjKe3yLJHpsvSQtbcJ6pIzX9TDeeJJvCLPt7w9hn11RNACqufZfjTm0SD3y/b+
         G06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702510; x=1768307310;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EGy+CLSLHRsLD91PudYdXZwmMIMcdqnAL5MOO2Ykibk=;
        b=RnaHulGLaE9LHnH0G0cpIxK8t/Crz5AgsRpy5hwzvvEYC3YiRSOQw5utkv/5e9jaxu
         9tqruqLbjML2KzlduvM11evkK8ZVvW0OW/fSfaAG04u3ZWULMva6O8tIvrp4uuuNlRTY
         USFIHTgHU1UZBILMM+i/LB0pVZXl/LmsTDHHG2OWNYwHPu9+H4QLRKqopZ414Q3+CTqO
         iR8wHC+TTJAC/SowiTBahPMjsr7CGgWRk8hQscyIvP0fKRtlmpfgM4qYvoVEBU0Fiz61
         oxrBBqZGdWdlFqxwTlFcUwWFSgaBNAxcLcSTzktEVr23lh3/ZG3wsmTBhitTKLNvChKX
         DBAQ==
X-Gm-Message-State: AOJu0YyMWP8BwYPx5d4NaCyOexP4/ZmflWOjSCss3Vb6DxbTX5LkNjbK
	8nivh/lKXOVN5j7IZgXogiVDrxtu15OHG8C8nWnyfQfAmta28XfPUlceEJBrYG5eIUXF256W9Ai
	S+41x
X-Gm-Gg: AY/fxX7P8noQdCjXgaYuS/cyAaW7x8HBmKOoe0k6QIrIdKxJuLWoFShDCYUNsH7ICyw
	SIwLG1iB7ut9IJhgrdHO9CcnTjM3m8A7uYTmBlnxGYjUDwsbwilgNpQ117+clchx4rZtNhnsQ5W
	Gy+jVuLr1yqSvybps4YOxcjyux/XN2T/Q1VySPJk+FnyZFrbbFOLXidAU+e/bGJnvoWnQj9hlt6
	idaPsoUGmZ2ch41ZgbITY0ymjpPQsJpr+J0OmaJe8/XsQxnUx09H8l8LGSjoOVE7MLqqINPOcw4
	wCFCQICo2a/cho502DlEx606B+oe4cPTi4+yGW4PTa+2dqJtSnUeJfgzlHos/PBu+cF7QqBqZCQ
	lRQqPB8kDHufWTUWAPh3sm53gsl+OeqksVncgPV/RvCqjyhRA+LTtrHrZ2XVrBGOq3jOz9jjFMD
	pFIFk=
X-Google-Smtp-Source: AGHT+IFjHc3VCPXwnF1tkgq5di57EUUZj12OGQwCoMhxXkEBE2fMXPEw7F+wdt/L6ThoAPqCSQt9mA==
X-Received: by 2002:a9d:70c1:0:b0:7ca:e8bf:8c4b with SMTP id 46e09a7af769-7ce4665187bmr1131336a34.9.1767702510044;
        Tue, 06 Jan 2026 04:28:30 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa507235fsm1228167fac.13.2026.01.06.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:28:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: hch@lst.de, sagi@grimberg.me, bvanassche@acm.org, jinpu.wang@ionos.com, 
 grzegorz.prajsner@ionos.com
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH 0/6] Misc patches for RNBD
Message-Id: <176770250832.675549.15679393984824160874.b4-ty@kernel.dk>
Date: Tue, 06 Jan 2026 05:28:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 05 Dec 2025 13:47:27 +0100, Md Haris Iqbal wrote:
> Please consider to include following changes for next merge window.
> 
> Florian-Ewald Mueller (1):
>   rnbd-srv: Fix server side setting of bi_size for special IOs
> 
> Jack Wang (1):
>   rnbd-srv: fix the trace format for flags
> 
> [...]

Applied, thanks!

[1/6] block/rnbd-proto: Handle PREFLUSH flag properly for IOs
      commit: 483cbec3422399aca449265205be3aa83df281f6
[2/6] block: rnbd: add .release to rnbd_dev_ktype
      commit: 581cf833cac4461d90ef5da4c5ef4475f440e489
[3/6] block/rnbd-proto: Check and retain the NOUNMAP flag for requests
      commit: ef63e9ef76c801ac3081811fc6226ffb4c02453a
[4/6] rnbd-srv: fix the trace format for flags
      commit: e1384543e85b11b494051d11728d6d88a93161bc
[5/6] rnbd-srv: Fix server side setting of bi_size for special IOs
      commit: 4ac9690d4b9456ca1d5276d86547fa2e7cd47684
[6/6] rnbd-srv: Zero the rsp buffer before using it
      commit: 69d26698e4fd44935510553809007151b2fe4db5

Best regards,
-- 
Jens Axboe



