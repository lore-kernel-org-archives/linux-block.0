Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437193;
	b=Wjhp9POyfGfn1OEuqjJ1TMTOxdLIIqUq4rv8qioih+AytDEIoZfm6WJKMRxX2tnghXAW
	 krcjhLQzitn0H6OMlDFwELxf4IgtUpc/uHR4qyaM1rDQbcKRGHM2wnOJWgZgVZC2y5vQY
	 IDvSVlgz5lADhh9Nx6Bfkzb1FP1xL4LqMOO7MeLujUbplb7CY/PcYdXDYy3d3YOyL5k5w
	 cS55wEjfRePfFBOADKaoJUQe8TByMHqoF9g28uO6rIGKD6EW2RseSxQUiOl5gX+1sZM0p
	 c8G6/MYdtjfFbYs8pDqZta1DCncJeYlH3Y7txgyTWfy0W9iQkydGHZNxILcRJBgpXyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=BfzRFGSzfApVYkFziw+urgr3LjBffHZ9syX991uudOQ=;
	b=hBYyBEQmSub51949SLXXIEVyagRkJTK+1UdQ+Pf02RYBvStv547nfSsuAjA6qzTPOS56
	 toCnqgk6UySd26zdMHYkYA3MzGT9AAKbpAr4HkY6hKSLOjVgDyQEFVJZ9oUeV+irMK9MZ
	 W7qoB4GsDuG6Oe3e/687h9NAu5k0oF+/LhsiEQsVsiqdgkSyBrkDnH7RVeRYZVw5M+jCz
	 T/Mpfid4vlfGw9SW9As/1TErvTH9ObIcGdaTXhFFCmAVRtOfUC7wxuJYxa6pNY03W98k+
	 iii69LzmIBsaoJxtFokvfESa+irAQ4XIHJ1x8vZWGPvC7bY7VMTbKZqTLzrTd17r+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kf56OLCL;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA5606A324
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 19:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDA5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kf56OLCL
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6cfed5dd071so2003834eaf.0
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792437191; x=1793041991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BfzRFGSzfApVYkFziw+urgr3LjBffHZ9syX991uudOQ=;
        b=kf56OLCLmnQri9wO8/Bg6f7z1sHz8HW6igNX1NKch+QcZTAAV3eb5432k3Sxo2oXZJ
         UB/iYwet/kjTealzUWxk0L05/+KsrFywD34bChvVH6mtiYe60HYqzWvKs59zyHw617ro
         Qx/8zZLHmBDolqJJNKwfPMXtp++xsPeeujnhfk4XvCH4ReuyhfgBS8R3kCyzayl1iYT4
         FfZuv1S6ih1mGfluwO+DNbLjqLCa6JxIpEkNoDhKedEWTpk0xXMFdfmJf7NTUsy3e4TF
         bfl3HG4pVPA9c1M1oyd2CJKTa2gA2C4Oa/+IoukjeAIdTF9/l8Cjojdn8uQUZo4Y1qDL
         96NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437191; x=1793041991;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BfzRFGSzfApVYkFziw+urgr3LjBffHZ9syX991uudOQ=;
        b=PAcmU7xxMrJKtpb6sGQCcU82imhS0yZo6EPo7PM841YK4DbV3eF2wf1/BHd7G1HHiR
         Cg/ZEcQf2FkH5exGWST6Iwf6pqBbwiO3UD0hNm6OlB3oIryyH3CCYzCnAxJsq1vGT3jZ
         YCkabXJ87zWDVsyp5yRQnVtQvkBEe76VoPwEQfI5mxEzHl+P5pH3qOovjvZL0cY78yp0
         MYnfzGMLeJ21UQl/AWRofCS1ttk0FdIcuNFdsOFHpE86DmM/C2iHodwedDUO9XOEqr3C
         JHbu5XfxEuSbVim6Dm37IWzBWNBeMXi4dvxmUX5VzVD4hQiYki67tKbVGkTffgl1oRyg
         iNGA==
X-Gm-Message-State: AFq9FYL4LFIJ97QHkKMcHYzm5yBEPjDTF9tb2LbsSBOYWs2GS86zABf/
	pqY9X9Nbodyc0Y0HplRL//PPRGAn7jM8k0ZJsqN5nO79u+ikQW+ZWEBcq5xugKNy2l0=
X-Gm-Gg: AYBFou1F/M0KvAURS7iZZPhMh6Cs6gerex6KYmNZ0eUdVZd+sWhiYbyggC22oyAqhUA
	57rxHE9I3B4u3kjqHCSMWRqYx5pyZrorOVhW/ipZrPxWmv3zziKYNRYgU3fHLMDsRmSfSbZt3Ci
	80T+JzrH51cO3ROmNgkX/gHVzfolS85lnpPWJN5JViL14DZG6IqO/KSkwV+LPjetdY0mIrOtAeK
	aEcftSfDyyVKYvQF/nJdm8ioOv7saoYIoN/2v7xBYQrxKDj6FXCnqzZo3EcQgWYY8iSFGrRyXN8
	fBhKgIM/X6MmXvNsBWV1CsoST5aHwR3/tFk9hv2m3sytm9gNoiH+2G7IoEi6G4ZeIXpQKOVS/A4
	WGIICpqjKJkKdMd9oENvh3Hag1Hl12cU/l3NabI6bvykcIcuPVLGYHDU2e+dKwx/vS6RmHYNpr2
	m+cq317FCxrROXwGf42l/t1xT/909j5dp+e8AFuptjO0Qrt5nrPUO804PJPJh4fL5swSME4iacM
	/y5tOaTDyvrmrX5QypZR4XgpUkY8/rGHEvXreRzVCgaWF8BYSQPhkM=
X-Received: by 2002:a05:6820:2087:b0:6d9:9cbf:4770 with SMTP id 006d021491bc7-70356f98829mr5862111eaf.52.1792437191282;
        Mon, 19 Oct 2026 12:13:11 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8462659e3f0sm6669149a34.17.2026.10.19.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:13:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Dominik Maier <dmnk@google.com>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com
In-Reply-To: <CAE7N4Sq6_M610g6gOUJCkkoBH06Kqbndb7KhGGLk=WCHOqHbtw@mail.gmail.com>
References: <CAE7N4Sq6_M610g6gOUJCkkoBH06Kqbndb7KhGGLk=WCHOqHbtw@mail.gmail.com>
Subject: Re: [BUG] loop: missing BLK_OPEN_WRITE check on LOOP_SET_STATUS in
 lo_compat_ioctl()
Message-Id: <179243718847.3127071.16200314156503584253.b4-ty@b4>
Date: Mon, 19 Oct 2026 13:13:08 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 19 Oct 2026 03:16:31 -0700, Dominik Maier wrote:
> In Linux 7.3.0 (commit c03c1a14507d), 32-bit lo_compat_ioctl() in
> drivers/block/loop.c (line 1708) dispatches LOOP_SET_STATUS directly to
> loop_set_status_compat() without checking whether the caller opened the
> loop device for writing or holds CAP_SYS_ADMIN.
> 
> In 64-bit lo_ioctl(), commit 604f275f9670 ("loop:Check for read-write
> open mode before setting status") added a check requiring
> (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN) before allowing
> LOOP_SET_STATUS or LOOP_SET_STATUS64, but the corresponding check was
> omitted from lo_compat_ioctl().
> 
> [...]

Applied, thanks!

[1/1] loop: missing BLK_OPEN_WRITE check on LOOP_SET_STATUS in lo_compat_ioctl()
      commit: d1be9e57baf20bf25a3fe6acb05fa9e9f85b2f16

Best regards,
-- 
Jens Axboe



