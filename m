Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400175;
	b=Q64wZVxVQBYHqlFWBq+s/rUp/eEO9DeL/4Le0c9wopRJtd8WCtDyGCbDmveQyy8qLc/0
	 TlLPJuCgk6Cm3J16EkFtU9zl5GulPBAHbf0qKW8SWGxz8ue2W/3qrhm2vJKJpHKx1Adte
	 J9UPSM1ot4/WZbXuzubxDrao55xFNVes3i+X2VzBc3r5+GDG+lJ6CKbgcjjTiDa/PSl81
	 RaxvkqOJfHklkxYzGCndltpQGzAmkZ5UWRYn2OCb1t86AY6CNxmJqumjwQV4Z0tKS0Gwa
	 yPBall4MaB/MLWVu8Z4zSoEZuG+yfk5oQQBm2HEawKhLG82IXb5jS6iCvZJ/6RGqYLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
	b=O+HApEzw3Rp+4ijT9LtNgxtrt6j/9sdAdTRmDu8YQLnS2P/JXDJLtWUzGP3uw4EbCCZQ
	 QUz3/dFWCvs7q2Nwlaeb+vGOTZy3z85FXZ1uHNRofxFmG4krCTghZsIPR/3eYMEPdT8vQ
	 nZOwSjSNZhJjuEYLx4bY5vClCiAsbKVfoUb1o9YbeWSf3ixCq1pAeHLc3A94z0IpL0liM
	 dG2lby8jxDGeR6I31moAlGQBH0htpNr6cRGcPJOtKSXiTdE0ACeFMdmh1m/dqyU1E7Ffc
	 7HDT/REu/y5XITmFZaKWA+qRx9uziuMybAtNbuaY4Ffh5J+G5QXTym471cKN+YryF5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYWO8fA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B8606A33B
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 12:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C5B8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYWO8fA5
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-539edfadfa9so1119938b6e.0
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794400174; cv=none;
        d=google.com; s=arc-20260327;
        b=Ru6NnBmORt/m/Car7wkQOZf0p3dvFrHGGB5h44z8cDU+lj4pSu+MkpvkwK76VlQhfk
         Ez085Ag1hRS8xfZq7G2Y8WPQXaVXi+HHBjMozPaSG1p7m5jKi6JK5m+vZhWh5G5FZ9Zp
         Izb6Kbau88qm4a1LjA5E1NrIYV6jj8ERdvIKXZzNtcQT6X6Qzx9QsyLPIp6ptqzLljaG
         LwqX5B4i3+Y/5e2UgYJcB9j18Xp1OyUsaMpooGTgjgI1c9uY5X6Z6smJKWXAJvzZ72Zh
         zwbq9++HlnoseB8j1prQ0dmKHEhPvDTZhicruYkW+V/jc4Jc06kqoozG3tYMX+0dr3aY
         BRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
        fh=C/ES9T/S3ZYBYdZKDh/JOzrF5DVm+NYiVq1Tvs7cF9I=;
        b=OYioG2IOA9LkrJ32w02rUpsE3A3MXrMYad4h5x7UOQDRXp4+ScewFIZa6YTl8iYFO/
         2HkX0AxrdCC7YqWKwPP3gdnfC72/OeaImWQwC9K4bqwbyfHoS+SfvsMt7l/QZ/K9XUcU
         y3eVyNMXapMvJn5ENNvA4eYZRM3/9TDhBHOmCaKynYJEAlbz7RvgoRobPgZUb5ITAJlG
         32Lcj1zOoo813RFAbjSHZqkahH9r0fXYPsjsNRlEBhiIAfQ/ujl34l27Rj4WCyW6gx2q
         Su3xRFRCuCXFMeI5G9OfxSALgJ8NOleafHmtkIPPazSmrd/25BA3fOorLY6jez5dW7A8
         Mbgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794400174; x=1795004974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
        b=PYWO8fA5gRWaYW8Qean7e52jZfOMsPHQuM6ciQ8I2KUqOeKzZ5GvpOXxNAPtY5AhhB
         Cad6nYp76jWYyg20Wx2CHvHn9HHzxxDLTgndd12baYuY+6C0DGzHUKTim5OkboBpeoId
         vehG+laM1C+esKuEV/5zMQt153Kiad9BC2j3B1+a1CrK/kqexT//HR+RqgX6LEVIzh6G
         6CfowtQUsymmzNYPoNwPuVEBXU04FHcImiZvdMF/Eg158rbV/NBP+TjTiJG/F9g2CSS2
         XcOKlfCa9GpvzMZfuzMW+fnlwfT2t7ncVQfJ47mwGVV2PjW5NvbR/mbXWLsk64EGQxIk
         wOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400174; x=1795004974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
        b=wil/8Gfk6IyBgF6CX981YTV3hEb/AJLblAAPfeTf8udVndaTGSykoExMyUGV5ZIc7W
         n1ANQcHPcrZOAWTqZvI0/kCLBmN/gUsTuHfOO3AD8szhva+CvskLHXuVMiDpHGnYeVJV
         y3OH7etDeIdR6Jg2FK6dhiyH/fYscnqhGHvgbi2ASWXW3bu0qR6NsyCHll0vTUA7XdgB
         i6DbF0C3236DJt8g1Zoyq7CjOKksH8mElHKFXZM1C9Qs9KD5QF85IOtiaJp3BlnRJ6hy
         WcTkPjE5heaeePofLcizqT+c7JUP5T2/F8gGWFYslLOJCVD0n+C880rk0Psg886QIOXA
         5goA==
X-Forwarded-Encrypted: i=1; AL+hErFpHCM9YQiZpWWwF7BbbZFEW35Jf4E9Q8FUCwbEgOtcg4C3Z0VHE05GbFBgOVV2PHe3OUbBfYhg9qoWOw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wRNFKWvnBQqDSIKDWmfr58V4dGSSKJugbgAp2IxeVuJkLICoG
	+ZmBhy6EHpdXyAX0YPeSxjWQO4MHz2N+zTXae6WPBGcMGn4Z+d6Si6L6okuVCwbNCkoR1bYvZfJ
	2c5MqDF70ESo1QWoUyHsyIQ6vdnE3TD4=
X-Gm-Gg: AYBFou1FnbRFza0Jr51OSWFxkbVmtXX7nQqupzPMCLGoP0yj7m4mRZ8IriR6UdnafxS
	9wgq/1b+535/PpYPXPqRrTNxciZsumGpjD9ihLZMJpXHhG1HHg+ImtJKydFeBXURgFVlX4wMyDX
	8ec7lmJ3zehQS+rYEStC5d5jrnEo9slH57PgyVQFNvxOmvxGGF6kldY2nN30Z1oiczmA3C7O7by
	7eISqZsplsY2JNlZe7h6l8VdPXw6l5KVcVnHs3VsM6JZ/r89rkvrvT+j2oDSKGRIr4JXnxgBX7I
	4ouki7/o6u20jwj+cMUBkGP8ZZkTqgoNdWeO2OcXWyKIP0tuwdtSnFnwL9A6XCp8skXEt16ye5J
	PyfA6mTCMRe0JVwuvrXQYnmnJIX7I0GRl6bmQmQS+8Wik69O6KB/HkxJPS9ImVSqd65wqZuELQm
	0wO+0g1NloXAS4iWgxJfZ/rlRn/6GmPT6P0WC3oqkLD04OFS10ZpY5Hw==
X-Received: by 2002:a05:6808:4f13:b0:55c:888:2a15 with SMTP id
 5614622812f47-56b97d216eamr1759866b6e.53.1794400173914; Wed, 11 Nov 2026
 04:29:33 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103185909.71843-1-dennylin0707@gmail.com>
In-Reply-To: <20261103185909.71843-1-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 11 Nov 2026 04:29:23 -0800
X-Gm-Features: AclHuK_f_I8U-R4ghS55caM--h46bxgyAYf2JvxTYf0GJGfw8SL-RER2v_qKYxk
Message-ID: <CAGEkeHfW2ADNSV7g5JMss8B80T+x8US17Bo51Ypp+1nnoxSPzA@mail.gmail.com>
Subject: Re: [PATCH v3] block: fix discard alignment for non-power-of-two granularities
To: axboe@kernel.dk
Cc: hch@infradead.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, mtsai@redhat.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

Could you pick up this discard alignment fix? Christoph has reviewed v3.

Thanks,
Hungyu
