Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794741103;
	b=MyrS62axA1KwzJTqNsfn8mvaqFU/ZNKc6Z80Ce9mpqM8adeygN7nSXoi2iqG/QTI2pgp
	 Zxd2oJyRMKz0hlQevbLH/yolhdTWZS3TrNSQ5AkKCvj1VnNrZDbphgcOn7X7bSEePLMyV
	 d5kBkD6HB2OL6Roh3RJY0UECVbv/vFRsU6ls9P0zAFt9vv/GtKA3pFsW0hNM2TfdNAVTs
	 rNEhgWvJi3FLp6y4U8h6aGKLCcJcfeW7BeC/3BlkFzMN/6gUjHjTvv5bC1jZvb5uM+BnM
	 p7hhrSdAObPEZ+MXzWzIaM4V6c/nIXBNrkhMGZ6m1naGtJCZY/3OjZ67FoO1EVz4JyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
	b=zw1aqzzQ/IeLpu8r2U5HF38SZMgD74jwBWxGcSsaPHjycypN21Fl6iVeMnvE54UBb5uH
	 MSIAZNGr7jdsSXwa5eJ7bQCn8fF+Ls0Tj1smfYjOfafwcpMYmZzLc8wQ2HGQhP4aA0EuY
	 uxkTUGow3XLxVkTPZcqJN0eklzLmySb0KzYo21TDU3UvZvUD6Mxr7MsoNbhL0WuRzvpQo
	 HC1tPBDPtWcLl5wISGPAhyBezbJop9kM34tjLJMoiGY/Ov2Uvivwz7QYxIzJ+11WRrVQz
	 4DJ6IcvM3rzSVI+VtHblz2/0BsVAIR+IYAcFCPEWfm8uCRekzmf1w2aZE7MBQj1k2SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of3jASAY;
	arc=fail smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEB606A323
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 11:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92FEB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of3jASAY
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-84e513874f8so2606667a34.2
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 03:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794741102; cv=none;
        d=google.com; s=arc-20260327;
        b=gOodhfWubCo+ILUqxinD3004cDsWSYzpjF8BP3q+v9ZC4zI8Qhj2IZtPb1mNzpgQVv
         LxrAfGwQFVov2/wUfZy5taQbZdjT/lmh/XEtEYwBNG2UFk52IGzgwbHuEn/r8AalFHBb
         /idlwJibJKUJ+Ng0rXaWJy+UVkVe5Jc9A7t/Dr7HFEt2Zr7Iy16GKhwwzUmdR1HO1Pad
         dHKzjPrdFiBoVUDZf9lP+ckaa6Ke82ZJ2pxnxr47Z86L9DloUrtOA0xTvZgdF1syOeuK
         42rm1BmP8zFqlS8PpHkWSqneu85eLG+mYYg8c0nK7anxIs4kik47rBtlk/lBTpBg9lLw
         WSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
        fh=kpyAIPklI/98s2FYuanlCT3pZTSPw1Xtujggda6/BP4=;
        b=b/4fzDNdsIMFRRw9/fZVxfldYPwuMz+N/D+idAruoXInR8gCJkS7wX57nXZKa3M6zJ
         6gWGdpva+qJ9hC7eYNpY5nt+hiKs+cnLEg49LInrngJ3AejqRYSbksFQ622ClPmau0Xs
         DRlVLMthEZI54hLGtehIKk2nWDcdr/IIJvI1gNAtIBd0VxvDbpNsQQkyJ0GuPVSNRUIi
         Qlcwof2OzBvhCjlHFQwJTEFvrFmwxAMWxQ3HqgKo0Edhj8KBIcZtQ8k2Xxq5XI5CHmJb
         Jh7Gad5Frkdkvji8LRHvkfKl9GIVRE2DBAD+mlWoKq5XRdOZPgqNIR9mDZEmNcAPQslq
         RIMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794741102; x=1795345902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
        b=of3jASAY2uRq/jJWJtu/J+egIQO1aiAxkyVYlqd8JDWFDtFgfEM/Ma9B8dkH712nlU
         FwU+6/jbKtlEGp+Te4LjsNsdHikC39GeG4Nl9n3ilFv24t3C8VTdUA9jVreMg2jF0crV
         etX6Qs1vrc1s6u9lg9S4EZP4HwAE5e4ybxFh+06r4L2XrA/e/pqm9QUnr0HVjdj0toYX
         0UeYI6CwkDYj95zh0ysL4i2peIRMgecP+5lvvpTKeZB7JzWwfBKpl+Pws08y8ZmK7NJA
         pOvfunaaFGTpvE2TjiFqAnvKDCOaHNvdi6lYP8Qu5gY/UTUJdyhnNjwXvZDIXDHxCzfj
         nbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794741102; x=1795345902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
        b=MSqmXhSN6P1WpmWUmpagmsrxt2TpxExdctinHMpufNT+OLLV+/Z4wsQmM/h2O7Zyoq
         SACn9hkjMarmMZugy7NCwEH3TaJqd7YzQvtq6LZqXyTBppHmkaG5Z/oxabwZh/Ikd+Vl
         OKDMyZBsCnOZst6L8eFTI0uokiuVmWCxpkXfRy00MDRS9LjRVDGIb5v9n5/ECWVpDr00
         ImL57Th+RTkyuXXlZrGIkp8S2mAHVn76npFvXbKEwn+CCZ9Sby+RTJD8bGtIrcxScvZP
         7a9oIYMn9bLxCF2osmmwpJ+VpTjxqbre4Ns0z+Sghijd+ZePpRTuUINsfLE9H891f+YZ
         EfGg==
X-Gm-Message-State: APuU4Z+DTOtr5fpAL0+Mvx8DmS4YeiJuQudyYoUJYlZSGNYQRajCmsXr
	6OHXs9SLpSeDW/fz2U/OsPGcQGfyeqOaUVEz7IRIrEMYpdAy970Rfe6Mr4FHZdPr6+X2Jj4t/iw
	EK7uCYo+5sxTiIJwdFGhcp2Z/tHUbAXA=
X-Gm-Gg: AYBFou3BF/1Fcn0cZhoTm0jbHTzWu2DqMHjmsLWicbVvI7Loa3Ts2yMmSPyxog6rHP5
	1vwLAde4SjJUSUhFQJ97lDzPppPxVENOopnszpGDSxkTiCcXWLLa0I7OuCd8nsFKP0EjGhQL1KT
	yLrqfLF/lFXvJLy6u1nacR9sV2eLiaZSbkR9KvO7Gm3H6bEz5lKGLZEQeqOiZTmHxzgCDPNz0xQ
	Iew3Vw+u9tcXFzuh9gSAe79BjXPu15SaSJhH22SYOXCNSMAOaAyDDyQb83mJRjbl3hzLVCwvv1j
	JdBCaAhkxctGT+ffThta0NhReY+gVB0Ss0Yn4roAJNArlDhxD9HXHNOeo/UCO4OKZek3Xi7Z6q+
	hmyovWUiOjoAsMqUcNTQXTpERDCQwYgLP4I5TLX90u20yjjXbPcvK+hkMH3A3pOPKORahrfv0gS
	t+TwrXkr+9sIsDsx+NBm6dfZwn5nm7/9pnMvWxKU+7dYmGbLZZEM/Ui3J9zQ==
X-Received: by 2002:a05:6820:4189:b0:716:d376:1676 with SMTP id
 006d021491bc7-71ab523f56fmr4513622eaf.87.1794741102408; Sun, 15 Nov 2026
 03:11:42 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
In-Reply-To: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 15 Nov 2026 05:11:30 -0600
X-Gm-Features: AclHuK-yfkBjfTlRzPqncy1or8kBWwirdyvLakJdI7oKdEpo6iQh6u-uxa2CP6A
Message-ID: <CACVXFVM_nfkBVnVr8oEVjjTOYp7mhox7KvhkME30QBc52b-yxQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: dispatch the next fetch after a batch failure
To: shao.mingyin@zte.com.cn
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 10:33=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> When a batch fetch fails, for example because its provided-buffer group
> is empty, ublk_batch_dispatch() removes the failed fetch and returns.
> Pending I/O tags stay in evts_fifo even if another fetch with usable
> buffers is already queued. With no new I/O or fetch submission to select
> it, that fetch and the outstanding block requests cannot make progress.
>
> Claim the next queued fetch under evts_lock before completing and freeing
> the failed one, then schedule its dispatch in the proper task context.
> Marking it active before dropping the lock also prevents cancellation
> from taking it before its task work is queued.
>
> Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O pro=
cessing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
