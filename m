Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294241C30A
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906155; cv=none; b=kQThTof46yMiqkFacYH5JkQ6a0TXutg7DwD2KgWK2MKZr0czgSYwBaxMVRivniivjj9ZeMnxsI1uMLLi3gCTqHGLw9GYj+Ww8i9SrZZFf/2Y7OuVdXgNN9qIDKKl4oQMwRpLQVDB/xlZ0DhpG9Qur97YQEth6ktImBgAurZkYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906155; c=relaxed/simple;
	bh=h47DogUUNeebCMlQ3Yt1ZJ1zjvOkp8df++frf3I++Ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l7u4BQWGWysXkkPfnHvwq4100u9V0i0LcThJbyWCe3+woEZI71+kukAyOtfl2hczQw7XLW5X6pGBahyIlAc4jlSHj6ZcOAgpQog02JaA1p59JjGhPP8QAVPcpQM1wAAXG8AteUp8sq+b7hXc8is/c92M07kW1mqREYncaFoit8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=zXYIPvb7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="zXYIPvb7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso136811a34.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782906150; x=1783510950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB/xrFSz5cgMUu51lWJNK00xegERuyTiPDFElw1a/oI=;
        b=zXYIPvb7AK+6StHI19V66xoa5pZ0s45Etw4ehdsVreSQWh/s6MmOBHrqKFKG9THZFI
         LlA9EIWNrOyjxnXb2eA6fpy7YeXaLlZmoeRrfnXIlK63gYG04E6hr36d0FSZJDdc+rPS
         fg8PjPMliuA3Zf+/5FU/hK83chNA1DxSvGANANmcbae4L9BXI7DP3NPOMqmrvYndubq7
         W0446F2KWzd/3VM/mjY0qWRdhzf0OZIIoSOqm4Gyphqmj9fdyl7dLf3uErGR2oygzD28
         4QCpeZk72aLvnYymK+3hmYJhRNQTERbLdfoxDiIrLJ7Csu/BIN+d6bCdQjqtZSDH6OyB
         zwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906150; x=1783510950;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OB/xrFSz5cgMUu51lWJNK00xegERuyTiPDFElw1a/oI=;
        b=OkIYj+ALt4ex3B0/pgGmiUH4ZFjtzijDC2cIal1OyjBSGyF4TR9y7zHMts4/LZ/SKp
         uyiZUvOVM+5Dt7Rrdv7uC7brBYs4e34jqkOL45MY4X1S8tsK8q6/Mz+MmoN20yEN5Nnv
         2h2mpNjxZIPpojq00ShJPpiJ+1GulMmI8S4nW+QdDPsS4hIX7Hgqblao8X2MlYWJ3iCq
         mjuYrvFHNv1Z1KQZ2grWCAqLP6g/+pBIC0NDvS/iisaIszOAQLN7JlDhXuQMe2mApAtT
         Mh72YzRSEPFoPxYRok3KHDccCkU2ZFS+KeV0CvsGrRO3QeUAF8tdTktmE8ddBC5ZhcPJ
         GDYQ==
X-Gm-Message-State: AOJu0Yx2id5A0J5cdv20Pl9lhh4kM1EVuL9/3YyxjPdBTUmUuGFhjPmE
	jeC84pmDwOWTcaALEJcp0CrOtUt9HbgeVluYW0mAOr3mMy6HkxA2oGMTvrrOx97LzJg=
X-Gm-Gg: AfdE7clRCzsobvvzm5sWoXPTLgElUobpw8WBUteutmz7ntO0//H60c+PuEoEOvz1dV2
	pyafMGjpjcLvU7sHuTwmav7B1RtWNEs9kXcO0U5aLjz9Q/jT4dCc2zHrMX/dTsa487zSgJlb+y/
	GV2LJ1vL8PR1yPYl7g1KthxOaATV8RaLxIzHkAHVpyCPI6jwXx3l5doYAjFQNwSwgRQAy1FatLT
	YwyJxq+ftmQO2H95WbLgzbnlgHJ7pXTj11mZWShUKOGvwVpO/OLj6Y+CzmNPLX1PUSTupy72aTf
	9XCAXEkvc4iHtr86NTma+Ls8vV7CuvipXK0R7Y9UZQ+mQp957zrsKiKFpy3xujyKtYzZ1mo7JX2
	zxKuuHaf9eyqzfZfT2VM/ZsqODdNAWp+QqxEIgn7wxSvHMDPoQYc8deSjnAqiHLwpUL1K+bh7ig
	BFctwtwVi4C6QoSsfedXxpO3vx5UMMKjtpFaJjh8aSvftj41w1xiBbKVcMqj6AEeQ8cQ==
X-Received: by 2002:a05:6830:6f8e:b0:7e9:e094:db6d with SMTP id 46e09a7af769-7eb48ab7e9bmr584509a34.4.1782906150011;
        Wed, 01 Jul 2026 04:42:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9f328636dsm3668677a34.9.2026.07.01.04.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:42:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260701082155.1369996-1-dlemoal@kernel.org>
References: <20260701082155.1369996-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: avoid potential deadlock on zone
 revalidation failure
Message-Id: <178290614912.198657.3775232855554250818.b4-ty@b4>
Date: Wed, 01 Jul 2026 05:42:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 01 Jul 2026 17:21:55 +0900, Damien Le Moal wrote:
> If revalidating the zones of a zoned block device with
> blk_revalidate_disk_zones() fails during a SCSI disk rescan, the following
> lockdep splat is thrown:
> 
> [  347.251859] [  T11230] sda: failed to revalidate zones
> 
> [  347.261380] [  T11230] ======================================================
> [  347.263882] [  T11230] WARNING: possible circular locking dependency detected
> [  347.266353] [  T11230] 7.1.0+ #1194 Not tainted
> [  347.268052] [  T11230] ------------------------------------------------------
> [  347.270537] [  T11230] tcsh/11230 is trying to acquire lock:
> [  347.272555] [  T11230] ffffffff8f91d400 (wq_pool_mutex){+.+.}-{4:4}, at: destroy_workqueue+0x15d/0x8d0
> [  347.275914] [  T11230]
>                           but task is already holding lock:
> [  347.278646] [  T11230] ffff88812fa1bcc0 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x16/0x30
> [  347.282503] [  T11230]
>                           which lock already depends on the new lock.
> 
> [...]

Applied, thanks!

[1/1] block: avoid potential deadlock on zone revalidation failure
      commit: 3dd63dba8f9cb6990a40af7ed66ee0159f475819

Best regards,
-- 
Jens Axboe



