Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EC4718E1;
	Thu, 15 Oct 2026 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095182; cv=none; b=ZN4VuFXxkPvxFNxqkrnbYpQ30k2pM2XGN6FvkZQZjm9cJ/Hsqtz6xO6wDicVbefwxeLazsMga2MTX+XDndHOhpWECm+BDk5HwMZpaZM4kCeno0UiFTmJKcGI/5AVso/Varcc8G/3cUtUJMiJe3P4ixPy+Ouf/baTUTDTsltPZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095182; c=relaxed/simple;
	bh=7xqtRmgOf/C+CNSdv1o4clnQx9bDqBMuxkPsqNMztg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=addG3IexV5/xRJk5AeDC0NnSkNT3b25f3dKtZ2/Vef+xmMcN1ZL0WhE09t46wsSX3hOsimlA546wdEn3SDJqaMZspB4itMR/+swZcqUVx6/0ALhu+dslpdDjTUvCWhYHwDrHzl9K0TUDsk1uNXR9+9dihKiWudrj8AFJJXHO/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=xRGRTdFD; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="xRGRTdFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6m7qgpzynrcttk7snp2wd3tmdy.protonmail2; t=1792095176;
	x=1792354376; bh=7xqtRmgOf/C+CNSdv1o4clnQx9bDqBMuxkPsqNMztg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xRGRTdFDkVKFmfKmT38Rrwvbe2of+oU1TLOeaUGjcblPE29DHyaGPIj1GpCdrcgko
	 PrvK4ouyqIyERon48e1qT6O9MUpyIabTgO2VBGWFtktdPbX/O6qvvNQADtgskQQpYw
	 ao785zd9024Pbezj9hgHKCOYd+TtxTITRx5PX2cSA7nkeqHqRc2d2DDxMT+m/h/pWC
	 64tF3NNI4UBASrgQRJcR5k73nAqJ31O4Che/d4oridzqGQ8grlOskwwAKvyDAWto2g
	 DS1fjoh6XlMXMN0MftFJCUK1jgXDz1UifyN4lBEGGFAwS1OsZgRzswyCZc/d6vs4WV
	 zXNjAvUboMPkg==
Date: Thu, 15 Oct 2026 20:12:50 +0000
To: Jens Axboe <axboe@kernel.dk>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ublk: hold RCU read lock in ublk_try_buf_match()
Message-ID: <179209516823.64241.11273116688502044448@proton.me>
In-Reply-To: <CACVXFVNi5E2Anxs5-EwevS+srqv2_D0bp3NJJv_hzM6pBNBWeA@mail.gmail.com>
References: <179010105967.8478.2344875677216734809@proton.me> <CACVXFVNi5E2Anxs5-EwevS+srqv2_D0bp3NJJv_hzM6pBNBWeA@mail.gmail.com>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: ea11ac2a612611565662cf943effab55159b463c
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Gentle ping on this one, Ming has reviewed it. Could you pick it up?

Thanks,
Paolo

