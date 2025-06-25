Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D32877F5
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848049; cv=none; b=W/bTR7xgUmWf288eWz27caM2r4mmSxiPt3mm3C1RHamw4KypOCV7U1NKjobzU27Jeqay7vLE8qjcfZCb9V01fLybPhVWx1f4sw/S1J1TuiWq2QaPrcCgDv73vf5sop7m86HoNZ3Hjrzx9LeIDIeBG8CjG3Di9GenYfApzwC8KB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848049; c=relaxed/simple;
	bh=kdRywbgWT5zbIjE0V4UnI7MGY64eaZ1GFQ7MxZL739g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbZxVcvaAbKGp09kwLG/sWN+GglskrwBKcW2jo0aYOOkFIAra4i/0fXsCK8N+YceUSCCKVXTaE4aN3aY+i3FbCGxUo5qZXaJvRAN3PwkQRwSsoBHzo13fzy0VLBVbopT41gkCDyNw88sV2yT6bharqtJoQ+/6FbLy0f9zWbd2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQlQxgCc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQlQxgCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h/KHM+Z1ETmgfw7Ga0CGtwnfJFvbJCAzq2poHb47zk=;
	b=NQlQxgCcFu1az6NV6o9Qs6wRIgJwCQWoBzlYmy3xEsffWTYp71yi8ONbMIMnxca9HWRE6A
	y7qK6oth1rrd2rdP4UiY8DOWgQzfBaSlwYeiAbNTN4d2WCnBe6ylAw60dDyfMAbQ7QbLuQ
	9iEu11bk51t8WAB06/QmuY9MD7nIPDM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-nkyg88K1PQqMuWELB66XJg-1; Wed, 25 Jun 2025 06:40:45 -0400
X-MC-Unique: nkyg88K1PQqMuWELB66XJg-1
X-Mimecast-MFC-AGG-ID: nkyg88K1PQqMuWELB66XJg_1750848045
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4e71cf8d0beso6193912137.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 03:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848045; x=1751452845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h/KHM+Z1ETmgfw7Ga0CGtwnfJFvbJCAzq2poHb47zk=;
        b=glfGd8/w6ge0O2BhVwmjGnnGIA/TFB4T/j8E241pzIzo8yZuzF2iHkdoTpg9un3TfM
         spvg5Jr098873t2xpN/+cGctUR9tAO8qJ1UQg8nUA5EqfI9Ueu4uUbBouTw19I7CNHkB
         DovgzayV7Kwzgows7vOZdPZxRiWZ8xubLyJtQPau6WmL0UfIU6mSC9dwfbcpF09J1roL
         S/7LTozJ9UkDZ1dI+xF4mKpmFVe/qIBedR4bvw3/6rHLiQ896PFjQ8j99xX++GtC/Ujt
         dfwqBieC7cIJXMJ7ZOtHyPVSd+dFwu3/C55JFN/7lOkHFrIjXxroxpL+Chcovnz2zW4c
         53CA==
X-Forwarded-Encrypted: i=1; AJvYcCXCAM16YQfbZYNR3q1H+DLlGtQGuKLo9ME9OM2xjD2NXi80TvXMxhYijvkhKUWyErpUH6olPzlbdZ+10Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEytDAa8LwnMHpDBL9rMJef9MWzOjj7tt2RDWp8seNkgdfO/Yr
	EtiA0LpnoVn0bYWIBXSY+VmD7IomGE0zubPzVe0o1KZ7R0e3I0jY0d6GPVSZNRFqCz+9xPKotc1
	hdmAlueSCXk8LOv3XFOhpoZ16ruuXIvhndntnewhqieK/YxCyNmrrH2cpJPrpErUgyoxlWPJoDn
	W7jwzAafgn1HzvJ1lvFtvkQzvJX2EyjBLQDWEQRmA=
X-Gm-Gg: ASbGncuIE0MlitbWTK6ZcEOhpjT041OKMaDYsK3McFD2xeE5bik6Xe2YHUmJKMw+8dR
	yAoSYEmftSAYIugXcoBZwcb0zNTIU5w93+MLARNo0t/MiirDXMjh7n7IRbP9CTlDcEE/6D0tjWE
	HW
X-Received: by 2002:a05:6102:2927:b0:4ec:c548:e57b with SMTP id ada2fe7eead31-4ecc63b0f4fmr1247645137.0.1750848044943;
        Wed, 25 Jun 2025 03:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Rrly+INsD2FyLdl36Be/L5V6Eddn3BzuS4sqrDJs6t6pJxfkEkXvuFGZkctU3cnellCkS1CHwmPPaKFihXQ=
X-Received: by 2002:a05:6102:2927:b0:4ec:c548:e57b with SMTP id
 ada2fe7eead31-4ecc63b0f4fmr1247636137.0.1750848044685; Wed, 25 Jun 2025
 03:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-4-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-4-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:40:33 +0300
X-Gm-Features: Ac12FXyMPBCBLK4e87Hspuz-o2CzX-UVv_jmEtLCyzergMQSVwUQNGmL3GwfGWY
Message-ID: <CAO8a2Sjtc9xfBjhe+MGjHwc=9vJP7pB1bwno1mgKpfZgAO1QLg@mail.gmail.com>
Subject: Re: [PATCH 3/5] direct-io: Use memzero_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:36=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> memzero_page() is the new name for zero_user().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index bbd05f1a2145..111958634def 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -996,7 +996,7 @@ static int do_direct_IO(struct dio *dio, struct dio_s=
ubmit *sdio,
>                                         dio_unpin_page(dio, page);
>                                         goto out;
>                                 }
> -                               zero_user(page, from, 1 << blkbits);
> +                               memzero_page(page, from, 1 << blkbits);
>                                 sdio->block_in_file++;
>                                 from +=3D 1 << blkbits;
>                                 dio->result +=3D 1 << blkbits;
> --
> 2.47.2
>
>

