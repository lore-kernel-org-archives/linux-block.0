Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333988;
	b=x4VGdQdjYfyafDKZEe+m4Se6N4iikIVN1CRIqoqMEImTC0hiv9yknkSdkeHCmgIjuqwI
	 uK081XXHiJeb56ZZXu6KfuqNZggDA/cZthdjoQubpniL99Jc5leD6qYLhmtTcWJd/lyYX
	 7Z9o99EkUyFVcsu1swT3JkKJkZqwBMOSlq4R4FUnNoNw3yogVreBc1aCF/AWMGsKwYjD2
	 UcIJPNJE5V31gjoCljj43EW1zUuTJwJf2mnLv2+E2vdrFnLKloQffnRRgI8a0ynXsqecV
	 N6lq1Ff7da46ZBwUxJvr5IzeeWAaPWX9+eYEVj/u0xofuCHcxLzBbmh5t181sylbRPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SfoLXtHqjGBdWNvjzeRsPhMhyNnS9gocssbFMuTMFA4=;
	b=4F1Ydt6/E/DW6cRWgYKV9cutuJxXd3ftBVSId8IcovSfBjjKZkvRz6if3vzXVJvL9y9u
	 E6FlRKH96PRUa1X4aS/ueuaUEX/6yHLYq4XsRQAg0C2bVkSwi2t47vxNPu7ZLryGYbSGk
	 hCIgPWH5GK+JLfsYKYRbxy1ldrYbpSl1zFC3xJaBops67ykwYc1zW56Ktcnn0shEYobZ+
	 tY7ti8Zx7nRlaKy+/M+VvOTSv364N+ex9G7Ha6SGpXLp01YcMtNVQJrk95e+IhZhUiGy4
	 TrgxztnEI2ewg1kWzZmrg+rKYoWLgcS10yaF71daIIkZs0tvxJU67o8/pPRBCJXN/Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8h9kxx8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD6606A325
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 18:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DD6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8h9kxx8
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3accd1ff4c3so17987261fa.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 10:06:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333986; cv=none;
        d=google.com; s=arc-20260327;
        b=eis3s0MQv0u1AwNZQRqySdyYMzjscHPR1w6YIrpVFLR05+Rq671T9iI6qsHQDQ2ZYy
         wMtikrxTEqFeXiEc3SiMKu3sc+mNbBPxjmyOf0Sll3b4prFVeqXJRor2xK4X41CjCiPF
         ztbEtdJrbjBKPI7bzMhXBqh+ICp2ttcE95yGpyoWsWIchBEYIag2ciKxZFFxW7FwMs4A
         zR2Nec4C5mpDMdOIZHH8m0HvyKC81CHsDqoQNktpCBMu7z0PdOAgQejLdAsNjhhFGCZ9
         w5M1erid9qQymLWHBwDCqYYHG2YY4MZ6H6NQQU9bXuuJO5Xghqvo9Q8fNYOC9McUsd3u
         mXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SfoLXtHqjGBdWNvjzeRsPhMhyNnS9gocssbFMuTMFA4=;
        fh=R3Ghxk7iZU1Tx1Pl7sxAhhENJPjPxbMJjJII/eVehHs=;
        b=UCwATJp6LaLMpqhqZWcJboG6qGAFxo5h6gRiwslPTrHeOVkQyEJOCU1f2C8ZGRueNb
         2VyJRyTn+4N7rVVfzE5T3PCTR+lKSQbxaojYhBA1HKq7DmYoUMQwY5O6CQI/LGVkKz2g
         wLu0h3lrOnmlGrqMTScd0ou2fh4edCofc0N4HAIiwy0Xe2qcXcvpyaBk8KzmEqOEm8RV
         YiF7cRiRoJjJKOqwOjZ09Bn68FlyPnLbfuiJs+VyMwu9OZgjybnGIyL+Mfb7BKv6aVgd
         QGUD7yc8FEq0ES665jv29lPm6ENhGLigfxgL34l05tEx/QVNOldoTRK017/H2NXcvN8y
         Up/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333986; x=1794938786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SfoLXtHqjGBdWNvjzeRsPhMhyNnS9gocssbFMuTMFA4=;
        b=o8h9kxx84PGbW2rpni7hxvpfcNJwXYKUoMbKQU64yIBjjuHJYIU1Mu98UU5WoAF65f
         JKLS23xoha8B8XfKn5IT5Cko5JUBHH10YwDLthAVhFeA9npZoKH0FnaMQ0ZCealdMDbj
         K3CG9/8GoJqtJY8aDDy5euBXgZDgOsiFxCDZ6HnrVSGoXeKNE60X3kKjGe6RMc8LPmCh
         eyPCW6zZMvvaSZvWj08Lf022fqoC5VuCL+fcvnEMz+cBb3c3EP8VxV9OIRTQQvxWjgVj
         gIE54XvpJx/tH8IJ1UKBJRQUfZo5S3+UrYFKpwdPSHtXUyVHhXVH/KM3AHeX5ISfOcG2
         IDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333986; x=1794938786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfoLXtHqjGBdWNvjzeRsPhMhyNnS9gocssbFMuTMFA4=;
        b=jjhrVK+NPWSLTAgNnEaP/n3WRTkBHGoSPVaojvfT9T5ZbKzmjsheVW4n2zk36c1OTi
         v/0mL5suUN7W1wUnQu8PRZeXfn1/GkFniysywFkrW55XZUEB+O1Coa1TkGLWgkC77ame
         +IQCz5hZy6zsWckLt2taJ2Tabced+A41y882+V/1Wvv5uwGMUiSi5q8nq/LeXgGrfLVN
         JXSLCWwgwg1W4ce0UIqeMVExM9/85ZueP7QNzhFsz4019+tPJlolSLZJyODt2KvlOkx2
         ufvj6QlSPffvlpZKx0svp9qIc9bpjeVvDPMjdVBCsJXEbSBxqliLULSbgUK3OzZQfGW9
         deUQ==
X-Forwarded-Encrypted: i=1; AL+hErHx7oKA+6s+29fXiaG6ZpkXVdPIq6XwFoI3v8bMwf1J5naCjLIJdL17OS1NovrSHoUbO1SC07nrFJVvxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UnCIcoQ5eci/tL1axrX/bCqoxuo5GNK80SgGeKjpzSu5wY/eV
	iMMS3rWttDccyIRaTAOcsXYlW7jx5J7YF1udYyE3DzF4JCTnFxyw4tbRTpuQa5krXkycUAxHH6i
	ADb10UQ7tMcGd0gr2I11K/+Th3aFhPRQ=
X-Gm-Gg: AYBFou0k4xADbQIcfE3mgMiIMH+P+YFD98s+gbIMcMfqXL26UPO9M1bqPZz0Upg5w4V
	Sm+EwUqpem6oD4I3Fq3C9ZLzUYMDE2tlGtE4iVreLYlA7BkYvbAClS2ROF338sCPPk2u78UyFnb
	yZ6rGbwdmysarpTlTLWCNQxCj9L19Pb99xksULQ2n1n+BzRDqnn74FBfyZw1AsQlzzgkTDYAlie
	9/X2wyIN5rJ/wj1k+1Vn5ed+Vxr7b3gfAbpl/Yuq+XI5c6DHLK6hGM42+hBn1HeZQolQv4H6FIC
	hWo81yvJrvfdAcB6Zxz6lhfQZmzEx/9MKeyzSQtTJVZTILCey6B8u4/mtLBUa32x+CpasmIc245
	Nb+x4KGd2cznulpdeh0xuEnZ8x1wQMEjfY4n53apyDTRzHosgL9mIq7QOJAtL/qCn+duSHh/nza
	CaYroFPlecn7MFgk36U/3jkSmwMADC7/WzofC7mOncRYlYOekyNG8g
X-Received: by 2002:a05:651c:888:b0:3ac:e902:f22d with SMTP id
 38308e7fff4ca-3ae09650574mr6624441fa.27.1794333986106; Tue, 10 Nov 2026
 10:06:26 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-12-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-12-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 11:06:13 -0700
X-Gm-Features: AclHuK_swjugJ8PYhgUUzKQzdHDuV10SGT2tfqTTSkLlpXsGrfb9HF1M_R3wmdQ
Message-ID: <CAKEwX=NvOym=p+pU-nxW9hdrf3wq+Ns6TGFqmjqHw1rY9ELcuw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] zsmalloc: populate new zspage outside
 class->lock in zs_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> A new zspage is not on class fullness lists and is not movable until
> zs_store() calls insert_zspage() and SetZsPageMovable(), so neither
> other zs_store() callers nor compaction and page migration can see it.
> Nobody else has the handle yet either.
>
> So for a new zspage allocate the object and copy the data before we
> take class->lock, and don't take zspage read lock.  This makes
> class->lock critical section shorter and saves a zspage lock/unlock.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
