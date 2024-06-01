Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5E134A8;
	Sat,  1 Jun 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717235968; cv=none; b=MTDdRgGqUGSPwbKqun4vC515L27WAzwhRScMWEF6AV4m3GdwL0ugbnI2gJySkXbiRrAyRLZQiYN5L4By/oIOBvq3teuEc0NE/hGe+AMhwBxMYXbrsuyrFRQKFWUoaP8n4RxGAPwt4DrX6k6xxuQx+A5PbDADeKyaF3PGrnz4AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717235968; c=relaxed/simple;
	bh=nEa0ywGQFv6LInAcgt7D1fAcDzqFUPUe77ujVL4lYGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKYW6cfUiZ12tXIUVEq+NpBUdUAoQaAH5g8yp3XD7xkTVPxWLtITNYgMiimSjxQ6bnHCzx58hgVfcmsdxNXzdUDlb5JVQsl8oTMXu88qEFyXh2eEWUj8CrQ6f/a7XXbRBQYF7dnEINJQRl2xMkDrvIgcYOq8v7XhlloG38mp/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlV1TcPl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlV1TcPl"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso1299116a12.1;
        Sat, 01 Jun 2024 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717235967; x=1717840767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEa0ywGQFv6LInAcgt7D1fAcDzqFUPUe77ujVL4lYGQ=;
        b=MlV1TcPltr6aFi+9ySdciiNKcX/YCMweviKSxG1FKnh3BQ/onKSeCi+5gvUFZ/4P7O
         DvpI9zbyqVPkMW6kynWHV5NSiZtWljuLIyOiDJd9Z01O8d783crtXrNgmc1UTXIWnNcV
         wolLOg84CDFo8hdZLFLu0rbLd+HcxPyAciWciJzXKacpHcCOOJc3B9HzbiMesWi2Zroy
         qXhHSUQyzaH1OQqgQvNMPg4V99zPGLHxBz++5KuvTeOyopbZPaPIfIVaa/7qJUB6Cds/
         I6LeJzzfm7/TBaCyrJPX6iqK7ko66xsIkIlnWPNV8x3LtaiZ8oBXKgBSyJwnZzdMsYH4
         ycSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717235967; x=1717840767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEa0ywGQFv6LInAcgt7D1fAcDzqFUPUe77ujVL4lYGQ=;
        b=LugxFKRNs160OWNYJTdbmjQhXeUiW6ZOJqfZQtBx6nrvoCZiCJR9PFvIL/P0ew07kC
         Diz5SWJv91d4vjWd6lRDdzwHTACQjKQrO+p4FcGzhTVw1//6I8sFVxY71OyzW8DmvP0t
         k0aWttJb7Xa6+zpI/VieENP5WXnyrCR1v+Hp57b5pAa3ne14NRxihC3Mjy3+Ol6yoiX0
         dDxM8TsvwrS0+1SEJeUwnebWJ7KaA+ZQMT1pasoFBDWJA4EjAEXhZ7nSrwDegshkaeA8
         2nmRElDcMasoDQtcFB41La0gawi4h+RsZFn1xYLUdG3YRUIVoBeHVBz5kDn68MSL6mLW
         3QjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDeUfI78UyEeCsWZIsCuXuw8T0C9SFt/XgnY/8f/My6gUqMVdi4dMdm5OrG9oPwMXpzImafxw2Id3Fdb1pUZVYhgd92rAjDZF7no6ZOW5MizUGPAzn+01/jw7jcgyt97TleyeiLzePGinknhfCwcGXwzDuuIU4Q5MYQM+I+jbZZdXjmPHSyIPIOg==
X-Gm-Message-State: AOJu0YyBN5HmppVE4Vnk7hpl2Y7HlXEHQF3IZ+CJhZJoApEgCVE5uAUV
	4aCjmKv437nfHt/hxdX00DCDkahF1R0JzLynmKQxDj41vMOBI2OFAZC9JcgfWZ9CSLZhiA1Abf5
	uCaAVrLycpQ6Zx3KmHwbe/D848lQ=
X-Google-Smtp-Source: AGHT+IHN6K6n4hEXNDD6eTHZnFzEkaECDBjwO6nhkKRWAvpggvRxKavP3OcFNnmbnLG2Tv7rfzlwjQopZB5GoJNQk+g=
X-Received: by 2002:a05:6a20:918d:b0:1b0:19d5:f400 with SMTP id
 adf61e73a8af0-1b26f1bb3f3mr4942384637.23.1717235966649; Sat, 01 Jun 2024
 02:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601081806.531954-1-nmi@metaspace.dk> <20240601081806.531954-2-nmi@metaspace.dk>
 <47a8ce04-3901-49ae-abac-a7d85901f980@proton.me>
In-Reply-To: <47a8ce04-3901-49ae-abac-a7d85901f980@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 1 Jun 2024 11:59:13 +0200
Message-ID: <CANiq72mtzX-OvY__dohQKmn+beU3pXDS798mVDnXYz32UK+WNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: block: introduce `kernel::block::mq` module
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	Joel Granados <j.granados@samsung.com>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, 
	Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	=?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, 
	open list <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 11:44=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> AFAIK the 1.78 upgrade already is in rust-next (and also should appear
> in v6.10-rc2, right?) do you have this on your radar?

It is in mainline already, yeah.

Cheers,
Miguel
