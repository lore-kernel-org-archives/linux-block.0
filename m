Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8940EBA9
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571398; cv=pass; b=TO6I9aVq3tSlUz1Z86pEOz3adTRGDJ1g4Q75LQ1mJ16zzwQRWBYkrE7SC5ajmwpkFKqJhfaGE4zAAFWFvb4zMMGhosAqhQ1MyDCywUgkLPdLVPzzEsQtMvpdQTmD8oic74mlkcYL677a7PlIgfdqxcHW6I7JNTtKgmUQL+txP8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571398; c=relaxed/simple;
	bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T01Wj1Fd+gSGubz3WlKxMMwx41I7+tI/fQAPzhpD6zIq7HTaU33lJHAp3jSvtH0rDeHonFAsbZsOZvv/t41BJrBwCmcw0EFfaIO231CqIY9ob291sZ5c5jHidbWMi0tcqOG6NhKF5wIZBG5iaxl4MDYQTV17cf4UDgL1gWF0U7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt7WRk9; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt7WRk9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cffd93cdedso2806875ad.3
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
        d=google.com; s=arc-20260327;
        b=dtnWvtn4yfvfbWhqZPlFemWNfbkDCpEiTCLs8fTPaU2RzQADhhBgQS+nF6YOWHDeTs
         PC4cfKIu5/jU4aKSVEaMLofDLaOKItufywuoVerJtKoHB4fhHnKCab7Vq9SM8c8UblT5
         A/fWWzPr2h+qKWf+TkjH9CixRsGFnKUR2OPhSbM5IXLoh/M9uts2k6Fuq89RwP75Yqwx
         6Jbg69V4PTvXKUSdkHEIPEWb9tjWeH4K4WcOxpAndMZOWenmFnRYrU1v90Ijwuv9cWVL
         lDd+t8lmSW21Sq3vy2NRqQgsUBBmghKCNm1XzYtws3WdYJjKFlzj7G9FCKikGIdTFHkc
         Z6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        fh=sfDny/K4hkO1o4D4PlX9F3yZOi7uHlJuD+kWDicxHSU=;
        b=J5Zik7TI5njC5priFp5XOBY1W++CX9/m3lya5BsFx4YhJJ7NhNYYtVQA7tg5EzlBhq
         4ih7W5WbxVqw7pcV5CJaRC1hXbOkC8DWapp+lJ7WlJzVZ1/FT5Ichz7P1kdp4eWyRw1z
         kYppbunHy4wEeelZ7+X+2Vi0VD4GrEzTTt7+RRWATJ2yaNiy4FKFUfkoXxe5DmPEE1hF
         wEmLO9y8BSO4cLrwMAfUGWq3XFy1RgUgg6DqP8eV/bWNchf1SNirZjosvmNlsCxsEATJ
         V5lXbS3YtZgTwpybIU6tsZuruvlLiU1fhE/tyh7z7EvUfDtTHvbYh4uMHjsRtsLse4D7
         MXCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=YFt7WRk9Nw5n+i/byMsiEaa4pUCFMwIOshTiaBYfmARkFAcX/qqf8idooFji7JpJ4V
         8I34V5VPE/KG8FVWrMOwRcHp0UY7rjPa7LnUR+B2rG5woJ3E9vuC/Eh2yg/2usdoBvp/
         sgDBOYdtWrBqrUWgwPwBFa0oDvKfFJLzefi2in5uq4x8w4fS8H4cBSKU8F9Y2M+WR8RF
         QkcAvfYl7OjkWvMO/Tb3tcOzaneE014I+i3hMlZOBVF9dLsLPSrerORIU6H1VrLq3Jh1
         krdI/j7GbiJT+hC7CSjdD2Uv42ryCAzdRaCZFoOZqJ9FlvCJBlxcPbPAHtRNv4k09cv3
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571396; x=1788176196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=WldxA4EEixY//o7X0ZKLL7yHCk0d/mEz3cfwe7ZJBlkEMLdPAl8lbs32QOV5DbK5Nd
         BxqWHxJFqZDlj2CbpLf/I9gtu1IdNSFbYLrqBEI+EX8LopXCgOzZNcHbRUYtkuhJSkrt
         9gzzNHkvrlx32+e1sKKVCx3Kadn3QS3YmXXBox8kwbxQDr4Zfl/S56bb79dElgtnQFya
         AP4Dbc20Bs/1K+9Ud7sdQcfJXtxjvHS2p2PGpqMhBtMcYUpk/2dKjzYb0H36LoTLEhBq
         9XpSgfKcu3IBqqLmnyhyCR/NH+bulFqkL0vaQ6A07liWuJR5EP4RXfK9rmkEqKlmdmf6
         5HNA==
X-Forwarded-Encrypted: i=1; AHgh+RrxYz5MYphoNzxB+C/WTKcKP9WNE9ZI6ZWHKJTfBQ/RZHmfd/W7GxrElK4r4Ro5sSn+s1KgyP9DiD//jg==@vger.kernel.org
X-Gm-Message-State: AFuF++n92by3N+lpVTs9l84b+g2SmygHdue3HZb+uizc7gkC/M2aNhr0
	BC+K9g8sMLy6+QOgoVUL0+faqiyhS+fKnLWkATBKTt9U3IB3u4Hdw+5iTPcVRZbwS3BlvD6ym4h
	/L0JmXG2DzrxUpfLxYRP57PHgFIamA3M=
X-Gm-Gg: AR+sD10l/5Q6o+fCSGxz6yLBz12a9dAVqWT/9n/xazxwkms/BoB2hWM3JwrbvkFkTPM
	D8alC5gSCezVIMcz0G9IXiOAgrczT4rdOzbTWGsv0qcll0Kh7vEXWogTrmInqAwqxHDnKM7myw0
	F7gwE7HzeHdCQSJmn/n1PZkBmLi692NlAD3zxao4xlxzOttzb0miWM2eg77jBASO5dY01cz0+Hp
	DK6Np4tlI9GG/eS6O+v0/Xw53I/9yT1nrnLaCsvrI6KiIeZE14GdH2WHX+YHKMtYedsGYBLpE4F
	k2V54LN4ReUrFyAmtiZF8fzCie55Fk4ljOTWGwVJQLcXz8VqqxHbLbqaPDCMgQRbPozVfEibX/Y
	gzlOPnb3Qiw8TKq/sbxT6xUF8UgmNAEi2iUSMQ3LVT5j1tB62JAXwQ42kAkrHsKOu2Bn57+Y=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel
