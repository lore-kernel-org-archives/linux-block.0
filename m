Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAB2BCF75
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848100; cv=none; b=PhVUOKyg0GffoPUrfThuqgaTKrdaJCFb2QgOYt93CsCOkGrOkKq+82r+SehW/5CjtNdADuAAhkpfeAT/8HpmmpX92ltccYYARGHsb3Z6QtBkQajSLoCwu9Mh3uEMIIOi+EGNAwhNc1469MlhS5+q86gpWuZ8OWCUOrekVM/DBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848100; c=relaxed/simple;
	bh=lOruoolLdTMrM1hsoH9Ovds3ZTDlEFaydFSeZp1B4V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgKvBWm+DLI60sCkFBwSS2Z77VJrXnvaWfU3Q8w0cwdFrclhibVb+j7Y3Ojwyj86nmmK04fGpEzHm26lZOe52rpLGszqkklcjkaCcClP41kht9VLxnfYDXcpXQgZ8lmpE1xO3G9mZA3dUkk/6J1YmZMG4t0lWJCGmmjjHswa1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2U7MUvr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2U7MUvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXzJ6BG9oFnQy0s13phUi78sKWJpBfX2ctrsD+v2g/I=;
	b=A2U7MUvrI3KIaWQqTzho6cR68uaiCFCjNvk1e/In8g7QRXZjy2zuQMvHgA5fue64PEeBEY
	887X6B4JWEg8/32ZjPLBngb8ybxaXftbaCecvbJbfswke3Fc0lPTxtaeBDApj5lunJT3/s
	5VO6ZKoJBuPlgCxGpMbbZC4fQSYLRBI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-q7sZCPs8M3m9f_wTN9nHpw-1; Wed, 25 Jun 2025 06:41:36 -0400
X-MC-Unique: q7sZCPs8M3m9f_wTN9nHpw-1
X-Mimecast-MFC-AGG-ID: q7sZCPs8M3m9f_wTN9nHpw_1750848096
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4e9b4898ff5so1172451137.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 03:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848096; x=1751452896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXzJ6BG9oFnQy0s13phUi78sKWJpBfX2ctrsD+v2g/I=;
        b=h8ug+FJHQVM2rToqO1y9QrwxVRXe0o78raEb4aWXt6dP6Cx6A4/XeOSDdP3Ei+CR1n
         k4dgm3p1bdUaZfUngSaJP6HhAvdVnO50t/kymZQMMWCRXrnKMD7RPB98uj347MSf/Sa1
         FjqtwErcVopa+dwnZhDSyDu7+p25la9uSCDFn5Xit3weBtbfd5WITpftNDgne9C+pNXu
         vFsmYlP5Q3vpMW/Dm3BUYPuVQ6ennbrg67Mnle/8tFKivKlUc1HaE/oAO4vqRrSOWof1
         k8NG0eFnl26Sb06RcEp7FkunEooi3ygQhG+qW7opjMQKqTGE4ReNnR5YK3EAe7SMysjM
         ndvw==
X-Forwarded-Encrypted: i=1; AJvYcCWCfMkzmeYfJ0Du72QCTCcmlsz5pnTm7Rh4t8sGoIDyuO+S7m7RjYST+/64FPrZ/ppr9X+QajtdBzLJqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0Wt9Ec4C5qmkokffzW1VY8gjxAz+Sq4tHCguyneVZ09ZeGS6
	lS1Uq7zuY1hy7KEyOPTmICvTEPjK9Wu678e3c7Rxemn7bQiUf5EKuug+6mlVTHSfLBv0YaOkZ34
	qR07dZWxXAa/tjcdUJ+K4pYXfofWeAxMeYE5WsfSaVFpjwHCx/LP3SCvB7OmLhxCb3hZM6PDoSV
	1VXL4qqkwN6oWWr/h0b1pI6xB8iIkkJqKG/LhvQ2Q=
X-Gm-Gg: ASbGncsHKdrpB6chYvmkiJ/ya6LP1opnMDE/uskA9n/u7dTqyDEzmZFQPRu3uO4ybMm
	BjYNa3orTHss3XslsPyD9qq4ubNQ/PECdWSXxOcjICZG27uD55ewJ7YA10A66Cbru0qFXSdHQm1
	bV
X-Received: by 2002:a05:6102:e0b:b0:4e5:a316:6ee6 with SMTP id ada2fe7eead31-4ecc769c5d5mr977807137.18.1750848096261;
        Wed, 25 Jun 2025 03:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rRMb8Kv0RHeqhtdNcN4p/j7yM7WdX52zFHAZihqFaG1oWPDvEzBZJHq9Wbj3VxPRs3mj3K9chbZ2rnwyba8=
X-Received: by 2002:a05:6102:e0b:b0:4e5:a316:6ee6 with SMTP id
 ada2fe7eead31-4ecc769c5d5mr977794137.18.1750848095914; Wed, 25 Jun 2025
 03:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-6-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-6-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:41:25 +0300
X-Gm-Features: Ac12FXwFWhOETzcvDHbBzNovjF_5IML_YC5DRczUGY04YVAWJAwP94hRxUpsl0Q
Message-ID: <CAO8a2Sg5Q7iYTSjR2iD3R+EXHe5O735zp4V=Ur17q8AgkJFCcA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm: Remove zero_user()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> All users have now been converted to either memzero_page() or
> folio_zero_range().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index e48d7f27b0b9..a30526cc53a7 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -292,12 +292,6 @@ static inline void zero_user_segment(struct page *pa=
ge,
>         zero_user_segments(page, start, end, 0, 0);
>  }
>
> -static inline void zero_user(struct page *page,
> -       unsigned start, unsigned size)
> -{
> -       zero_user_segments(page, start, start + size, 0, 0);
> -}
> -
>  #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
>
>  static inline void copy_user_highpage(struct page *to, struct page *from=
,
> --
> 2.47.2
>
>

