Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795766983;
	b=g4t9qz1vuC0jg+YJ0oiyJa8ioI7DerQMmciE949BIbTbIQmeNW/Ra7mPfOKuZ9hnzcwj
	 A32UgGucVa9Mq3oqtlSDsBrHyezEh6Y5b39MqRgLBFCL6UIx3/HyOSDhzp+blAq5EzIE5
	 uMNwXhwKfp/o9Z5dOrfoAqhYKsF05y6r6QlHigmULZb11qHMSjUQkhGt46Xgy3CjB0Aqt
	 95tlhZtQxjlV+OZWgbhPc34pE6qck6zmVzKeieiInGqDrwsx4/5YouZCyT1YGgYCZNEZP
	 uSyGEqVTeypZAGeJE/3+okHj3v+nl3aI05xYeWXpzRtT/pDkSVG/94NZgxzucxotYpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lfAZ+eV95Jshg9Xk+E5kfkX1skkeC9iTSDENSIQrVdQ=;
	b=eDssu7snPKy/NwbXIFz2mivz+9nckt4iHihC+gb+lR78nxQtwhHRMV9g9OqCbc19CQS3
	 Bc/DXwcjCVXCJnBeVSY2fcOB8QIBie2zYaq9czDoqqBhSLJOV+xQHntcBxdhozvXMcOdL
	 xMM4oOQhndneaJl4WAFDXmbr+efBDZwn8Jgf1yTMwrAGosfrhs4ZMiSbv2CXMJM3gpXmK
	 mP7lRDU5/2yifd4GP6SxnJbHXoRSovd5Pq6lHVSy2XwLZhtt2A3CEdd5niRpQWBj04qbA
	 TWFjbLr0LrsUQ7zSyNwL9nkrZXEjqSAsOoE8CsiOnE9OvChoLbO/gnDA2Nh6JHrmqeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UJfo/M9Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61E606A682
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 08:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC61E606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJfo/M9Y
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4e4a4d77e5bso5453509b6e.0
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 00:09:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795766981; cv=none;
        d=google.com; s=arc-20260327;
        b=Cf6JgXUWjs98R1G4KNFID3UYIdXEMTrPOVceUCxP/kRo536cNvSPu9hUe2eOWxrxJ4
         WlIIDryG9V5Wz+WzYoUaU9KIbmfXbQACtMSIPyMb+NCrkfRrW7x6SYmI+a5uS2UHsjzd
         4/fuFQFZfsJsUTsfgLZQMJAAcHyPrrWHaPgtS9wIAReik1ps8TBxXsgb58jcobISy5aA
         H2mtqWuxDHU7bhZW4tR0pDKLMcumnGM6wHeBn4ca0GdpO6tcf/lsYWNnKlxFEIIw5BMs
         r9a9CiyQSx+beD9cOiLV2mZp2nMsf6QTssSTQ0pPLh39yf5INczo7K5Rka+yRtQLyjnq
         eeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfAZ+eV95Jshg9Xk+E5kfkX1skkeC9iTSDENSIQrVdQ=;
        fh=iPrA/NbSiIexJ1H1HAVt0fZthCKo3QdtjPftVduZfus=;
        b=J/aJdfT66n9FIFgMdSUQE13fha9SJisLVxjXIRvN5nRzpXoRioBn08UmFcTH/+GJv0
         4TT57XvLVtSwXHsr2IhGLAEjTETrk6W0uWOerwVNTFuE247atfDb495svRiFiR2t6ZJK
         oZTc/w9IwJ9ioVy/aGNHyVCaKDlMB1tZKfU09yIsCo2gRXI9LCuCYh/APNzKeMk5UxPC
         5CtDHxNy0x9pkzSi0HZMsMaggO1q0iGvIxtGT+5Uwg9WWuNy1ab3H3MA9TuJypuGv4cP
         cauJ5crED5vBHy7YVN67ORehXp2OP+qyr74IcMBRcYzo/Enpbes2cNTCBHMLang1fKns
         6fCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795766981; x=1796371781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfAZ+eV95Jshg9Xk+E5kfkX1skkeC9iTSDENSIQrVdQ=;
        b=UJfo/M9Y+aH86agR5L+WdNAthAJZBgv1KW4YobBsiUHeT+8DGstD3A9sa8KmEbAD6D
         2/wVonWaFRqXqx5jFQ79Lb0+IqD6mS70s6tGB+XHyzaOJwmvwalQnxmgyDqOlTNqSwRe
         N1U3kwrgZHkw09myz5Diuf+QmYXI6OhMr+ADY5Pel+gfP9pnMAq32CSNZCdD5rSM7o3T
         gCRoJjVC7qabX1Q6sYeQkwvd5YgM7DdXBY6E139+zfhTlCWNNKFEpbpEYuyWk9YeiZTC
         RW7GZv7g2wX3QdW4UqwmxBsbvQGsMjDaQAXXFdIVR9QXglZ5bINkcnfZgmJnCe3+1+fQ
         Rdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795766981; x=1796371781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfAZ+eV95Jshg9Xk+E5kfkX1skkeC9iTSDENSIQrVdQ=;
        b=iHbeLdegXO+Gr7cV8/GYoPxCv0BD0E9E4IlOS21tWMuDBOghcofxxKT+sqKV2l+KDj
         VjFqQwFTj9kQdhpWHX4KOH2J6sM9vJgs99PTo1lellkgttqUkmS1uIswutvgkrOE6PV/
         6Bs5UMWKuh23U4LOhQ9NdENTeHw0BNEmuW4PWaVsTvdE14/JRZ/lcebGsY1WcOT/Y9tX
         OOz6LtcQCaye1VFdGwuUbnX7TpXOXJTLz7wNUdBS85LblesOqMDZR7lW1bU6DO/OzIk4
         riB0GHk6b08KqbK7q/o6ceGiLUi42KVpIvAl06FSMM/6mx5JaoOSV9e5mKTkeeHMOrHf
         tA0g==
X-Forwarded-Encrypted: i=1; AL+hErHaM26ZCS1MvKI5alPNm9IFMC+ZZMqSdQ88zZ7MzeRKqaZm7Eq27V9nJLWrcBQQTX4v9E0dwS2LWNg2Sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8YgAkvRGZRhMZwJdS4U8tZSuidK2HYCGHbFbt5tr8H9HuV9nW+
	pAYM5HibthhNMQLnTZ8RMzj018xHH25/bRbsDsS7Y9AcL0Z6+Qn7vi5EJ8Kc9vqjM2Ngks4uOVa
	0YC+SX2EcwbdMRW+5a4GqyTXhnlq2ytA=
X-Gm-Gg: AZFdTZcwQewM9A/VyMbMFRvMdkxAFAuJaKBd8aFZZ02iID2tabuBfd3/6shJx3fwuN3
	7WnwM3Rm/cCkN93cCVxuGyKBQkk24s2ZNL1GJytNfrF4Efbq1uKLc72uGognmLL/GbLleHtvBjq
	t4J/duFGdlrtlhC+YUAN7LtMW13iVNKbOyqOILbJ+pSgDKbqxsNNOcIADmqCSGIk7qgDAQmi1lc
	OFZ1OJoWGWjkrEHvsr7nwob4fLROWEH69Ej8vohBxs2NNHLTauStr3587ew9b169UGEM80qvo5u
	Z+0bg6OjJe1pIETgyxoq6IuoqS4JAJBoXa6mLF4A2eJi/YQ4FvhRntaOOtaGpSLn8a2ppl/15fi
	agmi9y/LURQGtE7G4WrxSXVS0vqLXREt6nW17JTMPIWmyqbAIoHPhE6TxHPbjNTrzduvyMSg8ss
	PJM8jvfuOxoTU3Gh1YyS2DNZmQ0XSW0i9cOEMC
X-Received: by 2002:a05:6808:250f:b0:564:57c3:2b28 with SMTP id
 5614622812f47-57a095fcf70mr17846706b6e.8.1795766981639; Fri, 27 Nov 2026
 00:09:41 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126231706.1303486-1-sashal@kernel.org>
In-Reply-To: <20261126231706.1303486-1-sashal@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 27 Nov 2026 02:09:30 -0600
X-Gm-Features: Aa3M54o9OdJEVwey50VSDsmvCuHgnyt-id-FpKGF0N0f936dbtzbMBmFg508QQA
Message-ID: <CACVXFVPGY42hY9qF9485H49xh_ZQm5nPEU-hX2gNVeJ8QBKoiA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/ublk: use the configured kernel UAPI headers
To: Sasha Levin <sashal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, 
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 5:17=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> With generated headers in an output directory, the hardcoded source-tree
> include path falls through to distribution headers. New ublk flags and
> structure members, including UBLK_F_IO_DESC_SIZE, are then missing.
>
> Use KHDR_INCLUDES to consume the headers from the kernel under test, and
> add the headers target as an order-only prerequisite of the ublk
> programs, as nolibc-test does, so that a standalone build installs them
> first. Baseline builds fail on the missing definitions; GCC 14 and Clang
> 21 builds succeed with the output-directory headers and target liburing
> development files available.
>
> Fixes: e371b9d3368c ("selftests: ublk: kublk: fix include path")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Changes since v1:
> - Rebased onto v7.4-rc3, where 3197517875fd ("selftests: ublk: fix the
>   build and file offsets on 32-bit") touches the same lines. No other
>   change.
>
> KernelCI's kselftest builds of mainline 9437ee8b6cf6 still fail on
> kublk, metadata_size and ublk_cancel_ready without this, with gcc and
> clang on arm64 and x86 and with gcc on arm, on undefined UBLK_F_* flags,
> struct ublk_param_integrity and FS_IOC_GETLBMD_CAP.
>
> v1: https://lore.kernel.org/r/20261014200144.1364828-1-sashal@kernel.org

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
