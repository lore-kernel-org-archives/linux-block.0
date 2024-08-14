Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80836134
	for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626109; cv=none; b=oFChrd27A6B+lGH2Zwo+/YqzBw8/JSxRftsDpklk37ebok39ZHQU6jGYaLR9dko35t1c657RupupFCTQ/YzXEgPtLGSti84TplXlQu6WfNDz6RiRbtvKXslApYfyI3Vd+C2GMGAG3QBOiKOQoJGrN3IOq/FrB/lRsPCqG9GGIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626109; c=relaxed/simple;
	bh=b9UMgfw3CEsBgKeCI12aO+Vn00deASXrXr0xy5WKfok=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=snJpxGmH4FkX8I4L6/otuXcHVusTbgr7iOvZXz18R+mhLCynbtEeT5uTadaVTInGch6mseU51XLga5HbDGsZNDJu0ZVxzpJfZAWgDACoxEz9UwfuOVSEMWJ7iN9/kl0qPkRfGX8LzxBXE2MspBxWh1/w8Q7pXqs935d/C/Ke4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=uNsWDlUy; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="uNsWDlUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1723626087; x=1723885287;
	bh=b9UMgfw3CEsBgKeCI12aO+Vn00deASXrXr0xy5WKfok=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uNsWDlUyhnkMLzv7HSW7tlvNHkVZo5SBXEa6bVyz/ypJWYetzargZ7gZjsh1gHwnC
	 oMZPgl/zp2rQpHbQ2Nc6BdogJfuqS4vKK5DYONcE20aNdD1Kb+bLCGtXimGvXGrF9v
	 dSs3Z8OJLke1DPgiJGaTKr0xIWHbF6phDM0J/unUHph+y55k1Zz0yw1Q/mCIdI5SQL
	 002xDhoX07ecCdu0eF02YdTuUiDEN3Upd/EfnkSWzR0Q5se1V13c2l9exr2kK1jGZc
	 3E3XhohIHsT8IRYc0w7cNn1p/Av0VKho4SwPJ9YKaJbWCDAqe3j9aqWRKKeFM0L4dz
	 12nRHEmsObH3w==
Date: Wed, 14 Aug 2024 09:01:21 +0000
To: Ming Lei <ming.lei@redhat.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] ublk: move zone report data out of request pdu
Message-ID: <87o75vjxcg.fsf@samsung.com>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: afdb147483f3a22dff12b0b6d8447f96f5aba5dd
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> writes:

> ublk zoned takes 16 bytes in each request pdu just for handling REPORT_ZO=
NE
> operation, this way does waste memory since request pdu is allocated
> statically.
>
> Store the transient zone report data into one global xarray, and remove
> it after the report zone request is completed. This way is reasonable
> since report zone is run in slow code path.
>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Nice!

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


Best regards,
Andreas




