Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3743101CE
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719501; cv=pass; b=XBdHfqrCyqm0TXJcIJnLn9F9+9GRdLeaWnK4pQFmaYaVmbc8YqtnVAqwPhsNw5MWo92q8yBgIhhu1wLKA4MNyIx4NUip8dgh3ZeulFTSdwEJoDgEEhoJVRt5KPN5ssHLiTtyTu4/E66Cuj0iURXZvvBT8Cfv3Uzn3fxelBEjtRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719501; c=relaxed/simple;
	bh=FMhsOOvrcG7nCkkg42h/QONAN6ZkhsvgfQOaRmIxBlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5fc1nYU186+ykrB2GUPgIHD7awHOUpkOxmhNIgTLpC6iOm04dCxSwrdGMGiVdm5af1vhAqZFjNUlmTMylSaE14qsN7+qnQr422O+iNxhRcZuVuLgdTBS0CMYU/r0rY/+QQPIjPDPrnmmibV+oWG8FTdfRKFEZx58rXZG0LhgKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuPzdpkS; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuPzdpkS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47cacb4ed99so6076138b6e.1
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 07:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719499; cv=none;
        d=google.com; s=arc-20240605;
        b=EXQ/dZHiT21oZAre8jj+eF3n2YXDtdhFjSHQh9jWR/4Pfd0W17HIvLdNA14bd3YoUE
         wdKf0q5XVJh+8ztffGvZtoLkDSDmX7R27Vig2AC/qHx6Z+fjlqe4F1hKb184xT6rdyxy
         PziqLzrqgqK59LihW63So/c5IVXDIkoOZU2stAD6PyXAb3Jx5CqZVxczhgxxO/M2uF5r
         iBi5GBxAw4WwU5bpfoSZNDIoKxMkZsa5WPhbNvI0Pni3u0gossgBKTE1dx/ALncCZAxA
         jmUI83YfN7DmRtuWiHZHRmii/WBkX55y7jX925v2XermW0DefZMaCINv/h8NHLGmQ30J
         BDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMhsOOvrcG7nCkkg42h/QONAN6ZkhsvgfQOaRmIxBlw=;
        fh=mp3j2OhGPoz2d4PwixVja/W9k65uIi71xcb6HLu9H4o=;
        b=cxob92E6yDgTNuuOAEyKwY10y0Yw3Q455W40EKGnyyZsqHXt2k/Kc2891MB28+dEvp
         WYElJRa2n+f1IkFNW72sHBTe0+A47TCkTi1jtcZG7fpKdlwAon8jNAjRMewuqvy4nng7
         754/aU2vnvlBMGuiFwNiFzY8LL0wG31elz59VMntr/EtjZkiEyEdjv73tfsvH21XNp3T
         tkX4aYj+4SjObCIkGQ0HDQsFo93SZrJQYrnG4Owhi3NY9Eluku6MZzrpBu5vFQNQruf6
         +6orBED9VqNa1oXOfIGen4Hnry4DC9nbYShzS1m6yqdJR2SOwnQPf5ebxtBCUgtaVRvL
         D7Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719499; x=1780324299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMhsOOvrcG7nCkkg42h/QONAN6ZkhsvgfQOaRmIxBlw=;
        b=NuPzdpkSpdKxrcbHvSXxrME4KEiwB7alS/BwcPfykPlk7PMAyMCXgkThbDLxLqk9O5
         z9y8aClli9OB5xkqSxwp9WDcfggdtgZ2VYr2YU7+ZgxjlPPtSnPAx+jfjhfbY4qKkjLA
         HnnKtWE17KuXF84U3bdjslssFT1AritHwDGYKO+JvxSRKOFD6w75O9AOGMSI+135YH6r
         yt65kcdryd117cH+vfOr7cnadaEFfGe5msaheSRWslmabGLH4xPYV+t7Nop0F6BMiUSh
         Xcb7tbPzsErYpCT1MhNCzxMa51CSWF2SlP8pKRW4L/EG5N+x4fHPFhfEA+JmkAnxC9qZ
         Lu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719499; x=1780324299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMhsOOvrcG7nCkkg42h/QONAN6ZkhsvgfQOaRmIxBlw=;
        b=sOjxhkIBnK3srNg1WkbzZBgEYQO6w98UMdMiVUbtTX3+N2kbFta94zMc5VTaPLk5Yy
         Pz1JZpc13jTOR302Hz4pG714uRDdGnQdlneGfnawXINCtWGTwEH9naeap+KhJyNW4niE
         ugEHQUtR78mJL8geWnF98Kok/oce7s5/xAvHSr9JNoGWi+5rNcQnIiqb7XHmriBqNj3x
         71PSi1fFvr9nsqN9C1aQGI7fBC2Kf624Pv/QtXW/oS/cDxpYD9SIml1PR+Qr6yc/Y2fV
         +a8OkQiChDZhjdNpJCnDEPGgzGhYXILB/EhlgJ6kCPLyOmWOm032syclDWORSrxo9PJf
         xGbg==
X-Forwarded-Encrypted: i=1; AFNElJ9yGnemc3h7q1tw0BiXZKaaPFwmc4wZ9TSr5+N1N4VPZs6Yo+1ByXZOxolAnyVxujY2N785V+sVKPbfPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlYKmefzVLdb5pUfwUwyqpZy5U64jCmxr/wdq8eeZKJ2/5px7
	IFbiX2RYwYpQaOdnB5LhUeZ3Pqlu4ALUB0QtAjv66nBpbiPXPaDasc9jjRunTC/808UAJ32u28C
	GuML6OaC/uf1T5QQoDE+jKsNIfxB1YY0LxuxLq7y2uw==
X-Gm-Gg: Acq92OG4/wsuIMd6i6riH6TfBjP2MBospbx2N5MRJh+bpPKUUh7IUzHHVS8PgaZEouO
	c3C3V5SdEV9LsIp6xcdVdFt1GGpilsnMCY9uIwwOSLHctQ/QFYv1OqX87bXasFtnODuYlX9knaG
	wDvfiaPud6COjCbqYZqKCxGL31pcpuuP7miD0FxlS1sFTUY9Z/3D/SWRFXC88LHALpcJpVGdwRx
	y3ezS/neBJlUHsjucsZk/B+IWUPJJOqgcsHv8CKSb7hUn3BRouTx9spBP4YhoAvP2ewI8+YAI/P
	l3d1Rg==
X-Received: by 2002:a05:6808:c2f9:b0:467:eccb:b788 with SMTP id
 5614622812f47-48549ecfd72mr8802428b6e.9.1779719498924; Mon, 25 May 2026
 07:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525021917.273190-1-yizhou.tang@shopee.com>
In-Reply-To: <20260525021917.273190-1-yizhou.tang@shopee.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Mon, 25 May 2026 22:31:26 +0800
X-Gm-Features: AVHnY4I_bfq80qqntiODSSjjnZtiFUQPz4tbUaVQeB_8jwR_Yl3v5K-XX_Ysgjc
Message-ID: <CAOB9oOaR_KU+O0Z+SUuoLMD2k8POCFQK52=_ENNT6K4g8VZ9kQ@mail.gmail.com>
Subject: Re: [PATCH v6] block: propagate in_flight to whole disk on partition I/O
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, yukuai@fnnas.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I just let Claude Code review this patch with Opus 4.7 high
model, and it pointed out that blk_account_io_merge_request() was
missed. I think that's right. I=E2=80=99ll resend an updated patch tomorrow
and add the corresponding Assisted-by tag.

Best regards,
Yi
