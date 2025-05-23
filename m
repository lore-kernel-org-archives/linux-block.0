Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31317ADF8;
	Fri, 23 May 2025 02:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747968282; cv=none; b=ZHP/sBQANP+6bzx3yTOoMExc9/yNYPFBWbSfIftTngL1HD1SQSzZ7D+1T5cae0XOyBNpbSxeBrw8WETQM+gtqICq5CpnnUoZeiIM96RDsGNpMlzV1KpT/36WY+AA8iBZdhkMXt82CUSwucHK2vDwDSaaIiDgQFtB9KEHz7JoGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747968282; c=relaxed/simple;
	bh=8sKyiePf+n8HaGco1K2oVtcjm5V0xv75QSdZV8InM2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/nWiLysoBPUW2vd9d+vik1OgtyfzsNxvaTy0rOgZORhL+QZ2ZOEDhIM+JxE03yEhJPy8Lm5AMVf81mstgM+fsQ85IzsjN1RZ4K0ipCSefiyQKWfF5Qg0wdSu7n1bq/c2blRffy2E6OMJdM1twJNEudR6kLn8V+RS5YyAgrXPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy2QnEN4; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy2QnEN4"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso305070439f.2;
        Thu, 22 May 2025 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747968279; x=1748573079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sKyiePf+n8HaGco1K2oVtcjm5V0xv75QSdZV8InM2I=;
        b=Hy2QnEN4FfR9pMhKr3x/C0IHV5Qr0LYb9ROsnNsB2mo7VKL+EvlyjR2coqqgRPhKx7
         +B7qeudk7oleueDBxNq+1DlChUyV3w0LgDLZUGmQbJDYrCoL7I6iioeerZ/Tqxwo+SRn
         bKBAb3Xnx34TFIqjo5m4jzayM3vVX9b5YWzRYOI0ewEamK5S1gyl6tZkwVysB8sUdXCC
         LhqCbD+9CMSAawjB8prvag1mfX4HqftsTx9sGInxevk3eUty28KVyGpbbbOG6vflQpc+
         +zW/40SsIOl6UpEOBr8lTQ5RmreDcM7obDtqWJc7YJWz8tqdtOROrUVS59gDxixx84MD
         g18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747968279; x=1748573079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sKyiePf+n8HaGco1K2oVtcjm5V0xv75QSdZV8InM2I=;
        b=VBXUHZGsZo76u8arfqUXwY+BLlZp3llPeiFwuMPt5TE07NkVpUWmAFqgpExgzmsgx5
         1U6Wrbm++OXdz20F27ay3KskFRTEC0nD1qUuaUzJ+xpSmdIfKk//ulE0ftYXrVJByCDK
         g2BhJKYeFtHo72NQnUksSX9efv2S25gL0Uni8I12cFYAZsvS2QR1crHQ2FYsZXDxvg9x
         rLZm+b7oRvcMPzizfyfSsRqJn7RL4YA1sQ1oEmqw1ZhALKoMsnpQttcRWKixi9LpNvop
         4F8EgwWwX/zrkxtdqRSdDirHaWsYZT96Ea1d5WNHIihlLWUq3WWH+w1S6zbgFF/GG4cf
         2IdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74UNI5yc9ZIcvKLorCG3gR9IHSZl0qgHx7nBa6CaTy/qhNH1Q5vG7E2Y+m8eosPE2cYm777Lf8gpP1cQq@vger.kernel.org, AJvYcCVd4MCl1gSaTQrvc5LxmnrJqHrwmHl3ebJLCuDtijGyJxoUxPE/H5fQo4a91laF3QXayXK/2pMh9g59NA==@vger.kernel.org, AJvYcCXcpM5uQcGrGLYRJNQV702vlxrinhj7A6HevE8d+WgpGpqgKmylKdcsQet4MCMiYUaqiHxb05wtqOnow36BtxpFC3Ka@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcpZjYyC4lag3M1iq6ogVAXq7Qu1JrlyGm4TYNFue4WlWVhc6
	ovJ4uqALt2DsD+WlSp9zaPJwhQEY4WOGdL0vSc1C08gr/tfceR/B3b3thWjeFZaCIVD06u/IbxJ
	y70pWodM7MraSlBEgVGK/eJydr+2QIDY=
X-Gm-Gg: ASbGncv7kshwkEg5ubV3n50mB+wUYBdiOk0mo0H09zqM/sMohHhkcRNUdEXUSjzzwer
	XbKblnU8CIIBiV8m+WiK9ygYfWZ6Q/t/d3v5pPd5n0OkyrkfQgIg7KW+jTflZKyQmIqNZaqSb/w
	iiInd5J6sZv7iuV/8EJ3uJ+5TpP3ML4J4JagbVS5hncw==
X-Google-Smtp-Source: AGHT+IG+9AnnXq2xOlQoj5N+v5B7HI7MLMaim/F3oBlVYJ5ytCMSfXvpDx/cyhYlfnN/6uiYkkK2s7cP4Q/5LNkwf8E=
X-Received: by 2002:a05:6602:3816:b0:869:d7bf:6f31 with SMTP id
 ca18e2360f4ac-86caf08eba2mr236676439f.6.1747968279191; Thu, 22 May 2025
 19:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518025734.61479-1-kerneljasonxing@gmail.com> <20250523113943.8739b65347b3ccacdea7e4c2@kernel.org>
In-Reply-To: <20250523113943.8739b65347b3ccacdea7e4c2@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 May 2025 10:44:03 +0800
X-Gm-Features: AX0GCFunj5bEpRNc90c6FQXeqDa9UMSrd9cJ2wTLO5C6O97irmtez5AQtYShxmI
Message-ID: <CAL+tcoDPgvGZNx4UsiJg5EyUvtKmCsZtLJoqvpwTMcs4PvqOaw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] relayfs: misc changes
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 10:39=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Sun, 18 May 2025 10:57:30 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series mostly focuses on the error counters which helps every user
> > debug their own kernel module.
> >
>
> The series looks good to me.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks for the review.

Thanks,
Jason
