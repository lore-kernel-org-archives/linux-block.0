Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025927;
	b=CGYaVFB+2R/AAoeCwYuhS658/mOyxteizeH0TpcIN2/4Omg/qUXPG8b/SXDtFc5OuGhE
	 V5S9w5lcJ2DnZYejBPBOXrzI6RxELRo/cJ46hIRVuQvEg0LDzf03OTT72FpKrxWk9OzbB
	 ziobDDRAX/BfeJPFb4rU2Y+4e3blonmj6C4FYlNHq9LIRJO7ebR/KWIYGx3tJ7YE1lJFk
	 vyXgN3oKNR6VjoWDcG61tJPHHwn7dUDB04G5cVNTUm3dMSxCbVKgTMdbtCtEUGNojN0FH
	 RgaGzwuKgiXl74jcjiNMm0pFViKPqONnj9VTfYEz3QTwnTmgXmExllE7F/sA3qNRIGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Jrz1FQFbxhVOGtd72ulpI3AidGor2hWN7VZ8+JpS2ok=;
	b=a1EavFcO8AaeMClGXWFcW1dr9cJmdxeHqsD6fh3SgtbqWNOqLfwkA/f+6jSjF+Ydgqso
	 bDgagGOFgoB74WIYeZycJDDm/24AAr53F5wEeIIG9i/Wwb6/nClcfdmTzpR/N702FONBD
	 3NfrvhN4G3N52hf3ywXBukhZhTJbsm5H+N8iW5Mek+8FGApe2O4DkUzYXKdw6demdGOiF
	 TKRigQXrTYB752fW5UAsxKPdqKrufdMFvnzvV9TmeyV+9VZZdDY2sTK89aeYmx94jYCqj
	 x+AJZBAYJJBTMGgP2A3j1I5N3NFU7gPs9WZbo9IcJGj5rw+ymuJ7hfaNQWd2uWZFq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2GP0woG;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26B606A31D
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 14:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC26B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2GP0woG
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-704597ef1d8so1352370eaf.3
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025926; x=1793630726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jrz1FQFbxhVOGtd72ulpI3AidGor2hWN7VZ8+JpS2ok=;
        b=L2GP0woGA87T+SzSL3FwfMkJl+W1zBF96i/z0Z7EVtI2h8I+U/Y1x50W79z5XKUmYw
         K0MfxsRdfyT6MVResUAAYMmdNwHb41LYEJECxaDyShcMcGYwpoCJFmJ/zI+XufQdDWO/
         7iOis3Jk3oAhoX+CPX2aQ4FviHE8YKdTaJTjEZ+xy/50z97oUM5LhLIIvvP+fUHWuX0M
         IMfeYGAmpLqTQykJ+vVaaT6Mm+g/gDTRmjSsTJzgnFWCuVLSivtU7XbBcrs2TiKEoIbj
         JDf3jTselTivKjwiUlwPpS4NIYoULCQTRQmQ37K4i/MLkITs4J0ax0/LYqH7zJBUHJYu
         h49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025926; x=1793630726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jrz1FQFbxhVOGtd72ulpI3AidGor2hWN7VZ8+JpS2ok=;
        b=jK+GhZ4t4YpTleUctf49L4Asamu3SHDzox2aapMDxZZ+uohrMBTRYOOTucBn4LaBjX
         UuUbaKTF1Fp6jN09CXz1GFbOxbik+EsBhEPqZ3zVivmMqHQUa4o+2JGD0XlrjffHGkkd
         t1Y0dXQD+yjN1L/9x2kFZ75LAUg6Tla7abNDbtXRPNyzw6j08oT9TnZghiKVAX57ZOLZ
         LjHBEpVlN8RKqANlQ61cTqAMkpwtmfl5UzXe4LTk9pmL0RBT6ggw+TS9gY4GhGLFpTdq
         dVdPzm0PROvp1ggObYSAZV7BKlpR9N2GzgMC/qx0asPpzXefDY9x9HHsvvj6jskAv/eN
         mWpA==
X-Forwarded-Encrypted: i=1; AKwUvBz2H4lTSm5zvVcGoLSlCRb9hkV/IwIfxQIwMTnIMCQbh0loYGKs8FZAPj+UpRnepJZBKQhKzN8SDSpa6Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIyU9KXKAufRQ1msr4u7Ea7ooCkhFsJKjz+tXaWct+RQ25Yp8m
	0XeeJ10lIcdF9tOu8sCga94q8k3Z/djXq2WpyGa82cVjrWdsAILeK7Ic
X-Gm-Gg: AYBFou3402zaYMQeon5cavsvj9blT/hqId0Y9+MNDyDyg/Fall1/v9nYv5J8vDs4j9N
	xdt1D27y5UPWYr/1wmZqmOdkWVn5FzbKjlUAKgym9s+mIbKtqLELVYK3Wtr+9h5psZigf7iRx8A
	Rm9he4IwdEcJAZouSASg6ZTmju5rYZiQeJUxAZ/+0U+k2W1Gk4rHcaQLXPqanpPorPli7kq+saG
	JigvWsdxJZ31Yo93bMz+6mMNO0kAbrkiCm04ANOFd4Emf94ALVSYfje536kQWvBPE6ERKLH+I+l
	1CAWkUHIoosJ9lir7XA9xeqUjDlTzycmSm7vNx5HIZceTAz5CiM//zNbIwfTivUfpFsqvgw1rEP
	47gVqcfZ0AvkRKKLZCs++1ASvT/jN/5CMMXBFXmyKPmmBS+SJJ4TGZJ13gPPyAcIZL++BbM13go
	sFQYy4NiPwv/+7KEzf4n3sS7L+kZYg1MjNrRYJeYCH9kHFTrtOQm0inD47vSJttbUgqvYofz6Zc
	k6ho67PWYAV5bo3RtV2G8JE4d7v4iSBbbverDc9pivnvV3sKILCrh9jGFfx+P260lwvNQ4cew/a
	lq0YoLvEcQKWewuF1Mqa4TfcYCwnpSOsknc41Jg0NaFsDAVkCBumfk6ZX2Nc
X-Received: by 2002:a05:6820:55d7:10b0:6dc:99b3:2efc with SMTP id 006d021491bc7-70ba0e59092mr2356190eaf.43.1793025925761;
        Mon, 26 Oct 2026 07:45:25 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9e163a5dsm7045276eaf.8.2026.10.26.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:45:24 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:45:16 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	csander@purestorage.com, jholzman@nvidia.com, omril@nvidia.com,
	ofer@nvidia.com
Subject: Re: [PATCH v3 2/2] selftests: ublk: add rq_affinity test
Message-ID: <at9nfH-P1RDoZUvr@fedora-laptop>
References: <20261026120619.47629-1-yoav@nvidia.com>
 <20261026120619.47629-3-yoav@nvidia.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026120619.47629-3-yoav@nvidia.com>

On Mon, Oct 26, 2026 at 02:06:19PM +0200, Yoav Cohen wrote:
> Add UBLK_F_SUPPORT_RQ_AFFINITY to kublk's feature table and a
> --rq_affinity flag to request it at ADD_DEV time, and add
> test_generic_18.sh: writes and verifies data on a loop device with
> I/O pinned to one CPU while cycling rq_affinity through 0, 1 and 2.
> Skipped on kernels without UBLK_F_SUPPORT_RQ_AFFINITY.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  tools/testing/selftests/ublk/Makefile         |  1 +
>  tools/testing/selftests/ublk/kublk.c          |  6 ++-
>  .../testing/selftests/ublk/test_generic_18.sh | 42 +++++++++++++++++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh

...

> diff --git a/tools/testing/selftests/ublk/test_generic_18.sh b/tools/testing/selftests/ublk/test_generic_18.sh
> new file mode 100755
> index 000000000000..c899a5bf0364
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_18.sh

Please rebase on latest linus tree and rename to test_generic_19.sh, 18 has
been taken already.

> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +ERR_CODE=0
> +
> +if ! _have_program fio; then
> +	exit "$UBLK_SKIP_CODE"
> +fi
> +
> +if ! _have_feature "SUPPORT_RQ_AFFINITY"; then
> +	exit "$UBLK_SKIP_CODE"
> +fi
> +
> +_prep_test "loop" "write and verify I/O across rq_affinity settings"
> +
> +_create_backfile 0 256M
> +
> +dev_id=$(_add_ublk_dev -t loop --rq_affinity "${UBLK_BACKFILES[0]}")
> +_check_add_dev $TID $?
> +
> +rq_affinity_path=/sys/block/ublkb"${dev_id}"/queue/rq_affinity
> +
> +for affinity in 0 1 2; do
> +	echo "${affinity}" > "${rq_affinity_path}"
> +
> +	# Pin submission to a single CPU so rq_affinity has somewhere to
> +	# redirect completion to.
> +	taskset -c 0 fio --name=verify --rw=randwrite --direct=1 \
> +		--ioengine=libaio --bs=8k --iodepth=32 --verify=crc32c \
> +		--do_verify=1 --verify_state_save=0 \
> +		--filename=/dev/ublkb"${dev_id}" --size=256M > /dev/null

This doesn't cover the remote completion path: kublk pins the queue 0
thread to the first CPU of its hctx mask, which is CPU 0 here, so the
request is completed inline for all three rq_affinity values.

Please use single queue and submit from the last CPU in
/sys/block/ublkb${dev_id}/mq/0/cpu_list, then rq_affinity=2 always takes
the IPI path. I verified that way across copy, zero copy, auto_zc, user
copy and batch modes, all pass.



Thanks, 
Ming
