Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FC1DFD85
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323998; cv=none; b=EHbzd/kA1cfE0t+YzQO/G8fEcQZ0/ZeDrSv7qNywdNHXoWdnyz80FKzcrAK+qKEwkt8EmM9BN/+xjyDeOzuckA7eCD01hXpK/djhgoSGn6iWsurmfBSzZGenGLLYBAl4o0Td+6e+fiBFOKyXrjaVgvMQ08h9vQUN+a9MPxHRhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323998; c=relaxed/simple;
	bh=f244ecSLvwFYWKN+nvVNGZD/CCd1MqPsXtb8FzVcZTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwCyJQf93M1Rr6X/S/d4yDxd6NSGSPQjy9Z8CagV4wSX+oUwWH3+PsiyrRIXmcQdTsZgW72GpNByx7UcJmjKLKv0W8Mv7rIOQjQwRFeX9SlyXM8jfU5yqfHgGVzx3aL6FfKq3BM1CU12cQpHRstX/ki4OSkcpkE1m7ZDB5XfFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDLa8R/r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDLa8R/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736323995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfEn9YjinVVVNTXWON+w9OsxNKAd/5FwACYKd4nqsdM=;
	b=NDLa8R/rxM7XseQLo9yI4VxpCJzJDSFLlW1Cku4Rd3ikH4qFLkC2jf+r86iPyF3d8xw/Ge
	naYdVtCrJGwqWzh1Bp7lfVypvk8JxPy2dFcSeBvL9SxqoZnCBPZnpfQ43CKVypGs58ePSc
	3xHRvyYFNuNIcla90dezA4TtukrSWd0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-1Sp6-gHwOHS_4GwXrKj_uA-1; Wed, 08 Jan 2025 03:13:14 -0500
X-MC-Unique: 1Sp6-gHwOHS_4GwXrKj_uA-1
X-Mimecast-MFC-AGG-ID: 1Sp6-gHwOHS_4GwXrKj_uA
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4b2be0369bfso300209137.3
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2025 00:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736323993; x=1736928793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfEn9YjinVVVNTXWON+w9OsxNKAd/5FwACYKd4nqsdM=;
        b=bbhUOweS/DO43H2OplCPpjaXWW87sMdihbcDmxkRYA4f50uotWplHcH//nMw1RHWE6
         UgfimbwHidt6K0qpsCYOlES0UnYQjZ2wrLi69ev/5SHV7oQfZFQ4yiFTQsFegcv3Je+W
         AkNQBUzA7s/yS3eNzJ0l9CJ2qvQQgDZfKt90HUVkz2+zXcfILnOxQvMd1VdBqNp8KyPI
         GXu6Ux4WUM1qzdi0yfOtXERya0Aw9lMb1mBgHg1nTM4TsIl4OWTTtwxbtaHE/SYlmvU1
         ogajlkKn2LxjIP54AANsPFm5zax/60fHc1w1ZrAmIDIRqZr3srU7N5OspOaM7+iOtarb
         INBg==
X-Forwarded-Encrypted: i=1; AJvYcCVfirFclU9ICR5BzMhoXs9Tgtx2jJGIOAxtJKH59nUEh7TPTBLii4pldaeN7IJjnuKDWet3UaOwYhX+vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrYi+UjljR/8G7xWP+nZjddaiaEsAmLrptue4R9AYQg4iCWUS
	JMtZLAa8lVPfJoYEfCYmKk2WGpN6QFsmi7ozDnMbAqExt+HA0aR8c65wm806dNdQMRpK9EQYc+T
	eBDuFG9Xn0GvW06dCIsgenGkYBf+rymA9LY6O2H6CpMVLyRFeJiS//6ka8CBMBQTxx49Q+lq2/R
	OhD18hIpvUIresf4upiQUHzwwWsazcO94XGX4/+12JFU3kYkVI
X-Gm-Gg: ASbGnctWTqS9GUEqsZK1WBkImIs35r69i9voutGyi2Fi1vt8H17E1jq0zp8broDDDN0
	aZIZyEEybwtA0GH9pnG8sAgX2p+XTB9y8YyBf/qs=
X-Received: by 2002:a05:6102:418a:b0:4b1:24c0:4274 with SMTP id ada2fe7eead31-4b3d1069ddbmr1301532137.26.1736323993727;
        Wed, 08 Jan 2025 00:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx613EHdQQEVNOG6Tu/8kBKTA4XTWVdjzmr2s+rNIR2kYPbmZmPUYN1EKQs0s4RRD9yp/GntaE+IgvvWUKids=
X-Received: by 2002:a05:6102:418a:b0:4b1:24c0:4274 with SMTP id
 ada2fe7eead31-4b3d1069ddbmr1301508137.26.1736323991986; Wed, 08 Jan 2025
 00:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora> <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
In-Reply-To: <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 8 Jan 2025 16:13:01 +0800
X-Gm-Features: AbW1kvYtXE2hA7tRb7YTQvuyPE-A3XuxemmxzJJD01-0zm23c_i_2Il6UgBQ-ik
Message-ID: <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 1:07=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 1/8/25 11:29 AM, Ming Lei wrote:
> > On Mon, Jan 06, 2025 at 04:21:18PM +0100, Christoph Hellwig wrote:
> >> On Mon, Jan 06, 2025 at 07:54:05AM -0700, Jens Axboe wrote:
> >>> On 1/6/25 7:24 AM, Damien Le Moal wrote:
> >>>> The first patch implements the new "zloop" zoned block device driver
> >>>> which allows creating zoned block devices using one regular file per
> >>>> zone as backing storage.
> >>>
> >>> Couldn't we do this with ublk and keep most of this stuff in userspac=
e
> >>> rather than need a whole new loop driver?
> >>
> >> I'm pretty sure we could do that.  But dealing with ublk is complete
> >> pain especially when setting up and tearing it down all the time for
> >> test, and would require a lot more code, so why?  As-is I can directly
> >
> > You can link with libublk or add it to rublk, which supports ramdisk zo=
ne
> > already, then install rublk from crates.io directly for setup the
> > test.
>
> Thanks, but memory backing is not what we want. We need to emulate large =
drives
> for FS tests (to catch problems such as overflows), and for that, a file =
based
> storage backing is better.

It is backed by virtual memory, which can be big enough because of swap, an=
d
it is also easy to extend to file backed support since zloop doesn't store
zone meta data, which is similar to ram backed zoned actually.

Not like loop, zloop can only serve for test purposes, because each zone's
meta data is always reset when adding a new device.

Thanks,
Ming

