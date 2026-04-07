Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67523A3E73
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569447; cv=none; b=uQan0Y+7VFfcGcQ15jCmBbctRMleS0n6l5euxqEGJeICDfiw/hH2xk7IbexD41PmdJfqxad8ILrzBQp01i8pRIx+bcSHg2QirJOO7otiovFGuw9hngrPM0l8VjN+47JD122twZ4fQ7gimq8eXBbcL/mJlSIf1eM6XtX3Fymk590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569447; c=relaxed/simple;
	bh=jZDxeZqXOeOYalxRmBXw8GeT7tmSJbSjr/2+QSi03pE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VjzCct2eUO4Ei68flsoyI62jrFOYp/0ElGOeE3Ifg+S69WIKvy3qgzK3jqlPDhJsW9upNhnl469+Hs2Y1jz9qmHLRGprnmiSraSHRl5Tfm5rL1gC0u7OK0AzFkijrCxzeykeN/Q5IwgOaYJAq54DqX267Vbt9FDwpaxZQyLpi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=w/7OLk0y; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="w/7OLk0y"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbd2a0211bso1982953a34.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775569445; x=1776174245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyYMQSKrY+uQnIpJbWhh41KomBqCGcoZRn2WnfigsfU=;
        b=w/7OLk0y0JG8/+03iyxy6Dh/b1GIdm7p3MIsxmrHM/fPinHsN+zSjUuZ4imBU0fP9r
         ipGuDHph+hJZRPI/Ym8Adr6JSm5z/IjxEbM87VTDKytfHYtsFE22vh8pa9UzsoZS+VyN
         hI7fyIKUxoJZUBMUXOk/Y6i0eVrWiXVXH5ZIRrhw8WF96rA4tkxG490uvyXCTiBSvc5w
         ixLP1sAhwxAgeerWT0WsdjrUl4tmi8ERatD/MUGW8JNG70S6rclQZ/JE1Xg5GrISH+Y2
         vTYGomU4lyIHmQr3ChqYtcADnyFQrls8nuQj1GgTBTra5Y9FhlnHxHXh71uFmIvAjogl
         SWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775569445; x=1776174245;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SyYMQSKrY+uQnIpJbWhh41KomBqCGcoZRn2WnfigsfU=;
        b=rlUm1VbW/+Lokit3yoTgmXPLnzaEn/E3V4G8GsJbt0JgdDRDBdJH4VOik9f2WiHDK8
         2GbYHug+M91PnVZjtiJswKCdf6TJrAFmOB1tfupBwrwjsSvwfTwX6IQbfmiULek4kaIR
         9rn0QpChceACV0MP/oMyqJdcZaRm0WNjqtUvq9w4XUnnmRK1rXdq/bGj0EWmmnI5mm9O
         u4XpEA6cAL7+SKy3Rsh8skNbeARLP/wpQRo2axL7vnfh6R/etshRcO3A1ruIkIyRGhwW
         y02EV4Jn0Gvn/P129crijvlvo3eDZH2Ao3mCCLhML8wJ1Y74O7/Mj/zUFJ/TO4kIfd7u
         +wPg==
X-Gm-Message-State: AOJu0YyUFdSW+CQNOIE+JEt9NmxW6U3kNELiZt+TKiCGjqH92g8mxa87
	PFhogJp46ZWU+BIudH31SlAo5HVWwod5I0MSTftJ2v9HZ3GfQMZcxJj1MMpL6PtVDCY=
X-Gm-Gg: AeBDievl750vZ9U4aXNpTYzDJ549xcs4sbpPu9lxidQ1YWv1enlRelSJAaAoKcznjDq
	wEKslQB01mKd1rRzg+DNKIhj+O5xFvE5vI3GKDRrkZrKHP1hydCjr8pRsadhuuv+4W527ecs6bE
	d6rLR3nt8u0VNAxnlQWYTWzb7J5yV0ilAUoSlnR6QRFMnueAxCKQD8H2mU1knYXmwKmHcCp6lth
	7VXDryt2SdBC4cgSxFnEPZ580Fd5UFl5snKdYA/k/G3xEcYPSce01dY22HUDPspXsNtx0QElW+Q
	30rYOOAAQeQpW5Utjflbz7Lj/WIRl7w+J5O22dbOAY8mZ1tsA3Fed82/LvdqPNsc626/3wxyex2
	0rJmXNqxrD6C2mui+LBCcR1WvA+G6p1T0qcM7k60VdEYmxLvMSqOJ3sWqAKSIqOxjFyOl7zghgE
	ePOSeT7rxlhg8c9pw54eobUJQVZyMm/pnjkQwB7MSwwU3lltnYzpT5qaL06Fm0MdL8IJ0E37o1b
	74=
X-Received: by 2002:a05:6830:81ee:b0:7d9:b1d0:39df with SMTP id 46e09a7af769-7dbb74e7c1dmr9827430a34.19.1775569444706;
        Tue, 07 Apr 2026 06:44:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbf928f085sm1409969a34.1.2026.04.07.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:44:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
Message-Id: <177556944386.174567.16950241476520536842.b4-ty@b4>
Date: Tue, 07 Apr 2026 07:44:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.1


On Tue, 31 Mar 2026 23:31:51 +0800, Ming Lei wrote:
> Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
> 
> The ublk server and its client share a memory region (e.g. memfd or
> hugetlbfs file) via MAP_SHARED mmap. The server registers this region
> with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
> builds a PFN maple tree. When I/O arrives, the driver looks up bio
> pages in the maple tree — if they match registered buffer pages, the
> data is used directly without copying.
> 
> [...]

Applied, thanks!

[01/10] ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
        commit: 2fb0ded237bb55dae45bc076666b348fc948ac9e
[02/10] ublk: add PFN-based buffer matching in I/O path
        commit: 4d4a512a1f87b156f694d25c800e3d525aa56e8a
[03/10] ublk: enable UBLK_F_SHMEM_ZC feature flag
        commit: 08677040a91199175149d1fd465c02e3b3fc768a
[04/10] ublk: eliminate permanent pages[] array from struct ublk_buf
        commit: 8a34e88769f617dc980edb5a0079e347bd1b9a89
[05/10] selftests/ublk: add shared memory zero-copy support in kublk
        commit: 166b476b8dee61dc6501f6eb91619d28c3430f75
[06/10] selftests/ublk: add UBLK_F_SHMEM_ZC support for loop target
        commit: ec20aa44ac2629943c9b2b5524bcb55d778f746c
[07/10] selftests/ublk: add shared memory zero-copy test
        commit: 2f1e9468bdcba7e7572e16defd3c516f24281f14
[08/10] selftests/ublk: add hugetlbfs shmem_zc test for loop target
        commit: d4866503324c062f70dddfdd2e59957d335fc230
[09/10] selftests/ublk: add filesystem fio verify test for shmem_zc
        commit: 12075992c62ee330b2c531fa066b19be21698115
[10/10] selftests/ublk: add read-only buffer registration test
        commit: affb5f67d73c1e0bd412e7807a55691502b5679e

Best regards,
-- 
Jens Axboe



