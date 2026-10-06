Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A33B9D98
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272944; cv=pass; b=BjVr5rAtPcBO9Hsh/bK83nY+qx1IqaFdXv5uJ4LP9mGe2kL4+rWaEpNzqcofo5crm89nT7bKSCeP80szk6Q/jnqtVfAsF4GgBisNgAZYlyp6W/aL3+u9dPMc3cm4nSsgFjBN0F3WFSZTWC2sTENvamSKd3RgPDYC6m9YupckHQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272944; c=relaxed/simple;
	bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyz8vvWNsARSwVgx1ok0C+jZlDQUGStENkQVC4qBQtLqiXi+Skee9F16FMkEotxPQuwlFHxadgc2BLVp1uBLBBdaSN9CALkoetVU9Ids1CkU4r44XVO5lIkvFE+Goy7u+LD8OMQBijxJpvR6I/BoTqt3lWJ9QFfN8D6yQrRYVRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=0h1G0AaA; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="0h1G0AaA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso593732a12.2
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 00:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791272940; cv=none;
        d=google.com; s=arc-20260327;
        b=arb9oiR0k4t2/HKLvLJx6/Jjh458MC4F2uwSFLMvsFTvhEDpAcBb38StJZTfZHDTR2
         sm61w1DKlNxTa3s1/onJDAdqXwHzKJEEZR/uxVxWA8qHb4/mqTYE+9HFx/5AY4/qgtz8
         /v+lHzUjEElwZYR//EnzPBJSI8KCf/3BI9aL6mWMpPjSqnHISM1GRw/gcPXOv2G5m/hO
         SVlBnBVCbs0ZvHAdmIw+lslWs00n3KRfdlj209HSg8KqHqbEnUKuwgq0TJbAm32u//fy
         R3iE3ZkaVMlkC8KA1UETvuwJ2laP3wNZ/UfqhR1XfHcynVBkA5UwngQXLmP8eFAjOl6A
         QHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        fh=MkRq3/oRHbc0lqYwJTPPfnOOuJtuwhA6MyFlHEB2isM=;
        b=Fs97Mo9CZ2Qao4cJ4PgcVqnbT3EklCbuUe9r+waQovb2rKRQjFLdXgifr5mxXK8RqT
         AJPtetEt4hS3Z1ytP/wzNV43kOzj9oVx0AACexCbzr9H/qf6XZ1SxMW/zLwtx9u09Ot4
         ZL6woxS52PVkebcy7QeiwQTlHFN0S1vpj6QRo6d25iKxLAP4lTzwMh6SNy74vJB8BINt
         xgR3AuDJal9hsP+jq8BLswQI4ikMDsPK4uD2sNwcmSJYTDA6lMvp92eDtQkfSzVmJF2V
         FGvHH2gj+zWd1tlPinKuMpW2CLHw4eLyQR6khrd1Z+YpL4K9cmUETyorI+JS5y9vVtfQ
         u3ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791272940; x=1791877740; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        b=0h1G0AaAq7RVxRVXfAbwaro/2HDV3FBWvJwzCLiCJTkXK+nX0hpeF1kv54Zkee2J70
         jzyNBFUoDFtbk3WY3Ef3nv9Ah1O3Lv6b8MV3jN/IJIzjY5D45Lan/BusKUJTr5an527K
         Czaeoz8jeAZrj/av5D/iSi1bghFPAK+7ccFCPizsaLbZYEcCmEXTIbPIv1xekJikSofN
         sPt8HqYgBpe6mwo5h8F5FIB5f96PKijy1IsnHdq8QGjj1nEYePbw0RcgJA7E8MKp3nXs
         Gkp/iy4l172Wwu43y3W56heqGWtSBKTyFFAZ3r+XTjdclWsDfWWdIaoedJqpHNYfIcDi
         i9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272940; x=1791877740;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        b=AoDN5udpUPOkcH4zevxNAD2IktJAY5l0BxgL/Exwc5Vfvill4FIEy8qKw1UdrNwazq
         TZOwoga1/ZEcBM03Im8JdYJN8MpztGv04nIYZ7S7hpcNcWjF2VNuiLl8S7Pmih6PY9EZ
         83h+DTeYyI33899i571u7zl0pQvWJchrE3nAQ4Mwvu+g93YIDwLKAg/3w1nFC5L01WCS
         qJ9LHxJrs7UUGyXPMTrn48J+8PvqU6gSSQVQaX+W5190RtTYnqN9ChwjHczW9D+zKKex
         2NFnDngBmdyYhjDHTBZ236NgcngxljJBfYrkZApNOp3RvNOUzs0BXgm4ZsIeS6JDKVWR
         yVLw==
X-Forwarded-Encrypted: i=1; AKwUvBwbEMGEf6kFg0Ml/7FOXVKvohaCwPiXH174+YjoaoWdIp2/rgVcKDa57oBFsoUgQ5382wK2Fg2vXeKOdg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJkkaHYkgpMilKtTjzQk8dzEeWdOAyVV3Madg584a+qIgnXta+5
	Wk6tyZB399EAFOImkwM2SUQtKCtJ+MGY1RwveZjyj7iSoCw2bIiSAqZY5uKBc6sGL8UWIJ3l4Se
	vAwzGjFTvsY07lesqXatAgtaku6C/gf2MnosVmHXQFg==
X-Gm-Gg: AYBFou1dA5RDm0TYL7km+r8AG6NuFvWqkuc+8Cxk9RAbA6HxuYa+7aP/0CtA2EB9ZVM
	Q2vgnAY7RnXilf2yEF3dw1eajSabWyXR31P5b6kSupA4fPUOx9UvMIq1pVj+1xVmEdjMX8SsR1S
	SLuVO212pvghYJdxt0paVzODr09vxM9cyx8HxILLXFdluRMjpBdwsB0Idl/nZsmP/t0GZNg4LSh
	wrmxzrE2NZ0uUOE96mF40mLJzQ14bo73XHxXoEqIOpyc9TYmcBFpyL+gQ/3y5EtOiKTw8A4ThfG
	fEeginS3uzB4+lqoR9V3sFQGKKV/RzdgEOUdDMf76WT6WrL/uv7y2Vqwc1E=
X-Received: by 2002:a05:6402:1907:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6afe290339fmr597357a12.3.1791272940042; Tue, 06 Oct 2026
 00:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 6 Oct 2026 09:48:48 +0200
X-Gm-Features: AclHuK93qFWTt0rPdrolX-1FvRtK-xCdn7iYpv4S1vx0jkfxOiNyhJFdse2ACcs
Message-ID: <CADGDV=V5NJViqSKS0JpFrm1U_2pGRBf1iE30hn+yuR7NmN9iXQ@mail.gmail.com>
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a
 compressed bitmap
To: yhlee@isslab.korea.ac.kr
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
	axboe@kernel.dk, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 06, 2026 at 03:57 UTC, Yehyeong Lee wrote:
> recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
> accumulates the bit position s across the runs. The upper bound
> (e >= c->bm_bits) is only checked in the branch taken for a set-bits
> (toggle) run, so a clear run advances s with no check at all.

Thanks for the report and the analysis, this is correct.

> + if (s > c->bm_bits) {
> + drbd_err(peer_device, "bitmap overflow (s:%lu) while decoding bm RLE packet\n", s);
> + return -EIO;
> + }

Checking only after the loop is not sufficient, though. A single VLI
code decodes to a run length of up to 2^56 + some, and one compressed
bitmap packet can carry a few hundred such codes.

Please check every run right after decoding it, before s is advanced:

if (rl > c->bm_bits - s) {
drbd_err(...);
return -EIO;
}

That keeps s <= c->bm_bits throughout, so neither s nor e can wrap,
and since rl >= 1 it also implies e < c->bm_bits for set runs.

Could you send a v2 along those lines?

Best regards,
Philipp
