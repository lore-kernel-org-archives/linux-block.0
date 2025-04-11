Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56025A32E
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396582; cv=none; b=gRVN2Rw+1RSEU9Tz75krYvQjQA4VFLJT0swDexv6EfpGYWk3UnuIve/M0H/GqOvLbf1nMCPsaKZvCaSSmW4RqTYecQJCmV2J+7QrlAUiomKo1TPWIduSEa3PC/HZ5bohKZDQz1QtF3PH950dJn13KeX2wf/5K8axadd/ewIYvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396582; c=relaxed/simple;
	bh=QJrJtIHq5MgqYP90HGhYDY8VuDfeMAoXcaiZ1h3hsOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi5qrkfTrQESM8vxOdNZJgdTDLTbM4tpMzicttzqjpzuR4JLVEHduONw/S2NAc8pEUdHh5I0NMRu9TjhW4gOIHoen6AMq5x6cJ/0ZqOd4SODRtyrIY8pHX+SxnrsfqCd2+0RUjGsJ2KSMTSlWt6Sgg0dN3yKi+Dw5QjqhD+f3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YrldGmle; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YrldGmle"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264aefc3b5so2794445ad.0
        for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744396580; x=1745001380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf4U/s3nrzYWQj940TchtZxgSy/bJE6FrQcB/mDG+go=;
        b=YrldGmleywo/aSmNHSe/KL0KrjO+r+54Q/lONP+7al1OAy3Mf9gdnBjJPGsM28z2l0
         eQiumFe9W+bZPJZBfqfC8AEmUVZK8s8kk57pPXKRrKzx/hmHATTw86wUb2QrPSJcoDHN
         F2XnKcRHFMeg0p+0OH1vdm3RuFE24hL9oE8S+SGuD6GP8aeQExYqaLyhL0Fdb+EHLaOa
         IwlEvapofwr+ksO5MAiKPWRgvPDutTrspfpESfvzv1IsNPP/Nn9Trt40HZJ3ckGPCB6V
         47tkDv1B6ooyPzV00eHonFjtF16lPUwn8fdjW13ruIGvWzNWPqDxLRdn3KwoVjRM3RG2
         ZAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744396580; x=1745001380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf4U/s3nrzYWQj940TchtZxgSy/bJE6FrQcB/mDG+go=;
        b=Bm/k3S0buGtVxXOVp7eBiCKQ8pTjXa7nRjJsLTMfQnzbqxC9dvqd7rvBT4uXcym3CY
         SqnQ3zp4CXFE1T9pY1b9+k6zdIYYe3GNjI8FBwLjEzVDA0oyDyA/Ab3mXWmzL/bfLGvm
         7XY0fF/tBVNUTTa351dwGgjOtr3tqgob/YLQMiJ9pBH0jN+QZksrkUTuI8REJwHn9rbO
         r6Yfi0kGhtbJKRgF4Qe9veCvCIf26XM0uss/cXQtLGW90ge/ZcSb0plfOMPW8bh6DI/x
         zCHOwjA9Xc1S8jV+YZioAsuX90Qk01LF/Q1vl6maWn3ki5V9NW2xGeWGziy5ZQoeLIjj
         nf5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCaLdWO4siWTfiXInJQcYRwynwhfT9HIukliv+K+oh1EFit/YB+CD3w6G46riV0J2J2ddGeMY7vFssgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjY2SaCRWmzf73uVtpcRZta/fcbYM68QVY1olbynN0JWsCQYI
	CWqaQf8ohHonX453GV0Vkwa9qqyMcjhd3ySwF1dZJL49YwZXgYa1G0nyUleogZoq0z564kaov30
	e9+EVuDcGJWscWV2yqUIWhGZ3JxTmK0BpUhcEnfxFw61ZPL0Hqo0=
X-Gm-Gg: ASbGncusGFszC+asF+jzWxFaujTB8uZeGZcYhzrrH6joh+r1lwXOZciiCqNutwbZTuQ
	xXltfp7jrTsB0RVtEXXk+ZvZuyo0ml4JrxY8NcpNXIC0lMKiH9ZkYiqYQzaldWZxKYjIM4kAU9K
	YCYARkKr08//NxjjwN2Nlol7QaMP47SHk=
X-Google-Smtp-Source: AGHT+IG3/t9DcvV7/nV+zi+y2xeV+055KSQcHp97R2aOD6RcEBSVyNJvLjVkxXItYXUgJ7YQzx3wzUDbt6HDkGWjzec=
X-Received: by 2002:a17:902:f684:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-22bea4a1d32mr19857785ad.1.1744396579809; Fri, 11 Apr 2025
 11:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024955.3626275-1-csander@purestorage.com>
 <Z_eOX-8QHxsq21Rz@infradead.org> <a76ac487-564e-4b6e-89fb-9c848a398c43@kernel.dk>
In-Reply-To: <a76ac487-564e-4b6e-89fb-9c848a398c43@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Apr 2025 11:36:08 -0700
X-Gm-Features: ATxdqUGbj0ogZUsZOWd3AucjbewLfXyhpCwyAno3yxHM2NIkhvx7JebiSC7_ePE
Message-ID: <CADUfDZruQch9Nd9dQ2tNzFUFMPmqTrVvKK_uHrwEQ1+4oL6YZw@mail.gmail.com>
Subject: Re: [PATCH] ublk: skip blk_mq_tag_to_rq() bounds check
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:13=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/10/25 3:24 AM, Christoph Hellwig wrote:
> > On Tue, Apr 08, 2025 at 08:49:54PM -0600, Caleb Sander Mateos wrote:
> >> The ublk driver calls blk_mq_tag_to_rq() in several places.
> >> blk_mq_tag_to_rq() tolerates an invalid tag for the tagset, checking i=
t
> >> against the number of tags and returning NULL if it is out of bounds.
> >> But all the calls from the ublk driver have already verified the tag
> >> against the ublk queue's queue depth. In ublk_commit_completion(),
> >> ublk_handle_need_get_data(), and case UBLK_IO_COMMIT_AND_FETCH_REQ, th=
e
> >> tag has already been checked in __ublk_ch_uring_cmd(). In
> >> ublk_abort_queue(), the loop bounds the tag by the queue depth. In
> >> __ublk_check_and_get_req(), the tag has already been checked in
> >> __ublk_ch_uring_cmd(), in the case of ublk_register_io_buf(), or in
> >> ublk_check_and_get_req().
> >>
> >> So just index the tagset's rqs array directly in the ublk driver.
> >> Convert the tags to unsigned, as blk_mq_tag_to_rq() does.
> >
> > Poking directly into block layer internals feels like a really bad
> > idea.  If this is important enough we'll need a non-checking helper
> > in the core code, but as with all these kinds of micro-optimizations
> > it better have a really good justification.
>
> FWIW, I agree, and I also have a hard time imagining this making much of
> a measurable difference. Caleb, was this based "well this seems
> pointless" or was it something you noticed in profiling/testing?

That's true, the nr_tags check doesn't show up super prominently in a
CPU profile. The atomic reference counting in
__ublk_check_and_get_req() or ublk_commit_completion() is
significantly more expensive. Still, it seems like unnecessary work.
nr_tags is in a different cache line from rqs, so there is the
potential for a cache miss. And the prefetch() is another unnecessary
cache miss in the cases where ublk doesn't access any of struct
request's fields.
I am happy to add a "blk_mq_tag_to_rq_unchecked()" helper to avoid
accessing the blk-mq internals.

Best,
Caleb
