Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912301CD0C;
	Sat, 31 Aug 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725130949; cv=none; b=j4IVz/oXFphFl71cLi4/ZE0DB8dpC579jWSaOkQ4rmGumJdOB3+xeo8Jqw4n4bNoDnI6Tfe0bEvv+6ypGTqfSMTggKknnu2g01L8wE02qPmc/7OIyNNkMLl/rE15u229EDM/kaTDWxsKcb0ZlrVsaKxrqhR/REbH4vQCCXl+3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725130949; c=relaxed/simple;
	bh=/UwpvMDj6dg9TWpWn+Kik5NIhTovCRdy/JB3SaZF8l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwoBbehIGzP0bcwI3guVm3NnyzPJ+wDbLuD9va8BIpbspZ10ryvFIuDlKt3RCHUxZ8gc6GyGEMRbI6L7P5Uiy7zpxgkINooUapSQaUk4VR+AP6P5sC+dWXZaw/QI+sFYbHfkqt+1t8qQj3TEOUP14l7xLxCbBvh4sBGqmJSoX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSDGzttp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSDGzttp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so451214a91.1;
        Sat, 31 Aug 2024 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725130948; x=1725735748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UwpvMDj6dg9TWpWn+Kik5NIhTovCRdy/JB3SaZF8l8=;
        b=jSDGzttp57gIL4uYP9D5W3UlBCFRaidWJy+JZLMZ8etrWP9OAZ8Qgcq2rJJuZ87/rv
         UgtaUDgx/SF+U0rShfqGEHyFzkbt5QOTgkw/QKDo7by1EDtACeYA9Mf/lT1upzqD63Po
         7fs/2hzI5CEtcraKI+3pejC84KCM6aIgO2hwm37O2PvW0SB57hsW4egKYXUGT0l+hVDV
         3qvY97Ljj49H/owmD96DF3gSN7siEB3FO3X987eJFlcGJZ6mutkeAg5of7A29+LOJHQI
         1w4iWTUy7NIvLtJA4lBCCw1dd2hps6kzxYpMiDX7TMYxm+h/adTuFjfrsF2zi/S/OJc7
         KwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725130948; x=1725735748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UwpvMDj6dg9TWpWn+Kik5NIhTovCRdy/JB3SaZF8l8=;
        b=hsDRg+dhMnDh6qJyB0PE9Dn45NkRTMrcT/ZGo6DMJUXujt3aMtPPtxEm0YYdjTrzkf
         mAu811aaOu/1Le3LXe4aa6O1gLrz4tehJQLzayFFVYM5d+TlE3Bz2gHuNXI0gRxnUpox
         yzT27nqUEe8LTAKaxCPlS6eeVlsuX55DsJbb9hVyADG5taqil4kfxAMQCrSGxqBeYs3V
         Fxupwf2pWkE9xwTs3crsL+Z7Kbf6T6oLJyJxvnmC9rZI3ohAV6wcw1/erSGilGj8VLO6
         ydoYEHaAJekj/y26f8VB2iS1/YX/1N1YO/te09ZoDb+grEkpwXU+3EWmT3L1savTcxq6
         uU/g==
X-Forwarded-Encrypted: i=1; AJvYcCVguRPmBhkl5AbWf9HJNdwD1BV5Dzg3Av12XMJgZRmKwAXPzCuwdZUFSH5V8nY2s9CiBt9yIbh2GFmYww==@vger.kernel.org, AJvYcCWbIUc9HSthRJ23WvIwnwspvWM9ZNhyQVYfoJeUeDhavIZ5Yq56dgYeDrX+SDE7Ivv6+PhUI1BfTSGI31htLS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPaBUF6U7sfn6FloqK1eEUfWfZWpoeU39HaC6Fsc5tC8BeESG
	n3YD3p0TGeAyFn4Td7useZjInscXUaEyr8T48CTKPgsxocvs+fkBaRt2JjxNzACx7aIBCtI0F9v
	F1rOS1b7VADHrN3BIwsm5W84PAhI=
X-Google-Smtp-Source: AGHT+IGxF/qaAquR3p4iN/ajwtjc4/plafA29JP3qHuoVKnM67HurHXakQ5FCO33WOySizgPzjYNWTezmZzL/3/ojQQ=
X-Received: by 2002:a17:902:ec92:b0:1fc:7180:f4af with SMTP id
 d9443c01a7336-205274fe1b9mr34696375ad.1.1725130947698; Sat, 31 Aug 2024
 12:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
In-Reply-To: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 31 Aug 2024 21:02:15 +0200
Message-ID: <CANiq72=pX32F4pDq85H=9pB=hmUcH59Xp7JoNGpKJ+XxkzovcQ@mail.gmail.com>
Subject: Re: [PATCH] block, rust: simplify validate_block_size() function
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 8:52=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> Also delete few comments of "increment i by 1" variety.

They are not comments, those lines are part of the documentation.

Cheers,
Miguel
