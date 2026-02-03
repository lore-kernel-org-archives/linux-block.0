Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BE201113
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113145; cv=none; b=kvwiPwB4F+cVpuEWpVRYX2Iz+rAeDc+ChfGLA9XP2aix4s/2kSRuK0DjzUdyOrXHXNljnCTNbF8j57OlQr2g/eTFi5AhjTA8rjvSGw9Sk5oM3gqcuRASx0qAKBOZ+0otKar+xSRulcMqgxUHC/NfPl98CywBmycFZFd07JTPyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113145; c=relaxed/simple;
	bh=OItMYGPQqHUE+urHop5qPqb1i6vjQEt+fmTKE7EtbcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJThhkWuqml3hNmo9brehyrrcYKBVZcYuUOxUkGhMR3VLUFY4PTfQDcNk8moTIW/AWxCoPL6t59OjdcMrBq0aJOYvJdzzH55o+YV+MGCCXl5SZ2SWV0PPt4ZB1vdj+AwTmslMvrMEKfWR64WJKzmX674buVIpewjiA1vljyxwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crhjyunR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crhjyunR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b885a18f620so814577266b.3
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113142; x=1770717942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvrluIg2iCtRBY994OY5LcLdBsBGupkAkPLQLUuiFys=;
        b=crhjyunRIYhRSyjacaRc6tleLnt5sMoL8XoS5qoliqPp0YvS7m7qDda3xmR3cjY8yc
         jxC+ggQ4XB5io3boCyOif7BUfyaBCaNf64Xa7OnyC+LZr8z1vsG2H/qqzi1UfT0yXyDQ
         Xae0NJ9RQKdmQy8otBAbFFs0kQbZuvJYFN/8QaVJFIqtjJOKJiFvlid6KM40ffWzuxj/
         7mDDQ3Pfzzvq9ZS+BznBATpDOJ0eJ3O9xWwDlgTfUVo7jMp5qgCZZfbf9U121kJFbqqm
         LtZrywXOGgv4WotAJPxxygOhhFgkG1e97hr5nH2hhdcs/FTy8qRhMjrb2sqTzvKPU6Xq
         xTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113142; x=1770717942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GvrluIg2iCtRBY994OY5LcLdBsBGupkAkPLQLUuiFys=;
        b=wV9xu337eObXDvJBRJwguKdcOWpkjU7AKgICl364ueXVVJpoUWQkihi6GzzcyK2VZb
         Vvs3S6YKVislyP9B4fOf1U0dmPnIicOb6STqUXOUvLBWbVFqRixmjtQfTYBVxwqfxnle
         jxVWYV/abC5dEdcAuqq5qH89qivVLusI00cdV53Z0KWgYI6sZt4S61r8Ja/SMiKVpSgW
         Gc/P7Cha6mK4wohxTTyQJcgDyI+jgwxOgxTgG451pqqDOyicvf1KGFa2HDmkbRisxk7D
         Dew/K2sw44GredqXmyl2hS4lZ0s0AUp9U9RLbo7fQQ2bSEfFe2iIqZy7mBNwYeuVSh3X
         6AEg==
X-Forwarded-Encrypted: i=1; AJvYcCWs+eteZB1eHHZHxkA7X7VDDEjaZNvJOH8s5deO9OqTW1lAspmVz59I21HwX6ssPG3ofZoLfmglOuBhUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZSGefSguJn8eOLHpmLUSM7/bUeQVkHMndlXiuYNUzDw54JJB
	m5n4dlPmpK6NO5dpoF3FpbobDIgWKy2ZJ1uw3mGCKN/Vvr6Ux30VfLHX4D2kFw==
X-Gm-Gg: AZuq6aIjE0O08IcTNBVtClPv++Lke6xhwd6D0bBiDJ1bqXGO8o0t0BgQy6/W5DRvL7h
	Tywf+shGIcf1bJ54lUPR9Q0oI+SmmcPEJoHCpD67LSnNbC/hEclLWvcHTUrPqernYkBEoX3jbN4
	hDSLslMehWWD/6SAsb5yqKBgjr7h7kdgFOcReeZGoz+S0CiGXk7dDYWqaiqQGIRDiWlEBVYKEDG
	DBzC4s/ztr9n41jO+qgZzzjrUeO7GlbKSTC4FXc8h2svnRIFA5GsiHY69pj0Ldae/AFlPhT7k3q
	2lec0ig0zCKTE9FCBcBz75D4zLa+Z/18mA0w5gjYRn3CpAEurN6i2ZiVS249DK5qVlJuBVbc6mR
	JXiGBp72ba0Msp3SrSUMr2+13xY+YTicXhbDbLTjJmohqK7fwAPMlS55cTSbQ5m33LcTN+B0K7P
	n2xgjHiHI=
X-Received: by 2002:a05:600c:628c:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-482db47ce23mr183596905e9.22.1770106824499;
        Tue, 03 Feb 2026 00:20:24 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483051286e0sm47463035e9.5.2026.02.03.00.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:20:22 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dhowells@redhat.com
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	cem@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	kundan.kumar@samsung.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	wqu@suse.com
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Date: Tue,  3 Feb 2026 11:20:16 +0300
Message-ID: <20260203082016.2824493-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1763225.1769180226@warthog.procyon.org.uk>
References: <1763225.1769180226@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

David Howells <dhowells@redhat.com>:
> vmsplice from there into process address
> space

You mean vmsplice from pipe? According to this comment
(but I didn't read actual code) vmsplice *from* pipe
(as opposed to vmsplice *to* pipe) is equivalent to
normal readv:

https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/splice.c#L1500


-- 
Askar Safin
