Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E03074AA
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841026; cv=none; b=hJGaFBOmwab2yh2HoA8uIolueVNhQd3+Ld8shgZxMIRosQmsMYYGc2MBBd44j/LO2OUUXwQgN5bR9IeKMWIx6Xv9TyRZmyDhJBCHHEWoJIXfklkmPXg7YN83nHerGyZ9n1hn/SVdaZs/w8dYtEc/T/wGMHhUDGNfXrMH85rzvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841026; c=relaxed/simple;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiAIEeDtLv8e6DbYXmeS+Nhc/mUmrm0i3rYCAZzH/YiL0PCdY4W0+yiyIybK72qn7pnkGjyF/xFXJKJMtu8mJvnFjTgVw014oW4uKNP4mzRZU+ETC0r94jAIwu8+EaIInAiYQDZ0wpijlKKGs9lsjTfs9cTRIvTkWv5ojms+a/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9Xg1hNG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rVIhqCbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Xg1hNG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rVIhqCbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764841022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	b=J9Xg1hNGgKJjP88Sx51OE4X/POL66noCRL4TOp8zfyt5r0S87yaYlEsZaFCXTn9d7HEudu
	p8V4h9zn+z9NvP99nwlzGjXejKldzFPtjXX2tCy+iphrOE7Zc2jFmAdt6NTxqCTzWi98m1
	cxkdLKadocpvq6QoQCkjbLAyCawE5kU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-CvhB9-EDOEu0TVhKa73VJg-1; Thu, 04 Dec 2025 04:37:01 -0500
X-MC-Unique: CvhB9-EDOEu0TVhKa73VJg-1
X-Mimecast-MFC-AGG-ID: CvhB9-EDOEu0TVhKa73VJg_1764841021
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78a82709389so11098937b3.0
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764841021; x=1765445821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
        b=rVIhqCbYJIshhr1SDoAzl0uxJ3l2OknzAacF5X1A0A8YSzt91sa5gVt2s2Kp2sWJB9
         Hgli5ZUl4CsxXmvL9tdbhsJry4TaLBE1C++twE7VZYk7+QzPkxNO4ooZGrS+nj2wZSDL
         6meyQgb+gtMBIucQ2xdOnMJ7o7G85PNDylK1hou7CxAjlvuRKlt3ve4UZRm9l73ZKBPR
         nf2rxHGK+5fX7U4j75tPudKUs2dYi0ismLtiSgvMKI6Zjz1HWz9U7HIQHsH49JpJEvC2
         GIdg/XBoZgwdsvkaWHa4+lJkRE3yiX1xY3S4HnujXpX6oHd441uW6MMSzVaiXCXoC4mh
         tYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841021; x=1765445821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
        b=BC7v9p4V2IHUldQFaysl1hye/MtazD/iN3MyXUZOrR6sk3u3HEpN5y3mtD1UG1BnoP
         TqYoJ9mjTKXQNJqVEsqvumjHp0bnjRMdoidl5nNWDXptH6/v+8Yoy8SnY1fKmoZx5G7L
         kHG1DkIFgHi808fRkXsZ9zW63AfreUe4mVdqF45njZUvKQ2lW6mvsdLf5BnW60deszb/
         INauey8r/RlO2L8tFa2JDZFnwUEDvxXwAmYf8fxsbdbyHSy2rI88GR5tnVmoRGjqlYPc
         OODeK5DDbFOYS6fSbcPPR0VLYkOF3XOSCHlc7W2MX+1Bn0Wjy8TZn8hFxyhpNf7EGBKX
         p/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKIEwR27j9c1AJYW8INcIbLTMmcBrFvMAreB+8HyTPnf4FfkoNT3M/STaOEMVepseCAiSw2FuRNSklNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YynVZ1IE2BquVagHk+Q0J66t8SPcwo08tdHBLkqRWjoFlxWcOnc
	yvZ8+ukZZ+J3ZkrxNe6QgNFr3EcjzSk0O4sbFwlmY4uoBE965jqqofhYpPH767IJpKRDBzT9cUO
	97ToW5f4dgzvaEsId0ZPtSb6jjS0ITglYMHPoY4dki5dgqhlspwS9cn3v4DfdzlrZbaUTaFwsy9
	cQHqmeLmpuz8PVCTwceMTaCaM7nymCEwRXN7xB5Og=
X-Gm-Gg: ASbGncuWyu7gJd8o9MekP4h3xb5rusVe9FUpWSXpphkvy5drrz/9PjAtfwmyWxOb3Wl
	pAdM6fk7tlCFrL1IL04rF3pg2oB5xLBApjWCOQt63R2OqUhndBc/aHOFhR3WVQC+orT+IXWE5P0
	TkXwhugDtfIo3eO+HD/TaezOtbRIPx7uNlOK3oUOnGE2igkr4N4u13ukA6eVAN0mi7
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id 00721157ae682-78c0c210028mr42666157b3.67.1764841021009;
        Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBJRkWOGl554rCJxMS1W+VD+59CzpNDKchBFktxp0UKkP2qgdZoPND338wG5ha+uJ8PPPkfv0dwHOd25ifO9U=
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id
 00721157ae682-78c0c210028mr42666067b3.67.1764841020714; Thu, 04 Dec 2025
 01:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
In-Reply-To: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 4 Dec 2025 10:36:49 +0100
X-Gm-Features: AWmQ_blRRqbIFTY0f39yIA51TqtDoPBldWIhSqZwhzNWbMT5aHjbQPCsAOYEw2M
Message-ID: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail=
.com> wrote:
> > This one should also be dropped because the 'prev' and 'new' are in
> > the wrong order.
>
> Ouch. Thanks for pointing this out.

Linus has merged the fix for this bug now, so this patch can be
updated / re-added.

Thanks,
Andreas

