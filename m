Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEB2DF12C
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027843; cv=none; b=uvS8Jt+vd4sIRuCWjISaHeKj9R0aaugwxu2a8xnGW9svfydmWH2moPX9ktPReEqsOw4hwfRVVbKr0C0cLuHrwQyeXr+dgCRbbTcW223sg4q9ut/ZTi9bDYoh1xjGzz+ThDh1Fgl+FjED6rtu0fxekasmntsm+1c7docOghB16dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027843; c=relaxed/simple;
	bh=jUk0AEkRxEbxVGm+qqnZTiENxDw1riVz/m69+MZ7tXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM53K2L4PEezalkN3Nb8daW8adj0WIavhUUBximVXx4aQ6nK8uMzvQdi98MTGvsw5vejMpCOcltE5dXLO7OEql2H8ztNhVWqiTBdbXUvEWwysCZleSdnSKcSzfZ9y7Ib1L0Q6PBnxSHDtOuHVIP0aVJUzggDsqJM7oZxpH7ekcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLPt1/Ve; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGCvz8AU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLPt1/Ve";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGCvz8AU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763027841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUk0AEkRxEbxVGm+qqnZTiENxDw1riVz/m69+MZ7tXI=;
	b=GLPt1/VePT0iwvfg3a0auCqZRGgw2M8rO8Flm1bhy3j1VYziEz1/soLo5jhpqi8Iv0ysxb
	oIR2R/8lFfKCQlSMCXSQR7K+3kVLMZNKhv981HbQGRLdkCTkiIEcwhW0egwHFt3W1Zt1tw
	dFvT7HeHCvCXPgGPgneSqunX+rVTYIc=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-FF8o-Gx2PNOL4HraNjbKXg-1; Thu, 13 Nov 2025 04:57:19 -0500
X-MC-Unique: FF8o-Gx2PNOL4HraNjbKXg-1
X-Mimecast-MFC-AGG-ID: FF8o-Gx2PNOL4HraNjbKXg_1763027839
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dfb407f31bso355435137.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 01:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763027839; x=1763632639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUk0AEkRxEbxVGm+qqnZTiENxDw1riVz/m69+MZ7tXI=;
        b=cGCvz8AUpT1n5tmlo1SfkF9bmq7BlhCEUFEpEdCpbOEZd/fQJycNr34V9+yYOB57Ie
         PumbioPS2NVZsAbwIsflqFz/z3NvtxEB/v1a1G7RWyyFzMLVwE8Czy4k/PZyajEqnzeY
         mfwfxfRoVYgdbcRsEEskF/BVHIipMeOn12GEcELdYFxGepnsZ8bSfNjTf+/seshrn5AE
         fT69FSp/dj2+OaCsmtPP5GttM19WQp1x6oA+CHhwHGtrahozZRtuPEN+pzZFie2Yx6jR
         rDw07tkwXW6yIvpIAMBmCVST2CWXa7+gfcP7nNMn6sqT39jh1bG8oI0/VO/hpxgYbLIX
         ZPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763027839; x=1763632639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUk0AEkRxEbxVGm+qqnZTiENxDw1riVz/m69+MZ7tXI=;
        b=lvBv+6PDzZJR7un+sENEYbvwnt+A+XsaIIw5moSo0qQ7btBRbNwAQ23aJ7/pLSrQXR
         T2X1iXElLSUwCZsYvvTA8Q6FnSP5LV59IEEll7VE08+OrAvlr4sMtYQdBKmhDlVWtl/x
         jJslYAhMbbj+w4cZhHSrOVGW4gmjsJzaNJGZh0sj8Yx1xMwLFnw3SukOLY6sDE/mKWRa
         ykNy9ekU2inMWAG8ZahYQxxHFhc6YkFTnemXeIAoUtRppAWaDWaIciKIunWeSuVLh/81
         aVHEzJQfgrOgkZ0bUWU9Nfi230r1jisSir2FF5PYXeD2XGB7TJJBJlKMu+Z8a2zsn2Xr
         7xqQ==
X-Gm-Message-State: AOJu0Ywbei0CixGpNVsbdu6aZMLPaBx0gepPQixgfkPZnzcwR6TmbXEe
	7PwzxQbX6XOsVGMCxDuZJihO83NcE0JYqPuU3d1OFMRoqeNRb67OQhJqXp8BD17ra/aLT0zz9o4
	/2hSUlc0VqYRaU8T3b0yAqVb+zMpEEUtRxVih3kWr+7gLh4S9e0VU+NJ1x6homRBjLVNB80keXQ
	8I5rjVSAUhbq1RaeDVj6S8RHQ4zGy7qy02Y8CmI28=
X-Gm-Gg: ASbGnctQ39h4xZ/PxegPgUXjJTySOfJoY7UgOeFOVm7jkJ4s+wN5hmdzKyGseoBq2cv
	Rlzy1Vh1NtsXTygjVBjTZvsMZ85CncZY/GXbTqhWOZQV6TVFq+bM0M+iXwMirYV0bPGsPaA/axv
	AtRXzFfCc1GWtqiAI1bDi7CwJaBpYCZxrcXjU+mdWlxVwvOv/eXtOv4BNf
X-Received: by 2002:a05:6102:508b:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-5de07d0b089mr1795007137.6.1763027839279;
        Thu, 13 Nov 2025 01:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFVGhD3rgrl+Ez9ZO2FKe8QiFjALcGYJX9sULUNtVRCB2gSOCxs7zwMW5Wg80K+52AMxDFGQ3jhXmC288PHvk=
X-Received: by 2002:a05:6102:508b:b0:4e6:a338:a421 with SMTP id
 ada2fe7eead31-5de07d0b089mr1795003137.6.1763027838972; Thu, 13 Nov 2025
 01:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113090619.2030737-1-nilay@linux.ibm.com> <20251113090619.2030737-4-nilay@linux.ibm.com>
In-Reply-To: <20251113090619.2030737-4-nilay@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 13 Nov 2025 17:57:06 +0800
X-Gm-Features: AWmQ_bnHRJL_JxZiYFOnXeVPbRJppRe50BNiLcdu1j_UZ83C-KqgY5C6Yfmht8o
Message-ID: <CAFj5m9Kk9MpX8x-i1JYD28V4ReGq6yY6a=YBwjz4BW2iqFt6+A@mail.gmail.com>
Subject: Re: [PATCHv7 3/5] block: introduce alloc_sched_data and
 free_sched_data elevator methods
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk, 
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:06=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> The recent lockdep splat [1] highlights a potential deadlock risk
> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> mutex. The trace shows that the issue occurs when the Kyber scheduler
> allocates dynamic memory for its elevator data during initialization.
>
> To address this, introduce two new elevator operation callbacks:
> ->alloc_sched_data and ->free_sched_data. The subsequent patch would
> build upon these newly introduced methods to suppress lockdep splat[1].
>
> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnV=
yjO0=3D-D5+A@mail.gmail.com/
>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

