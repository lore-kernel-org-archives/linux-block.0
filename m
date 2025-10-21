Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0032749F2
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011136; cv=none; b=mG8ifXh/W0tSVCPwoSAl1ZzNCLOCYS/kU/CvZ2f8dOUREvhbhPFrUF31oVhTcEb6yeXi3MS1r4LX6kK2aU32ei19u9noFEHHeZPNXyf8oFqANQlV1LbPGa8Ipwb0i8zWLXgh8DsPvUu3CtHtl4iPUhhz8WusfO6kXiyTzpM07lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011136; c=relaxed/simple;
	bh=udvk3NiELKCM+i4WBVTa8pBkSxfvSmis65OpTnox6XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwV4JeNmLgz53NehPJhvqfcXnXX4mRaA+lOpKL6/aH2LDxa8LsQsQ6+AsbDwhsk0m/mkYwV4l+2ovGu1FfMHLj3RsDXBex/7gPL0iv4mkVQ6aM4X3gehB2spbWDJXiO/ZyQpUVj/RFEbT/Ccq/Wk+Dc+oONHsox940jyc2eS14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIPejUUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIPejUUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761011132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udvk3NiELKCM+i4WBVTa8pBkSxfvSmis65OpTnox6XM=;
	b=hIPejUUb//VFh1AvkUe/9o00SQ0n0dyFRmGaeX4lb+IaUUdDJ551e21S+Dutldw7L2gYnq
	4eqZTbZCrecmXAUsqSFON/3Mmzm9CrlhWdDBuOTlkrfZXy91i4zj1gRUPRu7PtgVbHFE41
	DAtlcP+qPe9vz7Wtj634aDbWlrql36Q=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-yx8GS-mSP6-vV2V7DmuZ2g-1; Mon, 20 Oct 2025 21:45:31 -0400
X-MC-Unique: yx8GS-mSP6-vV2V7DmuZ2g-1
X-Mimecast-MFC-AGG-ID: yx8GS-mSP6-vV2V7DmuZ2g_1761011131
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-932bd4873bdso6700374241.2
        for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 18:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761011131; x=1761615931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udvk3NiELKCM+i4WBVTa8pBkSxfvSmis65OpTnox6XM=;
        b=kGPNtvdt6RLw9kl+H0wII7H5rPjxZXXtzFeiXHiGNADEDEUx1NVudEX3ldol803LrU
         Gn20xVTO4CheCtbpp9mLkN0p5PooSindDFNf/KwxZqAk0NEM94RqUT8+jO1trtFn3HYf
         Wc+dVfO3WIGGpxHwChB9X5axoWJwMKMuy7SRU924WJY2fkAvaREkcM4JgrmsA/2YCAhc
         0WSsnO8Al/eKoJ/PKtxsQqkH/LlBKmRIHABvzrdgOWyWpniyfJhu++eYAqMtTrilse8e
         Fc82uEUIWo6KhMAMsPGQ4CxoTbSbyz1+LMx3EcQ5Gd2X3Fokf1v5VxoeBwQpMCkTEPfz
         FdAg==
X-Gm-Message-State: AOJu0Yxd28fwY8ZAdaGkAjZGJKC0boYOCW2iiw47u2MrX2I180jE2YT2
	1xQRAH7TthKUUVQ+a75WE8MH6ZQm57P8dF3s+TeFRaCgHogLX6cmh5ddbFKnla87s5szU9xeVbM
	KFdsUKHYdW/thKBe9zclxWvi/BWKV8d6yDnIieH4YyWAjlitYIB584YWKOD1SCnWqlYlWDJWzhO
	nV3I8rChno62uw18AoJaA95r5DrTdevp7Zf9jrAAySRGsaFUBrvA==
X-Gm-Gg: ASbGncv29slBAJVvxyWqUoO3wOhBfEYtkUiHolqE7GvHkH6EdT+u4d8oNFdmLoPWjTd
	ZQrdAmAD+QSFVh+KV01FTgXU9/asSWNiXRM9Dis79/MaVTZHYBJbfG62HJXQcR4ImNGVlGjVqBL
	SiygZLcYGnpl/iDlVXL6fLxxnu9tuSn5xBznJqJ81BBITmGA6R7VtI67sq
X-Received: by 2002:a05:6102:3754:b0:5d7:cdf3:8cd6 with SMTP id ada2fe7eead31-5d7dd5b72f1mr5041428137.26.1761011130785;
        Mon, 20 Oct 2025 18:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtEbBaAaMqeGnSYGV8/2hKP5phkBEjJYugtx/aJDGz8ga8glhVcqI4Fe2ulItNsTAGvlYwCvlU/wbeWh9SNU4=
X-Received: by 2002:a05:6102:3754:b0:5d7:cdf3:8cd6 with SMTP id
 ada2fe7eead31-5d7dd5b72f1mr5041422137.26.1761011130452; Mon, 20 Oct 2025
 18:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020204715.3664483-1-kbusch@meta.com>
In-Reply-To: <20251020204715.3664483-1-kbusch@meta.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 21 Oct 2025 09:45:18 +0800
X-Gm-Features: AS18NWDpn-SCap0smBvjgnGUu9kW69sYrq2AE-ieXjyCmf2NTKnwG5pWXjDIvPM
Message-ID: <CAFj5m9+K5WC6DkyOvjS5kMV0R=-mLW_+Nu2LrNuaVQ5fuLDxuw@mail.gmail.com>
Subject: Re: [PATCHv2] block: rename min_segment_size
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, 
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:47=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Despite its name, the block layer is fine with segments smaller that the
> "min_segment_size" limit. The value is an optimization limit indicating
> the largest segment that can be used without considering boundary
> limits. Smaller segments can take a fast path, so give it a name that
> reflects that: max_fast_segment_size.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

