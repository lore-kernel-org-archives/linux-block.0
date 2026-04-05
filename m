Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E91B424F
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775388620; cv=pass; b=n9rcDSRpmx687RqUhe6zmqcaj+Qcf9BUm/3SPrXoqpvU/A4nDxLUXgeuj1apv7jiVxhqbq5VO/Dao9TlfnsHC0hBHwAAi0snf6RiBLOI/CSP3wXxZgjk1jgmSP8W6/JTnak+5b6+UcWGyXqfkTJ4Afi8H2VGvk4sKsMGfeTU0R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775388620; c=relaxed/simple;
	bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY86izX0JO4eoHxPJ5BLaubTaME9f6lkHSLzSxMntXhEzzd9veFG3bZZ2qRdY+v0MFeH8cd9BDkTQfCyim8+qcp9s4MeeID6xcy1y+FV/l6z0WY9cV6JLPTW5RCkRpzzfB+oIn972jHc9mvYv8WbNWFs05irFCXpAXe8ACMX5yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+629FMc; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+629FMc"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so1490388a12.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 04:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388617; cv=none;
        d=google.com; s=arc-20240605;
        b=CW5PcEgYMClROpLTBlgIftDWa5iAt4wuedXwEWkzn/acSNUzygVBVEU78f/rqD+Fgk
         ekozkVXbOzyUA1yGPAB2LWn1OKgZpwS7+8tPFEL1c4mFS0Rs81Pj8F46lNfgZmrObqKU
         xebu425MDiGwSTF8py7+IWox2ZQyrIbIs4bkUBXJecQ+u3VK6/i6NXw5RZ2EzstNH3t8
         9H1FF4/CCWIm6Aa16BmhQIz6ddHlNEOPIox5PtUFivS1g2iPS835peY5bFmr6ZjC+iuU
         MJcC4gjX/V6eJG5TvfXruBT+Ie6Nlw08E0JLQZ9NAktWVenQI0BncAE3JmC4LY8tQLPG
         3Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        fh=mcGUcP9CuK0a1+SNhK0DrLLlv2SgqumCfbEd0NiYS8Y=;
        b=g57ASyWtv8B2ORbj1IxYUIOG6pdzj8QHFQqpVVUMeQetquHHA8SAbaX6LK5uR7xQpR
         U6y3zcKeH9msI+coViLVfekmq/QZkubnDXJnQ6PajHsmeTVWpUlLZaPuAkLOSKFg2B99
         55Z1ct9wdojHMAnmP+212SgoqIJSMnnkGfgUxNYI2dQfZdYi9WAgGagwfomJH4vfLtTT
         n9yM6WS1tJeNsrfV18FBlKM/7TXZpgPq2XNdXVX0aXkh4fgxKpzRciAItaALakzWMLCv
         vvieDMKncR0c8McKadeyQsmajv7G6TKxnI+V7NZLiL3osnGdOsEGXdSTr+YhbYkZCkyb
         ia5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388617; x=1775993417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=a+629FMchi6KQ7gsXOapCt+K5NIEeVvHgtNI+Pf6DhtT28irjcfAi57toEJQqFY583
         1Z7vPU4+BzTeWrBQkWe5iXd+pkATi565F9dOZfVnsThA3n7zg1ZaspPgVw2Yb8M32Arq
         oKeRw+T+cjgivu7GZRlmMMzBB3jqCLPrvg0Lw2X6ojyf5kVw6lkkS2G4aWNZpVrAw3t9
         H3KLWrs1S2syd9aw+AwTTdBl1JEZph3O3UsL4C/azc1Jn9JZNO0RfZEfsesM/fEqQcYx
         4+xHEE8OWH9XFRFZoJKbFaMDGD9r4QkOeoeW2ZIjbDeqsfeOiMDALE7OrDJakbHGiiKy
         CoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388617; x=1775993417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=A8WRkit145a4VdGAv0K+LUnQIlgZH/Rve3aRFazDPgn9JSjj3Uf919iWGpxbiCUVE9
         hkC4fkpLJSbQZ7/DaUwBiv0LgDnwagaJ/4KDYpsq0OaQgMyNAAF7i4ku4rGtR/4Mgc3W
         sHThn/HroRBxrKhhM3HXiTr56Hw3ouP6rg0WBM1i3gcqht/VVY8YzgeVZ4UOKj4uS5J+
         wNwUvBu67n/z7oX0zBOJLNd5F/XU0rZyAgTapqLitsEGKEZmE8tYEN13eHICZaL6PBiQ
         5uFag+0WYmJF1QYkDdGEb/fDM9DTGTrfOlqfhCfby4Is7X91QQDFSh2BE0AGBc9xlnJy
         bOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlHkkyQgN5auaY+Y49jk69W2AmWrAGlCDB0baRCOr27AMmXs02JvibyTYq52FPaVCDpnthWJvJduO3tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkw0M0qB0ee144a2AmVbsMhjL0gtV8HqkQUPLGl1mbM14qUSrQ
	AfxqjIaJE+Gem/0LHOT6KSA7JijpUJWCyTHjSr6KZquQB2Y+cNt2Z1UMijo44NWLm8JtSf6MOmg
	mTlkSVaJ7wRbXnpTvTwHqgA/FG6udaw==
X-Gm-Gg: AeBDievTAE/QlcbHEnZ4m5SFfemfSRjqmtZF7e3VuJgC1fb9VLQveSBET/55LRkL59B
	bPo77ptq1sqfnTx7Tu0Nhulnu3FA4QitSNgmtLajDCJt0UMT+mQL9AVSSQ0yduxsIXmldhGKVSD
	iQWJMwPOPFbH51At4VtLAC4IxSTfs6lrCpBN2j6Fz0w13ecnu75mat5yckZ0/DfcgCK1Mo5wwE+
	2/YTGrWUorYd3X8o/Su80wFPNwNhXrAihBCPXTOeUdj9oIQjSVjHhIps4KE/QLA4Bv0C6UgoC0g
	891WqDCazl0odrEC3+kQbuF8h+pyyqdublzaR8JAZiguvZdzujjD+OFxhERi5mUNIN+xHA==
X-Received: by 2002:a05:6402:324c:b0:66e:df62:8826 with SMTP id
 4fb4d7f45d1cf-66edf6288a7mr338829a12.8.1775388616842; Sun, 05 Apr 2026
 04:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-7-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-7-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:59:38 +0530
X-Gm-Features: AQROBzA2rcbT0pZ0-7PJWuNuCAXgpXg-lAQtO03rLOJpR9_lw8vMvBFgqpf-qwE
Message-ID: <CACzX3AsN9osGEHdaZu-qKpKhR+JGTxaSvx3PhqWt4N9HSbj63w@mail.gmail.com>
Subject: Re: [PATCH 6/6] target: use bio_integrity_intervals() helper
To: Caleb Sander Mateos <csander@purestorage.com>, Anuj Gupta <anuj20.g@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks ok to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
