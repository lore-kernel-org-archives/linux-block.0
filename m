Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FB192D97
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773612983; cv=pass; b=d0xwhc8n4wzQeFaJyvDhrLoiq4xR8S5tay4PewWC/FwlGP9bK9fadW+VqE7t8u/L6vHH/PIxZ+tY6ZwIJ+qQEn91b/W9KZO3rQB+JI6F26AnXreQ5pyOPrLha+XuIwU+DAWlLzLHxiAtJxeREr4eMN07rHSFAcz+prFNQn2OP9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773612983; c=relaxed/simple;
	bh=+5+hPi2JuPwjHkL8L7DN1vqJD1ja2IKC8acdT9KDE1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kASu3yVVzmZWBhgiX4tqAl8oYmYpwMT/MW7McwAQAnwQgtS3xGBTr8aaXWXmQdkFPCOTHEwWhFiiVpMfAAvaBEqmQoliXCDBaGxzMqttSUhHWyUDhQ+lxXg3VZc/FkIxanv/TGQEs894q1BEG3khXjppyU//8wQ9nBbA8CY78xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABskiqY4; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABskiqY4"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0bf0a0236so23894eec.1
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 15:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773612981; cv=none;
        d=google.com; s=arc-20240605;
        b=EQXaXL+x/aOfHsr6N21YUbphliRmDWq1hziR+480r4VYVWWVECwUBQYjzPJGnp6iOf
         +Gz8Ns7aunghZ7ZVtciz7sF2ub5EUfiz3V07/e7iNOu/OaR2Ob5yqDcSJbm47SEUYG1l
         TlhA/eyl3tCAZ3RduCtUeoT5jhYZpQs26uSJ37gng2dYnKcfbCIKdbDHNfF72r1T7S6q
         cVD4U937aZihnfYpHDP+gnZzeP5zpDP7yVOd2MHTb/aqvTO04IFofvr4ekZTgoJQR5+a
         hrykYJV+t7H2n78KhXWsifXzSNVDqol5XOV6s6fG32FZgkIzm4WTqRRqeAtNj3dUDlE0
         1d0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+5+hPi2JuPwjHkL8L7DN1vqJD1ja2IKC8acdT9KDE1k=;
        fh=ea0RIxF7tnXi+yyuyefqFLykq9ogM84qmV0lyM8d0gg=;
        b=F5qxLBJvtiQBA9moIuJ0VQtl4cTHlRzt8qYogiM/CAKr0syY3npnZoND34hH2dn462
         rcySoZNOi435hk0sI8XWGbZWebh8Ly+7ftLJclsrKLJJUZDxBoP7w+OMYLLqQVvZlPYr
         2Y6YQSeMhwHo84hQfFWkdWfu5UEk19ZZuuuAzGhDU/qZY4FbNh+T64Jfy79vMFhgcb1h
         tl1QmoivLiYpPj+15uJ6AM+7eYwwfcm/Qbs7fzFsiGxEeX7N8amodIiJ3TLzCX2/PpGe
         0ta7cvZYQgTldBHbv+0JnR2bKhc4vbqQ0+kcjWxmuEqXCD7NYfUYDaGSItmRdLOU4H7x
         9DYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773612981; x=1774217781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5+hPi2JuPwjHkL8L7DN1vqJD1ja2IKC8acdT9KDE1k=;
        b=ABskiqY4wz0RTBvNLFPMeVsTqeTIc9JiBgJCTgNZpdanWizwxn5x3F/EODJzeacpln
         TSF8CHR6M/HCyR2yCRw1B1bTz/XV9AzjIAXj12p9MTzyebsB+eFSkmQm9lPJfrpYG2qL
         I3ywI7W9/Ww3lbMwikxQYGQP46uvVlj6YXViQjE7RydlhHLuHcSAy8q4m7NYH55NRLlG
         IMGSpYOetATGg37vFsD0d1ClSnA649C82cTj7r1K5y9StNTDpMo2MusMSyBfSIC2U3wZ
         CSYrzKZ3AKNzG7yLGTP8myRdup1rTUmFopNDr4OE6OJExFwAEmPkqIRCAbcbD/bNBbE6
         DbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773612981; x=1774217781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5+hPi2JuPwjHkL8L7DN1vqJD1ja2IKC8acdT9KDE1k=;
        b=qU3E5hc3A7istriFD+KGVyzg2HlyfbI978VNNQPWjr58H7jkPeTRUEWm1VZo1oK0Z7
         945SmDTDAM3PbTTdmzXQlsF58RgOOtsQvwQLRz7O/G4pKr2RY2Tuv5BZD7Iy8LmHQKqb
         6ooYCABqAQg5Ci15CIosSaYqGBX912F3IWtto2g+MjscNBaY6D6sUyI/EdkwhFGs6mx1
         VcONOLWPUY4WHN9vcHiwYqGP4VarhFjfwEOmnQwqkyNarMV5yaFgn+DeItyW5rxOtM9o
         XHQi1WcliIxIx4bin6LYNPPsyM2gWUsZ3HFMGFo25MClBNy4lZG4kIm5F1xO5M1/zELW
         yUyw==
X-Forwarded-Encrypted: i=1; AJvYcCU91s5pCd8cMMF3PIbK5k5HCL5JsMYtNw290y09JFqkTtGKR1IMqLZ2vkbqH/ir7vZsNUGTkIpyF85+kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf4XnVYH3F/NkusIODh+Yn8E2hyIWwq/Z6Dx/oVGIHp9foqL1
	VXzgAn6ZyF1gsSb7/U/908b1Fbl6eneDQvk9yfbymFkQq3hmnOSLE/AFyoq7iY5yvw+lKNAiH08
	2l+ZzF2oeyAe6YHx+KZJ8UOkR7Sjq91E=
X-Gm-Gg: ATEYQzyOLnnmySshTCwn8AVpLMkG2bvq+xV+LR+5yl3/ondgKn3nTNT9y4dHHSF3KZ0
	MabwIpcgJoACC1mff2dsEL2u06ZtFUeCotHYF5UJbdgNLYz+4XZvh0MZd1mtxWLJyEkAqA87GGk
	ldxpewxes7w739CSfDlBHxB9ZqtRsI48q7Obi3YmHzDa8+aqGass4H0nG1R7GjTLUNcDheUkLEw
	TESTfBnIsWC+QRfARkKvHJPhYtPUkXiSsJVN2FCVzFZMd/xInqKPWtCSeOO7QnJ7iFV7SJrpo/s
	onyPqA3HzYaKMboUIS7rQnFXqKCNgftZfFXrC9zOQJDQTHm6RXxtgqZIWSYsfRqHRDhaz5LCMtD
	e/XvK+FmimVnQOVqMjSXnSaQ0vOyNFhuVRg==
X-Received: by 2002:a05:7300:4313:b0:2c0:bcca:e9ae with SMTP id
 5a478bee46e88-2c0bccaed2cmr604178eec.7.1773612980958; Sun, 15 Mar 2026
 15:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315201713.15438-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315201713.15438-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 23:16:08 +0100
X-Gm-Features: AaiRm53YUbK-sLcHmfXbaOT0BMTdsHLl8HWC_-mgD-EzGothIZUIEAY4ZVovwhU
Message-ID: <CANiq72=5TWd6BRrAQftDWMu_25H3rmv6=TNpgN0o+NxmT_+M6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] rust: block: rnull: update to Pin<KBox<QueueData>>
 for PinInit
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Boqun Feng <boqun@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 9:17=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
> Update the Rust rnull driver to use Pin<KBox<QueueData>> for queue data
> allocation. This aligns the driver with the latest PinInit zero-copy
> initialization abstractions in kernel 7.0 and fixes a type mismatch
> with GenDiskBuilder::build().

What latest abstractions? What type mismatch? Why is pinning needed?

Anyway, by independent patches, I meant that you should not have added
the "2/3" in the title, since it looks like this message is part of a
series that does not exist.

But please wait for the maintainers to get back to you, instead of
sending a new version.

Cheers,
Miguel
