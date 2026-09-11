Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0090392811
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151578; cv=none; b=CSa9KHDNFwLwDU9inEDPkdi3Ij15K9T7VF7zuWmHFQUokoBxwGI9SzU4G+qP9rKzfxy0zaN+orvGY2II9m+/VrbUw1DdnFcasfOUnSPFB2ZJGVnehEuG7OR8aHPk7G+T25+IgUqtsBTI4FvniByKC2iuToEr02f0pqKg3VHVM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151578; c=relaxed/simple;
	bh=KwDZq6pIauSI/3H7u4BpMrdcFbfwVe2Yv5F5yFbCZXQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BWOPUtVOiMGW7YxLdKsuS74iGZeAH+EOl0c+zhTqHbA/G4j5EOuES62u4zjsq+zc7ZSY+dkDK8GxJliPkV5OwKPUssmBOJX0kpkFJhfLZnrZrjXmAwfJar1XoSiAQdEL0T2GPIZfCFKktFABagVFKMZGj2sRveasMMuJqziFaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=lh+SZlnV; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="lh+SZlnV"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4be07e7c54dso973385b6e.1
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789151575; x=1789756375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnPMjQ+gFGAW1M9N+pmmkamJvg9aNQ4EZprY09We9J8=;
        b=lh+SZlnVkOmuwljZKX0GBx7/qb/Mur/MP1XPB15dCk1FXb+mEV0whGT3XPWZln91ug
         5ttJ01ncvccaTJtM2h8BoqHsuVsgmKLYxAHUyUg+nHNmFgXOdibMOBiKy8T0RXtnT4B4
         rW4gVNUqwlBr9O7eWXPSVsPfBXEKLuJOTnnxnJBEs5QkPBy1MmrxcZNyBJyFjSPyGiey
         8geU9UbcS3O0/DuLY/ArA0uPhgEQ4lu+o3KPPNwsmZVXtsOETjC6gTreszOYX1vYp8x1
         cjBcSKgXe6JrZN3Q5qSMPeQ1i2c4QeXlnTkUrq68ZJ5LbGYZZgmfaH/dIPK7QzvURiKW
         CdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151575; x=1789756375;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnPMjQ+gFGAW1M9N+pmmkamJvg9aNQ4EZprY09We9J8=;
        b=oT0qCPjst8GnHMYaHhTzdHf+WPDa3WKSa7YnuiUm4LPCH5aro6P7gB40xx3glskHDB
         JQ3NHYv/3zS+vQ8tjOywmCZLES/57z1TrIdRGvrPZ1FSHrvTWz3wY+INGqNQmdU3LQvP
         Z5FOGka2rswE/3mf4c3pjUYY0GFYWEMeK37Fyt3ettN88vljcWO11BK02xjzPu8IlnEI
         3CYFUsW7uxvQmPK0HmaerB9CcZT9y87FI6emTUna+Xkodu5cuKl8LtcvNY6g07V5V5o/
         agqU/CnWpGBdaHqN1MN6fTF6AReUrRm2U8FqaOBFUzcsWgcOYsu+sehppfXF7n/BIrX2
         mplg==
X-Gm-Message-State: AFuF++nCIrV9tsB+V5b/zuDB6odMa/xp0ZB27+r7+0BXRYAkdvoMhcfF
	Okz13nWWHyg5IS+rkJ6oADI521s/er/iieGTJPfXQkUmeYe2QW5B4XgnruGrdKbjHBk=
X-Gm-Gg: AYBFou1KgeLb70w2RHgXKFAD8aRTCBNeV/oAZX7ad8T7O8mxDWggWtha8UM7BFt0Xv3
	cwzNwEBYMpmOm5EiYgfCacWduhttuOSQVrOSSUTTjhX1eP0/IVhXV3Nch4aKfJHbG8JZDa+4A1y
	8D8eS/3GWB13ikEchCPv7lHr1gTnHUbARim+WcRiewc3MR7FogkQr+opo28HMEFGyjDE8RIfPt2
	H8QA5+REGcd0GNSIgOuaXDHX47T7MpCaaksh73VebhhMA1hlj8TWhVrM3OQy0JQVK1Oa6xm9ClB
	JJOXmdmJ5h6ifb6YlCOFlcJiZYWN1Ia6W7HhT3FV0yik7P6VEPOUSQsg0Fpce9OWnjvd7JvtKtx
	lV2EZKvwhZMktH8bPEVebDb89zavSPchXlo8acQdHc0nt7WW0sfesQxx/UKYrMgbA2zLANFV+Jz
	xDrg894yD3v8q0BVpP4NhunWf3hFAzwQBDT3DRqzjAx1wqv1UTpEoTe2o9PLXFgbJdfsqkRfoHQ
	2y9cmw2uJJMjageSeWr2JCBe0BjJf4D5Fceua1Dk4tcq6KIcCiGP9XFQW03og==
X-Received: by 2002:a05:6808:3a15:b0:4b8:4703:db8b with SMTP id 5614622812f47-4c1a7cd8760mr5660726b6e.20.1789151574674;
        Fri, 11 Sep 2026 11:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df86a1db4sm2475709fac.4.2026.09.11.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:32:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Hao Zhang <hao_zhang_kdev@163.com>
Cc: tj@kernel.org, josef@toxicpanda.com, yukuai@fygo.io, 
 ming.lei@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dm-devel@lists.linux.dev
In-Reply-To: <aqQmqb1k57PXj8Ef@192.168.1.215>
References: <aqQmqb1k57PXj8Ef@192.168.1.215>
Subject: Re: [PATCH] blk-cgroup: save IRQ state in blkg_tryget_closest()
Message-Id: <178915157351.667488.15493767508949300974.b4-ty@b4>
Date: Fri, 11 Sep 2026 12:32:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 12 Sep 2026 00:04:57 +0800, Hao Zhang wrote:
> bio_set_dev() associates the bio with a blkg through bio_associate_blkg().
> If the blkg lookup misses, blkg_tryget_closest() takes q->queue_lock with
> spin_lock_irq() and releases it with spin_unlock_irq(), which
> unconditionally enables local interrupts.
> 
> Callers may call bio_set_dev() with interrupts already disabled, e.g.
> dm-thin's pool_map() does so while holding pool->lock taken with
> spin_lock_irq().  The nested spin_unlock_irq() then enables interrupts
> while pool->lock is still held, so an I/O completion softirq can run on
> the same CPU, re-acquire pool->lock (thin_endio(), or overwrite_endio()
> -> complete_mapping_preparation()) and deadlock.  lockdep reports this
> as inconsistent SOFTIRQ-ON-W to IN-SOFTIRQ-W usage.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: save IRQ state in blkg_tryget_closest()
      commit: 327c428ba79b13e4cc5253333a9d5c0aa5579bdf

Best regards,
-- 
Jens Axboe



