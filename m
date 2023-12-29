Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5312E4E
	for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MHXTAXZ4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26fa294e56so384972466b.0
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 11:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703879174; x=1704483974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxVw//0XmDBBzDSX3dVy7HjMF2XF0QvFm4eu66iyHsE=;
        b=MHXTAXZ4geHOw23ip6+HwqTzbthWXXELvGQ5OAGXwhhjW3nLVwHnSzR9PRcpav2Rc0
         EtHA4plGozZxaWNVt09jx2CE8FQUlWiCWUgnXWExE4ET1QbckPK+Xuirel8TVe7it7Ag
         qFXCTItTUWf8L5uFfRneyDBI0yp5ui6rSqKuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703879174; x=1704483974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxVw//0XmDBBzDSX3dVy7HjMF2XF0QvFm4eu66iyHsE=;
        b=JdE7XhqnrlgUcnz9lBYatTCBMK4xpbxxBogRKysZG5r6huUfJjLliVcREzlgeiIZQf
         powkkmn382y2ALvSzdR+XMTb4q3kYwgm+XMi7mMw9eDf65ggkO59gTZ1FfEkS5U4RMgt
         ur3A3Cnle51uYmFSikHtxB7s4M2cYvC5Wsia7NNNBWwI3k8qjRWTVOesSmS6rOEvfb9k
         0w0c98dJ/Afzo8ab+oUh5EtgBkwWN21xbCjm3RZF8OMfoWfznPOBGsj1JswP634mDEO6
         lL9B/tLjqZHm0wIZTrqurS7HqSMwMR8Q2+OfnKGkqa32/XyHdvsF9T3ytvvbEIQHW1jU
         9DbA==
X-Gm-Message-State: AOJu0Yy4Vy3SIqiPJ71441XIM4mAdnmkeus7z7/u7DAtrGQykE6OgYSF
	BvjGsr+1MRFhkvUW3x3ZcVNadTd0Uuo6jLZkbpdsX6Mb8/03Sp8K
X-Google-Smtp-Source: AGHT+IG+g8BR3i/VosdrahHa4gYpyyTouzsninmexmylpDlBtiqjaYqPw+uefiIVlli61MsC2TD9Hg==
X-Received: by 2002:a17:906:253:b0:a23:5a0a:7725 with SMTP id 19-20020a170906025300b00a235a0a7725mr5425803ejl.91.1703879173997;
        Fri, 29 Dec 2023 11:46:13 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ef5-20020a17090697c500b00a269597d173sm8640661ejb.135.2023.12.29.11.46.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 11:46:13 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso7527649a12.3
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 11:46:13 -0800 (PST)
X-Received: by 2002:a17:906:184:b0:a1f:aca1:6bc with SMTP id
 4-20020a170906018400b00a1faca106bcmr5384379ejb.100.1703879173062; Fri, 29 Dec
 2023 11:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
In-Reply-To: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Dec 2023 11:45:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZt=323ca+Fp6rUNHHzPn65krYx=pZ5REbdxuUeRGfdQ@mail.gmail.com>
Message-ID: <CAHk-=wiZt=323ca+Fp6rUNHHzPn65krYx=pZ5REbdxuUeRGfdQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.7-rc8
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 07:57, Jens Axboe <axboe@kernel.dk> wrote:
>
> Christoph Hellwig (1):
>       block: renumber QUEUE_FLAG_HW_WC

Lol. How the heck did that even happen? What an odd typo. Admittedly
'8' and '3' can look a bit similar if you squint and have bad
eyesight, but still...

          Linus
