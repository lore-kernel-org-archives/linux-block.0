Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795047920;
	b=dYtq0hh+qhE06wQfrB8Xmxl0b0OdDas5awti7/sTArMMfdDgVXWIJXRiYt47CvkUpNRQ
	 +vIOOlGiUPLGWkgawyzNftD2On53igXhGXm1jY4akTce6AGlkFzElzGw3gEnSmJawspWp
	 +VDanIo8H2e4BMJWC1Ehsst2DcssOqiO4fGCZ4IwecgaiiCyeGXjp/fLVs1CoYT92IJ/6
	 ZTJ6EojqqVrS2Xc9OrHu9Unhrn1BjFuTgrU2kybQu8IRtXm4l4eNSkI0q0sPuB5qhkWLB
	 vNXwFlgeRNHyruQxP5C0jH2hKUsDEWq0H5KeLdeQQMq2Ply58FAU7K/DYafnHytKPXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047920;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
	b=4SWiRquWFNH5O1M95Jj1oouG/RTL6rZlJS69ZSpd9uIt20j9SYJrUmj+uhHpW1HeLsPa
	 V10q5NJUrKuzdGCz9kWYMkEOz+FCqf4iWfrlfe+Z/lfU4kn9zZUtT4tYs6giAiWWbrFJ5
	 J+nVD0z4CURLzb678NUbZvg02BPMKCVUfJ7+nvloyhJtlBvk9uODMTaF64LrZbVejACDB
	 019kTmRZmTSXUO2eyzvuZLqJwLdSt2PGs1D8+HQy8PXwa8xa7cnr2B+VOq5nE5EC4Hsn/
	 htIYdNW2lbdi1Y2Tjla6Ipsab7yEDVGsdtTpQj80tHYU0COTHU5dyttrOCdqRnph0Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=figiuMqN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jLmZwlYf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541E606A32A
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 00:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5541E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=figiuMqN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jLmZwlYf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795047919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
	b=figiuMqNPSbJSC+rppKYW73jTrxg0F5RFlFTF8isncIxQMPE1WxN7Bn1FHZTvLkpofJq4d
	7m420J1xkEdKbn3Rcx5/MaC0RJqvUstWY08DU3pgmjHol80seQFiw6J/Lwkk9/s2t1SRbD
	9rIFexGnSFloom9KDpPKlHqDR/WtULw=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-cBQYt2FtMxaXp0MtaDvdXA-1; Wed, 18 Nov 2026 19:25:18 -0500
X-MC-Unique: cBQYt2FtMxaXp0MtaDvdXA-1
X-Mimecast-MFC-AGG-ID: cBQYt2FtMxaXp0MtaDvdXA_1795047918
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-679f81d5d7bso2448695d50.2
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795047918; cv=none;
        d=google.com; s=arc-20260327;
        b=KRWbMGkAc97J38bqmpwGGxOxtKQdtb/T4FgDF9/i4IXHpHVPVGnRTtYTT5UNcuPSAA
         l4m7FFbKWgYQvnFFOLJDma/jgPuWg5wFRaLeR/izrLzE3TDPHL6i17VyPW5HnTmsfaOd
         camZPiHyFA8hbxOCNBRPbufTO/gojorpV4wksPeZNpuC7iKuzdBZuhzHVJ2Xpl1Tvin/
         aM4Igg8CyeCzCatCV/SpStPNZWBr3sfeFD5cnD/Zr/hmfTSTDGfNNU+/XPsrLjdaIqup
         zcDkIygWZvYDLFtLp6UDMkiXUzbRr2/FV8iDQURp48NTeeZ0kh26JvC4cc4CRUDZxX1C
         lcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        fh=hC+KVd48YJoMwj+YI4+0sUMR37hAKwY30PZ9rwoqRbQ=;
        b=XZO6VUFwASMB3GFAtcue6SrXNjqZUmB2LJZkr/MTOs3CySxrwsPmldgGK6aOosZ00z
         j3FsJATNkQNTHd53S7vsmGZZxFXXlG9uuYsitxAwS7UMri9deLmk7RDpNm4TMo8IidJ1
         qlI3qofjBaB13hwBRQpwPXO/+UWKgBdB4SdU9g0nbnVW2x9Wl1//pdwn4yg1zM2AfSB7
         20fuNiro4bIcpsoWKEe5rviXeDjDyH1AYyjbk1CkREM+H8SocQvRYwJ1X7q3uR7wg9op
         Q+11OyPAmDw1dN2fXd7rAr5zBf4VJsa6/6aFiVYADDPFtYllNakjvzhnYMSGkp7PaD32
         SXyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795047918; x=1795652718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        b=jLmZwlYfC08YZsE7NZqnzqtNRb9j7+aWTCuWxNICrjRgOyTFNw2qopsnuLRIKtubge
         SyXrPiBDCQfpf0LFFRnDSd+DIvFVRdzG2YRu9TCqUWK5sNv7Z1Uqn0gq8SiaOlKPnhfx
         uwT+RdU4FB8YJp4P2wKoF5+dFY9U5Fp4TdN7E6eBfBuG3jnkqe/LADQMCJ9ORFvAB5YH
         dUxaSUkERdpNg7dEcsiG+UJAFXBupr+caaYglv/xdghZxNuB2GxSqwwO+wbPY1eT9tFr
         3kDm+8le+U/HRrD6tSfDTtROC6jjC/U8tYVoT22aRwCOZWnqBE4ln02mMJtObVuxWXDr
         lllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047918; x=1795652718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        b=sv6vIxyVxqOJnq6+1dyzaaiFsDji6CIRYYOsTHAuTGMErqJ82iVoyHkO0glLClsrUE
         Wek0FA6ZTY0KOsIFoxaormEJv8Bt3s1eA6c0qcS6jYdMgXvoI0ypyXTw5xVCtulWDQiJ
         cKHkCL1sS3sorXz56lHFp0/8FOEQV3g4WSoR8MjAqLbEQze+TcfmjLHGuRClUiGsiu6x
         mJ5L3+m5FXo8dO34Vzv51P+RiiNpJd9uiI9KSOkhQ2EVYsStomddZc0iuy16Z/kn9JrQ
         Xn0pDWKq4FVDDmjDU0Xf3/7ydme4YevTjxV3VKDo6pvOzRiOoWOLoOpauNyo+OCPQ+lv
         R9hw==
X-Forwarded-Encrypted: i=1; AL+hErHGD37++eoh8J8L+fGHSwPh7xShED1+AiQRiI2GXW1RCFDrs4tsS7SW6/MKLMF8Tz9WY5OWiUOgJyTaeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rnbkb3Qmz2uQbnU4yPLxNG1Xijt9EMJm7E1PBNfuI8FwO2419
	pjdRlbrsocQlk17AedyRvsl97GwOm8hBKM/aqIfp0IfjHbcxv6H0Y1sxYqzlG8w6GRd95GkEXuL
	mX8HjrMuOfpXKUyHcBlDG1BmFK6moo1lsKLX74CUM9IfRQEey68A5xV5umLhrtkIKZo/TRvKfu8
	6cRtHzKeIfiG+9RXNUv9EG7aysll/hvhatGURuQlw=
X-Gm-Gg: AZFdTZdtkMsQhGI/nmxvGjzd1b/f1St1jDdiibKvlqNxoJ70GfCgyj0nD09hKfdU+ib
	7D8Rkn8GqWgTv2N+bK/4iRa1fKaI+rKivdPMQvGLTsZl9rtZxy8s65oxPhdHTeMu3U9/TLkdGQ2
	gumjE5K/7cuLApiqoe/5EpObSCrUA81dy2RjNQdGENcMiliCNr+HtJYSVBYEaAYeexRFV/0cRbk
	ANfTTA6x2/6XJE4PsewiISWWjejjERyt2v54Jvp7qJQUg==
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id 956f58d0204a3-67dd3f89d1amr1300404d50.81.1795047917499;
        Wed, 18 Nov 2026 16:25:17 -0800 (PST)
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id
 956f58d0204a3-67dd3f89d1amr1300383d50.81.1795047916923; Wed, 18 Nov 2026
 16:25:16 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-21-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-21-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 01:25:06 +0100
X-Gm-Features: AclHuK8SUbQZgISlLcenRaPXTNhazVJfuhMt4GCT6fjiABD73HgWRuB83sKw5Dc
Message-ID: <CAHc6FU7qgJ1R-bz2icUyQTQFs7_mKt=tat-ut66K-cgn-uet3Q@mail.gmail.com>
Subject: Re: [PATCH 08/13] fs: Provide inode_or_folios_dirty() helper
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

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Provide a helper function checking whether inode itself or some of its
> folios are dirty. We'll use it in filesystems instead of direct i_state
> checks. Note that this check returns true also if only timestamps are
> dirty when lazytime is enabled.

This is confusing. Can we just say this here?

"Also returns true when only the timestamps are dirty."

> This is what users really want.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/fs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 025f5d890689..f602deacf953 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2228,6 +2228,13 @@ static inline bool inode_is_dirty(struct inode *in=
ode, bool datasync)
>         return inode_state_read_once(inode) & mask;
>  }
>
> +/* Check whether anything in the inode itself or its folios need writing=
 */
> +static inline bool inode_or_folios_dirty(struct inode *inode)
> +{
> +       return inode_state_read_once(inode) & I_DIRTY_ALL ||
> +               mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY);
> +}
> +
>  static inline void set_inode_metadata_writeback(struct inode *inode)
>  {
>         spin_lock(&inode->i_lock);
> --
> 2.53.0
>

Thanks,
Andreas

