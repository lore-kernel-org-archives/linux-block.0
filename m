Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FB247291
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634273; cv=none; b=BZVgVPxC/XsuxLxeKus3Id5/2uBZft3ng6XtX92WHQvgiy+t34jFCPz6saTaeNnD2fmnFuvAkGQ+BulpVRXm6Eb7E06JaEhampI0cqczlNQYdzWcCGXW1FEG1MAgolzVZUrv36oVkqHZ6bc48ZHkI7ZIfGTicLe7URkKYLqnzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634273; c=relaxed/simple;
	bh=IL2/iwbnP18kmI9n/7fv+snkdHP7FL53OqSbuuJhEyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu6xt3KvAo3CDQsT3zofkGLxVubepg2B8dSYarCnnv2oLbHwxPkhs1Cr+yINDkeBmEvzwao2vJTzMo3Z3B89Ti7TqOjHyh1aM9ZNdMIORR0COyyOS3dVWNBwz8Ha1U8UxLR1AMNXz6FEef3E2kNaUHpjo6F62bT6JyzU1F6Sjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRJ6NJ12; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRJ6NJ12"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8297310ce0aso382634b3a.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634272; x=1773239072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grjtl7QGNZwOyO6QhPmISZ7oxg/mzwVAxODgyEDDHdo=;
        b=MRJ6NJ12MwCA87y2N2+WPd1mF0BvDxZ7RC5bfT9NRnlf8vqAp8M1eIs99YseqMSs37
         ww79ZptdvLChKZTgYqIt4VA08wStPhceX14qY4e1SwxYxRxCjswXLda8J1ZhG0yf84pk
         lHI2HIO9V9/aIgjva0WISAQZoeRBLDOLjPefpvFZJjikF+2Eob6IjPJlN3O7VNRhgR3T
         YXsmJFEGWKvYAIeggHKF3QgR2OqDWlCmVFjtSTw/hOOed49KL9hcq9BT6hNY3YO+BPkJ
         5EDcMduP/vL3gJk4Q7SQKOSgSKT1V/1eBcuQbQ4ZDlGkndlymH87aqgyzNYwfY32qCTj
         ueaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634272; x=1773239072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Grjtl7QGNZwOyO6QhPmISZ7oxg/mzwVAxODgyEDDHdo=;
        b=Q33vkk5ZfYK9BsTpxkPAgDChFpVz9GPq89YHuIsf58fAnknmnfAS0xJwHmJ4hVHDfa
         +/58xWU2o4hFzrIesxT0pfkFZOQbRQWMI8De3sxqhtn9aRwnDnfgj+kFPeUCz1v72bL8
         rK56I4TzWNpAQA7+pUHYbzjELIYIV/9a3onxspiXUYaclmDg+O3MJkP8uSBTXvsJjuup
         lkRB75czWsofrsSQmQsCHpPFmIAE/hZ2ZhTGRrfnHBKQMVI7gpLqUU22lItvFJpm6fWC
         cgKdMTan6BfVnFdr5jrPpE/OMztmIjcy34/aXM8eM0zjsm3CJv1D7EAP8xNj7Up+5ysG
         YdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKu/6R3hz5y08GDrn4REsHVs1NapOONtpXfZl5CBAoiRELXsVQeAl0rrTHkHlkA+j04dNnXSCNNi6xzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkeIksG7DCGF102cVZxrYG4tRDH+kgJQFKNCskhClVPJ+xKzV
	7quDiw7FiB1d3n857NrYzpp35/jYE8iiwBc9WT1YWPDKB5h4Fy4CPX+h
X-Gm-Gg: ATEYQzwOGWSbGJNHzlDJUPbqPQSd6WbFvo8kFjZtI5m6N0JDlV304Yf/MosTPJMwrEL
	iXxTEw7fUTjrrm6BjZacAEuzCDjEjPePS+r9PGpuNfgqAXzGk3tJ1VvQgdO2oDdGjRavC1DEqz7
	jRYVgZ0915oNMKKqZzaXj6lsdaI/B4kRXVS21D+6dOlgCQt1HfKsGI6NtOyUJ2NR3Aoc7apM6De
	SH8Ldh7kZ9OV2tepL1JbaZmut1le5fPZ5dXycQsqFidTd+5akMdNOdbVrCGQwZGdEcEa9hW+USF
	BqKuwtx3q6rFGA1j7CC+UnRyqClmnsvGEQ6UUINoffRgmporUF1MKlXdwljEwff2LT9JFCbwRc7
	OKfAmGNHVOJ/2UGvHK/8wEuTB9wnPt1yOAK2qxYrm9QRUHmjlmHaDjyDzN0Su99zCYXx6sXeI23
	163gCwbqHbQlhYwIpddtFLrDLXma1CdYnM5dVnoCXndxd2
X-Received: by 2002:a05:6a00:1824:b0:7f6:4922:89c4 with SMTP id d2e1a72fcca58-82972cff3f2mr1778680b3a.55.1772634271578;
        Wed, 04 Mar 2026 06:24:31 -0800 (PST)
Received: from archwsl.localdomain ([223.166.79.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8805esm19757410b3a.16.2026.03.04.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:24:31 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: wjl.linux@gmail.com
Cc: axboe@kernel.dk,
	lenohou@gmail.com,
	lianux.mm@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [PATCH] block: fix race in update_io_ticks causing inflated disk statistics
Date: Wed,  4 Mar 2026 14:24:26 +0000
Message-ID: <20260304142426.446360-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260228100144.254436-1-wjl.linux@gmail.com>
References: <20260228100144.254436-1-wjl.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Feb 28, 2026 at 06:01:44PM +0800, Jialin Wang wrote:
> When multiple threads issue I/O requests concurrently after a period of
> disk idle time, iostat can report abnormal %util spikes (100%+) even
> when the actual I/O load is extremely light.
> 
> This issue can be reproduced using fio. By binding 8 fio threads to
> different CPUs, and having them issue 4KB I/Os every 1 second:
> 
>   fio --name=test --ioengine=sync --rw=randwrite --direct=1 --bs=4k \
>     --numjobs=8 --cpus_allowed=0-7 --cpus_allowed_policy=split \
>     --thinktime=1s --time_based --runtime=60 --group_reporting \
>     --filename=/mnt/sdb/test
> 
> The iostat -d sda 1 output will show a false 100%+ %util randomly:

Sorry, I made a typo. It should be 'iostat -d sdb -x 1'.

[...]

-- 
Regards,
Jialin
