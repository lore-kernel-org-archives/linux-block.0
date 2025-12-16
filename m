Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7ED1CD1E4
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874525; cv=none; b=ucAR+jcanoQDFnBjYG7wNEmM5qG6vjOrXyo5qbG4SsxMtc0sOpAkBWouscNw+W71JN1pkFRgITe/wRR0JMofJ7rYQrnf8SNFI5lB9MBsNGp+68LVJNBqMPCWc9lJWN7wG2fwR0oV/1A/RIpPJi6pqum+gVvGvNIIGW5FLPw5Kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874525; c=relaxed/simple;
	bh=LeSPLdw8CyUvLD+Wsks/a84DYfWD8ihFZCgPW/k/oKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVKea4GCWai5kx0ZhfMrPQbC7hBIKzylfMZKK8//xkYkf5UUi+lT0woP24Jixo4RfRY3HEF1yIfWkVfK59fzQw2IuudYcXpR6Rsb4CxlFmNFmwXkqyVMX0RGY1q9rZXDzYsCq99u38frVu/2FWSKv/Kuis+CCl34jsrV0DHVoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7TLAJ3C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQx2whWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7TLAJ3C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQx2whWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765874523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bedoI72M4dzcfCaw0bozxUr5koxef0u+N35NgEwFoMY=;
	b=H7TLAJ3CEpseqHx+NV8WMzYuHgvKJVbD//eZtyLLOZE9ZAT2vEvMgC799tmdZr03ghn+cD
	tcOQPTCKqLd2AG3scEurdrqWYMe6G2K9n/wgG8sqxVAbZx8kJagnoiBMrFWTAJiQkbBIXx
	cVZJm7i5iC4oq2HT2BeyhU6Z77GnmX8=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-PMCAC1r8MtOTKZz7EJHe6A-1; Tue, 16 Dec 2025 03:42:01 -0500
X-MC-Unique: PMCAC1r8MtOTKZz7EJHe6A-1
X-Mimecast-MFC-AGG-ID: PMCAC1r8MtOTKZz7EJHe6A_1765874521
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6446ee26635so6926570d50.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765874521; x=1766479321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bedoI72M4dzcfCaw0bozxUr5koxef0u+N35NgEwFoMY=;
        b=bQx2whWGC7/zTs/T2taZQ2SwQ3sakREVj/mczAXJf6or4kz4UIjWV/oNhg0zGhWj3v
         KypdbgOP2xq1nMAKubDDT1siuotr2dc8rusCHUa7yS8PGPBDd995LZvMQQObPaKmLB/Q
         nQBJBE+FN8Wd0fJuYhOw1E1eWJcmCIdlKnCir5FbILdQt3KTi452ES1minrzUioHQfYA
         RVUEKq8n4ei11Vts3aI2jnWql8uqcI9SlwrTZC4gb5SqFu4n818CNXv5Ziljxrnpwfo5
         9RI5S/wmuHmLvtfO04JzEEKdgiHfei0mZKzQQiVmOhhkmudtm+a1SQW/M6BvojVOwIaQ
         AlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874521; x=1766479321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bedoI72M4dzcfCaw0bozxUr5koxef0u+N35NgEwFoMY=;
        b=lQEbMax+Jt+gVNaD3Bl28zHI14lGrvAg8aNo34l81LXM9ANwKPomclB2gyeyanfzYO
         lI7vjGdwheKiuwP2H6ThA8RirhfHo2WxwR/azqumgha2EHuOkFoHxaOSmOys5U9rSgwq
         otTcYsMV0+bvjL4YoQXcXFS5rPJDvX0E8GWFStiRoYzaXvgxEoc0eOUGTpaygwNMsKxT
         0MW8VO/FtNN1biXYBeaeOP3Le8GMcd/3izv8j4DsnDKbDo+10Zb72eR3qjA/UuZ1WTUr
         thN2zAXkGljpyj79L7eKDXW1GGNS5nHormaqAMgdh4vDxKMs7BrJ++b0IqngDp0JamAe
         tadA==
X-Forwarded-Encrypted: i=1; AJvYcCWNUzFI1IMd2SdGSz121gLvWFa5zdU5p/BBVRSNL2iXRQsuXwA0EDTYb8hlTxRmo1CwtYBP62YmiaJ2RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8Pz4QQroQtZgtuzbRPAdiMzRFhrqr6FN4Upj4ROL4aJt+HMF
	oAhR1idJhnRq+4fUE2rfg1cBgsQgvOW3iNdDo4oW3DXb8G5SxLHgrnQEDnwlc49shvKscXnr5uM
	6Tmd/noPwFHO3rC7tgN32C2QaJSDl+QD9H174VP+r7AEFubp+TnG1aubQFMQzYVLe45AYlGz4Zr
	8bXQgKq52NDwa3u2k7KNfRxUEpuQw2djeapUI/4Z0=
X-Gm-Gg: AY/fxX5UQMDJngtMKOzqtwAJEQMpeL4aaG17F6/GxKHI+JtyBr54GS84AYYn0NcN3ig
	Y31fZ10zQKgqdeK0QluUFltMQSiV9wmIlrnG5Db+v4YsY9N6CX5kwNPNtELxdmoUbyhR9pbHE+5
	2ZWwxFQxJMwYaLEtNXydxHeo/zyhnZi3KN0l3YMbCWCwx67dTiL1WylpvWHAdPbZ1J
X-Received: by 2002:a05:690e:130c:b0:641:f5bc:699c with SMTP id 956f58d0204a3-64555664965mr11300525d50.74.1765874520969;
        Tue, 16 Dec 2025 00:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsdXWnoFL9I7pAq/MaIAVAy9awQVMPdeIdCZyZ8gA28f/XjQGXPGkhfCfGI1rJgvn170eyS00H/OkJzbKACvU=
X-Received: by 2002:a05:690e:130c:b0:641:f5bc:699c with SMTP id
 956f58d0204a3-64555664965mr11300511d50.74.1765874520647; Tue, 16 Dec 2025
 00:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208121020.1780402-1-agruenba@redhat.com> <20251208121020.1780402-7-agruenba@redhat.com>
 <aUERRp7S1A5YXCm4@infradead.org>
In-Reply-To: <aUERRp7S1A5YXCm4@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Dec 2025 09:41:49 +0100
X-Gm-Features: AQt7F2oWOgXF4BWLyQhRHkpji9S9Pl-ufTycpWlGBJkrm01TM2UaID084bN-gCY
Message-ID: <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 8:59=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Mon, Dec 08, 2025 at 12:10:13PM +0000, Andreas Gruenbacher wrote:
> > In a few places, target->bi_status is set to source->bi_status only if
> > source->bi_status is not 0 and target->bi_status is (still) 0.  Here,
> > checking the value of target->bi_status before setting it is an
> > unnecessary micro optimization because we are already on an error path.
>
> What is source and target here?  I have a hard time trying to follow
> what this is trying to do.

Not sure, what would you suggest instead?

Thanks,
Andreas

