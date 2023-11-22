Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cQnXxjcA"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432B1B5
	for <linux-block@vger.kernel.org>; Wed, 22 Nov 2023 06:52:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c8790474d5so54183811fa.2
        for <linux-block@vger.kernel.org>; Wed, 22 Nov 2023 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700664745; x=1701269545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqW0w8dJWEORWP66TgrclqI7GjFRrqwdDgyNGoDP6Hw=;
        b=cQnXxjcAqp15wAhDPAkyyoTFW5NVrqzeZUC6NkpLNaV/WYDE8WmibErj2VCFLrwv6v
         QesyO3Y3jy9811ANYe9cJMvqf2FMjR+LnyDr8Vuhfr/ZHGdWMqVtDMrgDbMWcKYj28/A
         t/i4LaX+OHJrVkW8Mt/31gBnzA2GlPSnLJ6ckcvmo3Fqq//KgxmwwWF50/M0W02OA+k6
         Txe0AYIO9cKL6fayS+su1DCmChS4ScDzBtIAZmU60mG1JvqmN6u+lNbpiGXpnBqZ36tN
         0tTIvdUxB8EqBAMxXSmEG+hGxTNA2hVUhGgyep4phYdHvqLIruHq5g6oT/ZmyJfQ6Evp
         dDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664745; x=1701269545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqW0w8dJWEORWP66TgrclqI7GjFRrqwdDgyNGoDP6Hw=;
        b=d4Ab6AyYxz2JCBjwKlmDb/anWUO+eggCIPPYmj0bO9PmPsRddTtcgw94bwUBJsM9Pm
         464eDSAYKuYtpIXP/PHILHpSYmngiUJVv0WRU+sZJvgGzkQbsrDX27cnj2M6mllbQSYU
         LCHwXXgMZhzie3Kkrw0E1tJc3JPJRTVi9IAN1ffxX+xTWje0Au6/rJhjx/ZvBfrvHtZ8
         HZ9vxRsNZgG495NL0IF0UI8k6fwhqC3jkiDpyoSjRsx4k77Jgt7DRmnrunPmZP4IGy4i
         yuQgLM+mjIEhdjGLDfr3cV/HNUfFBQb6cr2Cyw1m9SS3t+x6h5TH0FjvHki/zx3QKcmQ
         np3g==
X-Gm-Message-State: AOJu0YwpWVIsd2ZM0Djnqo4W3Utof5VoMJzr12LtoghcyiHg72/CCvk+
	8lU2qoJH+aRUDHD4hMsgFeCnAtoDfIk/Iqtpf/NDR1Q3oWjmsSVq
X-Google-Smtp-Source: AGHT+IEAoliXOg6ylfuGfCmbV33pTvm6hon3p8mcY2Vo50msh4Y0grfzyzizPLxw7PjnO91B47tBBF/5O0pyq1ZXjRA=
X-Received: by 2002:a05:651c:154b:b0:2c5:844:9e75 with SMTP id
 y11-20020a05651c154b00b002c508449e75mr2512487ljp.8.1700664745048; Wed, 22 Nov
 2023 06:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115163749.715614-1-haris.iqbal@ionos.com>
In-Reply-To: <20231115163749.715614-1-haris.iqbal@ionos.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 22 Nov 2023 15:52:14 +0100
Message-ID: <CAJpMwyh-24qFt4U1L2Ki270oWis-GUBLRQVC+Lf4cG7EumkpPw@mail.gmail.com>
Subject: Re: [PATCH for-next 0/2] Misc patches for RNBD
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org, 
	jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 5:37=E2=80=AFPM Md Haris Iqbal <haris.iqbal@ionos.c=
om> wrote:
>
> Hi Jens,
>
> Please consider to include following changes to the next merge window.
>
> Santosh Pradhan (1):
>   block/rnbd: add support for REQ_OP_WRITE_ZEROES
>
> Supriti Singh (1):
>   block/rnbd: use %pe to print errors
>
>  drivers/block/rnbd/rnbd-clt.c   | 13 ++++++++-----
>  drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
>  drivers/block/rnbd/rnbd-srv.c   | 25 +++++++++++++------------
>  3 files changed, 31 insertions(+), 21 deletions(-)
>
> --
> 2.25.1

Gentle ping.

>
