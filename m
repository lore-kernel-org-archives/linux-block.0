Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090692;
	b=guBl4dFOyNowkIonK+UY0ZyVTIhu6XIaBsYa714avd3zwVzqBX/bIhagXjsejPRbq6KN
	 Bzc5MU2N9jgfVfdWihAWb/2iAORAau1e4ly9noSCmo6zFAIXZKabXkama1KfzlnwsY7g+
	 s0fMHf1R8uSKyssnNOiEp0m0HxLcpzIAWQy7G0ULU1vOgk8qdxQpNNA39sdwlZ/kKvx2s
	 EnkD+feLUmOMKXYC0cpLXItLEUZ4vLEn0lHFX6QL1oYDTrX/aP9rMz1yg1N5uqR01FhX2
	 5hMdVwAnRuQcDfCYb8MxW6U6FqAwT+vTm9CRdtgKumekftEbIQOLSA7wk43UGhpnsyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090692;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
	b=kKuNL+8cRIoMCGCcUG+xxZLM0syH0qjhWFcea1oN5zij4DKBgRlPV0FBheMwO2Ewzp2O
	 QPsr62wc6TvnVb67AlapCKQK1JeC/ThbLF9oX/tgBi4wVZDg/qTMo/NB90fWR/MokmdA/
	 wlJbracaIDYmeWhsNmZA9xoCbfB2TOBpSXN11ACEpvlX2oPBhL/JMoAeFuu25MRlAGRBk
	 ygNYSnNA1LrH5OMEIslrbpJH80mFuIYBFdej6C4WduqgnNzv802xuPKGNuPYUizd2mMPt
	 u4pxiciJiGdlo5XV5lnIDhTFUyYed/F81NBa7FXBpyZaKMGdlnWsTu3gmEGCdjIkoUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVOWvP24;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=W8hMqnqB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4F606A330
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 12:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF4F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVOWvP24;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=W8hMqnqB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795090691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
	b=VVOWvP249gQbGhATtzKUMg0j6A/tChNgM6jO1Wzx/AIp5s1eeCFdIDmMi18SOLWYhJ7m9Q
	rNIwphULxYcsY2zcibeAN2PgqHM5Qtp28R//iOmuShffADY/CVLIqnSe3r7UUPwPkLmGtC
	V+TK597djrbR/oLLHzUarUCTnIB8KPE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-YljNHHNdOPmDI3wGUORYIw-1; Thu, 19 Nov 2026 12:18:09 +0000
X-MC-Unique: YljNHHNdOPmDI3wGUORYIw-1
X-Mimecast-MFC-AGG-ID: YljNHHNdOPmDI3wGUORYIw_1795090689
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67dabc6d5dfso3334100d50.2
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 04:18:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795090689; cv=none;
        d=google.com; s=arc-20260327;
        b=OpjyDT8iTJmdxnOqOn3580EiQvCVg3t4+gP6qRVEKA/Nopi9cMXONiXKau+qWBk7Og
         6lZZ/lr6CZ2YFeEidTSAEt4yxHLY3Y1e3rKLr5ykyd9Q58TTEQvph13GNfu71qNCdhD+
         C1F9MW9BCU8l2kANns6g0StdHjiGNnMZU9+SaVsPY4yypPtF6tkn8kmTbDhr04QHIq/P
         vZvZtcxIieb3Gad5+XuodLMTEgecBRkfKKhmg27gjDHDuv8L8hG9pg+LNg/gn0y5YQVz
         tbOW7NBd8SLtxo4tmfuzC9Q8DnYKZQuTwNE9gnUuS05+K3azb2lFiWKlA23yerGSiQGI
         qv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
        fh=vRtdZOBvDh12IiXUKtpzIIFn5OK9vnc0Uc1/zpdxGSI=;
        b=JEYe9wDhKjmKW5SKSojdhQleTKP2xKJnF7gHrLawqPTkGJlw6CFmbUF42IUxM8cKDA
         aDybCVQO6AUNVJGUFknNXp+uNuF9YTBSEM2kSA9Tq6HTPJPBgWOz8GFxl21qrrW678oR
         TLUJFB5M1zReiTmViv/JF9f60cCiJ0n2zQngGli+IInoSYN0xkSm2v5gvidT8+UXNZPa
         Vq8vHS4USZt/gxhNIEz/sksMohcbMFerDDSZ+bBsmuqEO6A/Soh97G2XUFo0VXpYexqo
         WW6glnSce5mKk0lM3RGXvcoVX9E0svQC4KScH62aqoLTwFrMT2V4m3E9v2qauUIVE16K
         r6SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795090689; x=1795695489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
        b=W8hMqnqBRGair6EoKrRvZxO77dqdj+YfYgkTq7D/3LAyjuaoOoDi6CBjJj2/uTyIN/
         fDpxDop4wdBIhC4E/qClwWzfxDsRKlC+fQO3UGaRGo+wxRGTZreAoLQjwFDN+CvKuSdK
         Xfn4nra5rpcDvAioHGKENKEPM3Q9kGHAhtzrGoyfmonoJyWGpgd9XJyQO6Ah/a7T2Ppn
         zsB9YEoDNUbUZ+k9HrlxOWcwAWQDOlDoV3XTlJHvYLtC3OS9sGUDCz3KiS2aQ5OT+IOK
         ip3K9h84fcgxMAozSavkACkeLTUU+AZnecsWcPbDZVD/GsrbNUaLtT+6HgqlfHiMchXd
         tWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090689; x=1795695489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqZVLpTgCP2ySw8awFBFsKWriU/az/ZtPImm1nmYhzQ=;
        b=fbwaXgntt1j+nuRzEN6iKi3X9DTPeQjCK6YYLkm2bDRj/XDGV7gR4Y7HKikA3Ra14x
         yeYWiPK1xIPDVPJYBOulVmVwQOctal0k6DnACiR0OALsniI65CdGQoZJzVWlhxO48ofS
         XcnA0azyyKmSgJ7JXa/fVDoQ+Fbr8IbwMkIvVKHPlBQEmrnYl63+LiYXXr0ekvgVxsaC
         zeW7hu3vhZ+oIWHpZBZgtzWg9hu6xSR24sIXD3RGv7yeWJ24jybbAdPwLITcy92ALOK9
         uGt2lgCCex3rqh11fDhG/5SejghRkcq9BuQry0TKkRLfgOQ+AXhs+OUiqLU/Um1tQYYp
         HVYQ==
X-Forwarded-Encrypted: i=1; AL+hErGE2iDR/Y11evbVDUqYmZD11xJaSwCGlqNJn9LhHQRrXQTVCqb4sIXF/SOA2C/skuWVQaZhXQOSn1EatQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9dQsuabkAAX3DH1o/o5OrYm5hpkmRYu/GRGdd3+u+rRjJcycD7
	+V52yNI5JAvaT8iOURQighv8mdCNoKUmGiw6ZESN8WvIuClCz/MvSpuHuQ0XqvcmL1kkYiPWqvt
	wtc/69aIF1xquvbjaU2faOEZOj/mkF4sNM97pd811pivWT3m+X4a9XLBkbTTeG3egW3LisuJ9Ae
	mzHTYicULgw/tGXgkNL+rjOUcbagbaUSNWMZQXiYs3qI/HM6CRmpwI
X-Gm-Gg: AZFdTZcWGGur8kgU9d9/NwuoK/FcgirWCivFY1vkKtuZ/cVOOIj93070yoXBzmzNv91
	e7omqXouNSbC7GPm73rfHVC3d+LWK5Qugdl6rXW0B5Kk3QdQqHRQZQb9cFktQLNNgnD9PCVu+Fp
	pF4Zbf2V0fczPTWCtDNTCKSal41Euno20RWS1TauZJhg8dvUTSUjDyfFLtyJE9NkUmo7jib/wGt
	rPy6Q7iO5xPvY/OJN/g3pMYFS9ml6Zsd7n7pAD0PKmKKw==
X-Received: by 2002:a05:690e:806:10b0:67d:a6fb:ceaa with SMTP id 956f58d0204a3-67dd3f193f3mr1716883d50.19.1795090688853;
        Thu, 19 Nov 2026 04:18:08 -0800 (PST)
X-Received: by 2002:a05:690e:806:10b0:67d:a6fb:ceaa with SMTP id
 956f58d0204a3-67dd3f193f3mr1716866d50.19.1795090688232; Thu, 19 Nov 2026
 04:18:08 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-19-jack@suse.cz>
 <CAHc6FU7NoZua98SGP9Kuga58gAcco6X__u=kOPfsUqbefAKLFQ@mail.gmail.com> <wo5723b7wrmu35q5qffzs7zzqwnojk3ireel2jkit2kxgv6bra@yd3gbigdmmdk>
In-Reply-To: <wo5723b7wrmu35q5qffzs7zzqwnojk3ireel2jkit2kxgv6bra@yd3gbigdmmdk>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 13:17:57 +0100
X-Gm-Features: AclHuK-GbM7XVFxqU3dJAQePNml2N4MUSkkmDt3mktzVCdVYt3Td22WOXOu6yXM
Message-ID: <CAHc6FU5HY9x5ntTOz_xk36T0XTzjNc8R4jy2zzpQKo=19HNMog@mail.gmail.com>
Subject: Re: [PATCH 06/13] gfs2: Avoid racy dirtiness check in gfs2_fsync()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 1:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Thu 19-11-26 00:35:42, Andreas Gruenbacher wrote:
> > On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > Check for I_DIRTY_PAGES state in gfs2_fsync() is racy because
> > > __writeback_single_inode() unconditionally clears the flag and
> > > reinstates it only later based on PAGECACHE_TAG_DIRTY tag. If
> > > gfs2_fsync() unlocked read of i_state hits in between, it will not se=
e
> > > I_DIRTY_PAGES although there may be dirty folios in the mapping. Chec=
k
> > > for PAGECACHE_TAG_DIRTY instead and use inode_is_dirty() helper for
> > > inode metadata dirtiness check.
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> ...
> > > @@ -760,12 +760,8 @@ static int gfs2_fsync(struct file *file, loff_t =
start, loff_t end,
> > >                         return ret1;
> > >         }
> > >
> > > -       if (!gfs2_is_jdata(ip))
> > > -               sync_state &=3D ~I_DIRTY_PAGES;
> > > -       if (datasync)
> > > -               sync_state &=3D ~I_DIRTY_SYNC;
> > > -
> > > -       if (sync_state) {
> > > +       if (inode_is_dirty(inode, datasync) ||
> > > +           (gfs2_is_jdata(ip) && dirty_data)) {
> >
> > this adds back the I_DIRTY_TIME check explicitly removed in commit:
> >
> > 3aac630b5ce1 ("gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()")
> >
> > Could you please clarify what's going on?
>
> I wonder how you remember this after five years :). Anyway, the truth is =
I
> forgot fsync path is calling sync_lazytime() as well before calling into
> ->fsync and even if I remembered that, then it would be fragile for the
> helper to rely on that (and there are already users of inode_is_dirty() a=
nd
> inode_or_mapping_dirty() which want it). So to summarize you are correct
> that the added I_DIRTY_TIME check is unnecessary for gfs2_fsync() as it
> should never trigger just for that but it is also harmless and the helper
> is more robust that way.

Alright. Could you please include that in the commit message?

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

