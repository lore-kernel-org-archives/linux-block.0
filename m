Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA45262FD7
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313768; cv=none; b=mCxD5Wv5Vgsr4bGtfLxcdIF1VgJlSRRd5TwOMH3Tlz8qdqAbMOB15YMp2rYPk9e6Y+ybEzuUxY/J1GAKHm0MFQkCB3hN8CtTAX56Yjpoi2bQzRcmbaGr2SpRVSMzkvoL3jFpo8vIU13emHGF0JULV1I2xdDJGK3cbZi06ApmkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313768; c=relaxed/simple;
	bh=3PeYTbupN2VISfwGjv65aYeNXt+0FlfHZjEj53N7LO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA1KY0XIw3Y0Iue3KyYBV4V+RDnME1EML/UWq5sniBes/bxt8y08BEoL6F5CvOckz2A9PTIliQBJSUk1SDKsY51IqubsqGBElDCJ3WI2uWJXYEyvv1K8UL0+3Po7JKYGmU9ytV0C8xwVIjEE4uZjT59CYy3rL51WqAqIj990DqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDwDWj0r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYcBt32u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDwDWj0r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYcBt32u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762313764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocA7y4ZtA8+hHznDELnZyszTc84eNA3IP7qXnz+EX+g=;
	b=JDwDWj0rkeAHQibYLnipo/Bf5fBk8zE5ivEyr4FRgCKg5nILjhUsIfke2wJ2k707p/nyh2
	q4+tnYgB8ZnrXi6HWNpoMSENmtfbeSJsxpS6ltYcZ/v3jKk5Cb3sSZ/ciLaw2T5ifyMaRP
	LjXhiQyaYE2Cq5+jSV7K1gFf4BIYE+o=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Qwr1p8wiNi6KMz5ztMDLRA-1; Tue, 04 Nov 2025 22:36:03 -0500
X-MC-Unique: Qwr1p8wiNi6KMz5ztMDLRA-1
X-Mimecast-MFC-AGG-ID: Qwr1p8wiNi6KMz5ztMDLRA_1762313763
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-930dda65b0dso12567590241.3
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 19:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762313763; x=1762918563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocA7y4ZtA8+hHznDELnZyszTc84eNA3IP7qXnz+EX+g=;
        b=bYcBt32uppfMkLsTXVUsQ4gr4/pDuP604CPu3zmbSKpT3H3dMBJdnyK+TV2Z6PYbYV
         SLTNNhMmf+wPPKhcHX9UGllKbX2ylcbwE2k/tpDkP3m3mj29QgC4Pa8KcfdvMwx4h/Lv
         Qq4N3RGpFRoku/HnZqTF4jhtpweULu/PruP5Kg+GYj8+i1cbzAJ4rW0pw1UF7TfLGqqb
         2z+Rqd9qWxK5njdwJ1rkmZ9VX19hPyMEAhz9Zh/zLI1blPVnHduh/w7PE0SUvvIuncPI
         N834l6LNH0+CIqFfN+a2hPzb8sIe6HI0ENwfhfMKjeGNfpVSgD3O2WIKnbBOjjYiW0Qb
         N0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762313763; x=1762918563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocA7y4ZtA8+hHznDELnZyszTc84eNA3IP7qXnz+EX+g=;
        b=HxNq4h5WwAjqyNHZAfqawWqBLbC4Ygg3PO+hA6/+siUAg82zPC384Psmf+Hmr/edN4
         lLfBfIrkCmyy9Vj4f/zjvQZ9FgrU/1m5A5kJpVJRM2qwsk5M0n8o9jGGeQpQ5OHnI5Lu
         1pBlt4vTGzvxeNegf+QARafvFh+acXgDkV8r1O1YEhUdwuySxWr83XWO8pRI4HAo+FCI
         zLZzF7JKh+SI2aCjmfe6t31u5FYgANzmzonofxHGcFy3qOMaVxUMPvRm2PJBZEK2ekXp
         zm3JrY7yo7+gD6xhu1/cdPJ1ckHotY6gjB5lEzbA5d4ruLvyIivT9rvGK13MlrwWNDBC
         4mRw==
X-Forwarded-Encrypted: i=1; AJvYcCUC74B0XpN0uERlW1UyNi7kzuemsWPbCMEBvXbdIXsGsK8n7skfzGJEmVrlCyI5z2baBIB2gICTQ2Wy2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6QkPDBsB4dM/5JgSbT2yLtK9ZaQEr5jmmYIZd06R7sSy60kQ
	8C0rAcsAlwqarfTJwGZ8mmA6mUohV1hiY9uSEuT/gwc/sCJ7Hdh59F/YwKDtrDA6gGB3S92jTLP
	jhTosY1ivd7r3Wy2F2g9S5vwWcGkaGTT+DQaoQL1y4T4d59PIaJqNU6i7rGgoPr4mZQqKQMuTZV
	UTeIwkYrYNnXuw9yZuZuaN9m0i9H+tISMY45lBjJ0zGC/POtM=
X-Gm-Gg: ASbGncseOyJPdBLxb/NE4sG3SGmGyqHVGUofRGzNGukN5Nuk1cU1nKIllHAQh3cmnqA
	x4H43mGDLXiMkxO5gEiWsTKObQ5fDHKDyzq6+p+VbMexYWLUhOKHT4wNywRiuzVFYYKA0Xh3u0L
	U4n28nCJdZ59Srt6GHOllF76hWh9ibOX4s41xYhqOA+1lG69+cF9tybUmm
X-Received: by 2002:a05:6102:38d1:b0:5db:e851:9395 with SMTP id ada2fe7eead31-5dd88efa220mr663816137.7.1762313762749;
        Tue, 04 Nov 2025 19:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaN6WXTFcpJPXSpiq1R+9dMIxdHLXt3eZaNMcu3Hc7Beh8Ua+C3n9+i2Mi1JWYK95JERw528TlcqBhjjCvoWg=
X-Received: by 2002:a05:6102:38d1:b0:5db:e851:9395 with SMTP id
 ada2fe7eead31-5dd88efa220mr663810137.7.1762313762420; Tue, 04 Nov 2025
 19:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020124646.2050459-1-ming.lei@redhat.com> <aP7Ft5Y0WEMGv7jX@fedora>
In-Reply-To: <aP7Ft5Y0WEMGv7jX@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 5 Nov 2025 11:35:51 +0800
X-Gm-Features: AWmQ_bnYsih5sanVVZF1jCKeXrZy7KJdv6xiOdNtzFhYRjOJHZha19sYkxxbnpc
Message-ID: <CAFj5m9JY4TSY1dYE0qBVGsRcEOmyNuA4utf+G2=SBU2n5Ks==w@mail.gmail.com>
Subject: Re: [PATCH] lib/group_cpus: fix cross-NUMA CPU assignment in group_cpus_evenly
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:07=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Oct 20, 2025 at 08:46:46PM +0800, Ming Lei wrote:
> > When numgrps > nodes, group_cpus_evenly() can incorrectly assign CPUs
> > from different NUMA nodes to the same group due to the wrapping logic.
> > Then poor block IO performance is caused because of remote IO completio=
n.
> > And it can be avoided completely in case of `numgrps > nodes` because
> > each numa node may includes more CPUs than group's.
> >
> > The issue occurs when curgrp reaches last_grp and wraps to 0. This caus=
es
> > CPUs from later-processed nodes to be added to groups that already cont=
ain
> > CPUs from earlier-processed nodes, violating NUMA locality.
> >
> > Example with 8 NUMA nodes, 16 groups:
> > - Each node gets 2 groups allocated
> > - After processing nodes, curgrp reaches 16
> > - Wrapping to 0 causes CPUs from node N to be added to group 0 which
> >   already has CPUs from node 0
> >
> > Fix this by adding find_next_node_group() helper that searches for the
> > next group (starting from 0) that already contains CPUs from the same
> > NUMA node. When wrapping is needed, use this helper instead of blindly
> > wrapping to 0, ensuring CPUs are only added to groups within the same
> > NUMA node.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>
> Hello,
>
> ping...

Hello,

Ping...

Thanks,
Ming

