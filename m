Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB70314B89
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370211; cv=none; b=XeYYJA3jaPp+W65H6ZsK8LUUaFFoERITb/hDsq/txjQYkAm6LdQb2uCvdyYhnmd1EF3q9WXOJZLOkYZfWXxlFOCWj7z5ABHmwj+WecATxfXJ58VKkNUMGSJHLmPKbEE2CWtQCgMPJS0X9kwxoaERICTM1insrQT3UAmkbJBiaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370211; c=relaxed/simple;
	bh=kIVPmCT9kaUq2YA1N7gOyA1JcTYZFNkXFcLBy2dOX+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyjEK+KKBU+7a1uAgHKxjXL+JyKU2/dtwrTVbVK03naWNIg0rHN9/cGtRaHR31q7vU3t3fM72LTH+gdKVyq8RShvQChRw8wnMXZclCWA21k1oCgVHMyhEqWjAhlSUBo8k/LPyVQLPgO6d6MvSxF82HGR8KfpEtlUM1DxsV+1qtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5HycyPM; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5HycyPM"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42d7d0c58f9so635145ab.1
        for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760370208; x=1760975008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvE2QaubCaNe+b2bi3Ii9pwdFgyDED1xYIH2KKqTA4w=;
        b=f5HycyPMTH8rgVXgmQyTiokCXEZEUXPC7ztFDYuZh5VzPNxNZeu2Rt563ptKcRa2Oi
         iclOKSQ/2x29qvifa/uMyBvXW1XemFrAbEqgk82kkPxoYqgsZsc0sxFysITyih+38/JO
         dW9xmyl383ZTkEkqxIzzaG1rw/qWB9ClSp947Dz21GpvD9vFJQowdo7dvR8C3LgteHbE
         Y9JImsi4S5TSpk4goUl9dRFm43rf8xcapzv9+WQ3dWXX4LX2jPruekr+uNatluT3t9ry
         ht4Y6Y/k6aKum3kd2Qjhmuqy72ssxE8YayuiRVd47O+XtSaaf7NmyjaEarlFVI5Znsak
         yRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370208; x=1760975008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvE2QaubCaNe+b2bi3Ii9pwdFgyDED1xYIH2KKqTA4w=;
        b=pZESpgGw7Fp3/GjveG7CtXBNkDorYBjtbrpNIZb2gvQMIrxhT60fmZ14Znyx6Gnm+Y
         7dZD0JNp6G9Z9XHyylb7qeecgviafXcKm1oyusFunR8QCSSZ4ln+Dryx8Ub8s6DR3IBi
         VlAz8NfCxluxO5HHDdfXn7ZDmCrVKTmnjy9ydiknbCmosmLl5X7qHDD8oWmU0+V56VpU
         L++aZJOdA3MP/2s62j/dIN3aWCczhxULXordiFwgZIBNOfBDPCpjoZbk5ApdrCqW0gRl
         7f9ph1OzJIMch+L/d5ItZe7JhDseF22mJzkRlIQsfjvRhZ+DgOrZX6A0VvAWIu7oMcfP
         ynXg==
X-Forwarded-Encrypted: i=1; AJvYcCVGyLImX/m/M2JIjBGG4cIOfZcjuvzj4RbiYUIs6vIf5nQMBh1XvXZOi3qjFruq7zL9h8rBiyMyYnMe7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiUQr9mlqeUYaFLDpsIvqnFyPXdR0p8QuL3e1dFTUT9Sd43Ow
	+ZrXZ0+/Y/NmCba/gqNziTED+yWY9tO5n6oHTzvyxYkePdHPtx+kJ8ZeHYmMnWFsKQ6TUNgw+Tu
	zNu36DHafgQXZ9Pp0vfXenjN0r08MjBPjRoFekmt1
X-Gm-Gg: ASbGncui0mA3ji57bCO+4gS6Z5XoSCVUzhMX6X67T+2hYuT+HVwPdUTw09xX4Vtu2tV
	YmPnzsqQFzPFEIItwUkWjv3rPFJa7ZFwhGMjLZYhc7CL2v0uVZjv3rfYAbNzLEPZgwK0S41d59h
	lG14RTfYv9RMQYskNGIaB1ST7SMsDsHeMk5GJsE88azzuTqIDtXKROlXg7r/IXycOQ73RMvWWCs
	gDJXBNL/GzJB7dv4uL3KBoQ8eYl6mkU7cKMhu+G2G7smOvOyvIS
X-Google-Smtp-Source: AGHT+IGi9WTnaWtP/uIr7PgRC+0JilLcGDbVVnkS9tGZZgbSezgQwLrXzu3IZ+mvJsC1St6EdcqZZFWTwoYrtUBb1Hk=
X-Received: by 2002:a05:622a:808d:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4e6eaeaaf5dmr26573411cf.3.1760370207737; Mon, 13 Oct 2025
 08:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <aOyf5FxH8rXmCxLX@infradead.org>
In-Reply-To: <aOyf5FxH8rXmCxLX@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Oct 2025 08:43:16 -0700
X-Gm-Features: AS18NWAw--9GoJimKYZPU6XtnCpJ2t59ru9kAaQP92i8jW-vrfiHymNpWuM0LSo
Message-ID: <CAJuCfpFs5aKv8E96YC_pasNjH6=eukTuS2X8f=nBGiiuE0Nwhg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 11:44=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Please don't add abstractions just because you can.  Just call directly
> into your gcma code instead of adding a costly abstraction with a single
> user.  That'll also make it much eaiser to review what GCMA actually
> does.

Are you suggesting to fold cleancache into GCMA? GCMA is the first
backend donating its memory to the cleancache but other memory
carveout owners can do that too. The next two on my list are MTE tag
storage and memory reserved by kdump.
Also note that the original GCMA proposal from 2015 [1] used both
cleancache and frontswap to donate its memory. We don't have frontswap
today, but this shows that it doesn't have to be a 1-to-1 relation
between GCMA and cleancache.
Thanks,
Suren.

[1] https://lore.kernel.org/all/1424721263-25314-4-git-send-email-sj38.park=
@gmail.com/
