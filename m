Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CD2E889D
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121235; cv=none; b=o+iHHHpC48PrSLo2wTN61LNEhv9eNGWF1G4+Mbc2XWMoW6Gm6wnZ0fFHgqdlve1obeBAm4dODi91jcdVIBUkkoIqiCWDPFT0yC0DpoUfkaCAC0PRBVX1hH9RbcCekmU8w0v0l224TC51hXPSZvi2o32EB5fxdOih9g+8SIuJvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121235; c=relaxed/simple;
	bh=pTHQElAElWmtrbZTXpxQVTHBHqc05mvh3lFsp+T4NEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6MLBy/Brj78RSGkKdA3UmXXQ3PIbxE04dEw1e+SbKw9A1Ks/zE2s7o8yzZbcbPtLpoHOnkYqKtFLTZQYmFiEUt4wqguu/0pDjLfCi4VhHp4An5DhjOeFABe8Y0zZlwrftiRoCnr/wysihThGsa6c1M4CWb0+b0ThLm9xfK4/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEQnpoIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEQnpoIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756121232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDMukmH0FQggYXKvzUec4QBhOgYrZ5QeyS3SsGzawf0=;
	b=fEQnpoIiTCUpH+JWCTwlngioyP31bYVbJ0+d/0MSrY3L9J0TYSmc1x+X2i81noIrKZefV5
	BC/TVKsnsomXmwfThMOpeSxyrbM3EMNDGf8oLX+7Lo//xl2e7sajp2FJxCsI2FlgxCt1yC
	Q9rKogp9muM+LA4J3I/7m286znmcRiA=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-7o_FrloDMGemOb7F6wbvXw-1; Mon, 25 Aug 2025 07:27:10 -0400
X-MC-Unique: 7o_FrloDMGemOb7F6wbvXw-1
X-Mimecast-MFC-AGG-ID: 7o_FrloDMGemOb7F6wbvXw_1756121230
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-89248531bd2so393343241.3
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 04:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756121230; x=1756726030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDMukmH0FQggYXKvzUec4QBhOgYrZ5QeyS3SsGzawf0=;
        b=D6kCyC/jqwsaLBNfcS5RQR4Dw/lrF35I7VeNcziOA5HrluKda0JdrIDiK+bk/bngWS
         zp5KiiVzkhGRJApTNj00nmJxS4kRm9u2W+RnTLkg/dM/rozox1oDkn1lL9DOP5nc0Hf4
         32pIhbATHgI9LqLmK/6x/q9ffpo/RDsWi4B/sOcYFGatxuzbPqQUKl5jNOirbX0dUsvO
         DB15pIyCEDdy6+7QnyYCJkaiZIcArfd299CrfiGrlalCtZwgCHOS+ors9kzZEOa5kfX/
         JR16t1OadBtyNuUJOl396RpaTzw4nwedUDWEJusPurM4aZFm7UbFE+oq0kLRkP6dIrJp
         XPJA==
X-Forwarded-Encrypted: i=1; AJvYcCXNYx52f/oJDZRRXYGX8BOHcvb8VvJeWdq39okJlGkKxl6+UQwofITzBZi0Tp3S3PR0N1VxAcSg+YiKAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1VUSqc96H7MpvfZAHqhLwQSz8A02YEXDOMQEvBBhT5Jk5gqe
	ennATv6i0wmURlg3uZsuRFB6nnqOT+zBBhsDBct04JXfMEJ1702LDGf0xhkxe6U373zleZ3qQI3
	hOJADXA9Ul2/WaVg5sJz+j74S9EKa9Ojw1waNF42Op8rX4quCqqz/KmMELjVKZVttuArSMD5Ujo
	ixWpCgOqx2MGya+eJvvQw633vv+U8AzPrYBpqaeqE=
X-Gm-Gg: ASbGncuONBu4aloFbNBO2iI/UHu0YqDb1kKpjXNfSYRZW3d06xuKsD4Kx8nqCFURR7y
	ewXbWk6DfGGEXny8rGvIr+1J5uy8OMzXofULb6xzpkGyiXRY1afb1rxfkit3yYxkQg93utGPZMY
	Bvnfyz8CHppC8J1cj3L54UmQ==
X-Received: by 2002:a05:6102:a4e:b0:4fb:b78a:6cd1 with SMTP id ada2fe7eead31-51d0edd3396mr2320029137.19.1756121230052;
        Mon, 25 Aug 2025 04:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPYvkopN7UqDChOYSkUj5QzTSAZ7Hijf4D6K12CDHkzfHjzTz0n9WJqHj87a0m2x1X1OvuE+9z3muxtjNHvs4=
X-Received: by 2002:a05:6102:a4e:b0:4fb:b78a:6cd1 with SMTP id
 ada2fe7eead31-51d0edd3396mr2320024137.19.1756121229688; Mon, 25 Aug 2025
 04:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 25 Aug 2025 19:26:58 +0800
X-Gm-Features: Ac12FXyUr3hWAroe70N31cD1VLoq7XqtMeU0YdR_bS7U3-G764sUu_8sjIHgAtE
Message-ID: <CAFj5m9KTdHdQrrwBdUF=2xK9uDqnv6Zt6j7gLXRzr7CYy_cW+A@mail.gmail.com>
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, axboe@kernel.dk, yukuai3@huawei.com, rajeevm@hpe.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:40=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> By default, /dev/sda is block specail file from devtmpfs, getattr will
> return file size as zero, causing loop failed for raw block device.
>
> We can add bdev_statx() to return device size, however this may introduce
> changes that are not acknowledged by user. Fix this problem by reverting
> changes for block special file, file mapping host is set to bdev inode
> while opening, and use i_size_read() directly to get device size.
>
> Fixes: 47b71abd5846 ("loop: use vfs_getattr_nosec for accurate file size"=
)
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508200409.b2459c02-lkp@intel.co=
m
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>  - don't call vfs_getattr_nosec() for block special file path, by Ming

Reviewed-by: Ming Lei <ming.lei@redhat.com>

