Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A430F536
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896337; cv=none; b=ZF+hemzN+kqMibg0JPYHL8pbfQwgd7SrDKekwCoOr8vjyNjMMb2FvMCeTrVCCQhQ0Acn7D19Kydj64FcnOwrml62CUflS/jKjMOHgLRSCanK75ijlE1sl8UbdmNTHKFzeKu9LrnYKUnBNRqQ1b6lfrCz2TUBBWJ7Raik8S+EY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896337; c=relaxed/simple;
	bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjW3yzRiaPVaxYqjkLzt/Jcf3QCnTbZH1gotrAxCNildGAHnu/qvNA5qap8gGJbT3GRn6KQNMcmZ+588k5WGJl8c5R7WhFRUPFmvuiBQOyY7dDaagKX6gL/kbmGdT+Flxex8gOTh7kTl70IY8unYRF921cBfLJoEa1cguU17d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJfNMYdL; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJfNMYdL"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dfa9e34adbso2476008137.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767896335; x=1768501135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
        b=UJfNMYdLd7CGhfVtjf1YZKGwtsOA6VJM7o0BT5tJIxRs6a8Iq6OO+fo1J4eWXj+8F+
         BVzQj0KyOeH9b3veFy27ddmS9r/VL/S9MlD+TgZYZx//kzC0kUAZ44OdgT4+vNH6WuGw
         GjWvT3NRd153lgF7kQCSWuec9feiOQaikbrvBgfY1cjuAUb4ZVAG4nReqMOeP8geE0AI
         9+Xuon7lnqUd2tJOmEmG+4tt1nv9CQEioyplZAXF5OkjOsIuQMPxzjXhKYkqPDLTSnag
         95b9o0Sc01ZmSu5nuk6rgdsZ3LbqHZsjncK5ibn1TvRh2sM6kUZGuu5KIau9ukCcNk/1
         TYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896335; x=1768501135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
        b=tYpF8s2CapuZ81aZrEseLNSIMyGsiXT4iZnrNM8DJfv8A1KztL2dCXkT/iDaPks5cj
         DBJNmtZ/tpGu8Q6X+yBB0PP3hRI78rmAexlVUj6gVHWUoL729HfwIAklZvfHmHIpPJhk
         pgeH24H1dQRWgLkFykskwd6RjB2uP6PIfhfrcnb7xfY3B2QZCelox/RnUxg4wo2mEZbb
         Lp7qNqdvhUhEQs38DSJUcp5ajfJ8LHeX2Tk2P07paOqje7V8o/7hqeFCQmz65owv49SA
         HatLEyF6zYZH8fp9LIsT/wjmMrFtaf9pFQsO3xlWTjQIgasHtv0txapgNoEhEeaMHAmu
         73CA==
X-Gm-Message-State: AOJu0Yysmg9JkFc1Ww8pMP72aRSY1RxwSxnzhAStA8TmomXucdHOevwz
	Iv9LUTwiHp9scD0vhgiPGbVX1FUkiOF3PzwX5N2r05bZYPRe0PS5NylkrhKfb/Ypytfe1n6ttZ7
	PUXZ3uifMvzDuW8EVlojx8Rne0u21ckQ=
X-Gm-Gg: AY/fxX6rtMAhkqTCvRrQ9VYlboTB/nMtWI9H7oVpfxdwQHYX+U6I5j+hw8NVxfyLfM6
	4uo/72EGYyAt997J7BTTNbxDk+g97y9JfXOalaC7/AMbQeoWuzpbi3qZ6hD00pFU8cDnXUqSevt
	LiHTJ8iZBbWJrd4x8J6rBzKqXkAY62WjxjXTRqBJi5uCzfVvW5z6p+NBIfKvJ+jFmSDhCFZiJi1
	HoQrfJZ5gZl5HEQEiws23RXdP2SyO0SJ+Np9Kxg5nZEhjLff7oBpZX6VkvkvtU46PDQRSSeNJ2e
	7W2uBZkDHqNfcUFRca5wlOgNhl8J
X-Google-Smtp-Source: AGHT+IFZDy2QW6KnuIxIEyHkKpqj6MMEJSR/7O9XSRt3iqhghTeDZkCmQR+L8EcADh1b6vUy07gKP1CBUhZxixK3ryE=
X-Received: by 2002:a05:6102:4412:b0:5db:f352:afbe with SMTP id
 ada2fe7eead31-5ecb5cbb3e6mr3294188137.6.1767896333290; Thu, 08 Jan 2026
 10:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Thu, 8 Jan 2026 21:18:41 +0300
X-Gm-Features: AZwV_Qi1KXJg98wuNlhob-PhKfYxveiRiQnCM2LlNsbeCGFpRxNmbpDflphYfZU
Message-ID: <CAPqjcqoqR8UdC5K-RCjKvQEoA6jnRBVZc53ieR1fjJKz9-V9=w@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Soo, let's remove the 2^N restriction for raw block devices?
