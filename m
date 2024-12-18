Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED619198E92
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518335; cv=none; b=YDB2AEOHCX8HcRXWAGCAh4a4z+UWZiDmTJOSGLSc/nj6WFPRY7Nh4IpXUxOn+opGLhkXwPR0tCPj8WLdutXydk4VOGwm2uITcrZh8iJuH1a4WASkqIEjb/4P0yIL5feX5pz8DZCgNzuJ2ymQV7TZigGu37PXKnpV4EzYRre5qOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518335; c=relaxed/simple;
	bh=6IGYgQT7mpGiKkN1hgePz3FK7WpUR/9d7qXsuYxeXhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhDoaqaXhx4KpZJkTZSOyJXybj+x7Zo58jCOuZ/e1/wjY5Ocvhke10VH7bo3VxB7MwS3iy6RtvGqFYmsiLIgePxT75//xCgWMfWH4JmKztl4160cw3ZfRZ/nnlYch6ONqQpVBrLipldLok9rsVhbyjqDo1DBX6Ebx2nT5nQGzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFKSS3eI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFKSS3eI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734518331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IGYgQT7mpGiKkN1hgePz3FK7WpUR/9d7qXsuYxeXhg=;
	b=KFKSS3eIOEsLm33Lxag6QoMh4zV/ZXZMXz2slSEd473wv+9l9mJmDSaZCAzbn2DreG6Ctp
	NpgCgUbilSYlRZ1dvOeP2TpUSuJNMK7eEpRfokSZdCPEphVLI1llnecL8HVuLIRhJx2QMQ
	TQ+QB98rLoVF+qYaxJkU7Du5s4jMXhc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-neaHGPQDPuaccg7Edg9aNA-1; Wed, 18 Dec 2024 05:38:50 -0500
X-MC-Unique: neaHGPQDPuaccg7Edg9aNA-1
X-Mimecast-MFC-AGG-ID: neaHGPQDPuaccg7Edg9aNA
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-85bd1aacebfso1298645241.1
        for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 02:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734518330; x=1735123130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IGYgQT7mpGiKkN1hgePz3FK7WpUR/9d7qXsuYxeXhg=;
        b=kXJTioQfhy2vmbCLBdJjgwrrpgmGQKwBd1a8GX87Z8eBWs+VOsfdOH6+e/mLz3+RAi
         6eiVaUsY+9+aCesBfwwgbLA5peG399MIQvctPAKXu6xkN1tLswxh/aRpvNXvL0xDaZop
         B8Ts2lu/SSsSRcP6EtoawAok8IlXKvUaXM2DCB9sKTq3P7zt7LWwJGZp1ez3XUgrFRj5
         iA6CrSP2pt6LRurLsPMag5wAL81YzX2qJK9r6LkI7Ssw+k95yU1FhmHglfX4zLVx0pCT
         5Jl2/wGOe2rGQEyEZt9bcf8Js319nYc2mufjadqxD2AnfN4WDZ4FqARqflgCQ8JtmMZL
         wa+A==
X-Gm-Message-State: AOJu0YxnnA5UJ7A/cpJMjVh1aC+eK2n1kEwlm1cZ+YLCUBc9Yn3B42tG
	QdBECMfLv5nWvlP9KMIbYGOpx3TSo4JOCosokOEOPEFEDCbF+tuV2JKaCSvlnQHjnGHrKN1goIx
	W/ZuUVYsod2OKpcWA3AucgWnw8OTnM6qesPJaUq1OuWx6yDZEEuBqMwMOhqY0pxfrf6nrsFH97D
	3df6RtZeVzgFAAQxmrkeTxBFDW/mQt7OyoV9rqKWc97wNkSg==
X-Gm-Gg: ASbGncv0CKbqKTThQrVOQmvGMUo1xnRbNDYJq280et0oWoo0W6isG1nAdX/7WKO+9+F
	B24yNHNVjQMn9flQkoh6h5z9p6ZkWw8EgbwokcHw=
X-Received: by 2002:a05:6102:c8c:b0:4af:de39:216a with SMTP id ada2fe7eead31-4b2ae70e307mr1558064137.6.1734518329873;
        Wed, 18 Dec 2024 02:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxhYSCvAHNAga8g9oC4ngN3RSpczMtBWIft19uo6wihqsX5CNCK2Y4jRZ7rG7/qJdHScNgrSp++4KF7aexK5Y=
X-Received: by 2002:a05:6102:c8c:b0:4af:de39:216a with SMTP id
 ada2fe7eead31-4b2ae70e307mr1558062137.6.1734518329659; Wed, 18 Dec 2024
 02:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213073645.2347787-1-ming.lei@redhat.com> <57fglxl5mwxugcgj3aa3hkwdvmcfsfwdamlhd3r7r4fcfx75bf@opaflvrpqa7i>
In-Reply-To: <57fglxl5mwxugcgj3aa3hkwdvmcfsfwdamlhd3r7r4fcfx75bf@opaflvrpqa7i>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 18 Dec 2024 18:38:38 +0800
Message-ID: <CAFj5m9K6Qn3XFN4WpCUpOgBQVy93KUJT0Pbem5KhKG1jNB9M1A@mail.gmail.com>
Subject: Re: [PATCH] blktests: src/miniublk.c: fix segment fault when io_uring
 is disabled
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Zhang Yi <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 6:17=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Dec 13, 2024 / 15:36, Ming Lei wrote:
> > When io_uring is disabled, ublk_ctrl_init() will return NULL, so we
> > have to check the result.
> >
> > Fixes segment fault reported from Yi.
>
> Ming, let me confirm, the segmentation fault was reported in the blktests=
 GitHub
> PR 153 [1]. AFAIU, the segmentation fault cause is in liburing, not in bl=
ktests
> src/miniublk.c. So I guess that this patch is not needed. Do you have sam=
e view?

Hi Shinichiro,

This patch fixes another segment fault which is miniublk specific.

Thanks,

