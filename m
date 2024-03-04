Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354F7867F
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577166; cv=none; b=CVGRJyH7S8QLv8rrtXyW68lKIyAC+y9UUr6JrsQRbbk3UiD0kSzldtDwH+2OL7F2ykiRxC37nfkMZYP0CUE+QybSRge4/XsIg0v6OtLW0qGv5hl/h6TPvK+u6u2p8fKrgoJlyh4Rzyohuw2z0nZogNHfYeA5cLnwHCWe2XDI/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577166; c=relaxed/simple;
	bh=KtfWqAbL60dmDmNJlm82ls0DTRmdSK6fujqZ9REQ7jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/JfVU8w3z9EGWCmKbuQDeJJQvQf8S2psB8zc8swWS24TO5KmkiGGeKNk+2U6iKN42dECP92OfAWS3hTwVG1K9GxWM+59K57j77Km4WiMRhQsRuH2lYmTztjCKI4wPm+DAjFTvv04cLcfWX8UvWx8g57o+6AYF4/tgxSfrtj1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BbWTIXvV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BbWTIXvV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso630195966b.2
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2024 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709577163; x=1710181963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=BbWTIXvVXccjOIm6D8UrLPSNEOVbttfbMP1WZ4f0oou7KQSadyMmLEJjcYg6b35Rof
         ArKb0L6JTwpK2zZZTd4V4+h4CdxqULG4VZ0zJMb2ytUQUYOxKqYf+I4LtYAblhvjvW59
         1IOUrloYE4kqblgcXfSGJAjvn32ooaRHjFsMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577163; x=1710181963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LczxhZqLEWu5Pcwo59Oo1yTNgbAQRYyUzuwaCxJZY78=;
        b=fRqDjhE+TLMpB/INHIUNE11G44BuQ608sDth4XgKf0s0HbyZ8Ia868PPtnnB2lL2sR
         3prYO/pmf+n6yzAsSY/AN7yzajdhWcJuntAl70/UEBQ9+bLHiiav1vF1VVek+QlPsRSW
         3vIHlD6oYNeMXrqIafEJzY50zwWMu/njq+tUxHH/oodotnDVt93lOm6rcaybajuaw5qm
         p1RAf9DP+YQhyVrffS2o8ZZKu+O0ARSpkIvq9o4RgeRE21EP7LYJo0ocVuRAb2j5DdVg
         aRd33bT1C4bIeVmo5iJdc7yFGyYQs2+jTInNCE9LMdk1SouPabAsjSBs3lmmQMwWbD2q
         ppkg==
X-Forwarded-Encrypted: i=1; AJvYcCXGJFF4m+2pBALO3d8SJ671rkkER39x071P3BM7ha1KuO2e2yOEQBXqPM1GnR7iX26MDiMOtQ4VJpmXKM5rxAUPtRs9d75tQYPQ8Fo=
X-Gm-Message-State: AOJu0YwQtEIhSkt4LZYo5ocbCPuQRpoSdtC1QtpKo7yJmMpWGtESGURX
	mPCWFE/jflXbCiytuEBi7lC6B3tphf4HYUPzKiGVCVu7WhhdzTiPLhBSD/Sr2OhOgRI1gQSbtnG
	gWEI=
X-Google-Smtp-Source: AGHT+IFLlhJuQPg5b9akPFfqa28pmtNta85KTe/S5eaTadvWxN8IjWFjg036avmoBy9lrGsGEtgB9A==
X-Received: by 2002:a17:906:3954:b0:a43:eeec:57b1 with SMTP id g20-20020a170906395400b00a43eeec57b1mr6331239eje.34.1709577162863;
        Mon, 04 Mar 2024 10:32:42 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061d5a00b00a44f6ce3e7fsm2625722ejh.77.2024.03.04.10.32.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 10:32:42 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso630194266b.2
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2024 10:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvUh8g+WBoy1Ykt3k2U8dKHig/nxWtTAIvXREc/Szuc3spx1qZAS3b/2xXoAxPmwd9iwuVPW090gaQJ4UnXCUb3Jew9/2J9LOBIWw=
X-Received: by 2002:a17:906:8da:b0:a3f:ab4d:f7e3 with SMTP id
 o26-20020a17090608da00b00a3fab4df7e3mr7570338eje.0.1709577161818; Mon, 04 Mar
 2024 10:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <769021.1709553367@warthog.procyon.org.uk>
In-Reply-To: <769021.1709553367@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 10:32:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Message-ID: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: David Howells <dhowells@redhat.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 03:56, David Howells <dhowells@redhat.com> wrote:
>
> That said, I wonder if:
>
>         #ifdef copy_mc_to_kernel
>
> should be:
>
>         #ifdef CONFIG_ARCH_HAS_COPY_MC

Hmm. Maybe. We do have that

  #ifdef copy_mc_to_kernel

pattern already in <linux/uaccess.h>, so clearly we've done it both ways.

I personally like the "just test for the thing you are using" model,
which is then why I did it that way, but I don't have hugely strong
opinions on it.

> and whether it's possible to find out dynamically if MCEs can occur at all.

I really wanted to do something like that, and look at the source page
to decide "is this a pmem page that can cause machine checks", but I
didn't find any obvious way to do that.

Improvement suggestions more than welcome.

               Linus
