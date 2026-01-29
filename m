Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52316218ADD
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717850; cv=none; b=NiRd0BEvpMhoyCFEEiDyUBidQfmieYVzoAh9yGQv4VnYLYgEGDdFb09F2RRy7qWxTKNzjjY5uIu/NiKSNeH3qJ5zsBYDgQ7OPW1atP/QGej8XYCy1oJBffSmiMjxKm3f9JXsBcGglYrJvMX8DkyTyX++p3FKjuKiW7zLZ1btG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717850; c=relaxed/simple;
	bh=EwIM4yPaA7XlUOXV99Kd2GmK7eOBiJep1q1lQ986eu4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XX5bjR+J65K9oNZ3illVi05IMrKyk37OFy4LXPbv9d+tOUGMOsfIPxO6cDbnsVdYyeULu7Y4vER/qRcwVebgdHbpCykKq8nZDK3KZrQ98WqfsqLofYrlOJa63ERKmHW12yY7PIDlNDa8fO/x7+sTZ8AXKygt6rSvtGzrUK/7R5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ku+OoWMN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ku+OoWMN"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4094d7d71a9so481802fac.3
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769717848; x=1770322648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pnd5emAPXoRmXIfQVpve2qBXVELm+5B/kDo/alWfPzg=;
        b=Ku+OoWMNaM+FqLnd31khhha2LzwQCn3wH+VCBJ9tuFfQN+baKKyXGI4Ro9iSczFcKm
         4Qq1njrWzYZ5rAN+Q+t5l5E8y8iK8vpUVNStyzyon5tE9WLOLvNvI+0cShI3dYZGSAkH
         4NaoX3gLTkI5dSeYLm+1/MXYcEWskbyKojtQPB344dno/kwBHVS4kzYBFUXS5HfniqO9
         8usum0cXVEAzZgglJTJIKe4js+ZI1Y6yRG6g1rzqKIn4nPH3SiIfnC3djrgZzfzSKnd3
         nsAd6SsKNjGCGdyAU5gjYHcllqANMnlKQgfLrg6Pj8zV+TWqAwkxS/OqTIinMMYqau/h
         XzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717848; x=1770322648;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pnd5emAPXoRmXIfQVpve2qBXVELm+5B/kDo/alWfPzg=;
        b=HUff4OasL56xcUbtQ9p9R9vsZbT1PH2VkoI5KMK1UBK/w3ASb823NmCTkblw7B404J
         gAjPeiUTnpRBGBcsKLTbFdiH8LP7VIrRkg34zzjSs8kpqHGMToEhlz0EFvbbq07b9S5I
         g4wpD1Thr0NRua1GS1I3gjHuQt9SN57WyL30aNk6LJvVlM7wns7vIEhY7vRDqqLNuKEA
         mfkw5Rr8mDCVKXLfpAVPuPQiQUbQK2pKA46dV4rdyO7sbdEwxKgTyQJemGm9inR8ujIc
         4Z1RmIATF54CP/uPYbWSdnmFB+MHJ3KIg6C4Gqj8Ofzash7BGZSnqPXa7N+0zQHuOWrs
         JLXA==
X-Gm-Message-State: AOJu0YzpCBJ1sR6Rd2ZlUXra+8M8MjM3NlxpvVJw5aIvDmYIDYbkqft4
	RLy/8aAoBeL3x3wO1DQiB3nzh19kH/vLFw9TggKAg45Qn4gaKs+V3DmyG78lml3uywosurhB90/
	TTn9uoX0=
X-Gm-Gg: AZuq6aIVILiZIDcoJQSBVGLE8W8Qg5RAq58rEldgRsOJ74zh1jwp5jGTxQ84SW99vf6
	PIP3BIyPgl00K5xDlqhiQzLZJtPi1mPDklseQjJdTpz3oKPO2ndbLvWS18738sAzAwZk5H83BPN
	iGRUfR6h5QwT67Sg74oPlskBq9IA7tLB2HC2L7n3ZHZZQUcYfYbK547ZY9zGYJ09Y61SC81dytv
	QHPy3KhlMBx4StVS9hRpmQa6mMcjSakzC16JHRVy6w4J4x83Xg93s90qAIdvdK5TWpc9iKG8pF+
	I6EgAhQ2B72TiN6W5gbU6AauKkmC2wICVJUThWpwSap08ZDDsMt1EmL9VOq7yIAfg0LW8NBETDz
	zP/aZSUmRFfTKmKRVKr5ggy/k45dqeT5wscbBwgQy1tp6kaBT7skKZk1+n1iPlWmh3bj+LD819D
	is02XHdQdwc5OnTRA3CyVTyFzjXwnKlJFvQYjDVO2e6gWzFuH3fnrGLay3Wlusc4A=
X-Received: by 2002:a05:6871:4b12:b0:404:31c3:9b8e with SMTP id 586e51a60fabf-409a6b20ccdmr467245fac.16.1769717846409;
        Thu, 29 Jan 2026 12:17:26 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409571ae8f5sm4375162fac.9.2026.01.29.12.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:17:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260129072715.1107336-1-dlemoal@kernel.org>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/2] Cleanup patches
Message-Id: <176971784566.604315.1588048806304347328.b4-ty@kernel.dk>
Date: Thu, 29 Jan 2026 13:17:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 29 Jan 2026 16:27:13 +0900, Damien Le Moal wrote:
> Jens,
> 
> Here is a couple of cleanup patches for the block layer.
> No functional changes are introduced by these patches.
> 
> Damien Le Moal (2):
>   block: cleanup queue limit features definition
>   block: introduce blk_queue_rot()
> 
> [...]

Applied, thanks!

[1/2] block: cleanup queue limit features definition
      commit: 068f5b5ef5bf97e25568950f06ba32325bdc660b
[2/2] block: introduce blk_queue_rot()
      commit: 2719bd1ee1a1cd0535bc62e89b52822f2bbd14eb

Best regards,
-- 
Jens Axboe



