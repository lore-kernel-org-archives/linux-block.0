Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D438FAD
	for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813281; cv=none; b=qAFhLL5L3iGLojc/XPdYzAm1SyPLiOZsAgNHatWaEMAc5nMy0ACnajP0N5D4Xnr6N1CakU5r2GvJC0W0aQEgwQs8Dt02V5PwUa7duHhQWTyHMxFHN9I3VjAWRHbcwm9twyIGJ33w23fdCT0mxLLyddwB3s9tSFo5VNBm2U8TbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813281; c=relaxed/simple;
	bh=+oBKUfU8/1Sra/N74rv4ytNfXrBn3Z8bSXDcpQXYfg0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t7hOBzhL0CIoS/Jreq0se6V/SaImgZRfkv7cl9tMvto8VjFAYO3ejwbB0TP+viVWLqT/kFpvgWBgwdLzVuoBLaKz99Lt6PbRq6UVdkj+2VR/h/f76+H26fWnSkFEn1DxHAXVYMG2/Oi0jO2oMytlsaARDqBMK+obaA59WANbBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R1FOZNcc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R1FOZNcc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso14370575e9.0
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2024 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726813277; x=1727418077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLzM1ahvHfafy6aED/dhPY6v5XZOVDgxNFlMplpL260=;
        b=R1FOZNccNLJqhzIxj2msW0dhGKd8uWlfF0LvDVhRkApsDVGafRy3rtyZtl1qPkjoTc
         U6Socr5pOw8cJAoZzvRI3fjBzuRpDOR2QCMH5JjDqNYPOnfxZ7AluAJeqAmLjwdpjjVJ
         ag8etwT6a2djBZ9JG77TTOARjSjPiumArNBUJXBzwhxZDbl5fSK9mN6HMiW9BqYdq8KD
         YK1gXiB+rE/PED6YUZtACOQJSWHzyStks2fBzP7rqwp6xsXF5yDqN5O/HRPsxgh8jnWN
         qormm9ZNu/szStWWkS7GbFAuOLf0pbYRExrIS5Nj7C3HMMcOyb+iBmRDojp8jcQkDWVW
         WchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726813277; x=1727418077;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLzM1ahvHfafy6aED/dhPY6v5XZOVDgxNFlMplpL260=;
        b=LavBp4t1SiT+dFDn3F2/7S6MaaYqNHfQv3rAaDFi69vBnla2egJ+KG1I4lhAjXhF7C
         oHOKDBlg+vuo/8QRXQIkmnFYeQEfsE2mOAbN1Uc0AuD/fid/S4Xrow1+OT4dq8BaYRs0
         oadlxXnh9kt91FsziRjQ3287B9aMnwWrXwzmmJbfXqi9uxofFjJLUB2hr9PhHeXYuTy5
         YiXqcCGDuKmhu2HV+YkX8x35xwdhmEQTGrgEF9KIArJeOmOAGIZ3Zraq3Aso5rC36bj9
         dXWC7D8/EQeUhSM9jytlPd14aqGDpkJ6bhLdTXi8E5r4fqB+vcdsjJ8En7pmxsLyH3u+
         5TTQ==
X-Gm-Message-State: AOJu0YwY+6YfS+ieIDgvw4cv7c4h9tauYGAUVnyo851C9th+2wjUqDAD
	ZPFBoaLIFw0VgJUD3CE5PIYRqBlH6s6fuQX/A9mgKlQDlns90AkH3lpUjM0krJ6yXMopTQ7kkCS
	ySbNpPA==
X-Google-Smtp-Source: AGHT+IE67V6mMm9L8Wc6srzwQd9vUOAKRzNMriC6et6+cEb4w8LFo0m6PARZ5L5WfECXLLQ3voBjsA==
X-Received: by 2002:a05:600c:4ed0:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42e7abeda5amr12221195e9.8.1726813277440;
        Thu, 19 Sep 2024 23:21:17 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm39780565e9.21.2024.09.19.23.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 23:21:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yang Yang <yang.yang@vivo.com>
In-Reply-To: <20240919021709.511329-1-ming.lei@redhat.com>
References: <20240919021709.511329-1-ming.lei@redhat.com>
Subject: Re: [PATCH] lib/sbitmap: define swap_lock as raw_spinlock_t
Message-Id: <172681327480.42824.5229268259914084398.b4-ty@kernel.dk>
Date: Fri, 20 Sep 2024 00:21:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Thu, 19 Sep 2024 10:17:09 +0800, Ming Lei wrote:
> When called from sbitmap_queue_get(), sbitmap_deferred_clear() may be run
> with preempt disabled. In RT kernel, spin_lock() can sleep, then warning
> of "BUG: sleeping function called from invalid context" can be triggered.
> 
> Fix it by replacing it with raw_spin_lock.
> 
> 
> [...]

Applied, thanks!

[1/1] lib/sbitmap: define swap_lock as raw_spinlock_t
      commit: 65f666c6203600053478ce8e34a1db269a8701c9

Best regards,
-- 
Jens Axboe



