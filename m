Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897F3AE6E5
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818534; cv=pass; b=NATJh8tZSXg97z6x3bBquXUCu9GgztEyMF5789RMuDd6xnhMlLpwVoxpIbxeh3XuWf+xWwtOP3KKb5M28Jb7qJwaQk+gwJ0grc+O9Vdt+zOpJ8u7ma6LsVC9aqVBga1pyY3G+X6vg9X140i0ZNvDBizEaPFZ9iSJvb+jDkYa3OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818534; c=relaxed/simple;
	bh=LdmePwj2kdp+plry1N7dVcpkgWVO063DfcLTWWbi7Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXADLoODZPneWAdzP+u0oYsFIroPN4ZW70bSakeZZIUVnkepjxO+A4jxqKE+3teKsymvRN1imzcF1HjvnAtzWYQspTKeABbePAspbpCdldP9HqUI01WqMQOiFd+okEmF3NgMiYuIXbkq0M+L4Jm3yPnRiZ8I+Rr9tddT9JeRCLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiqwdH3s; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiqwdH3s"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bdbac72ac1fso1064432766b.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 11:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779818532; cv=none;
        d=google.com; s=arc-20240605;
        b=ZrMcfXGwHPt1TGFLueqciNWEwW368LKGAWzXudNUEOjK7nSRAJm2E7IiN5UMldHn6F
         RudnwJgBHIVdSSpBX2TLs0zJGVug+dWMCupa6aAfu3EN/G+pk9akssCsuXG7J1QBkxk2
         eUU3WIA/+w/HBc4Rule0V5TUbdQMgE5hSUMxJPD7Ri9baRiAnPzYHFsUVLMmnQuBaqVu
         JQgnbrYele83UoQmdM+8LIW6QoXYD7x0zM9nqrLzTuJQgN9FLsvQMW06p8h3DEw64thu
         ZgylH4EPLtt/CKIxMY+20dCO+WHvoC26hx1jtvOOKpnkchRiVB7eVgcG/cHp+yUa5rDM
         k3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LdmePwj2kdp+plry1N7dVcpkgWVO063DfcLTWWbi7Pw=;
        fh=oKNjM8rCnUi5Yj5wQBourO+k6f1W2bFB8LwBI5ca/V4=;
        b=PnXpuHgFsGCYXXOsyL90ZWhbbRx4CiuGTO2zGLgIT3cmOL4HPfaGObfGURhxc//xj3
         SD63ylJI4fcDeJ7rtpAYqiPsdXW4arinlOZR1VeQAgCTGXZTXHtYzlrkslnvEr+GGm6t
         Ny1h2gDVdCrhq18e6YdqdJW3hMaECPTLBk5jO4BD2KP6O6w6JEHFZBkSd8MuMLlJiLOP
         AVaSth9PwDApmVFPQEftPOQbnr5HfzKuRVLnk5Moz+IvbscWLouzpcJR3Hpfmb7gUuKX
         c3h/dt8009UlBGnzDRTmneZzacwYnZaaAM26DxIbSGPXv9C/Mc2k5kUhMESuNZqMqfE+
         0nkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779818532; x=1780423332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdmePwj2kdp+plry1N7dVcpkgWVO063DfcLTWWbi7Pw=;
        b=fiqwdH3sH/GAMU/ep6Y+msn3+fPXzx88zYaLDFp/5ZE3jveyf6O+8iWcIBl6ntpY1M
         Sk5d1IgXZ+RNhxLkBWEHNJUgd++Gjq5a+VuDinU/tqVkENppSLAQywq56YfHnRCT1UoV
         Tv+c2HlCmCj5l22+Imyo8FMaBr2wYfPvdw0buAfyA92e977x26ciPFJB29o6YSictWDj
         guT+qIQ4aiFNAw6K3Qi1wv+xIJZeLNDCuPVvqYTdJVX2/YLtmwqtvCE3NOu0Ipy5O7Eg
         80G/5rQE1MHGTMWNwGokIQ70KPkunuwHuMakYTs+JxuQBW+0mQU/xstAA/3QBNCSc+ai
         4+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818532; x=1780423332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdmePwj2kdp+plry1N7dVcpkgWVO063DfcLTWWbi7Pw=;
        b=kjXlufw/LyZaPpWDuaFm8ieGYNZXYbTn5eyyZLxfyimfygVk4yyN4lsTcF+WtXjIl1
         /VMrh8xBgRzU4OvTMtw+zSeG9VPeeKUAhyHPgYzhR+AZGhvc99dwhQurPINE1cvOrv8i
         uWcscEMBTl+efqNNsjqSsAzwFRt3zW/uAHBuncuQN2Td6ZaLiIiWDaW2rTIu6DsiKlLm
         hK09QE8Hv8KeS6fnoRYm4LuhLMcU8PoLmhpsd8Zg95i2+w+C9EVtDUDoB0GPKfdFjqM3
         H3uFA+hyYjv05ElhPyKUpoTQUIRmX0pY1icTQAA+5F5CfJ2azAAN6DWP0V+fjGrxb+w2
         EISQ==
X-Forwarded-Encrypted: i=1; AFNElJ919g9rD77PzAsNqA2TvWZuYI1toGKhppos43unN2jj3/Kh90hz9t91GIda10BgLLpRhMnQVl4ec5bP/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyt/NtsGSg5LlHxog+uF8uC8BoKZhxEqheMyKb6YIuPxTxoAQ
	+XBytQh1EQstmXZJ5CXZz+l0q9FtobX0Cw1bqn1NKrF+CtVsWsTfmkyhjOlgcV0lDDMf5Lmw7Da
	QvnI+YX9uTK8r1KCqTDf8iGs/bIxo0ks=
X-Gm-Gg: Acq92OHFwDJ7sSWFhOhvY4DZzY1mXD0jSltlcX3CUQ4qu1OyG+FY0HJHfyztq9iLhPY
	VzqTFHSb2Pn0UBHQYAPCUEPxv8aSo+kw3Kbbn8bz+9Ls47bFPWOHkpaTdkhQyofBeHF7jrING2Q
	bYnjEHBweM5QG3p2c/pbmSSpcP1eEdPKjna70fFQxXEQBlrxjyff3aPrH382cshR88vJ7ejv7T+
	vJafGVwrOquJ9D5YmGA3Lu7BWzFZ+P2CHGXyEDyzmtUnPWHGM0inrm108vQnB12iT6y8rlesvQJ
	WWDBTtc=
X-Received: by 2002:a17:906:23e2:b0:bdb:11d9:43da with SMTP id
 a640c23a62f3a-bdd22a401f4mr884624766b.4.1779818531675; Tue, 26 May 2026
 11:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522220025.1770388-1-coshi036@gmail.com> <20260525055810.GC3293@lst.de>
In-Reply-To: <20260525055810.GC3293@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Tue, 26 May 2026 14:01:57 -0400
X-Gm-Features: AVHnY4KO07v2vwx7qZZg0vIerDYLUbOvvTNKVf_FsUCAE5Howv8cy39oNuwYb_U
Message-ID: <CACd_6n1LGfuNoxaP13w06HFhgW7xyo7wVkWGE5h0eW+CQGxd6w@mail.gmail.com>
Subject: Re: [PATCH] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your kindly review!.

Best,
Chao

On Mon, May 25, 2026 at 1:58=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
