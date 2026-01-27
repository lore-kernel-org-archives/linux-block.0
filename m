Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AD2745C
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487076; cv=none; b=ME0Pq/2pZ8gpXbHI/GGTTLsxEg3N4+C0aLRGNLnIIJm3ZP7+o19o90yME/1E47hJ0mkFyODzoAEiZSCZPfgxvgkNlXmOVSee7v0i5Ow2DFcDd0nhuv/Vnfw1NdXEGdZ7Ur3k/KrmZdskqyFza9l1muRNzxv2NzfkdhI/dhX2jHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487076; c=relaxed/simple;
	bh=AIqBVB1PK88aZn0HV4nZkfSl06nyEmy5ybHX1xRuhUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SphyvZqqZdIktncRDAupq1rvp92g8tsCq29aqkuJuD052NQA5Cv9Lfq9/YSqBKezh1HrmycxSBY2F6nL03+R2ZxK8VXZXYqi5FmGIGkAJTI83lWCs6uZqoyJZvW2MeTcfldb3F09uCYBp0uUEk2lIZ3VzP6ZMD4NglZqNczJXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jAAjMJEZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jAAjMJEZ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c533228383so321585685a.3
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 20:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769487074; x=1770091874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8TP6kqeIkAUWUZZG6tF8dQqnWr6eV8BDEPZ1MqHsOc=;
        b=jAAjMJEZoXFAsjeVbotkAOjPxG2EB1419kEJAUwgel+BveiCQSwLmp/VuN/i7T9fgF
         Lj78zFiDM+9/AwybZabyH852Izc1Jx9d8ZN8AncMgfCiwNH68z1zsY0WgFl1ivfeDbwZ
         hpOqN/bMo+9G73sBQ+VLlW6Eh2Fc49PdcExOGV79518WQpmYY1HPgkQqT04iR6c0CNpH
         PDmGabnFXk1Cvz99srk1Ul/qyPRnrdlAqhj/yZb0k9NBL1yKjKGBNhMLuvmYsHAAr4AR
         qWYD2EQD6q/AeDNts1UspV0OhwjlvIwbLKbk3BiEEOodhqv4MrwEJXQ7MaG4vhycJ9o8
         M4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769487074; x=1770091874;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S8TP6kqeIkAUWUZZG6tF8dQqnWr6eV8BDEPZ1MqHsOc=;
        b=GsvVE9vbDvgLsowYjCWDxCodkBCQ3oTan/xnxeovADC+RVGgMGEO4VGweNCPcMzuzd
         MYaGA8wrZK7jePfSJVYXGvWUtVm5nqWcF2adldridOgiBJDSyKy7TKKjKn3vdY/Tmbxe
         tydRvGAqlSyy7ZxZ6rLOxrBpKLD/bcP2dzkqfFeMprSmTnjgUZ4DdIq1ES4u0y8GERaI
         hvaNRMVZlwuFCG+z/VdBIedVRkQV+lt6Xyc5qeL5CWpy2yTNEkPrmHuWiSvY6JbVrcLQ
         mGVV7M1z/g2G15lYfyV7Er2Ywl17TrvSyzZPIziGznyTFolkS9qh6hHtgV6DMJnkSFis
         4W7Q==
X-Gm-Message-State: AOJu0YwdrgagUxms3l19pGdAxwyd+68YAKggEzHx8O0g9+bF/FwVuFZc
	Bh3UVNVqAkBhMRnaS4OPgjQclHyheLwvEkf5abRLYeVMafZpIVBgPHTFAZm9X9R6q0E=
X-Gm-Gg: AZuq6aJybC2XnjMkmk0GP0tmnhmUFfxybiUT+ba/BF5I14VyM3q4YT0QkpRm7BkOSOH
	GZe5coi439BfIoLkjZNrISWhv/UflZbjcaBrTkXjQ+Lj6+wH7fflSmyxV1VazgWcLBtKOY/lkFh
	4eztCI0fCNhODj2rert3nwyfyoYzDiZ3KGLCRBKWKQ83tNmjdH7A3BAi5lmBwS3ADTy0Zu4jOUK
	o8iqyLzegAyFYpDHdrGryqpB+4w2soZL+8oeA0gehyJCCJsVQ7LyRnZFYYAq13uHJA7XdMlYdOJ
	5Ma+IWz2zzc9Zk4UJvI1c5GDYIl+UdNS78VsydH/31qzOqgJi8MjDxf3nP+UqxYGmoyG4Nachtq
	ED/LM5TnfL4SxeLuy4bLtZqLI3WICMbn6FkcGcC3cres3u8g2VP8GLVnqWTPHzbCojAexRKAA3V
	G6SGqsIn+IfNRWXiIdapVvXCsvRe0XNokEy+zFcOADjWjG2u/i1I3InSXco2qCmttV
X-Received: by 2002:a05:622a:64f:b0:4e7:2d8b:ce5f with SMTP id d75a77b69052e-5032f8875d2mr4270121cf.36.1769487073662;
        Mon, 26 Jan 2026 20:11:13 -0800 (PST)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e38700d6sm1070809985a.50.2026.01.26.20.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 20:11:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260126162724.1864652-1-kbusch@meta.com>
References: <20260126162724.1864652-1-kbusch@meta.com>
Subject: Re: [PATCH] block: remove bio_last_bvec_all
Message-Id: <176948707247.253132.515140634443961704.b4-ty@kernel.dk>
Date: Mon, 26 Jan 2026 21:11:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 26 Jan 2026 08:27:24 -0800, Keith Busch wrote:
> There are no more callers of this function after commit f6b2d8b134b2413
> ("btrfs: track the next file offset in struct btrfs_bio_ctrl"), so
> remove the function.
> 
> 

Applied, thanks!

[1/1] block: remove bio_last_bvec_all
      commit: 72a41750f1a35b46caa5bbd70df7b5d3ce4f4b0a

Best regards,
-- 
Jens Axboe



