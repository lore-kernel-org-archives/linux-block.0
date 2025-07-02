Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72254C6E
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453024; cv=none; b=TbojR6uAP7d8jfEG0j4uPE1xjzHJCbY3UwEjT10paK5Q205QZba2uDbHz2obOpHEfXty+XLiQEFTFBkHxbjbZLGaLVL2XuWzjfIQeYEfcJrNNts330joKqzbDFMF5+eZ9ZNelyYChXuAbXN6+rSIjSEJNda8W0usCr/+FSAs+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453024; c=relaxed/simple;
	bh=EhqtetgkIVjJS4OxhgYfBuNQjaVZdQlLo2lRt1LOadU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpOZFd7k6Se4DICUsu9Id9wne1r2eyPWUj5k1xjFdvziHl5fejDdgHK0ZL6KjlM7qID33yyh8fNBVCCsIz5iZRqm9wRoqXMfT8Q+uARwfeDWKM/ADu/a60K60OUaV/XJp1MDMfw5t94Pd4UBtvOVVzPFBnDP/NukYZDJXBNWESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOkv4q+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOkv4q+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751453020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhqtetgkIVjJS4OxhgYfBuNQjaVZdQlLo2lRt1LOadU=;
	b=GOkv4q+Gc1TRnloBscLhpBHfEAUZIMf1w4Uk85N6Av7jmTjt5l2vMNgw+Hng78q+Wxpj6s
	x1ubFgoujyqrSR7gh0sEBICOBWxeDekM+rL9N5D/rW+PKPJ5arg4NGhGaZTPZx/iSAYUj2
	C56djK6z+59NQ/E/aoYvi6/jN1wpC68=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-y9ZNT99YN6maWcZJ3xjrMQ-1; Wed, 02 Jul 2025 06:43:39 -0400
X-MC-Unique: y9ZNT99YN6maWcZJ3xjrMQ-1
X-Mimecast-MFC-AGG-ID: y9ZNT99YN6maWcZJ3xjrMQ_1751453019
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e81374b177so1239994137.3
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 03:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751453019; x=1752057819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhqtetgkIVjJS4OxhgYfBuNQjaVZdQlLo2lRt1LOadU=;
        b=hRHfM745W+rp5gyJKQ4bqgyxOA5ob400qKvkSZIUPbUom8zV4hWwHVBD3+V3/4mU0/
         RTqiCWFrWB/56zlnxO2+eEkXfA/ZLRwdYrBnkDTMhdtR033X0PjVkk7bizR2Vv1jFZuw
         XMetx5L8dr63xop132i4mUZaLIX5lH0ioWmDDX/GafY8jGx7CQFLrDgv3fHYaIbN4MOB
         QLZ6XwZ06Duwh12jk4CPDV1+O1SkUJ6xT+dQsmNFJuwN022TEWYO9jSCOlCSvlokNBLR
         gUJiKLVCil1XvJa9YqjzLphZlfgYGfyv79NHJTgy68I6Auj8cRcUri6WFhSOSWTXegoE
         bzRg==
X-Gm-Message-State: AOJu0YyYX0STtL0KsylG0seGaJdgrWdsvg4TBwctmgghwDwoDhrBwP9G
	D5HT5Kr/SLdODWBc+usAe8L6O/cgyCAlzlm8IRfjDMfHe8HPULcA2TYbAa2KDTGijrvNzSwoE4b
	n1cdql8kVHVs4Cif8IuywyrGIcXkvbOBIELBNxOvMq8mAnJYDy0zMXiBb/Wh2mod1NUap+mU+Wb
	VHBAJMRHylLhSE/eXbb+6hgQSUcpkqvaf1tD6ycsw=
X-Gm-Gg: ASbGncsLVbgYYw+HCHbDlO26RHSjOtlpirGkbXxvEzCahlaSgLRbqsF3BFIs+ro8TjK
	+FdKZzXPPqfQ+Tr1+9eMkVilPZ+OSB84Qf2l+qoVQSGizt2zOftsIu53Qjc7YUQAnXRW+pPPZa3
	7/dEV8
X-Received: by 2002:a05:6102:3f45:b0:4e5:997a:748f with SMTP id ada2fe7eead31-4f16104b5e0mr863612137.22.1751453019223;
        Wed, 02 Jul 2025 03:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0nmQxWK603spPoK8cL0mVfr/uxie7CJhpdCLovHNzwraeXO1I2XpqNBD8yGcpbsYlMUtvtO/2T2cdLI4lz1Y=
X-Received: by 2002:a05:6102:3f45:b0:4e5:997a:748f with SMTP id
 ada2fe7eead31-4f16104b5e0mr863606137.22.1751453018969; Wed, 02 Jul 2025
 03:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702100932.647761-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250702100932.647761-1-shinichiro.kawasaki@wdc.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 2 Jul 2025 18:43:27 +0800
X-Gm-Features: Ac12FXyJVphp6vQNk03OdyLA4X2X0Wu81IMZpXux1aF1xD2W8UJfkybAILPL28U
Message-ID: <CAFj5m9LHJkeb=h+8Z97_8NZxnGhWe97VEW3WUOyVUT-+FJBbxw@mail.gmail.com>
Subject: Re: [PATCH blktests v2] block: add block/040 for test updating
 nr_hw_queues vs switching elevator
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:09=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> From: Ming Lei <ming.lei@redhat.com>
>
> Add block/040 for covering updating nr_hw_queues and switching elevator.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [Shin'ichiro: fixed redirection to scheduler file and skip reason check]
> [Shin'ichiro: renumbered test case]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks for working out V2!

