Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC0166F05;
	Wed, 21 Aug 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237458; cv=none; b=u9C9mQOXVEt30et0YZViUcTN0j4bQ3IILVUaTyB6Fsh+3UotNReFxDXSLtD97QU/ACOiT33/o70p+LGWu+WgwhX/MbrBbYSxpZaZ2GOYUmDNL5WS/r8WAYQTBn0e9tv1B9ZI0WrUZhQ0Fth3KTe/1Q9gw3SuzZHNLlHAjL8OD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237458; c=relaxed/simple;
	bh=RgKVB5rp8NIujsP5fR6Quizw2XisCYrGl/GvPSA7ZMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9zIpH7+GPfUHT92bWr6Oxx6QgMi7bu5BM6J6kZktmnw2121yiEOru5jAoUBkCpW1YhzQalBVEuLTB13pkRxVV7H4boSZ0bfzCB/oy+B5FsM9qBviaWYD1bZddFNx+c8MmHGJBdh5hwEO6DiGk4En6JLNZaw0+r7ywg9J/C6+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd9SzYrE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd9SzYrE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3badec49eso79854a91.1;
        Wed, 21 Aug 2024 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237456; x=1724842256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU8yVhJ74aNvIHdH35b58Gtu2Vbl1e8wdXOY/YRC5do=;
        b=Yd9SzYrE0PvwLWNXAscH3O7avXnpERDl5aJ0TXoFfvqVTk7EVNQ6zMEDxp7LObGcMx
         aJ7Iz4z0M3wLNPkVF3R6tKDClBCWPMBKCt38l5EK82wtOVqtIlpJTOFgsB4BVNghOecL
         iSLdS0wBPZBzIjzqWqfMRP5hfAIa3J0gw1AfgZHFLNxaAd0ZNwSf/bq2ELFAFOOKWkUp
         WeA1r19caU97fq+8n8+w/wi+w5y/29GtSf+8GyzohpDM18+N/q4Dt1/1Wr1fbgEMlVtu
         AJmBdUQgle6+u+eTrk1+vvlWhdiKd57ZBMDEvHsHFNA7KtOKCJxAqsFzKUBRbMCDOqi0
         +qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237457; x=1724842257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU8yVhJ74aNvIHdH35b58Gtu2Vbl1e8wdXOY/YRC5do=;
        b=e7P1z21vDzcOBVtBPzrLWkNzJkX0aHrGs/Nqe/k2n/8jXzqfH5Qw2MMMwQguXoxD0x
         R3s5AzlLDaiKX61jFbsBL6BN3zZUkaiuzC2TUn3Cody6RJldntRjaKFudKcYa1CfTkM9
         rPrlSY3znMLbmao+3f0PRi+z9SQniz6/Esprw3/Slt+DolM6rR0N/Ugxope8kKDtMigt
         hjk1E/xBbO6hp9/sPclQ6jN1XLJPXQ1sSAqDJX1vcnF7gmzK6Mc6P8M6QFZBRvLDnMFm
         DTkzQLq4wBPML4fqQGrWmAZI2p+NCaOY2fbWZytpQD4hvhHOlUF9RZNAMDUab1iRHBHO
         3A5g==
X-Forwarded-Encrypted: i=1; AJvYcCUdOp4u1tzbCPo2Cz40U4liDbVlDN75fqI/RV6J0RyNshWGQ6Ov5stgSl+TV57q9qP7Ny/Y/K7KnktSW2eZ@vger.kernel.org, AJvYcCVZwsBLAUfDviJxK3HOsXoO+KwwdWFa61bWxL0/ozn3NOQRqfR43EA2V4M5sAu8yIIEQP+mB2i5/M3P7w==@vger.kernel.org, AJvYcCXIq9aXlWtvnIwzO1URvA8Lw6oZcsBgJa8bSiPzuQOXBgBpRfe108gEOkodqm5iY0+/p+3LlUVnUYAPZPuYoxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsHUOoANiQ1LJXXNu/UHIEsWJN0xTepeKdeAICPSQ2Hsm97/a
	xC5d8O7jtqpd4Tt1lYm3lGr0UefDNmzoH34Db36aXCVjNWyzaSAej8eH9wrPcm3PmMR7phl3D46
	h70OcPNIxVsFPVNK2H4Q2Rjy/9LU=
X-Google-Smtp-Source: AGHT+IEpWod4fG0oxHGsWmHP/tvvSmMY0WXDOtfKiEuLt7vRaQ5nBNHKl1judWb9bXyUnwl5GDEm0GuQ8Vpjq9AANCQ=
X-Received: by 2002:a17:90b:4f89:b0:2d3:c488:fa6b with SMTP id
 98e67ed59e1d1-2d5eacbdc22mr1143769a91.5.1724237456565; Wed, 21 Aug 2024
 03:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-1-nmi@metaspace.dk>
In-Reply-To: <20240815074519.2684107-1-nmi@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Aug 2024 12:50:43 +0200
Message-ID: <CANiq72mCsBO01FHbf4D0h0yvTV=TbpgO-jeTHLL39ae-JpMLZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> The rust block device bindings include a wrong use of lock class key. Thi=
s
> causes a WARN trace when lockdep is enabled and a `GenDisk` is constructe=
d.
>
> This series fixes the issue by using a static lock class key. To do this,=
 the
> series first fixes the rust build system to correctly export rust statics=
 from
> the bss segment.

Applied to `rust-fixes` -- thanks everyone!

(I am sending the notice twice for this series, since somehow the
email threads got split into two in Lore, which also broke `b4`)

    [ Applied `rustfmt` and reworded slightly. - Miguel ]

Cheers,
Miguel
