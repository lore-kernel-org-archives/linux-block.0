Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3D2BFC85
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846003; cv=none; b=ioHpIm2mQkJ4hex18yKnXQdFMS1ZddxZU0wIBoA+OrQiILPBoCxrnWUUdA+LH0OONBB3aDLSerleRDNAEHCip4IIcfPpTRZRbJG8qAdS5+akKRX8Is7sI+zl4zgzGFAl+tDc2LAYNaOyznqMu5YnjOXDgqsL8GkF0Rb50Oet8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846003; c=relaxed/simple;
	bh=VnjjArI2TT9oxqUTNNsUpo1SvNdQAx/kesCODtC6Q48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EI1jYILWUfBSvYhhiZRQTJ5Jxh0BppKqZqQtiDgfc2MesLzXMt5VirZbVck5RPTpQZxDOCuG0C7qr8x4ADu0sqeSvFvXct5mtpRDyKhm4JegZxLleE5QsRLOAF95TO6kY8YECLClwxQenzDZgYZs+Z7OG+A6Vja3lZJhobG0fXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ZFAv4qXu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ZFAv4qXu"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a168dc590cso1818836eaf.0
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 19:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786846000; x=1787450800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qkr9Hc1lLYooEsPvZF2xGEZV9RQr0VpwZuTowoP/YPs=;
        b=ZFAv4qXuzB8l89M69xOXbhUYK0IIktoKzRgDoRZXKdQX5Kc3sy5METwd7aL6abNrQb
         jjHpf7eMRARjYpLhcyJi35dyLAigDVFC/zsajJnRutNqn1B4jaB8I4ql15+DFBOopOsQ
         66yQymOzpRHjW/zAhegPc8vZ7Rs+vFSX8DQJmXA/0KcwqFWvVu7sf4BaPMhysJv3tCnc
         1UkTu+t8Usb7yDJW3JM/dBDNfNQPjpKXERhNSuv0819iZtBxDID7BGpvphAl0eRhgdN8
         s6h5b8FGcfFF/1Cfpnz356k/b/EytB0qsYBekJZFlwxj0GpSSZi0qkkoZaDNWTK5eyo2
         mwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786846000; x=1787450800;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qkr9Hc1lLYooEsPvZF2xGEZV9RQr0VpwZuTowoP/YPs=;
        b=dgI+B9NMJcLGfKXgsxsPiwH9t2StF8jBwEqMNDbMadJXOh9lCvwLvs9bHFp+cTTuOG
         o+M9eLvXtif05LXpF4Hj8KtnPw/YrU4NZtJGQtD2utrFXPia5mDVpwckAEV0Wslp4RHB
         PMNsgEsK61IdNwBfb0i9HCHzBeIxQkURKz0crwbJ6mosCCXVEn38GbYf4P8WEGyjAsAg
         6W3LmkLwQpfWyYOJ3qJZnansz6jyQgBRlOCvHP9WAsrBEGaaxtzR5Yl49dk9eel16bbc
         AXAEkIZvlDCVixW9Tnu14fIZRhihvimNzE+7xqVZSo0JBla8qYZNrAnbxOo4BY/HV5BF
         HfUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/Vn821Rk5den300SJWN+bstI/5i6KhMzHXlE53YNTlQR2RozHoqYr3nPdjr2dby+M8NR9zxY5XxERcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxutmphmIFjbwrMtv6rWP+ceyYcwnSZxb0GWjdzBjI1XU9z1a8L
	h7HrH6kwT+JOJu71jFH1qhA2Xkr0FTvAoWX+GOS0+hnME6ZTNNckdMt//OQCNvOt7+U=
X-Gm-Gg: AR+sD10UghyfTUOj8k24y1h6hXXAKAK77rpzt8YwsgdwPWis2MVP+SellNs30Wi78Ih
	qdr3N7Yr96J0TfZHqKRm0TppzV6qr6TDT7LYtnhnjg7dxzGg7FhIx2K/cCMQn/4nPShDiWVYC4t
	av+v1/SVXrmLe+Vd7Sqdf+gEeFeVjWhXlCwbP836oZ5gmzcYbuZG6muGLac49JGu1EMeDzYzoHy
	bmuCs3hHvY3GB3nTYVwTbP72k6bXL4f4T0HZydkreKT4yCQdBR4ANRAbj6CLElWOOxtkv4ORD+/
	0JrEjJDIjkX1KRtBYRVw2+cFX9FXyep48V9rJirGhZzR524ZltkBFArVJ0QAYRSUuXskK5uxr+P
	4fqy9UPsJGj6knLIfRSpg4xz8d58RjHLcgpvpBuXnZOxBY/zzhqxz2uldE2PHktlMzM7pIbEqBi
	MvCd7hkW9T40EZWYYNYhpV0qZufbgJ8qTzl2UXvr8lR8IojxrrvHsfxc6I2lisUpVMtoy5ayRYv
	iWghrGaLNYyPHNRzk4Yrs1eLzTH+7n2HxQw8q94tg==
X-Received: by 2002:a05:6820:a289:10b0:6a1:80a7:2c8d with SMTP id 006d021491bc7-6b0d690c32fmr10463707eaf.32.1786846000629;
        Sat, 15 Aug 2026 19:06:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0db1e9f89sm5686279eaf.9.2026.08.15.19.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:06:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Vivek Parikh <vivek.parikh@breachx.ai>
In-Reply-To: <20260814151617.73752-1-christoph.boehmwalder@linbit.com>
References: <20260814151617.73752-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: don't leak the shared secret to unprivileged
 netlink dumps
Message-Id: <178684599913.2049660.4334999854490321092.b4-ty@b4>
Date: Sat, 15 Aug 2026 20:06:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 14 Aug 2026 17:16:17 +0200, Christoph Böhmwalder wrote:
> The conversion to explicit netlink serialization dropped the
> exclude_sensitive parameter from net_conf_to_skb(), so each caller has
> to sanitize by hand. Two dump paths were missed:
> drbd_nl_get_connections_dumpit() and the volume-less connection branch
> of get_one_status(). Neither op carries GENL_ADMIN_PERM, so any
> unprivileged local user could read the CRAM-HMAC secret.
> 
> [...]

Applied, thanks!

[1/1] drbd: don't leak the shared secret to unprivileged netlink dumps
      commit: c71bf113dfdf426bdaf106636f573ef87b6613a0

Best regards,
-- 
Jens Axboe



