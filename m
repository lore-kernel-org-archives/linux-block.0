Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3E20C48E
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450384; cv=none; b=ElTysD29TgF52iMXWsJYJjkcVNT4eotu7qemINR9RUE011GDXoqDOLxsWqI9p+RD//vdxZzlk0ielyJJzn0ifW6rBgDCIKuTzGk7Xba7n+o+pj3SSgdX94dyZ66XmeCddNTvbJMd3BG03r59SbONIiEt3LClGgE3clZmaF2iipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450384; c=relaxed/simple;
	bh=SwJA6S/tp/y2Rb7TYbNgiE7VIXEAXWUrJeLYW4jxT14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDw5H/trIrspkxruYxIiZz21L3KVcrccKEViXTkoMy56vRuU8s9zNn2D+TwDxoskS2udrEakVI1V6Q10zXMYy67AU+BMHNLSLL5D0S+UZ40jU1fqoJvkDccrVSX1XYOjNXF287mOj8g/bSI6z9xnjihVPcu9d8pSL0008o7PU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duymWrmw; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duymWrmw"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5b16621c28so619046276.2
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739450381; x=1740055181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZgtM/VzP0ygSUhhZPW5/KCIpzSTTauYjcPdfKEaFSo=;
        b=duymWrmwKE3DDayW682G/EcgvKv0mmPzF82oMzp+AvszG89skw5/bgCdynFS4+XZNe
         cYUbUisHyF4bjTpYNm3886gMolCmdp/gDSJDY/CGAhfEHzNurUIAGzd2TTRACC3vNs8a
         B4eYBITgS9gFYrdkxrMqYP7l6CQezGKmF68oDI5dSp4LDJ27TRBscf1sxd00Rt06ZNcO
         /Vdy2e3qTEm1srMF1WDuJPB5X1cAk7oWVyLdbdIGhFHmnWNf57JkSJ7tz2Vk9rdDZs8f
         fOWUezh6dbGL9Oq6Pix7XvaXSgCeD3BKp0d+nI8ZSc3TpXh5CJBYGCHomGmMUqMn7EkD
         eGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450381; x=1740055181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZgtM/VzP0ygSUhhZPW5/KCIpzSTTauYjcPdfKEaFSo=;
        b=KDUNd5MPa6I+2tXnSXAoFKyg1PmWfRPCSE8mRj9wXQ/KVp319VOlKNlCOKtxmfHmOP
         E1X5PJ+0tjITkHa3wubXnAx1oOcww2zsL3u0cMc7iHcGspMNQFCV86pjX9zqUKcvW2yx
         nOlBWDVXYNfUXKPFJg3bQVAGgG+3zqV+6Pul8yIZXp/pmagkuQpOeEU8EzvisD4YZrUT
         vT5NcSwrlwYpPv//wzxE87Bh564r5zlymWIdKU9cjulq9PGLwVTtEnhzy8CcDZtSAMUG
         NnpCV0BOir3MghFAaWLqHyy4ONl45WsBk+pZLmA6zUbAlOSrM0fCn9TjIrFJADHPleb+
         Telw==
X-Forwarded-Encrypted: i=1; AJvYcCXRtRBGY44TiZtFB31jv5JCdNa6H3ZjkmliIWShf+SW20IdW9QQDhgK9k8Qg4BZVYClnPQsJ673dEFZlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDg3MMKkR6nwxoJ9APh/y2DbW8cH+0lG5gCAn8DZ2yVSUlZ1yN
	cSTG+VkbxqCgDNKHA9emJdPn/dxAFrvu3pRhWQCdC34cVsy2XhL2+oeHI1ByfKNwbxBZX+xOQWE
	5LTCwaYy4SkxXJ5miPTMbM44pD4s=
X-Gm-Gg: ASbGncuUgXjKN9dYkJcqSMX/te3PmVc/MPphCTjplW9qDd/HX3PCXtHGiaY2MxnO80w
	Olir+H/l46tu1+miz+SjY7nFurfy9alRSg/wZ9ObbEjxDs1ndFVAMYpZ1SpEFHMsgs88hDfF+
X-Google-Smtp-Source: AGHT+IGG9EqGFu0c5R1XxXYBKscHNi3zma9Z+qM6yVUgKyPHagJtfnLxPSgE1CvdK9rJzdRhYtMmw5miUx5EFb00GAQ=
X-Received: by 2002:a05:6902:102a:b0:e5b:323b:a1a7 with SMTP id
 3f1490d57ef6-e5d9f17f889mr6008681276.42.1739450381585; Thu, 13 Feb 2025
 04:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
 <Z6s-3LndN-Gt5sZB@fedora> <Z6tss9YS98AEIwQy@fedora> <CAHpsFVcMnSJgJbGrqiBDmYkHyneJdby4DMkOKQKAuicA0kgJQA@mail.gmail.com>
 <Z61LEUdHI2Hx3bue@fedora> <20250213063214.GA20171@lst.de> <20250213063814.GB20402@lst.de>
In-Reply-To: <20250213063814.GB20402@lst.de>
From: Cheyenne Wills <cheyenne.wills@gmail.com>
Date: Thu, 13 Feb 2025 05:39:30 -0700
X-Gm-Features: AWEUYZnbS9GZTK9JtaSBS1KcdF4Zqs7o3ecAeZ-LMLER3qYm5VW1CxxvrkewEKs
Message-ID: <CAHpsFVeoekuk8_SxQfsggwxUx1c5xTV-Na_8zB9yU8cVK0X0sg@mail.gmail.com>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With the patch in __blk_rq_map_sg, I was able to boot successfully.
(just to note that the code that I tested included the other patch
that updated blk_map_iter_next with guards as well).  I can do a test
that just has the update to __blk_rq_map_sg if needed.

Thanks

On Wed, Feb 12, 2025 at 11:38=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Thu, Feb 13, 2025 at 07:32:14AM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 13, 2025 at 09:29:53AM +0800, Ming Lei wrote:
> > > Yeah, turns out oops is triggered in initializing req_iterator for
> > > discard req, and the following patch should be enough:
> >
> > How do we end up in blk_rq_map_sg for a discard request here?
> > dma-mapping doesn't make sense for a non-special pyaload discard
> > as used by xxen-blkfront, and xen-blkfront also only calls
> > blk_rq_map_sg from blkif_queue_rw_req and not blkif_queue_discard_req.
>
> I think we're probably dealing with a flush command, as that's the
> only request that doesn't have a bio except for empty passthrough
> commands.  xen-blkfront is a bit weird in calling into these data
> transfer helpers despite not having data to transfer, but I guess
> something like your patch to safeguard against it should be fine.
> But add a comment as well please.
