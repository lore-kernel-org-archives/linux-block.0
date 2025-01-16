Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9151DE2B8
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027457; cv=none; b=Yxjx8+H00wxSoxzsZzF40HLDVTNoJyQ2K6Lo03/5VG6t43hrOmz6hP3CJbg0UtbAX3Nn4CD077t9j5Xup6HF7RdVNXdDJgdziIi31Ti07DD8PmSH+iBNPjx4nndTqaelMAnMFMTdWNQ/s3fHjVxAZXvKmVt/wU+hSiibGiuSfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027457; c=relaxed/simple;
	bh=Ngds+py2NhWELW6w7lsXicgpPktv7KP/qm2Cqn+OHwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gls3gs7gQRier7Rh7GdJ5hNJ+V6s+s2EDgxZZxprgPnUF3iKDqdaOeVaNyOQhYYgR040Yy1BxjyEqFYGWfa1sEoiMUccaolUXgmxvLT3eVG4qZX08b6kOjb+b4uz6blUm9PVK3m9Ow8JaJZhvNaEdZSmGMObJ3DElkTYhyJ1nVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G3Gr37r8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G3Gr37r8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso406800f8f.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 03:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737027453; x=1737632253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7stgIKmiTDblq+OqjhHkL/tfKe48xpa2yz7a5pR6Sqs=;
        b=G3Gr37r8HcjaRtNhz/IV4bNw87v2CghQS0Kn7wpPhD+J7BQ41naD2Ndq8YTLrLAsNE
         ClfKiHDiek4X+fTqLWpC0uKFbgESbhZS4d4T8ktZ1UCtuhiklqckUvXI8H2+wg1UW/ku
         v9GGl3KyZfstULfDiW13DnBGdtzhA4BmzNz9BCO3/CKs6QhWXk1JIE48oKJO8oVyTHId
         57R5oUU0DAwl4WMxeqsZx1BPqBU/mkAmFlH64oHM7Nn4kk9+HWcfEVEvoUwV2uQnCqEz
         MRntN1kXgoO51QXRoNuxBiDhJH2769DYHjzQvDhrB6B67F6zJSoRiEnUeSmv9CpHQfg4
         Aahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027453; x=1737632253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7stgIKmiTDblq+OqjhHkL/tfKe48xpa2yz7a5pR6Sqs=;
        b=w/hQFAYO+mu5eSii+4Q/cM7DBDMGkApuIXvPJYCnxh7CJhGgoLGen6f/TgkdsmoZOZ
         8AiCI7zOmOajQOuXvWH2PAHYP5ap0ssTuhbgkKqkP6jXNv+NNbe61U5Kw/STE4sWVv9c
         Zpeo3rbyJEJrfhf7b68XLrgKLdwSIdeivTn8R5B3/Uq69DX0ugeNJbIZHqbMdw5g2JGM
         b/UKLLU3um7FIKaT6ShtwUPwP25O1kkLz+oMJPycnefAdD5eq3/hmbGjPU77TPgVhuD9
         ghsq5Y64AGpURxKL/o2lcCoWjO9OCASm9WSTnIjJxWhriBm93yOCJiGWGa2nft44/nR1
         1J0A==
X-Forwarded-Encrypted: i=1; AJvYcCVeBFG1jZr6N3PD7TZoAahIvUUq+hoINaVOVOMKYa6M7sOkNzQ2jVJ3kMQwqQlgRBECZELGjOencsJA3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjyjlRtL4WQXIaLaEQkEgrDrP58n/ScJO82vSe9NbRe5zC1vFY
	sZjLlDVIm95rjPUBKNCfWAzRS6HKwSCdAzavjIz5ULszTOA73zx6KoEJWWP6VZE=
X-Gm-Gg: ASbGncuMTE9rc+3bKhSj/Q3iyzfesMKS7wugoKa9zlJdX0pnWr4fUOVXAsqmkr2pcKj
	ihdjsYJogMp1gr1Nq5SRRSokx2l2/VeYAxknHNnFZIqLCXVx0xkWWNvM2UaVEbLc4t87TwPHnGe
	+hGg7+pROa8CcM5sVF3DrgZvR+BDoSxBMLPlawmMuIok8aIU3/LOks3ckkI0IcpJ86rUO51W9q4
	cnfaGXP+ESl5Ht9qR+4kx/bnpb98pMuRJD19m4Rjmowv49caU6ohPoUn936TCfkWiQhCQooFZ5i
	Iw1WqScVNwdx3yK//1sEKMbnH4s6SXPqeeARPAYXifb9F7ufDjaBpiWsOTNdVbxtCkGHKCie9AM
	XVCtV/0eWAu2w
X-Google-Smtp-Source: AGHT+IHwO2jJlAnxMchHosPjUJhphRNKR75DhQS708KRZDICK3q5Ej0rhK+BaRodG88L3q982CEqsw==
X-Received: by 2002:a05:6000:178d:b0:387:8752:5691 with SMTP id ffacd0b85a97d-38a87309d15mr28920725f8f.47.1737027452786;
        Thu, 16 Jan 2025 03:37:32 -0800 (PST)
Received: from ?IPv6:2003:de:3746:4600:ac00:378:25cc:9f2c? (p200300de37464600ac00037825cc9f2c.dip0.t-ipconnect.de. [2003:de:3746:4600:ac00:378:25cc:9f2c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b82ddsm20089008f8f.71.2025.01.16.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:37:32 -0800 (PST)
Message-ID: <737c9769145dae722b0274b2a09decf7ab474a26.camel@suse.com>
Subject: Re: [PATCH blktests] nvme/053: do not use awk
From: Martin Wilck <martin.wilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Date: Thu, 16 Jan 2025 12:37:31 +0100
In-Reply-To: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
References: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 16:17 +0900, Shin'ichiro Kawasaki wrote:
> Luis observed that the test case nvme/053 fails in his environment
> [1]
> due to the following awk error message:
>=20
> =C2=A0awk: ...rescan.awk:2: warning: The time extension is obsolete.
> =C2=A0Use the timex extension from gawkextlib
>=20
> To avoid the failure and reduce dependencies, do not use awk in the
> test
> case. Instead, introduce the bash function get_sleep_time() to
> calculate
> the sleep time. Also implement the controller rescan loop in bash,
> following Martin's original patch [2].
>=20
> [1]
> https://lore.kernel.org/linux-block/20241218111340.3912034-1-mcgrof@kerne=
l.org/
> [2]
> https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.co=
m/
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

LGTM

Reviewed-by: Martin Wilck <mwilck@suse.com>



> ---
> =C2=A0tests/nvme/053 | 34 ++++++++++++++--------------------
> =C2=A01 file changed, 14 insertions(+), 20 deletions(-)
>=20
> diff --git a/tests/nvme/053 b/tests/nvme/053
> index 3ade8d3..99dbd38 100755
> --- a/tests/nvme/053
> +++ b/tests/nvme/053
> @@ -12,8 +12,15 @@ DESCRIPTION=3D"test controller rescan under I/O
> load"
> =C2=A0TIMED=3D1
> =C2=A0: "${TIMEOUT:=3D60}"
> =C2=A0
> +get_sleep_time() {
> +	local duration=3D$((RANDOM % 50 + 1))
> +
> +	echo "$((duration / 10)).$((duration % 10))"
> +}
> +
> =C2=A0rescan_controller() {
> -	local path
> +	local path finish
> +
> =C2=A0	path=3D"$1/rescan_controller"
> =C2=A0
> =C2=A0	[[ -f "$path" ]] || {
> @@ -21,24 +28,12 @@ rescan_controller() {
> =C2=A0		return 1
> =C2=A0	}
> =C2=A0
> -	awk -f "$TMPDIR/rescan.awk" \
> -	=C2=A0=C2=A0=C2=A0 -v path=3D"$path" -v timeout=3D"$TIMEOUT" -v seed=3D=
"$2" &
> -}
> -
> -create_rescan_script() {
> -	cat >"$TMPDIR/rescan.awk" <<EOF
> -@load "time"
> -
> -BEGIN {
> -=C2=A0=C2=A0=C2=A0 srand(seed);
> -=C2=A0=C2=A0=C2=A0 finish =3D gettimeofday() + strtonum(timeout);
> -=C2=A0=C2=A0=C2=A0 while (gettimeofday() < finish) {
> -	sleep(0.1 + 5 * rand());
> -	printf("1\n") > path;
> -	close(path);
> -=C2=A0=C2=A0=C2=A0 }
> -}
> -EOF
> +	finish=3D$(($(date +%s) + TIMEOUT))
> +	while [[ $(date +%s) -le $finish ]]; do
> +		# sleep interval between 0.1 and 5s
> +		sleep "$(get_sleep_time)"
> +		echo 1 >"$path"
> +	done
> =C2=A0}
> =C2=A0
> =C2=A0test_device() {
> @@ -46,7 +41,6 @@ test_device() {
> =C2=A0	local i st line
> =C2=A0
> =C2=A0	echo "Running ${TEST_NAME}"
> -	create_rescan_script
> =C2=A0
> =C2=A0	while IFS=3D read -r line; do
> =C2=A0		ctrls+=3D("$line")

