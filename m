Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8148627C
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155289; cv=none; b=EUJcNiKV0cKe4ycdPIsjyX9OrrMd+58KOutR1ERCQhf3nIgwGwZt2TKXgmJW0daxtak33ERf4k9SIO+E4TIjW4xShzMFzWcerTrMGPt1wb2zXXdpMCyA9GTjRWUM8KE0k9BKp0b8LInn3zTpydYCANIY5SP9T2PwHIFLOcaJglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155289; c=relaxed/simple;
	bh=1MRLxMSSbDaZOoH74gZrRBxdj01ORAzox/zNSSQV35k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfGJAABd50qa1FSVemCndudSUfoynYWE8NFsCFgdyAZNxibWvI7C5aej15ajQFEB0vcCoUb1WfKvf0LIYBufqVf34vzX1CtHia00ueRHc4wfSRAsXOoIHJ12b1wNnNlRO/WPBnSbqnb33ybW3A/m+7FhE1GMHjKsEjdJlNTlYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B+m69ozj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B+m69ozj"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4429c556efso45553266b.0
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709155286; x=1709760086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=B+m69ozjwNePNGkNIqZxY5cYxPT5xZkc2iYa3mL8hTrYFU1YOYVnRJsPkJqCi2ymQp
         hTWjmaksS/HCeGz5kk/DM0ms6EkmbZ5//kAhxkq4/NA3lQz8y8UqCP2WwQMif4pCIbFR
         Ue6ZGIY3ca0Oo0WS8pFOfA50DMxhF4102kkC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155286; x=1709760086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=DYmnz8fz93PwmecCaPQ4b49pCU0OFmfm8cXDkR9wmGIIZqE772Rh9p9xDV5yCLSgmj
         q5KScYPJdsObLW0GlXccbUaV9tTVQFom8V5hLNJ5cPfetmRSWQTeRGNNLxQXTUdCYUUz
         QRbCegnJLqDFXrNUKJfkEJinSB6niwbTIbvMpRw5unrbpm/WUlxKeOTHxNLcqQAR3V1g
         ir1H5u13c4GLYE1rnekrADEHnqV5Gi3W1kqqda8k2ebAHQdHg/p4EmP/y8KfTnuEZXPS
         ywXQ4pDdxwPwyfdfJALNoDHFVuhpb9NnZvOu3ZswDU+fN4+Nz1yoGfoltQTcRycscBrf
         QbNg==
X-Forwarded-Encrypted: i=1; AJvYcCXYVsAmxlJ4zz2B/EoWa/ujxBC5k7KTJ/hF8sJPtoDcfj3V33ek1uwdO7Klg1NvijAiDrSENGe4/uexDTgkmHQWu4GVnUTzCWZ8Mlo=
X-Gm-Message-State: AOJu0YwBqG6pwZsksppF6n9oO7zd+XdLaxBoHUetVcXggRi6Se2MOPYZ
	M/rhjLN0NY089/ogF8fA0jNR99sdPXfex2KnxJIWh3vcHChFaTpfjI+MG0zCgSgEtFim1ATHWKV
	azqKyUQ==
X-Google-Smtp-Source: AGHT+IFleEEOlObUL71RagOKq+sTsqy/T31ac2ZaGM7mnxkb7flU7/KPk+rdPf5eVN1ZCGLSjPdVrA==
X-Received: by 2002:a17:906:dfeb:b0:a43:8371:2efe with SMTP id lc11-20020a170906dfeb00b00a4383712efemr120772ejc.32.1709155286220;
        Wed, 28 Feb 2024 13:21:26 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id vi3-20020a170907d40300b00a43eb697337sm1218150ejc.49.2024.02.28.13.21.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:21:24 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso328149a12.2
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 13:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIHE8B2dazwALwYNGzrrOhOfwLQtDlDFyQ8c7D9JVBtEKRNBRdug+WqvDfdzjXdGuqw6g84I8J1z+sZYCMxr8PFpY0Vobko+xpXuo=
X-Received: by 2002:a17:906:a291:b0:a44:234:e621 with SMTP id
 i17-20020a170906a29100b00a440234e621mr129720ejz.10.1709155284453; Wed, 28 Feb
 2024 13:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
In-Reply-To: <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 13:21:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 19:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> After this patch:
>    copy_page_from_iter_atomic()
>      -> iterate_and_advance2()
>        -> iterate_bvec()
>          -> remain = step()
>
> With CONFIG_ARCH_HAS_COPY_MC, the step() is copy_mc_to_kernel() which
> return "bytes not copied".
>
> When a memory error occurs during step(), the value of "left" equal to
> the value of "part" (no one byte is copied successfully). In this case,
> iterate_bvec() returns 0, and copy_page_from_iter_atomic() also returns
> 0. The callback shmem_write_end()[2] also returns 0. Finally,
> generic_perform_write() goes to "goto again"[3], and the loop restarts.
> 4][5] cannot enter and exit the loop, then deadloop occurs.

Hmm. If the copy doesn't succeed and make any progress at all, then
the code in generic_perform_write() after the "goto again"

                //[4]
                if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
                              bytes)) {
                        status = -EFAULT;
                        break;
                }

should break out of the loop.

So either your analysis looks a bit flawed, or I'm missing something.
Likely I'm missing something really obvious.

Why does the copy_mc_to_kernel() fail, but the
fault_in_iov_iter_readable() succeeds?

              Linus
