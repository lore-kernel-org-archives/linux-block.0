Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAD265CAB;
	Wed, 30 Jul 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881681; cv=none; b=Mre/iE9duLe3v3Qr305PKM4ptyAYdfXXhla6Hutc9WqT7NKTh+wo8YrwAPdmtHeV9di65cX0sLTYSiB+zYbBxRZY4/xOyli6ThFtk7G5yEQ0sJuoj4ooZajp6eK7/Xo7ySJIh+0sZsTj10bsf4PizijF1KOdy4NsPGU1voQjV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881681; c=relaxed/simple;
	bh=fxUh3dEZumi0cHiW6QpFsdbaoORLlmi8xlQ3Jppnza4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtWSfwIFYqVy+hRkLNBBqK86dfFUXMEd78O3i4b+JyupFzNNttio7mQxkItPupYwkKFtY5O/jmsxExoHnUFAsYJ4y1ziKM1N/Nq8fGJZ2/GMfjFKWzTFB095jGqCn64jo7OfhF781FecrPiqAiEkTeh7TIzkxZ60kREjfIm2dKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=CBtfodzL; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="CBtfodzL"
Received: from mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:515:0:640:ed11:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id BAA55890DB;
	Wed, 30 Jul 2025 16:13:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HDa5Jx4MmuQ0-xh2DFQNF;
	Wed, 30 Jul 2025 16:13:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753881202;
	bh=8z4SLApFyWRAw7OvW1QUAJYsAMQ8uODmFgZDAW4+n+8=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=CBtfodzLXuMQ1iE/wsmVgHKHCGhM5lKI7kTA0WejqL/SdLSQbiZUs1wHZUwqpdFRj
	 AII25WPIzloHL+fN+fo/buDX8g6W85n66v90wd7K3cvK/yId+vscFchrBiZeTtdymC
	 KLSd7b8ZYUPbjDqpZx+7ZZB8UfVEOqg0SKQvuAAQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 30 Jul 2025 16:13:16 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] rust: warn if `srctree/` links do not exist
Message-ID: <20250730161316.57bd7745@nimda.home>
In-Reply-To: <20250730130716.3278285-4-ojeda@kernel.org>
References: <20250730130716.3278285-1-ojeda@kernel.org>
	<20250730130716.3278285-4-ojeda@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2025 15:07:16 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> `srctree/` links may point to nonexistent files, e.g. due to renames
> that missed to update the files or simply because of typos.
>=20
> Since they can be easily checked for validity, do so and print a
> warning in the file does not exist.
>=20
> This found the following cases already in-tree:
>=20
>     warning: srctree/ link to include/linux/blk_mq.h does not exist
>     warning: srctree/ link to include/linux/drm/drm_gem.h does not
> exist warning: srctree/ link to include/linux/drm/drm_drv.h does not
> exist warning: srctree/ link to include/linux/drm/drm_ioctl.h does
> not exist warning: srctree/ link to include/linux/drm/drm_file.h does
> not exist warning: srctree/ link to include/linux/drm/drm_device.h
> does not exist
>=20
> Inspired-by: "Onur =C3=96zkan" <work@onurozkan.dev>
> Link:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DxCYA7z7_rxpzzKkkhJs6m7L_=
xEaLMuArVn3ZAcyeHdA@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org> ---
>  rust/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/rust/Makefile b/rust/Makefile
> index 4e675d210dd8..a27503028216 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -93,6 +93,12 @@ quiet_cmd_rustdoc =3D RUSTDOC $(if
> $(rustdoc_host),H, ) $< # and then retouch the generated files.
>  rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>      rustdoc-kernel rustdoc-pin_init
> +	$(Q)grep -Ehro '<a href=3D"srctree/([^"]+)"' $(rustdoc_output)
> | \
> +		cut -d'"' -f2 | cut -d/ -f2- | while read f; do \
> +			if [ ! -e "$(srctree)/$$f" ]; then \
> +				echo "warning: srctree/ link to $$f
> does not exist"; \
> +			fi \
> +		done
>  	$(Q)cp $(srctree)/Documentation/images/logo.svg
> $(rustdoc_output)/static.files/ $(Q)cp
> $(srctree)/Documentation/images/COPYING-logo
> $(rustdoc_output)/static.files/ $(Q)find $(rustdoc_output) -name
> '*.html' -type f -print0 | xargs -0 sed -Ei \

That's awesome! This would help a lot. :)


Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>

--

Regards,
Onur
