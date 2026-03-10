Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FF43E493
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135034; cv=pass; b=MIV5bxLd8u9ShtxSodXgT9XD1lqjeLTWcu8JdlOsKHpaKHWiBI9rogn+XhrocWJgGhQKTPv2Zjks+EAtih4nAVggHStdAbFp9smp/WSSzVWNOTznsnBJYL2vIrZpwbuCJqmzDjvkW1u+5NvH/6RhrDC2NpnON9bPfO+Dwbc4U84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135034; c=relaxed/simple;
	bh=L0d2ilx4eHr2s2WQk//cXKOMyF7eCafo5gDeTlAlZko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGiRR98s/xf/9rv1dHGj3gYEr3llDq3+b1nEz+l8XiLDj/W5xy4QatrM2pWGTb+w1pOQJUgpvfvChK/VFdoFFoazfOGIf/0nJne2BYMkdgFkFajjt8vRt3mg3I9CqwZft0QCie8VtRNaJsV3vPaeW9mkBVjrdttfEvV8zICTieg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFpIYoDW; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFpIYoDW"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899ed41208fso173225716d6.1
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 02:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773135032; cv=none;
        d=google.com; s=arc-20240605;
        b=AlBfJ/r4ewxvkXPVDsWtfLzdSpxZVoFjZGUAKjsHg54wiVkvaGySq6Xp1+6/lC2vOD
         L44YzSbHghNnUp1ky0WD5nVJ9uArUDgI4hOHGnO6EYJj2fDF8Ic/uhqyzcxjCAtfo8U2
         XXriJuclAXedwCrLGqvPYv27yOhoOiOzdyTrqRHjwy1ORQnALsVRBDJTiBjglRei7TP1
         xcuzIcY5i6Fpk1mge4g8xxYG7ZKSDu+B6vPVsuzH9naKn5otwebsOaGBNxkiDlf1XcM+
         qXY0LtCSfsQLhYtr62Q6zstvnpKHiJZTrXJSQh9pnkwOrhunltwQt/4UIxrfcGkGuTi5
         1Ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L0d2ilx4eHr2s2WQk//cXKOMyF7eCafo5gDeTlAlZko=;
        fh=ISc6h0jvX29xF0meK0oBRrQd+7K5yHA8FWYEflMiS8g=;
        b=ljWiBWN/3GgdC07l5DnfLe8d06xQnPjQIlWFsLnQiMoFukMHEmrLpr7dyZuJgB/TUw
         JwrkwuIsXNFFyuqiIdYwv6j6CLyNasM1YIpAigYZ4miwoCxINlS6QZP2w++M4cxKnUZx
         z6mG9IqnTAGKfY1ckaEmCfyIxjPEHXM6nbQWWi/k0rISRDyS3EruUZn51fv7sSkMZuI5
         6i1R/LPWfVj8idvhVTR4VtKcOG6Ar0Pc8KcyYOK2tRdISykYvFCViAEIH37e0W+3IVfW
         /L63oerDmW7GhSD6bVyGz5cCS3aauGvPf5OF7nLA93HgnLexGrDd3ufnKI3AGiyUsfJf
         DG5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773135032; x=1773739832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0d2ilx4eHr2s2WQk//cXKOMyF7eCafo5gDeTlAlZko=;
        b=WFpIYoDW85mqsCPnRunvRPVHakO778wNdFA81NiPoHBhtFqZhVjx2dLxhkqnxTA6/c
         Vx7ci5i6g5GFYAZwd0bIAigPEXHRWgPlanv6grU0ajwfZySngHyLaHUhbA44kat5/pek
         5VIuWJi4ivyn+M2hypyR0hpPcf+liihmFVIQGmxE5iBpI4dqx9llOLBeR+CxKC2UH/9V
         pjvy23qY/muGlwshspBRQtpPZROCKihYDioyGFdblIqgeD5gdb9/ywaa6TsCl7NHYBMK
         21Rd/QThlr5RSEFeJmsiNGgT2aBnT9AZ930/jDKEP+3P6YcqywhmwNuQiTPE8qAh1OAY
         xh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135032; x=1773739832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0d2ilx4eHr2s2WQk//cXKOMyF7eCafo5gDeTlAlZko=;
        b=HgrwdixBc93WtdjwZ5A8ytzYW9gRmVoBuxqVnb4bdgUXivHZMYw0VsNj8yxFsU9o8w
         TnntUS/w545GTflDNC54xCMdQCYcI1zEfhi1f5UVCIdfJRx/oM44obyY/a1K3By8gxJg
         cx42+uML4jcYEaQlqfcezoEPyfeOPCdRyGeD5TxCshV2gisgA4EveR4/HbBYizXkHsM4
         VEovQbcOPfTZtS3f7Q055TpaTUy2uuAiNL06MG7Qs4VhcFN7gXFuXqiSP6cCaoBGba5O
         HzKedE+Qq0gKMr25nw6Qwk34aR9Q5yBm1KvDXZul0ggtCqcjb3+dT3G+2K8o0VTFkd8o
         s/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2wczdck5yxubc5sGgs38ePRHvi4J5RVu9D27y8h2Acv/ZVUvl1hZScMNLrW+YudSFJuNnbRtDjXtitA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypXHlYKFfYs531La/+9MLJHGGrIRzB0axbtJJ2Qi6E7bkmS9Fa
	gBHfF71nWFpNd6B7KeHCkFydZ9ew1/ZOGaK1VCZins26INGpvefLomTUtuuvSecQi7DvXHuF+NW
	OVEEbELzzq+U07RylRwIRioa7NhsXDXQ=
X-Gm-Gg: ATEYQzwkxzDlKwok62wKDjtu3GwJQYcwz4nqrfrUT6TWtVQNqXHrm7tcU/iq4VvyoZM
	sZhLJfK6SrkK3Z8J7iVdtc1OuzPwmUkbnAPNB8KdMpxDDyoXq5YnvWn/UzZHg92Js/2TxkJED42
	7fNK7aG2jwOXNiRb1R9owyrP6f8MSGLCmrZ3xS5AnVhSGME1AnfPMsnv2ksjB0tfLhx9wg7C1tH
	XxSMyybquBnwvqXuk030paFjUtdlQ3Q12+FHbWIeTcMdS55JHByM2CydHTkpdmMghYAIk0FDDt6
	cG3PIIw=
X-Received: by 2002:a05:6214:e8b:b0:89a:116b:e67d with SMTP id
 6a1803df08f44-89a30ad6c0dmr227011126d6.37.1773135032404; Tue, 10 Mar 2026
 02:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-bcache-v5-0-04cd4c9080d7@suse.de> <20260305-bcache-v5-2-04cd4c9080d7@suse.de>
 <aarFVqxrXF9Bah31@shinmob> <baa3a723-2f9c-4e10-9d42-b4152de92df2@flourine.local>
 <aav7vTM7IerMwsT4@shinmob>
In-Reply-To: <aav7vTM7IerMwsT4@shinmob>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Tue, 10 Mar 2026 17:29:56 +0800
X-Gm-Features: AaiRm531AQK6W83oVfyfdl7CaQuHywGOjzjWLWtuvzLamYUJA-NsVM86mhjx1HM
Message-ID: <CANubcdVc-cP4dAZs_mkTG3rYVYa5Z2ihd3Crp2J-GRDUYpGGhg@mail.gmail.com>
Subject: Re: [PATCH blktests v5 2/3] bcache: add bcache/002
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, "hch@infradead.org" <hch@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Coly Li <colyli@fnnas.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com> =E4=BA=8E2026=E5=B9=B43=
=E6=9C=887=E6=97=A5=E5=91=A8=E5=85=AD 18:24=E5=86=99=E9=81=93=EF=BC=9A
>
...
>
> May I ask you to share what kind of devices you used to recreate the fail=
ure?
> Also, could you share the kernel .config to recreate the failure? I would=
 like
> use them to recreate the failure on my test system.
>

Hmm, I tried to reproduce the issue again but couldn't.
