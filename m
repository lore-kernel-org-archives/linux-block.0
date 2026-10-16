Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5554706C
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158536; cv=none; b=gycTb1U5BILpIzn4xw1FUQdI7ZzITdqQhMNcuXNXnGvVQ4sx6rMHfBtICz96I+KvY2ZyL2FgDoMk3kDv4cc+h4WUHpFD2PpLn8GUthe++n1puwpSxiuBqzpEuRE05Ms3gtWIyrYysK7FZQXZl0rK1MMdxOOpeLMtuePK6C6eHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158536; c=relaxed/simple;
	bh=qap1eOGitYV75+L/QKg9xm+U2tLDgEHHJGYhahzwLNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhXheeeRfZFOngfhHcJfP+ybEZvf9ksCDVpzAnistF1glW96hLE5/br4X8joMpNFXTh0KPS+mLQZyyCWvJAcENT3BDu2qstwycN1en+8LRihYJNVYa/nCA5FT5pV2SxAdw7tpgTrV21NX1RlDI8pT7MyoDcx/9S1TCx/9/vJEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXyzV+9D; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXyzV+9D"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-144f79153f5so870610c88.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158533; x=1792763333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5uF+LfQczF3q7pmbkjozwjBwMdX5SJot+p3Vd/HXF+0=;
        b=OXyzV+9DdmB5v5sTvPfcd58P9I0M1XdYAkofvygaDhgnhbz2y2/dfYKPOKNDkADwCe
         2+zXDEckGwqW7cXcjCMgc4LkKVHrLb/wRDmMYhM81KycdZRtFwJL46rJpinqi0p5ebky
         vgQay7OYzjPxHWpIBDh0V4Zh7Ci1q4HY/qoHfpzNu6NNLw+dwKojcH8jF6LzkVOQHqtV
         9TP1MUNmGWoQZS37k+S7D2JsOVZVuxJd+asQpuGj42lcTtV/xltbiz1Z0T6P3gkNr7JW
         m003/kNphSMkQa9wg30idhUriSfILjukVPYkiHPx3FOoKgk2zPQUaI80DDwxxkwiwQ3H
         /jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158533; x=1792763333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5uF+LfQczF3q7pmbkjozwjBwMdX5SJot+p3Vd/HXF+0=;
        b=dS9ShuHKz57y+PHgZWW0TIOZ0wF7tqPW2ihbiWP0R0ROGORDIIv5WXUtbhkxaMhH/b
         avFESIdI8hF78vAiNSQFseI3Kxlfqms6abmVkRvXcCtUsr93Le8rcHZwhhrUMGjtvJW3
         i7Dx1BCT9J1Fahy6Botf5v5fRE6YEHaYwr6SXAuf9/bdAEkvgUZjhF4FnX2kqwy6TMBI
         eLh9wzTiOh9IQoQxTjMylFEGRxUPINz61vzHV5Tlw7+dIH1H9W8hlrYurRmvrPmtzk68
         Q/9xA9wj1xmnBzVX+1ptyU6ZKs/c4KUCev5qtIRdziZ53+4vTZUo75dtS7nN9kilEOpA
         9IoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwc9LyUFxNLkTil4eUNx8cryAv6nVzd237yzJb1LyHAzdk24NVkMhKAFT4xTlW6t7xR2O2DyGDIvZxhAw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2N2cMRXYNGhSyDI+UaDRzhdPgZXkft3qObqm0YeJfQ0UJQRr0
	gJPKDMvdqR1WC7gOl41q41peSxAzfZ/1ZUfeVxQvvMguly21bOxJWGKp
X-Gm-Gg: AYBFou3aik8jfjW96o2ARLywIRd9oHfsfdjOeL9zBVu/SuPvJmfgkm5NaMQkYZHNpzB
	B+TpEManudvgkUIPjXzCoxrHxMdgS+4N3tonD1yK63CA1PMRA4zFtz64zTsy/e2bSrfzzGNY9Gf
	GYgqz50sjwNmHUFNFg5XizyHzxEjQp4rOTfRBoDHMKt0FvaLxYVk0pYAz68e/JOsItYulGkI6Hk
	LmtIPkTJko5sxvYVvZDu1u5jMLQxQnzjh7xlU0Z6xllz2abGPg4gkSDQBJPp3UApHSrF+jrrH6H
	pN4bvPo+6AmM2aEsdT/C5dwh3jkn4MnpzfF0DO9Axw17avWW+IziTN/shBnxZcDG04kXopeHhCD
	j87N6RC6ZD62eN/MyTWfidL2XUVF1tTt76mEDCTy4Z7de9t6qoUgBGyHt4mMvhcEaodHBD0WVrn
	u7uGSZk/2YlbW01SkOzPuXgfNH4B9hcYNXU1I8KdH/FVFbP5tMKiOK8OP3EPBm4XwMPukoioFJ2
	TKOgkq/rI44qa0ycEmBnHaKdE9eonuY/r+NzQKagTyrliU6PLAR7JH5Kyv8Pbu9oZ9UgumlR5U=
X-Received: by 2002:a05:7022:43a5:b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-18511eb69acmr15578c88.19.1792158532965;
        Fri, 16 Oct 2026 06:48:52 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm7956376c88.6.2026.10.16.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:48:52 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bgeffon@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Date: Fri, 16 Oct 2026 21:48:47 +0800
Message-Id: <20261016134847.1620103-1-zhangbo0325@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atHftz13hWzGludk@google.com>
References: <atHftz13hWzGludk@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 17:54:25 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> A quick and dirty patch, as usual, just to play around with.  This
> attempts to improve the reader side, because the reader is side
> much more sensitive.  Tested only with zstd.

I applied the cross-CPU borrowing patch on-device and re-ran the same
zstd Android A/B, so it can be compared against the preempt-disable
numbers I posted earlier. Focusing on the read (exclusive decompression)
side, which is what this patch targets:

                        9+10+kmalloc   preempt-disable   cross-CPU borrow
  dexcl_contended       15,919         54                1,447
  dexcl_wait_ns_total   109.6 s        0.68 s            3.66 s
  dexcl_wait_ns_max     145 ms         34.6 ms           26.6 ms
  dexcl_avg_wait        6.88 ms        12.6 ms           2.53 ms
  dexcl_acquire         2.21M          2.75M             2.94M

Borrowing clearly works: dexcl contention drops 15,919 -> 1,447 (-91%),
and the residual 1,447 are the genuinely all-CPUs-busy cases that fall
through to wait_event(). More importantly for us, the worst case and the
average are the best of the three - max 145ms -> 26.6ms (-82%), avg down
to 2.53ms.

One note so the table isn't misread: the preempt-disable column also
disabled preemption on the *write* stream, which is why its
cwrite_contended was 48; this borrow-only build has no write-side change
(cwrite_contended back at ~16k, as before 9+10). That's expected - your
patch deliberately leaves the writer side for later, and the writer
isn't on the swap-in path, so it's lower priority for us too.

Scripts and raw numbers on request.

Thanks,
Bo
