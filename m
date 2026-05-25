Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E7318ED9
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731524; cv=pass; b=Mjc6ZiQgi4QwV1ja2cM9KQ67RqMFtgXxkZHIv92ogYxKmlfn3rdfJ2yawnRV0eFJ19EUvIzRp1RoKMd1Zg3yww9+lwRkMEkH8zsSkq9sNjZDOF4TfMzJ475MnYLlMa36Ab0TdO/GlH6u/IZoSPhacIqDb3kSfUnd3sRY2ePauzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731524; c=relaxed/simple;
	bh=kr6z8jUXJs76+Hb66TPj5wAIPCr19WpDG6Lp2ByKQGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFE7UXwRgwOJ8U4JAGCMC1jzyEo7ur82adGlY99SAc7t/GV62ouJB38xfbsDM3NKvKAYPv6C+KySj4EQSvfolYTAxvpCzgx/5fINWeg+clxz1XKSTqqalyx776hkaqnkLF/T80/Hydq0X3GospQtLMWK+C1Qn3htSrDV7bu2pJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OppDLcB6; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OppDLcB6"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bda3b4318dso965820eec.1
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 10:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779731522; cv=none;
        d=google.com; s=arc-20240605;
        b=DOKMN92dn+i8bpdbF7Be287d/scGPiaEcNA3rsTGA/fMR1VZGGsNOTXANiG534U7kR
         /XJGBoo8pjzu/XBAvDkof7Wp3pQo9YysITrPA0eaqo2iNSEq0GjVClFKqQh6KRU5jiH5
         Ma7Aqv79XVF717/GnKXtKkP/EP86frQ4kAmXqD9ckw4Un9bIYKwJuVe2cvr3FibSV+Qh
         Im76e2JsBSFyM1a3DkBBN9XjILXVGEaounWFXMxLpzKmhXtdbn+HYp47w2S98Uhv072P
         e6Oub+DfLDskYFKtnTqWyZWr0tsGxZ6Pn2nA5nABK2QyZh1kvZgzGkPkBGiRIidirLPn
         j3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kr6z8jUXJs76+Hb66TPj5wAIPCr19WpDG6Lp2ByKQGw=;
        fh=OHnksx0i0ax3UMqEXmAbCJ9JzuBW7l2A5G/jGi383ZU=;
        b=cfP70UhKHRd64ln4FXMDvE4x1onY5hVCyCbxjgKT+Rxm3QYZjrjnzdjD6RvDBcb1j+
         KaZYjNSXZuDf2xBmLKs2Ycp6kFnkvGIOvbsM+1KubkW1HOvTaMgpLd0V0XaW5BAW8EKq
         A9azKFWYBK1ldifx0QhkcVlYh/72fvsmFcPdlFSc3wYlItmM+a91EKxa5Fktadqe4TM8
         FcsJOyiCvkI5RjhLXEkUastRQ6NTlPFFFzyqHcv63ivAHtS6WvPBosYZU2l11QWOZtEf
         VhQyTdsNok5Dzc/GXGwTDJfxolcFZ+2UYXJBE2MKFEM7saqFaxZxyPkKb4rNCprT5uMI
         SRAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779731522; x=1780336322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr6z8jUXJs76+Hb66TPj5wAIPCr19WpDG6Lp2ByKQGw=;
        b=OppDLcB6u+4hVFF0nRgLbobmYXoTLVQJl+Z8xPBBHmHFhvYb8RJRiF9YS8rMNI5nCc
         7Y8Mv0RdAOhQbay8yY1egS3iRvlzguBb1ZAA5/XLhVgteYSK+JiGxyk3//MN4458SRo9
         RnPLdCXmz6BGOrsL8jz/xmx2khl/zkRtjFrmwzlRIX1cARxKH1ICKY/RTZN9zD9UCIY4
         M0RsNpnlmJzXox6znyWLgimAjUEKTjik8ZAFNZ9+ZZRRE1MRZ555L/2pLG3E12eCKfoW
         DO1NfH6+ROopBpWoGmUixJGU0ztsptJdzJY2XF17VDZnzj9mul7XxWDgSEvcG3nfxPpi
         nZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779731522; x=1780336322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kr6z8jUXJs76+Hb66TPj5wAIPCr19WpDG6Lp2ByKQGw=;
        b=ZbaPnHcMeB8hkhPg8gOEnp7Cer0HGzq9j1E3f3eFgF4ZFYsmciKI6gIeptVcBAB+gF
         zJhNbX+c9sFQVSk/9ewDHqXojfjMLwdZmI6QcAw0p7py1UiwtlltxfR3LjtF7lp+ic+N
         V7PjU0SCYiniWnwJqKEIg/Nln2M/XtHd9ZRTSrC7Crm+/xRK3enlgoLP00wEG4mil3lj
         JTYXcLE4y5fX56n27l/aYbKEhRERepweQUJyxhxvMs8HWoO/khoTRUDJLVnZukIb2HEC
         17svn3b71JCzUdku5gMh0ieFRBW5RIhrZpKXUE7zYXdF86woCtrWj1rzFnBV4zSWhF2Y
         POBw==
X-Forwarded-Encrypted: i=1; AFNElJ8uxBaAnFJTA9jH8gQNOTRtp5/3fJJQcGryCtVCetV4PI5j0jvDa+r+4UaTHc0BsdKaLuGx4VrA96dbrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRf9yRAkWNtK4B2L1ZS77gRltgCbCpoiDDJyvh8fgrF++/ZX0
	vllq14sBw5VcpRGLVHHVhxKkrNuk+KuiapQSdaHNsKgNczYrvCuSDYtKqhd50KQcPei9hFLsn+P
	/LSrSH7yqzcMDdG4sFvg0c2/mSdXdeIo=
X-Gm-Gg: Acq92OHT5RgfrPAbmTe16TuC5Uf2kI+aR++GkuOv+8beZZUiJXEGfq/gAHI+ATw29/M
	KN/xew38zJ17o4AhY/V3E0ywI7t2HF/zYnOdAaCt+PI1/akbz8saPe0Gdv6bMfFovFq5zb3HhQP
	QMo3WmX9orOcjSLAzkwhtj4PAUvIQM+ur6qTD4cjXWaa90/KK23iKWffggglHOMpmvp2FJ2yLMT
	xpvTxmrO8oYSJawME73RlKoAHKOAr8AwWd8RIC4n9cdS0uA0t2A2KXsAoFZn6bbyoJzD8L1wO2u
	94IOkj7G1dykHNyWosqkmnCXygGOEDvoJu4boMZpkx7ohv7t7jEMeIt9+FhACsvf/40UIUhMBYD
	mikl6+hXe6C2DGcR0bxmadxo=
X-Received: by 2002:a05:7300:df44:b0:2e6:b55a:76c9 with SMTP id
 5a478bee46e88-30448cf0ceamr2954662eec.0.1779731522166; Mon, 25 May 2026
 10:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
In-Reply-To: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 May 2026 19:51:49 +0200
X-Gm-Features: AVHnY4Lj-A7r4aYA8iAqKIKO_8AgbVe3NWs2TYf--zAM-mIaOF-qUbEBAdoXyqQ
Message-ID: <CANiq72k3cjgHiimYqGfuQjPy+A3oOUEoMxUJCS-FgBm25D4MLA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] rust: use vertical import style and remove
 redundant imports
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:57=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> Adopt the vertical import style and drop redundant imports already
> re-exported via `kernel::prelude`.

I can take this if block and misc Ack. The changes are straightforward anyw=
ay.

Thanks!

Cheers,
Miguel
