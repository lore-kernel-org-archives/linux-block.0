Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6D179B7
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718165778; cv=none; b=rVCcyyohXgYZH1ySBeC3I+LuZnjT1d29yIX/ppsNYggjW/+TnGCsB7s9bMy5giqQetNnnwA/bJQm+yhNJBp02Wz5e15VN/0xv+lKPo2NNIC4ab6xRNHpZ44r7QzirXlnMwv5JbomqT95gAtd9QQuddEm1XbaUry102hZFbIP9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718165778; c=relaxed/simple;
	bh=XJdZ1NK1r7xH/DOlwYXo2NjXnWh3k3yXqMsrzOUJ6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NK6q2XtuWTztRNIh9dgvcQWJabtJTVF/MPEbbtprvzVb7x7vBJF3mnJikC9ydJkIvFggwFgsufqGUB3UccvtuXTypHdPpvGAR9W37GW/7yCsLKjmSxGrraHPdDE7XbwV0v08FHkB7ISFTjBb1sg6WYr+LKPVthHsxMEAFM5Vzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+i0XQvf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+i0XQvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718165775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJdZ1NK1r7xH/DOlwYXo2NjXnWh3k3yXqMsrzOUJ6Vo=;
	b=Z+i0XQvfBlBynvY4mBFoOcUrWtF8CI59QSbXolizSa/4WLe9ebBXXRxya0YCnfYUHh/HIB
	8X/IcRSHlsonVj5zKcCV/YvKnI/JzGwQUGTR1GA3w2O8pwxp+1+pxSSDmgaCue54WqyliF
	k+gGr9FKewzR0D/2N8U4Kqd7mqFXoqc=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-QA5yCm7OMIKzZ-NaZX6itw-1; Wed, 12 Jun 2024 00:16:12 -0400
X-MC-Unique: QA5yCm7OMIKzZ-NaZX6itw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-48c34a1112fso337231137.1
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 21:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718165772; x=1718770572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJdZ1NK1r7xH/DOlwYXo2NjXnWh3k3yXqMsrzOUJ6Vo=;
        b=Ut0ooNc3Eam9hFE+B8OJejLyTWY/27JsorT1NDxb+zSeqS+UXFv1ivgVSk60ElMf+C
         ErCY2F9bzADegrUXDvpx9ISrdcDvl1PSK8j+XuhcNlM3kPWtCI9SKbXY1iiHLDxAXpTo
         fpQcbmeHhWUJDQgsZsqE8rWyCxQNlt5GR0HKNLVp3VcJO96D89jZYcCiFbXI7S9rowCN
         yhF/ymXyRrocPeNmQI5azYSUWLY+bfNVVQ/A37WSlKd34ceKnR63Cs+zPJmvfv+J1A21
         pkUoaOaOMYDzQPMBmtykMLbqqfSFs+ZR9OJHeFY0H9r0dtfXuWaLCrMv8JZmh4Av9bS1
         oJWA==
X-Forwarded-Encrypted: i=1; AJvYcCU8E9kTFATHVhDHxDqq0mC2N84aGd3PKJ8HFwYkFzbfO0/ZeVYpbul+Fzzm4ZNfbHZzv3Fwi2SZDurlSNZu0wkOGiS/CyWq/sYeKPA=
X-Gm-Message-State: AOJu0YxeO0SFWYHrRlEyt60JFB8NxggQZi4ptJeEUUDTzZNvjqVRKB9e
	TcMbUb8YzjTfCUeVIhBhO4X3YjAQ4k35XJAQEKs5vRb1AhuPE2WyAOKnlXAiF0/AgoavInO7iC0
	+0I9+R1keP8zQTC0wXQpxDEI7Az0dHBLU5yFTrk49bP3029G5SiWGfmE5WwSMSRUDtf5opHSWkU
	wBqKxqs7/1RTDt/d1U2jVxx1f3PXC7xGhrGDE=
X-Received: by 2002:a05:6122:905:b0:4eb:2012:f5ed with SMTP id 71dfb90a1353d-4ed07b8a29fmr837887e0c.1.1718165772031;
        Tue, 11 Jun 2024 21:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgf/PBHKG2XAoTeJYfg7b0HqVAZBlUfdW3oAoNADQ9WSfMNyU9XcQ8GsoKL5eBU4edRo1juf4oVSQcQ1cMPtE=
X-Received: by 2002:a05:6122:905:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4ed07b8a29fmr837878e0c.1.1718165771741; Tue, 11 Jun 2024
 21:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>
 <20240610111144.14647-1-anuj20.g@samsung.com>
In-Reply-To: <20240610111144.14647-1-anuj20.g@samsung.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 12 Jun 2024 12:16:00 +0800
Message-ID: <CAFj5m9+X+A+yVBxWutKuCaV0gxEhgwhyLJDt2u65BEZU98gZ3Q@mail.gmail.com>
Subject: Re: [PATCH v3] block: unmap and free user mapped integrity via submitter
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 7:26=E2=80=AFPM Anuj Gupta <anuj20.g@samsung.com> w=
rote:
>
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.
>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

