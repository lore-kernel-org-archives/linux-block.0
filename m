Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A310141999
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712280; cv=none; b=XSs/3zCu2Oblw5kSE3hA/dd3KZ3zX4Wnl5/fjAuBRr0bMR1Ro37jL8RXrC3zPIgjD38QtvKfIxWyv6qkVFbDWQyD0YnkU62u/UXy5OxTUrAihrbbicZ6K7AT8DlIXsDp2sNxY72tjNyCIDU0SLdveJadhWnEWJVduYRqWpwb+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712280; c=relaxed/simple;
	bh=s1J3yxJJmHAT7tpjiN+ReLmhK0Jn7qywHUyIzFNWgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRXqyHRC7C2UEU0f714NtKwTgs9reGB/YzG5bkdeg1PTOPQ+em+83cDJdOJAWWpUtWUsfg2c+zcm/g7m1qdzkaMWkW3pDtil+2qysahUF908fFOoW+eTRZppX6j1VcALFxQeiSgwBVXfK3vVuHVDxvAMIi2/nx/6HgdryvWQ4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HO5Z+gHZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HO5Z+gHZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3fd9063261so95561266b.1
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708712276; x=1709317076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMw6mgHykaNOkD9F2veVqYVpqjqdsgVrDzeEVTrgN9E=;
        b=HO5Z+gHZA3i0pf1J1M1lDNdvmtXo9v9MZcPAV3B+cYA+CRPcfbSsJuIN3nHUkjN9ze
         frZNTRPqBQKdgowsLcH1rL7rudZ6ggP+jmAkbfdVG6n8CdAPjZSxqzWgahZnLgBc7+BQ
         FrSwT1VCz09HjNQ+ommxaz5giJDIgIuIa5kWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712276; x=1709317076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMw6mgHykaNOkD9F2veVqYVpqjqdsgVrDzeEVTrgN9E=;
        b=gBPBwziX6kKm5eIybgE/CcSdmTJg+bSh5BPZcGJOk907QPUQIaddHekVMBoiRygRw0
         P6vZ6w8QFG3MyBp4KHjshTar8+suB7WS6o+6gVk8bp6DGGOCejKIONaPWcZhUfI3Znel
         fHgH7p792LjeCcndvTliaFdIssdUefz8uSrTzjmJiBeVhfxcRaIfONHhCqKlJBhtJqYn
         RZLOTYu3BkGjWeBWheZ9o3TGpBG26/m6MwGv0xi7Kuq5fapXj/BIhYX7Y7/xwuuKlctA
         N8VvSB+oxzVYY4TXZSpzYR/agCFL0a6jzWnm+uNTf/LJWAnyjAehkKaydUE3EwIDCLjb
         YOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Byk4HEKKjyCJJzVfSY+lVzr5Vje5eU5ljYi4wQB1GZDu4t7FZp4nFh+Zu3gDrIp8qgMpPojGA2HHavDMPYZL9x4VuQid2CcZGPg=
X-Gm-Message-State: AOJu0YysR9IYwHWQhFk77N1gtkYCaGieJxeWe8yVD0CjtpNxLkAhtdk4
	hkLDTmipDwpJWAaHc1dIYKOFPWTTaKJ/Dofb2KGx+7WA95p6QBygYlnG0167u3VoQJpKUAo7IXi
	U8C8=
X-Google-Smtp-Source: AGHT+IG5a6odsK5c2+GA0dD165GEUGC8/EwnkF4/PfgG/puYqXMQb8LUIT0G+84kcTfCBExzvkgPSw==
X-Received: by 2002:a17:906:b7d3:b0:a3d:993e:ad24 with SMTP id fy19-20020a170906b7d300b00a3d993ead24mr343236ejb.59.1708712276153;
        Fri, 23 Feb 2024 10:17:56 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id k25-20020a1709065fd900b00a4136d1899esm321041ejv.102.2024.02.23.10.17.55
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 10:17:55 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f829cde6dso135797666b.0
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 10:17:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRyscM0192f9UcF/hAaQxliqMv3zr6CzGPxofhgypDAUSXwtqxHmor47Sd2hIcH5XyiD7Q11Ce61cVun5tNiexi/ejj2Ly0zec9Og=
X-Received: by 2002:a17:906:40ca:b0:a3f:2259:da62 with SMTP id
 a10-20020a17090640ca00b00a3f2259da62mr384294ejk.52.1708712274991; Fri, 23 Feb
 2024 10:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdjTMZRwZ_9GjCmc@redhat.com> <CAHk-=whmiQC_F1s1bWmOhM8csz_zxL32B=sPGgaz1kiTK_T2iA@mail.gmail.com>
 <20240223174629.GB5743@lst.de>
In-Reply-To: <20240223174629.GB5743@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Feb 2024 10:17:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU-9SAYOWWJbAsEW3fwSXggB=KGWFjYCtmu1yAURM-iw@mail.gmail.com>
Message-ID: <CAHk-=wjU-9SAYOWWJbAsEW3fwSXggB=KGWFjYCtmu1yAURM-iw@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 6.8-rc6
To: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Alasdair G Kergon <agk@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 09:46, Christoph Hellwig <hch@lst.de> wrote:
>
> I'll let Ming speak, but I think the idea was to remove the padding
> at the end of the structure when embedded into the bio.

It's not horribly obvious if the beginning is aligned there either.

> Does __aligned also work on struct members?  If so we could add a
> __aligned(8) to bi_sector an get exactly what we want..

Hmm. I'm not sure that works. I think sizeof may always end up being
aligned to alignof (because otherwise arrays cannot work)

And looking at

    struct bio_integrity_payload {

there's odd padding both before _and_ after the struct bvec_iter due
to having three 16-bit fields in between.

So right now I think that packing ends up actually horrid. I don't see
any *reason* for that odd setup, but right now it might have actually
end up being 2-byte aligned with a two-byte padding hole at the end.

             Linus
