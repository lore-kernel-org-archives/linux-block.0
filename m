Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF31D61B9
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884026; cv=none; b=Gi8OLNfdqYSCLjBWbVdno/LOku6r0IEFHi2VHodnDvS8NthBpdy2qdNg7jYjQeCuio4kpXkdsfC+tQa6tWJUNxP36/oCWJBg1Lw4HhqZTUJ/43mOdgFABE6BGcSzqJSovCL6b6V3eXO3EGPu3DwOjByTfqE9UvKj91Wz9MLqCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884026; c=relaxed/simple;
	bh=t2NEksvuyCLtRHWGJdBHHbhf71fHxG/Xzlny5xheyx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5JZGO7hETGeH5TobYIJFhawB3TxJPxqz1/37BPOJBX6VeA1CCdDl993dGL7NsJ9IhdotIfIU4am4uguczVJeJJUlihKwCCXSvOHuh4pdR5iFj4BWiUrbT5jHy8CKCzV35xUTENm+g19g8uXc1VD54Qw1cBe9WBHaHfdPs1nJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAqbj09W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAqbj09W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2NEksvuyCLtRHWGJdBHHbhf71fHxG/Xzlny5xheyx8=;
	b=LAqbj09W+Ijn+YvRGfcM3oTm4SkXwTAk+hpr7prejfih1hx2cu0NidPi4JNLsVH6wMbjH0
	s8lXREt8wUZJG2VKSDCbiyd7J1kO4tdu+l9DqYiKheA7aUYSQs8W1w8kgWXcovVBxz32+l
	Rk7Oo9PKty2sP6uUFkHw9wfVXQGRDNM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-vMqQ0eE9NWSst1g3TF4h2g-1; Wed, 06 Nov 2024 04:07:02 -0500
X-MC-Unique: vMqQ0eE9NWSst1g3TF4h2g-1
X-Mimecast-MFC-AGG-ID: vMqQ0eE9NWSst1g3TF4h2g
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8501337720fso2252359241.2
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 01:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884022; x=1731488822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2NEksvuyCLtRHWGJdBHHbhf71fHxG/Xzlny5xheyx8=;
        b=VZG2Hqpgj8uoYmKbTt3mFPgNDsTQE2igFGa2HeCLttggAK5+dP49fLggnB8XolRgyx
         tyBG5RgfQ4PJNNt5zgjb+JCCKQbNLh4mihJNMqvYewXpDVezSzIDbCoKf7lourmlUi88
         pPWCpmPaqV1+ma2q42vEb/lApDvsJkMDo1zEScxRhFnzGVPc6tNkuXydn9znOdh6aqsV
         21oXl1DLv+PmXZdkdvqlIULO1fE095LncLpKGxgzPEVU31AoQ8RfCkM39qfS/tLbe/tQ
         7M/H1+3EJe3EJMyOTL951lBjxe5dFjd0xswGznstvUTcHXyqQWcLc8GYJY6B1S2uMa1w
         9Mlg==
X-Gm-Message-State: AOJu0YwT++Yp+Eb1Ns3gPnXdTtsjJudxDPxWTF9zW/1uNnCRbw4gGQlS
	DcbVaGCSwtZafb8RtaSHeFgJyWplAAQvmAZnvJPid6uSqVlsSp2mZk89EpBUCJI77oGTa4y9Smv
	P4Ibb3NrH7E6Y7MEPNkZsPGL9Wmvic1u/3doMCu0u2sMg6ykP5mkpS41SiOQB1acsVCjoZfTQC6
	0hoIJcK6gvtTL8imOgW+ccYn+K9BM47uyN+0w=
X-Received: by 2002:a05:6102:5127:b0:4a4:8346:186d with SMTP id ada2fe7eead31-4a9543ee82bmr21916585137.26.1730884021900;
        Wed, 06 Nov 2024 01:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7N2o3kpNWhNXEs36XEzk/WdpcmfQEN0nS+q3NJ0OkbjHc3WyCEEEvIYpClSwK4ekDjNLB8Q16DECkcwkwRLg=
X-Received: by 2002:a05:6102:5127:b0:4a4:8346:186d with SMTP id
 ada2fe7eead31-4a9543ee82bmr21916575137.26.1730884021622; Wed, 06 Nov 2024
 01:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-61uwDYDdMduh+UNp5er9x3=1snH6j78JGP7uWF2V5YA@mail.gmail.com>
In-Reply-To: <CAHj4cs-61uwDYDdMduh+UNp5er9x3=1snH6j78JGP7uWF2V5YA@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 6 Nov 2024 17:06:50 +0800
Message-ID: <CAFj5m9LZbNasB3+Ma1FzrLCFc-7C5mC3AREipvuXMnB+QLP7_w@mail.gmail.com>
Subject: Re: [bug report] possible circular locking dependency detected with
 blktests block/002
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:29=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> Hello
> I found this circular locking with blktests block/002 on the latest
> linux-block/for-next, please help check it, thanks.

It should be fixed by the following patchset:

 [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes

https://lore.kernel.org/linux-block/Zyq3N8VrrUcxoxrR@fedora/T/#t

Thanks,

