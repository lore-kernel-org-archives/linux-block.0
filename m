Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEF19F43A
	for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759122870; cv=none; b=HvxpiEDsIfbI0n1e66VYQqabrNCIjEe9AnTp2pjkcyKr7PNlXLjsxa+dVXF4nEhvVlBRT+1nbMe78TT5TxgDkr9ISwyJMQFoCA4eti7pPxhJaqN14FNTIrLLuskna8LqDowYSWQrbL2hGuE5EmOUL2Q7MBMX43xi3kJJaksWIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759122870; c=relaxed/simple;
	bh=2nWBXd4KZrZn3Kozyj/dcu9GKU3e+h/EJFrqN3KQUNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Htu8lV7YRUSb24rZW4erLgAAJaqhXHJ+SHzBabIJcXK1bWKZjHA9SKBtM6qFqBz/sKqEUqzOgghzW+qiDUa+d6tEIM0OmxybuxYaiVXR0dFirHi37A2ijstiEP8skZGWMtUDgC79u7Bw9vPIOZb8NUgjXTwwSEoHLfzhr6yn6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDQcmykL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDQcmykL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759122867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nWBXd4KZrZn3Kozyj/dcu9GKU3e+h/EJFrqN3KQUNk=;
	b=XDQcmykLZLgz8KA0akEWu5WgSUlHt2N5eU+lvtNzoaR6rLbdQEjP3nna70dIWralupdLQ4
	ex0L54KM+KFikmUphfrn5xRSIwA1isq5Zadg25hp64RC9TeZhORE7Htvxmgo5jaRmtEFxq
	DvHnbXbxP2Fx5BDiTcvCNR0Qu0Uhv48=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-DpGw2pooOqCZaYDnGbH5Nw-1; Mon, 29 Sep 2025 01:14:25 -0400
X-MC-Unique: DpGw2pooOqCZaYDnGbH5Nw-1
X-Mimecast-MFC-AGG-ID: DpGw2pooOqCZaYDnGbH5Nw_1759122864
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-581daecc31dso1646511137.1
        for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 22:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759122864; x=1759727664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nWBXd4KZrZn3Kozyj/dcu9GKU3e+h/EJFrqN3KQUNk=;
        b=TmiL24H7+2vdmGrDzYiLhHdoCZFoHFr4yC7qSFwVmyCIg4DmKXWUyYg75ahtX3tqlQ
         zJueuYJgwY3MEE5cmCNB68IbV3Ck9elyiztwRZoXou8T1rw5ImcdBN5+jTFtlRw+MFXl
         S3dRh6LQSgUtfhxE1qYWvdtkNKPGPx02GCQW2QdqRcEbHeCq6wC+a9af/1AgJ3Rl5dT8
         X2rPMKRPZe30WUmaCAkN3XFdUQytYIMFLlZ0ZwHcZz9XItLBqo6utq2uMWsNDrf7J4Fl
         CfSm13JaIsBfHHSxuNoH2rPHW0rw+VSbd/1XVQ4RO92ehoHBw8oaj7+zXmY8UkpaiT+p
         UnzA==
X-Forwarded-Encrypted: i=1; AJvYcCWGdEpOM8VWjoQLdbWRBDIDAxpPE5/3nXDLPde/FirbhXg2Cou+a3iUqMlRq/dZC31lCUTLrn0+t30xNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUDe8skg1AkoJ5Go35SxbX+ZhWHCnWS3d6e5woZ5C2OvL5huW
	0GKcS3vH52n75rqmL0yQeqEYShuY6j/cYaOLpBAbhvaA1sMDJjiKSu5wjxLIfc2GN76DstlpmAR
	64v8QT+u0J6NDgoKOERgOqFQMpt0mT2JdSObQCHWoz14NpS3JkADznpT9ax3f2/wifddqVSdY4R
	5vlSn+OHt++BaPWkd0fOoEvHJ8gK5LRrOIZhmZbJ0=
X-Gm-Gg: ASbGncu5zciZjxIs1NVdSar9PQbMOO5v50R/NZLNoG2x3CuSMSOk6HzwNfEfemUm+a6
	q/g9mCeF6Uf165vDmuizgSiQbipy8B2qopzKvYxJ9dG+w7HZKxtmqEukVuhJ9JOvi6hXaU6HWwl
	ypDunaen1fk2iWyJNVtl6/3w==
X-Received: by 2002:a05:6102:e0b:b0:4f9:d929:8558 with SMTP id ada2fe7eead31-5acc83f70fbmr5692681137.10.1759122864373;
        Sun, 28 Sep 2025 22:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBBAQ7Gy8XVwAW8aHjkNgwg3zjuam2zWgWYcrltjztGrwXHhbkc163/MD/lKu5otxjmKnF0CE/e5UEeiuG7UY=
X-Received: by 2002:a05:6102:e0b:b0:4f9:d929:8558 with SMTP id
 ada2fe7eead31-5acc83f70fbmr5692675137.10.1759122864049; Sun, 28 Sep 2025
 22:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926121231.32549-1-me@linux.beauty>
In-Reply-To: <20250926121231.32549-1-me@linux.beauty>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 29 Sep 2025 13:14:13 +0800
X-Gm-Features: AS18NWDXKiUqoWOcUr7IEczOPRgfBRc3SIC3-S6lJC4tqxwzN33sIh-Pgku9MGg
Message-ID: <CAFj5m9LN80E3xyNY+3nGjncr8WauoUi4QUKEX-vtmGfHrzE48A@mail.gmail.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
To: Li Chen <me@linux.beauty>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:13=E2=80=AFPM Li Chen <me@linux.beauty> wrote:
>
> loop_change_fd() and loop_configure() call loop_check_backing_file()
> to validate the new backing file. If validation fails, the reference
> acquired by fget() was not dropped, leaking a file reference.
>
> Fix this by calling fput(file) before returning the error.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>

Good catch:

Fixes: f5c84eff634b ("loop: Add sanity check for read/write_iter")

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

