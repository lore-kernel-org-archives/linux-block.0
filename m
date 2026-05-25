Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB026C3B0;
	Mon, 25 May 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730974; cv=none; b=sWxGP+Z+yy62YSz92C39b52hUCxGkeVVUPQDxJLtI3M10gqrhzimFI9vSBhLcsDdHy9CgXCz/a/8jNrhO9T9QKdp4fanzNZiFiTDJIx94QqGg/F6f1VnWSmg1mfdrwsPCVyS+vIvmzl8xvzf2q5qXl0yzcZ9ukAJjC//WO4C6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730974; c=relaxed/simple;
	bh=krDYml8YGifkQZQu/an44kUMkKmvTm2izItleu67Cs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TI7rcO+diZYYOTL1S9366DSYr++8R85VxA0MuxAHa2R2EbTHZqSYa83OWADt0SK4RHtMDvqApm6s4mNJ4o136cY9KmkOH1ry8ABJedfTki2Tzayt7+WLErMZm7ulbhCNKeqO0jH1LniQAi/aa3j2YqM7Ngjl7Jn2oNrB3AN/r4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qerfwrqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qerfwrqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA92E1F000E9;
	Mon, 25 May 2026 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779730972;
	bh=krDYml8YGifkQZQu/an44kUMkKmvTm2izItleu67Cs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QerfwrqzktXNV4cUWeNCQOrRPGFbrkbcD20wD4gi2v45Mkv5R1uLT2rdLxzOxJua8
	 a2TIKoc7UtPfLaTX08EyOER/QZStTK4AbRNqiqRzh3K/ArPnQaspP7opMZSqayqb7F
	 i++dfo3+bEdVxBgWLpVt3lzolmX8/5noVbk0FGIIYsjJlx2QWIRgEW0rCNkdu4GFJr
	 soqR3NJazmzhtXEe1SHXP7U4Jvx9TyFK+J43+M/dIvw9xL+2rGcPW6k3rxDmSc6mP0
	 JV9M1vVuY1vjt8QDmgxK5D1xVgIFy2v4k53Mm+zZZb6c7SCRshRvNcqJge/psCjGHC
	 7eI8SCvb+N3Rw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 axboe@kernel.dk, sunke@kylinos.cn, tamird@kernel.org,
 yuantan098@gmail.com, bird@lzu.edu.cn, royenheart@gmail.com,
 n05ec@lzu.edu.cn
Subject: Re: [PATCH 1/1] rust: block: fix GenDiskBuilder failure cleanup
In-Reply-To: <b6411cc055080c984a67bfad72fd683aa84b8e13.1779596478.git.royenheart@gmail.com>
References: <cover.1779596478.git.royenheart@gmail.com>
 <vDiE0u5yWwpR73QOOL97_K5xky-jGckDYtTjHAJH_7uGK6V1W8OKtcgrAIK2mC6I0Kfkd6lhbSYgjk2IRbvORw==@protonmail.internalid>
 <b6411cc055080c984a67bfad72fd683aa84b8e13.1779596478.git.royenheart@gmail.com>
Date: Mon, 25 May 2026 19:42:42 +0200
Message-ID: <87qzmz75d9.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ren Wei" <n05ec@lzu.edu.cn> writes:

> From: Haoze Xie <royenheart@gmail.com>
>
> If GenDiskBuilder::build() fails after __blk_mq_alloc_disk(), the
> allocated gendisk is left behind until the caller drops the last
> tagset reference.
>
> Handle the failure path by releasing the temporary gendisk first,
> then converting the foreign queue data back, so probe failures clean
> up both resources before returning an error.
>
> Fixes: 3253aba3408aa ("rust: block: introduce `kernel::block::mq` module")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Thanks for reporting and fixing!

I see we also lack a `put_disk` in `GenDisk::drop` after `del_gendisk`.
Do you want to patch that as well?

Best regards,
Andreas Hindborg


