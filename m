Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1316136;
	Fri, 16 May 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371818; cv=none; b=gKLa8QCTudy61kgZYIa0tT6Pn/vLMB87RQqmx1I9YQ5Xhir8TJcN9wcc47RYFDbIE26CttgZ5cksWwFuNnUyZX+NRbt7ctraKEsKs2lDgfq3XHdWn8gwnj3MepD2hxw+1VJLZoJ1vogmRkk0nzBUgNt1rnqxrcEbrDvkwCiYNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371818; c=relaxed/simple;
	bh=vfHO8Cu806qRwunobDX+1+4PqY/E0h8rmFWKv+QUIVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaHSFPKBGBfDaQCfQ/adPtxZzAwpZPHsCEnffageIW3e3P/yJkaKLrfaH6EFKz6OuOUYuKvb0Y6gmZaG3u5+uzB5afDwYeZXgnRQ+yOBqlM4F7OeGQwr/v5HfecqaK3r1L543Q4eJkt+8nP4BtZYG1VeTj1JVHXbEszADtmtLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLDRMOnq; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLDRMOnq"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3db703f0fe7so3717255ab.3;
        Thu, 15 May 2025 22:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747371815; x=1747976615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfHO8Cu806qRwunobDX+1+4PqY/E0h8rmFWKv+QUIVk=;
        b=SLDRMOnqGEC6tPiR4h8GID9bGvf7l83wdO/OFhWGm1DrnXlTLMvsqp9cTLeNcVRwFD
         y+NsSBQE4JsKQZRruFxqFBkVPDjSrZLPgYpsRFoOHmAUH7xqiY2Ut4/dwOwMilXmp88s
         Z7YIHWy4VFE2Rj+enMb8oabKRF5fUAZJWi0gtTY744CB2M+NyUvJlGTN8TMJ3Eq/gJ9M
         36lomP9ijgGtZBk73vmATMzmiqsji8JoLE6O/KsRJYsohQYMHK+/Pinn+Pr8zZ2061C6
         v9rsf67fmj9TJvSpBhFniiPNNa8cXikT7NF7khCnNOmZ4kexpX5r0SnCM+taNaTrUN/g
         tYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747371815; x=1747976615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfHO8Cu806qRwunobDX+1+4PqY/E0h8rmFWKv+QUIVk=;
        b=boYJym6CjqSTz+2VOrsfSmFMRW3CMk6GfNByGdvbGQiQhE6XlGyJHH8fDtScEi83p0
         IIrzhPKU6qXjJIr2UXpK5CivFYvJLF/wmxcE3uMHcAGDGVIJ5VubHyQmmk1+d3YleOsP
         5Oqc02Tcufe1I4z+9OCjkrjEAC0cQofreHycB/rByfwfnrj6/biGK/0jnNU7UUHVg6sQ
         Zh6QL8RnypMAxXrp4oOPQhDXwUIDl6j+hMiPCoSh9xv+NI0ZThr0pWdydm36IR2zq+wO
         PEvDGfCsnzh13ixfcOG1lZeOerMolZn07b5xTnEXBoMSOwdGf67WDdf+yzFIxZhmcPp0
         YHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaNtIR//fM9aWb21xaz4/OjMq9/jhGeIG66JlZeSfRgu1vKdQYq0chXN3zKFwhKAGi+APKRgWgpG5Dq2q7skjbeKmP@vger.kernel.org, AJvYcCWQ48z1ZhbuRDvOPFJ8L6LVZsfDWoiMwkS/xwPd4cNsbWcZ0Imxlg1cgbej/RE1lpqoRVkgwsPePhfBCA==@vger.kernel.org, AJvYcCWqlxsfnmQoUUc3B0d7IUi8mTObGc/H+n1gIzrtOjhhZ5kEAKnZ+v49/sR3xZTiva5KKXb82sykxxfVawnM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+W3EP1I2Kj30wsvtzCZEYLhIyF6YihIAMqRFN2DWk80NUnPKb
	ZeISSloFxuu0Utz6xwo/oh52yENi2NVoikQKcXcAPak8bUJb1D83GtORGKJ5BbzC8F5/Lamug4f
	qR65c8ku9w+5kCmYk7hZbIMsxdLqRV4d3N1gq
X-Gm-Gg: ASbGnctsDvzaCAI4QWIUOwz2+04GUT8emuU6OH9VCvoejf7t2SZId8Nk0PnGbpMeR7S
	fEdu9OESUY2xB4OFVPnr1sDBL5QQpvWHcVUIPgtwsv3iuMbfMreavJoX8TYZoNiyJsb4vGfzg3+
	rI9YlNszXqAMjN5MsQ5ScfaDXz7eSeqVLE
X-Google-Smtp-Source: AGHT+IFYrJOhjTVLzbKs8xnZ9+ArasciV//3bbbyItaQXPVWh6Cx0qVyiAMYxtEdMiKAiN/Zwm51ThRRmW+7HDrvi1Y=
X-Received: by 2002:a05:6e02:3790:b0:3d8:1a87:89ce with SMTP id
 e9e14a558f8ab-3db842adf09mr27734255ab.3.1747371815436; Thu, 15 May 2025
 22:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com> <aCbBEg-DFYvx0Dpa@infradead.org>
In-Reply-To: <aCbBEg-DFYvx0Dpa@infradead.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 May 2025 13:02:59 +0800
X-Gm-Features: AX0GCFud7BwCZnFXGGuzCwd6g8Kk4hgoR46sY5ReG_zVqAYJVO2J3Sb54Adzoe8
Message-ID: <CAL+tcoBtLu6_E1qKL9VHOiCe_RVpEGzMiMqA3GpPi1Z88aMiWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics function
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:37=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, May 15, 2025 at 02:16:41PM +0800, Jason Xing wrote:
> > +extern size_t relay_dump(struct rchan *chan, int flags);
>
> Please don't add pointless externs for function prototypes.

Do you mean make it inline in include/linux/relay.h like how
relay_write() works?

Will do that.

>
> > +EXPORT_SYMBOL_GPL(relay_dump);
>
> This export seems unused even with the entire series applied.

My initial thought was to provide a symbol for some kernel modules to use.

Thanks,
Jason
