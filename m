Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2E4B8273
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405814; cv=pass; b=TrgzvY81tEyhSU+VrBpNg3zwHr9jK7bna98SwaEYsw6xtEUw8XdO0jmznTp7HSXMLR/yXsE0EuYX4Ipeh+JhvVmfr7lnUrbPlrXLMi5cxNxUj82Y64Wj+GUHL/zHSva4rz7bLebyGE8P4tnPez+2fnM9cIZLFcqNyltamc+DD2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405814; c=relaxed/simple;
	bh=w+Qw1NJ7EznQQFGT9BDIAW98bhAEyfZHFMzc+72qucI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VftqxjsoUxDww6Sej60wmflhkjXt7gR4OgQWlgKN06arEcOBuJmOzRuinxQVItnmt+OQ3P0DYnPuQbaQdrSzUgjySnEoZjx/Rg3MggfskBKNMg/S2xtbBTjsogqIfo5v3XSAxdityVYpfRJuS21gHvHWDuNjZWhY1WL6hO8LpXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaHVD2JF; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaHVD2JF"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso289784766b.1
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 03:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405811; cv=none;
        d=google.com; s=arc-20260327;
        b=EqLPiJnwLbLMMeXnV3W/K2J3weUA8Zyfa4DZ+IEVPW8pxx7W6qOWjeVgE4WoNx2WF0
         0Glhw6o0SodYWKA1oGBDIAxLta/Yp2Gwm/HUmBWw4xxszD+C3JUW/cf18YV/7AI4rjn5
         Op9SRwuIq8ztXewI459WDoWB61mXVu+ARBnWkcawDFyNSD7fR581xrsVqJEESlFKhP8M
         hF0I4nXLwzhMyRKIuDZN61ekxzYzYvdVJKIcfZNleNeIsXGc21m7NRCamBQ9JDzU3tot
         z7YBL0JUBEf5o1fVM++cP1hTyDlRre+pQJ+TK1nE6V75ZfgV3S46UTQ99SyBrQ8kPYnx
         GIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hDMlxvMSsYfLSEsRi+m3GMMa7nMDtPhzoMRARDxjIFo=;
        fh=kHvjP9ARPBP/4oI6WH2C32DleH1xB84MJxnynvgYdis=;
        b=ZinDY2VKekZw0Cv1jg27qmPppwtSmiG3khlsuD8cKtHA3ojd2Hs2yW35N5qtAnqS7H
         0GLzP9JO4VeuxeGuH+EStNWpoGLKgedl4JPdvQ82QU9OekhTvXiGG3p1GHzN6nFv0N7n
         uJobs/av997M72IJ3wxC6O6XQ5gifRGDCq3zY+1BWBmpIz63pg0NpzxfNmXVN4B70Pwb
         uf095tbVWehKe7bfBXB5TlDIsY+ADiwcjz6RR2fpm49zx4l9UR4LCOxK4/kw12QutDjC
         WfcRveM8ekYwEV9fPsVBOVNkYfcJkulPhKA2r9dF9llZ7qWcpEvSjGbCQe9CZL05Jlav
         biOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792405811; x=1793010611; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDMlxvMSsYfLSEsRi+m3GMMa7nMDtPhzoMRARDxjIFo=;
        b=IaHVD2JFW5QpQ94PKc3ONpS/3xBNTLZOJ4qerCzcPapnAEb/tpEJdg9vZ9WvitSU1C
         A7/+QnoKHY4O2Gy5pvgBvsBLFcpJ548voTmEqsFvzodzvO6xF5ELKb3rCApsY/clRXnH
         iLsL0/OmBy6G+GGy3hdlOm4swG5Wr0lo3USLGe/i4/EWLcBLhJlnRjMO5gGnf3G7OCGr
         m4fs9qcviKiRBpmRf/xdI+M+9SXMlb+oQ4QBaxUr3KSeSrY91BRk97tY7Z/sVB/dRmBO
         +clhV1BF5Okuk1RwjV+RoNJgpwZsLaznW4PBEqdpOyqDzmEnACG/RadDVHN6RJZm2lVq
         /VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405811; x=1793010611;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hDMlxvMSsYfLSEsRi+m3GMMa7nMDtPhzoMRARDxjIFo=;
        b=WAHYtLN1eh7O7QrNJWZRa1EdGhPjFTD00DDxR9T71TcCt4OEfzlGfWwkrAYS1ptQUJ
         5s4dGU+irTboBm24SVWYsstcqLBLB0+B6VLiPa9GZI1wE4WYqnDp10Lms5gB82g+NMfY
         AfQbA6bnwS1Hue8EK5IKmuLndalJmkwo0Ttx1QMSOo8vkpBVhJoxu3OFuPX50VXGi3Te
         iqPnKWK72qV+i/U15FV70xnUBa83WNVytyUgbKu79eizQZUQlTpsOGF1g640ET/q5SlW
         zE9QNISNOaw6MeDjBrfceS8YKYgtv9M2V/ooi5QKxtivNWEcfPdBs1cvpXa8c/4o7JXx
         nZBw==
X-Forwarded-Encrypted: i=1; AKwUvBzgaSv1RxE5TVOC2Z7PCfSFL1GYSYjuBpa9jS8V070/1wXWpHEZwH9BeQUpbSOu/joEqNgcCAB/DforLQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKJoH3wOvqBw+QBUh4RPOetr7OP31vxeQFukYgqU0q2vaic/hCZ
	SoTN1509dJMdeNA+IuveD0U3im7qqvLmpX5I5/LIHDGSLzw19SMNqcD9uylQ8xGn3KdDXim2f6I
	MUmR9yx01w9tlf6jA544I4z7NBOKlgQ==
X-Gm-Gg: AYBFou3i/fdpkq2lu8qvwGjPr9kYZwGh7eHES76KEwie9g3qy+TAHxmpa6ntjNnfo2n
	oWW6y3c2FKHuy5EyLj5FUYsLs8mxCWQEweLdb31mvDrqTv26mF71tSyDSGXe/0BxJOhi5dSbDu7
	Wf9dZmp4LAjl5FudM+uCmk9fWl/aH4AfdDj1UCvbGX9W1nCCZ/fM95m92kWUHFxmNqOG4KRYXG6
	0enJIUmy0NHxnrSOHm6NoaW7nK0Lx+Y6JQBDLxOTLWUCgKjhbkaIDvXQckLmzXN7l0XSE8Jkbju
	bKKgMYr8HaaaFnPT8kO8BT3kzApDyyOgn/mGbrb90I4M3d18vLWll7OIL70aP8vFKqiQaDIzYYQ
	Oc/G6nF6g7R7cVP0EfmYt0Q==
X-Received: by 2002:a17:907:94cd:b0:c34:83c0:b92b with SMTP id
 a640c23a62f3a-c419e0372e5mr550966966b.23.1792405811317; Mon, 19 Oct 2026
 03:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <20261016091919.971295-5-anuj1072538@gmail.com> <20261016092855.GD23141@lst.de>
In-Reply-To: <20261016092855.GD23141@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 19 Oct 2026 15:59:34 +0530
X-Gm-Features: AclHuK8ULi6B2WLcwQV3l7PwlG0hY-H7b4F5ML9dbW7RnQW2ii_Z4DBtgA4I11o
Message-ID: <CACzX3AsF4t_yLoWpN5t5jjhxb4noAXuyFdK_-F_FdLA1gmMYSw@mail.gmail.com>
Subject: Re: [RFC 4/4] xfs: support dma-buf registered buffers for direct I/O
To: Christoph Hellwig <hch@lst.de>
Cc: asml.silence@gmail.com, djwong@kernel.org, cem@kernel.org, 
	brauner@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, 
	anuj20.g@samsung.com, nj.shetty@samsung.com
Content-Type: text/plain; charset="UTF-8"

> > +/*
> > + * A realtime file's data lives on the realtime device, anything else on the
> > + * data device. If a file is switched between them after registration, the
> > + * block layer cross-device check refuses the I/O.
> > + */
> > +static int
> > +xfs_file_init_dma_buf_io_ctx(
> > +     struct file             *file,
> > +     struct dma_buf_io_ctx   *ctx)
> > +{
> > +     struct xfs_inode        *ip = XFS_I(file_inode(file));
> > +
> > +     return iomap_file_init_dma_buf_io_ctx(file,
> > +                     xfs_inode_buftarg(ip)->bt_bdev, ctx);
> > +}
>
> Ah, this is where the previous cross check comes from.  What about
> simply disallowing toggling the RT flag with outstanding reservations
> instead?

That works for the current exact-file scheme, but not with Pavel's
shared-context proposal[1], since other files can use the buffer without
registering it. There we can validate the context tag against the
inode's current backing device per I/O.

[1] https://lore.kernel.org/linux-xfs/4649a20f-aba9-418e-987f-66f21ab24410@gmail.com/
