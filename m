Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B32D6E5C
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889911; cv=none; b=hJd5eCsqMA9vHtc4Z2z1QDJG0t4A2JYNr7Ev7FmntAZYjXOMKj9je0h0CQIV0vxmJYpJhq+N6zW7ITAyu4rXS9RZsRsCklQuQiuazW6bMQm758F9nuklwnWxCIESdS6/ShPDYyVkmsW4xaZgQmI0xqrItWQrHwRf2doMvOg8Nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889911; c=relaxed/simple;
	bh=y2B3ij/YoKMjH0RdoX/27lvUgNYe+GdjRmFEeNLa8vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCNp8/L2Nxm4yCwBZJZ3VFxZ5aF0JvCPy/e97Nl6w4jXMYBlmOC5P0sRZY3eZhvYAF+8WYj9bHNScEvNLNkflgIeNIrof+ct+QmSr2QzS0IJ9nOUeaHMgG8n6VkTnTzPyIwEHXwveCoLCxpeijxzmqK2q85HsOmFudk7YJSOhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CTkiTZeE; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CTkiTZeE"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11df44181c3so137235c88.3
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 08:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767889909; x=1768494709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpeZdi0CdJj+zcuvq/qopypl+oDVE8/rx1qK9duNStw=;
        b=CTkiTZeEVJl6zuEn5WFEV3G38CVWmU0u2RZkz8utGCsMEVGP+LnKvW6Ni8lEpdHEN6
         Z4LDPOvOLtC4USWO+VfsaQrrjwjmZ1cWxnhEbYP9Vma3iIE5/llIhwZug/yR8ymUd4cS
         oE6lzusQ1KePwEzBKhksPfga+pgH9eU1dhoK6hDjXQ7Ciux7NWq/uZd1TSy0I+6q45ag
         /M9GQKZwF8Xxn7zMC7Nnj/DGja/9uT4sARj2HM8H5Qb3iEwOYOebllU+AOM2/WFNEZyc
         QHUmVxT8+aGuAt8/0d5mHLho5LF3ksTmEdlAgjnyuYymx4oKErIEDEOAZJtQ3x+AIABr
         JERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767889909; x=1768494709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpeZdi0CdJj+zcuvq/qopypl+oDVE8/rx1qK9duNStw=;
        b=vos2B8BnBej3vXUqa9CW1TFcgXIT3uhndwuafg7fptOIUZPa91scXYkWCHR+DLAtRP
         oJ/5M0yXQ2w+OEcRDS1ZGuwbZWTnuQ2E2UbLnsS3Kjvg2VtZuwfUrczLOrn/8k5gmAdz
         ciPnlMxUIJ4A/4CLz7oyJJLpBl0kp/2n4MbgO74MH1UWSSUlFBybt6/VQnzV2MRcyD4l
         bNBDqFj9n2I548i84RIkU3B6NeYytB4uMvfxbSTW1lXJl6C153hPS6jA97MaUJM0YjF9
         e6AY1hu6i6Dd8XaMAHZoRyM8Z+jt981JJOWpqUyS9Ww8PJEQPu5RoABEjXgey+cHo/8l
         IPYA==
X-Forwarded-Encrypted: i=1; AJvYcCXyPtXeD3FkhK8oWYPsAD7w4KaemIWtjVs3Wx8LN4EJQmT+44ljzXWW8qP5nu3fUfJx0S8vXLzmE8wBDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgD+JNI5VunTaSZosRaNSlTIPo35B7+BsHKrBnIq0l+NDvtcr
	iiYuCR8al2f9aWCTQCEHeBC7fIAP5iyDnvGHjWQR8YtgOyYFRLL9zxTRAoykHzLSmytufGd9tym
	xUnqC09R7UQktIw/J4HDfyBoebaGwvJtsIp0IktyBHw==
X-Gm-Gg: AY/fxX5ptoXBuIbugYMVidsB46hK6atvMFLadD5ra9xkvg9l5FFG9i0Rnlw3GAaE7h6
	ZOOKTDmoif3F7Q+pV2US6M/5sZ51DmDkgldKWhQgfpLKDwHAuHWLcGPNVoSVOKrhlwLHDtF7vLj
	vIW1/U+prne4Rr3tkJ+MtmVXdFR3EKofiQzvFvwJjFSSH7eI9CMQgSvXs6c7YmzFTqEamC5ryOc
	8hvyPKtBuow/UyGqIeMTNyWyNGZlYL0KYGLiqhN07K4ACZjSP0ugkYNL03x4Y240LA6xa/Y
X-Google-Smtp-Source: AGHT+IFFBkSuvL4eC3jK3/PGjk7jLQcsalagp5Y0/AY0Eqe+h7oey8CSzWVOXdOxfrAeKH/WTZ2reRq2nz0JCQ9hInU=
X-Received: by 2002:a05:7022:ea2c:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-121f8b00246mr2947919c88.1.1767889908308; Thu, 08 Jan 2026
 08:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108090401.1091352-1-csander@purestorage.com> <20260108135821.GA8886@lst.de>
In-Reply-To: <20260108135821.GA8886@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 08:31:37 -0800
X-Gm-Features: AQt7F2o6UFNRiVui1uSmMYPETS-3ggs-WzOYzMBXEaegWewCKYVTTztF582oR_g
Message-ID: <CADUfDZqJ0_7f+r-V0MsFwMT49NqQdwdHNGkQyqMOq50oqPBYFw@mail.gmail.com>
Subject: Re: [PATCH] block: initialize auto integrity buffer opaque
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:58=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> The subject sounds a little weird.  From looking at the commit
> message and the code change I'd expect it to be something like:
>
> block: zero auto integrity buffer when not fully occupied by PI tuple
>
> does that make sense?

Yes, that sounds fine. "opaque" is how the FS_IOC_GETLBMD_CAP ioctl
refers to the non-PI metadata, but I guess it's not widely used
terminology?

>
> > Switch the gfp_t variable to bool zero_buffer since it's only used to
> > compute the zero_buffer argument to bio_integrity_alloc_buf().
>
> Yeah, that also makes total sense now.  But maybe split it into a
> separate cleanup patch to not detract from the bug fix?

Sure.

Thanks,
Caleb
