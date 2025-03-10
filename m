Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2211B3927
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619885; cv=none; b=WVxy9ViwTLBtBfEayubV+5qTFqgPEPV7iLUL7vDHHdr6I+AdJ0vTx3a80dKrcSL9UNfmvSxVsEeUVLBftD1n1lGzfNeEQYDhfK3SMgCn1fS6c0Uxzmi0R69UjVvvrajna4EjlX6tY7a2B9jA28iGpVrWexKE8sXgb9BuPdmh0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619885; c=relaxed/simple;
	bh=bPylOSDwS97iSZCV+IEqBXVcR6T1dmvHZUxK1IgpS9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=usMjnKgwaXKILig3XMmVYYa4k+VCSUDDI1GqrFp3DpdoL/tEP0DUBGIb64sqJkoYiqq+1KxX4/4vKPHscNDLVv2ArE6yk/wwV3jlbWWDu9YBsD6w0pX33xJAiWh1GphhQ/rMX0/epwXT8B710rW70r8m59K69ZqJGWCG7NMU4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r5qPsxO7; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r5qPsxO7"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d46693a5e9so2275295ab.3
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741619882; x=1742224682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJONlHZ+GagU256YR9i4k/iT8kbk8lsmHf8ZZIFoi8U=;
        b=r5qPsxO7zJjb+EM2lDGjAycLC07ZTQ3KOufDZU5/3eB465ILeo7DWNujMbDJhvQQ6n
         jhzTe9FXDgfwQQ3pxtyFRDpzOFDOz8Axs8aOD0rQ92E/VSLJ0MswlVCNFfmVpnkCoy6r
         FyoGUy/rTJGsytx/Yb0R8ccWKR8rwATbZ0ocqSE8aHz37TKA71Gm019PsHJUzW0wRnHE
         vZn/VhmfKAg7o34DaHTtansori9mttCQHRrP1vzJ1Fh7aMiynUqdcCSnEN34rA8tEbJc
         IeK+FIDO3Bz99UP3i1l7LYl6/ZNC39sj7/l0j6CMW6v20wcO+bVxonG+cTjPpboQ9wen
         24pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619882; x=1742224682;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJONlHZ+GagU256YR9i4k/iT8kbk8lsmHf8ZZIFoi8U=;
        b=PZdHch1E4ezmKcJ1pVYe26JfzBvMH0QeXdA45LcwPbfVTQbvoTH86IYR5I02sb8tTk
         NkZG7gwaylxgGK6vw7EQgiJNYAtjCOV7rHc0puDnVNF8EZert/oNQekhF4Eqvzkpd0Mk
         8glNYcokcZzrT74v8Rvwu5p1uFTzwzYNgv5Ow/Vjdz+Hweo5THz4vkqTfZQ01aTVj1Ff
         RxTqB+eFfn+R5FDpooy4RVR8LFt43i0Sg9m6XgQiJksyDJLGR/zS5JKQt1RRZ3TcPVIa
         EInwc+I1nepnt5W2DDw0F0ZjNx9AwrBISm0dj29NUz+vtWvRWuV5NWeCMV6oU9lId3hH
         h8TQ==
X-Gm-Message-State: AOJu0YygzgSUk9FXKJiunVMNN02l4wvdO/VXIB9PTG4qPNkwv5lwMEsi
	antLPjYMzAglEdw8qnOE8csHKetGXBNz3OvWFe0IGI5Mau4c0QkUvcHIJIucNtZ5z1i6VzbPx9z
	5
X-Gm-Gg: ASbGncteuCW9/OFLzVcJruKaU69B2Yh08ILr3QUP/x+4LKDgT7cS3uOleP1TmnrBGYS
	8sGj4dU6AiqxnvWWtsPl/LbCrImbrcEJGfPg7PfWU0gpu4KNj/SgVM25fx/cdHAKcl+HAvdx+oW
	hC+daGGWjhMkvaK2KmG4ssVGN4qMHQboc8AY+EPIwJM7Ogdz+XPB6BdvRitwghfsn7fTDn/oGdr
	GCISNGlW13NZeJFM0x4f5edUpDbhsWJ1wjox2KNgPRbbiFofaqTpDnXCK8SwQRWjESUsdq/AnxK
	nPP5FkRYZEuXCA8oGeeGRLLqEFfoPT9SrlI=
X-Google-Smtp-Source: AGHT+IHv9VsH6yBvvTt1jAq7zvObqCkXqipABSruyTT1k4fmXx9mvK0swA53Jk2vVY8Ndp7VAb1ADg==
X-Received: by 2002:a05:6e02:1b0a:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d46890d179mr1277075ab.5.1741619881935;
        Mon, 10 Mar 2025 08:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d459e2377asm6121355ab.31.2025.03.10.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:18:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-kselftest@vger.kernel.org
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
Message-Id: <174161988103.195912.1952372188242377031.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 09:18:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 03 Mar 2025 20:43:10 +0800, Ming Lei wrote:
> This patchset fixes several issues(1, 2, 4) and consolidate & improve
> the tests in the following ways:
> 
> - support shellcheck and fixes all warning
> 
> - misc cleanup
> 
> [...]

Applied, thanks!

[01/11] selftests: ublk: make ublk_stop_io_daemon() more reliable
        commit: 9894e0eaae980df1ed3f2e86a487fe4c8ef1ab46
[02/11] selftests: ublk: fix build failure
        commit: 9d80f48c5e08b2e003e506c6e5326a35a652ea2f
[03/11] selftests: ublk: add --foreground command line
        commit: 2ecdcdfee58c028c15ed00b691104249370db075
[04/11] selftests: ublk: fix parsing '-a' argument
        commit: cf2132935639813a0b88e55074e6e52a4b82f26a
[05/11] selftests: ublk: support shellcheck and fix all warning
        commit: 30aab83035048c70e09ff058a73e8428de9bd103
[06/11] selftests: ublk: don't pass ${dev_id} to _cleanup_test()
        commit: 8da9f88fee59fe5aa99014a2621b07347edd5780
[07/11] selftests: ublk: move zero copy feature check into _add_ublk_dev()
        commit: b95b47eaa8d7c8b595d93397d1b85f1559c2d220
[08/11] selftests: ublk: load/unload ublk_drv when preparing & cleaning up tests
        commit: 9e71305495d1b79f96729b8d77d4d823a6bd998a
[09/11] selftests: ublk: add one stress test for covering IO vs. removing device
        commit: 6f3004e78b59e98a903e20e2240ae77e76dfde77
[10/11] selftests: ublk: add stress test for covering IO vs. killing ublk server
        commit: 4fcd5b5a6dff71cf82212dd208dc1765ca8a8088
[11/11] selftests: ublk: improve test usability
        commit: 22c880f446a149f5ee11260690a34d4b3f95c221

Best regards,
-- 
Jens Axboe



