Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B730BF79
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594444; cv=none; b=LnE1hT607sUoVD6cgE3kzTiZTN4bNRp81patMdEZbOaJzdfTc1zN0xtoOhdJ+l4eqjw4AjSCu6Zt9fdBvtTobenhzxCzgnZV+Hl9kM03HzOgBpQphgMC/aV8IGz/IT0cZEY/Qtrt7O18g7lHdMHbxDm1lIdCuCHeuxlrMsu/0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594444; c=relaxed/simple;
	bh=4TpthFrcKq6ssOYA3fnVs/rr4i9ZL1kaJQAKh2YWwDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgD4NBqiw1TYnA5HTubRVrlCz8+6q3w34M0u+2yduSAWe/TMMaOhxJUMi3v5nvACyQlOpRTGjG6ldx+Rkh+76lypCOpGCXw0JT+1kRBG8y9vbgYz+Rk2O5+TNCChwymC5DTBZBhaAmlhum+iqpavr6BUh58D7YxN3ld1RBPFiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBr20oRY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q6z6KB5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBr20oRY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q6z6KB5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764594442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlTMWc0lSWfMGmCtqVPNzCqix8+u3BGSjIjRHo6O3xM=;
	b=CBr20oRY+tNjxRo/z6bv/WkhgaOeH6+0TfhPJomhehVgK13ZNI2aYHNXHk468voXINBWWT
	fasySjf2lEC0hdXB/9kIPlXUnJ+TRvukN2zk2S0V1GdreLncnJositih6FY/Us5rRHAuAD
	9zkDtow72wuWQlnddM8lAOlkE/14rio=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-YQgCcIehN3yLbTl4srzFIQ-1; Mon, 01 Dec 2025 08:07:20 -0500
X-MC-Unique: YQgCcIehN3yLbTl4srzFIQ-1
X-Mimecast-MFC-AGG-ID: YQgCcIehN3yLbTl4srzFIQ_1764594440
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297fbfb4e53so62790005ad.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 05:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764594440; x=1765199240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlTMWc0lSWfMGmCtqVPNzCqix8+u3BGSjIjRHo6O3xM=;
        b=q6z6KB5Q2pkNxnSVcX5Dcz+/a0lrjkJaup+E3vpT2ihLZG839LlVyj1v92tns+5B0H
         WDUPi5kHwoj3j/9GVKMlKkqc57LcBfAPkW8NmpSI+fyJZB227Ok1MB62zSPn4GMxpVRv
         c/poUuLXQArlVUHquOAHZ7F3LcsHc44fO6C5ZhATXNL60fgZmxIi00fUXIe0jyDP1wBZ
         T2gz+6xkLVkoSlo+mh3RDmQ/0QGFSZRA78JiefocwOOe+tN6pkC0T9a500ziLd8JVZIc
         9paaiRQL96mHi8G8UIrXqQOzdCmLgZts3u6IexyMQUC9kcZRm8XXCoTZbqtjXTb7gXxE
         1pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764594440; x=1765199240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlTMWc0lSWfMGmCtqVPNzCqix8+u3BGSjIjRHo6O3xM=;
        b=Ra9NBoEEg6JjP52A/sSjI6zJoiBM+dTSC85FNbiN3IeVXl5P49k9ns/KDYXwBxLChl
         HjwAZJrNLepZIWDIuxuwh4M0VpxWu3+B3D3+bb4eSFhkftgGbJNHPArMBj7eJ977ysmv
         ERa0i4BfOf2ehNsxCyeoS6+FxRgqep/8Zu97pKfp9fqGWOobPsyAkGsGHzuPtHjdDiq/
         I+lNiDVL9Qc1ElSyVUVXVApLrKjlkTN123p2aCuxSZD3qe0FO+LZqQQpkAuO+mcWPBdI
         atBnBj3xZy1lUy7d8Q4A23PV5JhEfztmViunJCk7xbl61XrMcH5+Y/I05XQRE34Iq7r+
         SOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBvTjbrRaW7PmBUE6KqVRorS68wUNPdD1aTXOnZZRamYQkGSfY7vmLsTL9X2bqEek1G4PH1ff8/Ufr9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57A6HYj8c3y8JFmZoIC/f10UHct+/mqmLZTQvVKB+SFJmI42H
	5O5bxT6yMdKX8+mgYyxaH+sD5/+yUk6OXhtg8jJIRQ1EE8KM/XXKRGJ91qb1uv8Z88sN6P85N3T
	BcPT5eijMJDh9fZX3JOLiUCYFbz0gDExHNRw53tSW/mNYi7qEYkusa/sKrjT8y1NUfrMYT1v2JI
	RtqYo9GCAo/FUnJKeUK2TOjdJVAI3r7+tfoLK/heI=
X-Gm-Gg: ASbGncuKqrQWR8rS/33alxf1rWfwNNMymm9AuQzqjHTyoowdfRTyCy0Q7jkSmOhNdAg
	7dc682SviZBV10M1uDALaTklP7J5FXIE+cp5uqtMIq2YuftfXm6/szKTOh8XrzCFMoEu0rkBAu2
	RP0SNXYJB38h9ZDJ/+ukTFiRt9bUxv6L5GlfwK2k1clgYVePOokK6xduexYnjVy+XB
X-Received: by 2002:a17:902:db04:b0:276:d3e:6844 with SMTP id d9443c01a7336-29bab14895amr290317335ad.33.1764594439635;
        Mon, 01 Dec 2025 05:07:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa3nN9mzQFXbbhuJZF5DMZDjfRKoqVAVxxR4e8RxhJk8lGIkCDoTseNfIANRkctGS0AfRNFxOhkbyBQ98AXfI=
X-Received: by 2002:a17:902:db04:b0:276:d3e:6844 with SMTP id
 d9443c01a7336-29bab14895amr290316815ad.33.1764594439085; Mon, 01 Dec 2025
 05:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201090442.2707362-1-zhangshida@kylinos.cn>
 <20251201090442.2707362-4-zhangshida@kylinos.cn> <CAHc6FU4o8Wv+6TQti4NZJRUQpGF9RWqiN9fO6j55p4xgysM_3g@mail.gmail.com>
 <aS17LOwklgbzNhJY@infradead.org>
In-Reply-To: <aS17LOwklgbzNhJY@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 1 Dec 2025 14:07:07 +0100
X-Gm-Features: AWmQ_blxY-wED26_5AK29jUVQ-pdlYqyUIwkotkgWe89NafMExamU2oKPFJsVP8
Message-ID: <CAHc6FU7k7vH5bJaM6Hk6rej77t4xijBESDeThdDe1yCOqogjtA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: Christoph Hellwig <hch@infradead.org>
Cc: zhangshida <starzhangzsd@gmail.com>, Johannes.Thumshirn@wdc.com, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 12:25=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Mon, Dec 01, 2025 at 11:22:32AM +0100, Andreas Gruenbacher wrote:
> > > -       if (bio->bi_status && !parent->bi_status)
> > > -               parent->bi_status =3D bio->bi_status;
> > > +       if (bio->bi_status)
> > > +               cmpxchg(&parent->bi_status, 0, bio->bi_status);
> >
> > Hmm. I don't think cmpxchg() actually is of any value here: for all
> > the chained bios, bi_status is initialized to 0, and it is only set
> > again (to a non-0 value) when a failure occurs. When there are
> > multiple failures, we only need to make sure that one of those
> > failures is eventually reported, but for that, a simple assignment is
> > enough here.
>
> A simple assignment doesn't guarantee atomicy.

Well, we've already discussed that bi_status is a single byte and so
tearing won't be an issue. Otherwise, WRITE_ONCE() would still be
enough here.

>  It also overrides earlier with later status codes, which might not be de=
sirable.

In an A -> B bio chain, we have two competing bi_status writers:

  (1) when the A fails, B->bi_status will be updated using cmpxchg(),
  (2) when B fails, bi_status will be assigned a non-0 value.

In that scenario, B failures will always win over A failures.

In addition, when we have an A -> B -> C bio chain, we still won't get
"first failure wins" semantics because a failure of A will only be
propagated to C once B completes as well. To "fix" that, we'd have to
"chain" all bios to the same parent instead. But I don't think any of
that is really needed.

Andreas

