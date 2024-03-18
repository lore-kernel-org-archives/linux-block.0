Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969B200A0
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794253; cv=none; b=cmXR0d21R1RU2Q/vHKdrJg/GgQmIlF9w+aV60fKRQey9AXt56vu/zvVm2x6jMH2GePfcXfzEM5J3oj8dMsV7bhn339LXOcTJKn4MPz3X+GTZCZGdTtX2LoPwyyCFF4YbzYf3UP4lwEkTmF5EnDEbO+o3pAYXWe64jmkRX2jUJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794253; c=relaxed/simple;
	bh=VqUdaK9/7+tpHdN2FO3ZgGi4B31q9n8BjGi0tpzECok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAjTfzMOtgZjGEbDaGDl4RUP+Dphv2YAEW7F0ghXbBqwr+wtQXvPDPju3rnzy0HIwqRXXMBXmU9d6L15d1KCx7HEyu/5Yuj/0w+tx8ZPl2D4c1V5qDnNmL0uZbFG4A9OckrPGWV5Hy622fpugsGVMFLDmUHryRlQ51CMzIVp65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icPyJZhl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icPyJZhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710794250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqUdaK9/7+tpHdN2FO3ZgGi4B31q9n8BjGi0tpzECok=;
	b=icPyJZhlvxQlbGaxCO+BAoM/xd2LvLcnGRRHtKZYQDfr2O3Gif/AVPvMdgYVp8FdKyZhTc
	rSb+zAkQKRTE1oWEg4HhGWHCwhNOuEBoMj08785ZKkKZ7cdPvFFZOc8wn+Fb69hTr6ij1O
	Dj1ANWfbIbYX549am3V8MxQ6lKoQT7w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-vkcEEIzqP3aDuh7g7S6tDA-1; Mon, 18 Mar 2024 16:37:28 -0400
X-MC-Unique: vkcEEIzqP3aDuh7g7S6tDA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so3581051a12.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 13:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794248; x=1711399048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqUdaK9/7+tpHdN2FO3ZgGi4B31q9n8BjGi0tpzECok=;
        b=FeNfSS7deWHBniOGKhVD9etzkhAtSL1lH9vytTD8PHrbTD8VMD7Q/PsxbuL3+Lf9U5
         qJ6Uy27qYk9fq0F8iWz0xw6jn30hMZT6YXMQpGB/h+9nx4T+pCVaoeoQIMtN3jUj2Dn4
         WYzy7oFkjOWBmKKIEFzXhCcjA04b7MyAxjgr4cOafYepAxQEuJa0iz90uzTdjtgS7pqY
         gvwVos0MecZu81glVilfU/QTIDUKC5Vb0pZMr5IWvU+NzM8/zGPqXf4BT0SJfUhZz7gx
         WNSp3OQy27yXS8FTQ9iy1sSrCLNeYAlksSxT/EfDQIYtZeXsmKdzlmvMfdkr+5+yuNxx
         31zw==
X-Forwarded-Encrypted: i=1; AJvYcCUeu8LLANsnn2T7VcWVWCZ5bkRqa84COyYdGnTe0SSRBOJB07hbUcRDrd0p/xlK8D27K8muH+vN7GrptCBlwMJLhAJi00fRns+2Stg=
X-Gm-Message-State: AOJu0YxuG10LG9GXCzaMBySGCCdQvX3zEPlJsZg6xxmk6qk9bdWDpYrW
	J4HWGK7ANtdiTYbbnmduTrY2u3PyW09rDWB9CtvsxnwFMjWwKY9b/4QESsqPrpTa34Mmng8Myuh
	0YKo1PrRDK/NVib/63IvQuAXlCd6xp9O9kc0rFM8WZ4j31XIAdED0uiYba3OVrYAWdt/m34s1wW
	0RasXoe4XYxBQOIkU3LEfHK+7Su9cw8OUMg14=
X-Received: by 2002:a17:903:2285:b0:1de:de7d:d3a6 with SMTP id b5-20020a170903228500b001dede7dd3a6mr950731plh.30.1710794247657;
        Mon, 18 Mar 2024 13:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUpJT89xQZSz/cFtms6kcfogrMTsC4m5Y7X5MeMjfbSKTJ5CS05UfZSjgpqv3UDTtTeSBtK4dXFOToCokSiKQ=
X-Received: by 2002:a17:903:2285:b0:1de:de7d:d3a6 with SMTP id
 b5-20020a170903228500b001dede7dd3a6mr950715plh.30.1710794247359; Mon, 18 Mar
 2024 13:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026214136.1067410-1-msakai@redhat.com> <20231026214136.1067410-3-msakai@redhat.com>
 <ea57f231-f78e-4a55-bf85-c5d50e17237e@roeck-us.net>
In-Reply-To: <ea57f231-f78e-4a55-bf85-c5d50e17237e@roeck-us.net>
From: Kenneth Raeburn <raeburn@redhat.com>
Date: Mon, 18 Mar 2024 16:37:15 -0400
Message-ID: <CAK1Ur38jAmWo35HTNrDDAaN5Awiie9wRiPDMVrNUg6+ZM8mJ7A@mail.gmail.com>
Subject: Re: [PATCH v4 02/39] dm vdo: add the MurmurHash3 fast hashing algorithm
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matthew Sakai <msakai@redhat.com>, dm-devel@lists.linux.dev, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(resend because of accidental HTML lossage)

On Thu, Mar 14, 2024 at 7:38=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On sparc64, with gcc 11.4, the above code results in:
>
> ERROR: modpost: "__bswapdi2" [drivers/md/dm-vdo/dm-vdo.ko] undefined!
>
> Guenter

Thanks for catching that. I don't think our team has any sparc
machines readily available for testing.
This is an artifact of our having imported user-mode code to use in
the kernel. We should probably be using le64_to_cpup and friends, as
we do elsewhere, so it doesn't try to pull in libgcc support routines.

Ken

