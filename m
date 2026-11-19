Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795047181;
	b=pvdeNz66KRcXvcsuhat7Z8jDMj1JNxHNvGm2wbxDKd9gQy4YSyYxGCtGlTIf7sjWGgEf
	 dtTWzXk4InzsaOHxfmufcwUK5x2btvfuem5tKMW0Djkve/IKHWQ3SxJ7FiEMxw5JJvhNG
	 02SKEeTmjYB8LLR13IH03AnC5kR5d2siwsqW+fn7aMp5bQPEmo44i20KHfJG6qAXaKdTu
	 /n6/EKNUmmSnTAs2yF/3QGV3bjMxENLcAbuvnvYdVsHBfR2S3D+gaqW2CtvKumIzPWuhC
	 YItSi3F89fHYX7ozrpj/ZItBdclG7xoyIdE2stxk0fcIqAnwcQiZkh+kwqrr1C3ojhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047181;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
	b=gBJ/3TitYSQQLsGcxiAr/coJs8Ph5nYW2wtQdyO/G5Yzpx8/SQyPDerBsZrJ0LIi4+Fj
	 vfCQd8sCWzz+EFBP16+R43qORrleNfjfa8Z2mVUcAAUz4AW8KdzeJ2KWobr6OJAH86dLf
	 1XAb7LN6PteZY7wxNkQ5Z5IvzlMrbl/FHfXjuExMQ4xYygRu+U3+08VciFhxvqRFwQSJQ
	 ewwc7ji4K+HuytxP70LkMf4j/qCIef+Ok9Dm65xx7feTpMSIpL6RzTmQMczrdSDCqUnWj
	 XzZiCGOdLKUjVc9/4q3dPCv8fp+LfEaI0ct8rIMVc0PIs6LCJeJCvejtq6sjv4ujFqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkK0PJGZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gUck6dLA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195E606A331
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 00:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D195E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DkK0PJGZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gUck6dLA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795047180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
	b=DkK0PJGZuU6xjETr8IRYKlcNarjz50cFTcBVw20h8LQ8DbaJqNlOkLygouqeiVQ6f9BAMj
	hlYkXzCB5swKDdnXWJS9JX5e2ITrFTcvHgf++ruGyd2Z7eCOMQtCTwwievMnz3V803ec/q
	h8sgZGiWP9NInZCCic8F2tddi1D6QTY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-SbkTtexXM1q9XXlSTlfvMQ-1; Wed, 18 Nov 2026 19:12:58 -0500
X-MC-Unique: SbkTtexXM1q9XXlSTlfvMQ-1
X-Mimecast-MFC-AGG-ID: SbkTtexXM1q9XXlSTlfvMQ_1795047178
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67bdee091feso1967624d50.3
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:12:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795047178; cv=none;
        d=google.com; s=arc-20260327;
        b=W80VUG1SNYejRTQP9PWn/bODKaorwMH+EmwZJJJ+kIJOKVOVr1BeLmNYHCJk82W5PC
         2qr05juricqAvRtvvb0GPr1Rcg+2Ng+lHtEkAdMCSeHTazkGHspaNCGCkq7e2V4LGFKd
         TMms+yoz88YIuwlodc1L8SFQpjbfJ0DJw0di+AJtHvWUjcbcPJW3YZ5CIHl9tieR+oA4
         d4ZYMGgL/2l24M/Dkv9od8jIoFCt3cJxs/qGA0yRBYosq5PaZupgNFdjUpUBj2/RuT4f
         cuZb2GU3fp39DDHFjd70K5c6Cw6r0qt9JeNYTCoAfMxb5ounKFrLUYPC7kE0G7Aymdk5
         OLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        fh=SVHsJug6tbZBlgDMysSuEIiPYOnOwwhT6igF3u9vXm4=;
        b=HBVEmVNLx96hvBdb+6qrhDmAq6PWw0pKdTndiMxtex+Y9DNZPRDtoJcPoNv0GZESVg
         Wf88iTjYgjSVa5klJWz5A66TrGrOGDJiFmEtCdjNwAGb98RxlEbtaWh830Utjp+EeCsd
         5cp6+I9fXqbABzCek7i/uKbsseAPykfJ+utKUxMd2Y5bW/PoOe6RGNttA2ho+pj31Ivs
         456R/4BY2wVsGZpv2zfPMAOK9QzUk4ILtRabu2CcKQ4emlselaDSUW+k5mQ2ydDc5u0M
         38G+F8mnf6NvgGCECYntqDjvHaEtZYY5CI4eVbC/NQ9A4WxzL0Pq4vSiirRrbNp364Wa
         DyFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795047178; x=1795651978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        b=gUck6dLAwdhYR60Buifwx95UYkvNlKNRmPnyo7USrjas+FkHH6q0XlA8zMbJUAOSEc
         4esQdx6pFabYHTtqUnRAbnqHQA+DgcA1v9Z8q382bLMxM7p546hudO1FBCaRByt15IEm
         /5vyT5BVDmw2cAmmuJOGyhMjBm6Z38q8chTcv+ssHh/G49YDGn4gHaXvGAwNX+jSP5Bt
         Y6dNlXK3huhbk8odG0lKZoxQMQgtT0ra6l6EpuazzBV6saVVp3imwrgtOTJyno51uUmc
         6zZmOUm07V1gdA8XhQX9VKm6Mrqa2q5yZBP+0CYfzheFkQJZm4upXymWAt8SIYWCbdr8
         DWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047178; x=1795651978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        b=zSu5Tj7Dl4+smuiX+rjF0aD8km28/mGmK3U3BuJs7EX2zESKD7uKU/10gAAO9bOm+4
         MFN6Fo2se68pk2rX7Qe2u9bL5KZOh5s3fdtrh4/hc33AI4GDeU380RG+fW+34CMcPAkm
         iWQrzCQFeYNLdc7sg9r1knxEhn0/6wHeuN08jEFfuEXoe8aVJDXlScmYqVl/8DtMJXYQ
         QClDI3UW5pOVTHIQVXlz7vQVvmlnQILGoRthdSAT4YS64zzLi0UyIVkJ3OJD3sKah3LY
         Y48Y+7kCFs2DIWGEeJdsqwpON+qKZJ3g8dlRpI+MazA2Nwlje908T8zHPLiubtWdEd8m
         4rJg==
X-Forwarded-Encrypted: i=1; AL+hErESjCrcFI/9IJMoet/AdQLM63o1rC9eVm+Qf/Iv+v/hi0nFGC6yTZ3j60B4gXqP+mbJX3Jt7XX/MeFwXA==@vger.kernel.org
X-Gm-Message-State: APuU4Z85/3iu4N+vOu5VeW2zhrNbcDr+MrI+QUoZ05V3tRMq/+mZyZX3
	OQ853COF2xTxkVhwvZZm/xpdQ+WVq8iWv2UavefKpsfnkeSppcp5kPzOergK0pRljJt62Dnpxxm
	zSttGIR1YMs0E70WQGl4nMlthP7jWy/q5rKyC8TJ6vYCFOkxwimPobWn5goPBRkLpid5rc4pBtp
	6eO6MBH6s196TwsPyiQPxklTg8FjZStSzuf0q/J9c=
X-Gm-Gg: AZFdTZefRA98twrE0swAewrFvBTKd/ovmOwxhI8mRnGaW/w2wmIRXHXQj4pq/kn5Ts8
	73rgRjvufTJFdW/v5Z0JLLmEN5GDA4OkIpUSIFZfnujR0+Zr8gAe86fV5esZ1sEGfPnUyIkrQ5W
	ci4Obg3TQjJvnsD536IF8SxhsGrLVIdvzPRQOLALcJdxCFa0J5f5Z/6YYgGZ8yGicmPJjZkqdRu
	fuYx+dPRkYyMRj4AxhcmM5SRLaxKr0/Qu6P5xW/bQ+rag==
X-Received: by 2002:a05:690e:1907:b0:67d:b34c:9f19 with SMTP id 956f58d0204a3-67dd3fdcc80mr1565912d50.106.1795047177770;
        Wed, 18 Nov 2026 16:12:57 -0800 (PST)
X-Received: by 2002:a05:690e:1907:b0:67d:b34c:9f19 with SMTP id
 956f58d0204a3-67dd3fdcc80mr1565894d50.106.1795047177150; Wed, 18 Nov 2026
 16:12:57 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-22-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-22-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 01:12:45 +0100
X-Gm-Features: AclHuK8R-2iEv0c9btS3snfH7Yzq75Yl9vf1mN1FPuSVCWTRM2Ut7aYcwFy-L9Y
Message-ID: <CAHc6FU4+FV=A2UK1oPejHSt5XQ2Ox+CyvZfT4Q17YaceJ+NJ1w@mail.gmail.com>
Subject: Re: [PATCH 09/13] gfs2: Fix dirtiness checks in gfs2_write_inode()
 and evict_linked_inode()
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

Ja,


thanks for catching this.

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> The checks are bogus because they check against inode->i_flags instead
> of inode->i_state. Use the inode_or_folios_dirty() helper which actually
> checks what was intended.
>
> Fixes: 957a7acd46e6 ("gfs2: Remove inode from ordered write list in gfs2_=
write_inode()")
> Fixes: bd67f17718cc ("gfs2: Fix data loss during inode evict")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 04bb4cf787d4..9b723dd591a5 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -460,7 +460,7 @@ static int gfs2_write_inode(struct inode *inode, stru=
ct writeback_control *wbc)
>                 mark_inode_dirty_sync(inode);
>         else {
>                 spin_lock(&inode->i_lock);
> -               if (!(inode->i_flags & I_DIRTY))
> +               if (!inode_or_folios_dirty(inode))
>                         gfs2_ordered_del_inode(ip);
>                 spin_unlock(&inode->i_lock);
>         }
> @@ -1418,7 +1418,8 @@ static int evict_linked_inode(struct inode *inode, =
struct gfs2_holder *gh)
>         struct address_space *metamapping =3D gfs2_glock2aspace(gl);
>         int ret;
>
> -       if (!(test_bit(GLF_DIRTY, &gl->gl_flags) || inode->i_flags & I_DI=
RTY))
> +       if (!(test_bit(GLF_DIRTY, &gl->gl_flags) ||
> +             inode_or_folios_dirty(inode)))
>                 goto clean;
>
>         /* The inode glock must be held exclusively and be instantiated. =
*/
> --
> 2.53.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Andreas

