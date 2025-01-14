Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCD22F11;
	Tue, 14 Jan 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736835781; cv=none; b=CbdeaRqBCy2Ik5uNprwBawPA2kbI63/hlCXA7FlgckRV72Qfrv25u4rWiZtR8yBdYqEyYxbFWUO4fUA+OENcup+ID86iyj09R3WIrGTmhqZ5Rk8hSIhCEZ0jCHj6dFNA6vlqfpR0cnGW2Ug5chPsej5CeyMvv9CgiFFQSE0ipVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736835781; c=relaxed/simple;
	bh=jVuIhZRUvgPZRSCuVQ6t/tU5d52q/hnSXQjFm8iDUIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLsSVbc+90Kl/xXzFmXrKjFVNTwJtpUv8jK13FjmkVelYi+et96IrcYMzXDqt0yfNyDud84+71ZURqAqZouN1ZDns+pTyB7RA0u8VBrTDLmjrFVKnFnLgwfgE2azDixQrmg04fAljE6o/dBNl4WehT0XAU066iotxAkop7B62kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4tq8Xa9; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4tq8Xa9"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f2e31139d9so2392285eaf.0;
        Mon, 13 Jan 2025 22:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736835779; x=1737440579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVuIhZRUvgPZRSCuVQ6t/tU5d52q/hnSXQjFm8iDUIU=;
        b=L4tq8Xa9DmgW4GLduyf5sWya5gxMYPM5Aeall5FY7ciPmKekHtDvwr92UmTPxBaPmd
         vOVcsynrItz2lAZFUAgtw8V+TZk7D//ZqC4Ua5vjjEzWUhAsboPF28wQ3STw3VEqA1Dg
         /wfHswOqZkAAJbZ40hK9FKMiJdcc6YMrZxtJDA69p57mARO7xV4gMqq7Sx3WGqducL3K
         IMswSy15MBjlKVVsHsZTX9QET5hb/l53nD4kG6uLgYe2mkV9h8lWAwZ7Jfa0RjAPiAQM
         OMJIkgFItIl3bNffwI2qt6zRMhjR3+ieiJcju7cqagzI7LUBwv1NompxKBFX12GCKAfV
         w6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736835779; x=1737440579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVuIhZRUvgPZRSCuVQ6t/tU5d52q/hnSXQjFm8iDUIU=;
        b=NlbXAA0Ij+l2Mr6zfZDu015ReNUuwJk/PwtNW/58UJP/h1td+JW+fENZX1YJylJE6o
         mTq9s+NbgB6LOXZilVA27qPp7UZML+LNN/ZnzNnYSWTRwAXG2gkZldW2sSuKy6STL49W
         ip5J/pLnRyaHMy+Ksw0ujfo45/SvRa90fzMJjU33NZYGMt4O3ypjZyvlBKnRIzdlvwgM
         hBr6JWmzmCqKu3t8GYJR9EfPQ+SpVrhRg2QWoSOcH47zKZt0yGVD7PX7o506RnR5pz9i
         brBTyEghmt9cTtpakOyfKLGKGKRZ+5uF+SrmLbs4xNDT7k/6X4f0WuZWVK6Cu98r5cZ7
         ++oA==
X-Forwarded-Encrypted: i=1; AJvYcCVsXlp2uJlyyqZBx99id1qLShC9+6AMf3r5Sa9LulgKsAMJ4QFO/TWO69ZshcpyO1Ri+2jn/vQVAa6iY+65@vger.kernel.org, AJvYcCXVpb6GJ7dQ8/EWm1HmDcW9sqXRW5iigfi/dtnNNrTTOdnB+tZQhZMwideK8Dahuy0W5OfFNEr8uiDsWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3l6VSzLSOgot6SGuiaH2iAgR3vtTodDaeta0CWKgN1zlNBwv2
	tjIyTlSD49EGRTtQiAATJl1erRnTN3tT6CmFIxY8BCcTbGRAiYlsGxYnpnIH9ii94UjU/sBoZlz
	5fIw97eUzxJQfOhDaj/yjSPOjO6D0s/g4raA=
X-Gm-Gg: ASbGncvXdoyeBQ1RmIXrSnC+Ch+mMxNAErz8TZpQpn7MaCdDuMVgzwAIEhrYdSkzkBY
	9TzrXPXTg8dunwaMwMyPqZxYzodEmzwp8nHiuYB1B
X-Google-Smtp-Source: AGHT+IGfwjdSn2wvrk/Kn99SIO9d89rRMrWGfTmIqA+a1OvCy95oe+MDxJlwx6rYYI3XBhfWwPUKgcPlma7D2Mh57yY=
X-Received: by 2002:a4a:d024:0:b0:5f7:3654:4595 with SMTP id
 006d021491bc7-5f7365448a1mr9262674eaf.5.1736835778552; Mon, 13 Jan 2025
 22:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMS-em+jU0M9TnoVwViUfDudv4juN9yccsh-p+kuAneBw@mail.gmail.com>
 <Z2I1HAKhKrCR51XO@fedora>
In-Reply-To: <Z2I1HAKhKrCR51XO@fedora>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 14 Jan 2025 11:22:47 +0500
X-Gm-Features: AbW1kvbG-gRPiizkMDvNUL8NfFTZ0lsrGVH1cK-7cHH13_zaYnOPeuTxEDq9p_A
Message-ID: <CABXGCsM87Ezc9Z6TAfGaMLZsdD63O2CUyhxThoUnLw7_NmZXxA@mail.gmail.com>
Subject: Re: 6.13/regression/bisected - after commit f1be1788a32e I see in the
 kernel log "possible circular locking dependency detected"
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 7:36=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> This is another deadlock caused by dependency between q->limits_lock and
> q->q_usage_counter, same with the one under discussion:
>
> https://lore.kernel.org/linux-block/20241216080206.2850773-2-ming.lei@red=
hat.com/
>
> The dependency of queue_limits_start_update() over blk_mq_freeze_queue()
> should be cut.
>

I see that conversation ended without sending any patches.
https://lore.kernel.org/linux-block/23008fc2-6e83-4d83-8ea1-4a3f6c0e000c@li=
nux.ibm.com/

I am still experiencing this issue in 6.13-rc6

--=20
Best Regards,
Mike Gavrilov.
