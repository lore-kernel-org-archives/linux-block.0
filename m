Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF3381AE1
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432668; cv=pass; b=FCKVmalFhjRU1c20LfpHI+b1UWJLQclj5DEIPtCUBG6YoFz/7vsu+TxqMXEL3NK0OJRsJvw8hjb5L7AGd7j23xFMs7lokMnjXc/hxb1Q6a6ESuIM8T7HcWEoywaq3PFqNL2nlYZw7fiKy1lyKIbtHZon6tXyHdn2J1bZLUvxMd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432668; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUo33q7rOqPbR/M0hGojWBKL4hRLfgK1kyNL1Cqip3tclUOezTF4MFcve//6tyLz+p2s6d7JV/EeboZn/HjIrO8gtwbV5l9Gfd894G1G3CaUS83M5PBbrUIQ1IO9r8NOhFVkevPMLy4lR9ypuH10dQbA9kOXCyFKysT+wESZumk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4HUS6JM; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4HUS6JM"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66c17372965so6356434a12.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 16:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775432666; cv=none;
        d=google.com; s=arc-20240605;
        b=DHn9kAxkwJ+OMokHygOu/hjls+h6M37lJk+99MKioNZoZtl3CPbcze/ySdr4vaDQM3
         FfAk6qpneFKA8K47E5phjUZq0IOyG2UcQEBFyfKqJtWWEUjnRMOE79Jtrt/2WX2cBWF5
         f7YmDY8a9YTBx7mqWMP+DTxSyvyw91x02QMKMvo9GqXXDwH9NEoBxh8vCiu1xb4Xk5/6
         TaO1WuTZwrdFnPOg3ik2uOThJ8bbqNZpVd7EisaVOu6Iyg7H9PKRXcFWGZXDrrJLQtfJ
         EDToO5rWxIOv8ss9zX3BtlTH0qmzKlSd8nWX6zZLpdJiYAFR/izWE7HCiKbEAuGF9qX0
         7VFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=vO0UoqltRz4ySa3Wt0QOumYQ6WV4dAkBwHaXWyM3iLU=;
        b=LXIj4sOTsT7dMZVHppZfDtSEsw3ipj1wTc00jtLv7j4BXNJYEcccHzzdUj1ROdjkWf
         8Y0X5nNUS8xHoyycPj2Wa2r9mdcdf9rLOFvfw5Z+paGpx4GDWsqbSxOKtv+OERteHPRi
         Q3JE8MT3aSde3ctTKQOUt8pyC12jAqbHf3W+yuHKVXS++syJcGib0w8czHmuEhFIOuT9
         OHKI73ya1RK5LoNHfMaAasw1TwWG5sCeMtAaO8JsK0sxYTZfh4IAbHNYEk0Lc1ETM7jJ
         Blzrkt/aV54x7K6ZyFhZ1t87jpf88zc7UUu5X7MvvmE0rf0sZbxE+iAbJusGkbMO0Me6
         8nLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775432666; x=1776037466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=n4HUS6JM9x+dGGgomcwpfcKVfmD2Lsf5L2P0OY81Q2A7L04kOXBf59/C7EbJthsXDX
         tKizkhfCQlUWoUBb/ktUqvb2wysjnO/cd6JogzKdtzjjAaK0GmRtegeLxTgPbuNVIQBt
         gNTu93mFMunR5f73yHnvYJwvAE+t0m9imXYrp8mQ7ddQBjLPXb2g744yRUsBU9mocYpX
         Hff68+teBPDcxomP5+cSyNO8XwtuzOoUMplNuCbmA+U01U1tOFHTDfOIKZwXCSf6xo8N
         Suje8KsqHQxs05fZaTPfCPuM2GcSaIuXI1dqNdV1heyKfPa4EHX0dbq+7xZ6gD5xp6C/
         M6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432666; x=1776037466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=kIPtkNT2r43kFKIGx3ksFcAE9oSo0IqHoJ5IlCDc/Pa0DpSaSPb8vh1hHqV4vrlXWM
         qq/BPkQOn6/HIEMVhB5D/l+6oUG5+fv/xHtQyUx8uAKm+o2Z/ZtcJc0D0w8RzjEq/wyI
         zlujggABK8oTyvFlIvLRgJuF94SLcuSXHY10nTZaXn0GoqBjwn7mGHFaBDHSHU6wLHFt
         jRXslfxSaYeT86WXqPd2PErX2I3IKe4z6flIpn1A2uJX0Z5JtasCruAHLHtUDm3PHG2+
         sGHzGCIOLnbLf+IFWYXMBqbufNpkENLQduLdx9cJG0Ev2xyZ0rCDA3YRxtct45ZWiMM6
         KR3A==
X-Forwarded-Encrypted: i=1; AJvYcCWLS5/AkapmfgOF7fts7uvyeMThzQ6f4uPdeI8QoRZg+zMDYrHfKiz4xnsqFlItzz/wzeBvmUNVBQXBAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuBZ14KguiMrP4Jey2YW39O0oFEaCWWRFIO2IbsBkfYSmOtOO
	zDser5W4MBH/Obo98Mr+45jpCD/MqGPx54CiD6BzQi7X392X6KN6rGTP/qFc/o50g6bh7lCD8Ed
	wrGOrWmWUjyOrQN6EqvCcV2aL5N4G6A==
X-Gm-Gg: AeBDietOfBk11kVILhSJ5ma9sJJd5i3jHDZHYCiMNS5AFg3fi+SndZ3W00zwfqte2rr
	S1dbQuJI2TqSGv3/GnH0G1/9q+gaz/w/2c+gMVycsH7mik0coRVBu5jvxwMXBv9bzVZdPvFDpfO
	5j2pgmDbBF1dRimwT/eFkl7+o9F6jUixTJX6qS70JtDh5vAcX9P0iD81Rs+1Jh61xiv59iu4xHa
	eTJyPPDT6C+c+ajaq5/rRdWd3a/yGFhsAaCm/MYpe0m7SYNom0Jqd1vJbqG7hfSPYA4ENiLr9En
	HUB0EZzomCVn9k5mxSjJjMwIbpERGwqpZCv0cQJWJnkfS9Z10AvTAXnZ4X6+nBgfY8mDa4M4+vm
	MqVfJ
X-Received: by 2002:a05:6402:2354:b0:66e:de5b:d9c0 with SMTP id
 4fb4d7f45d1cf-66ede5bdb9fmr1235273a12.17.1775432665648; Sun, 05 Apr 2026
 16:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403185101.2172135-1-csander@purestorage.com>
In-Reply-To: <20260403185101.2172135-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 6 Apr 2026 05:13:49 +0530
X-Gm-Features: AQROBzCJp260OOpbmEBqtZArxhqBAPGBxPYmwphl3C2wSgI2XE822v8CViV_1nU
Message-ID: <CACzX3AtbfkRMpu37yNunJ7R3KYd86=2sEu0TahmmLzJGkTdSkw@mail.gmail.com>
Subject: Re: [PATCH] t10-pi: reduce ref tag code duplication
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
