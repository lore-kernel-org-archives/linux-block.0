Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795199371;
	b=f8psSOApheGBtG7/SWlfIwtf/nX+HI9B9/pmMYjH1+pehYUjiaTq0n+qLzdVM3fr6cAg
	 4PtGk7vFDDm+dgTyU187JVaaCPQYFQdmIbJ7Tx66pIrfLGDasSs3taoYosyjo0VoxGgKC
	 JjcNIfPpuVzqlMfQEoNSboc4sdDiZTel7goe9mH8M4zIY26liiLJcbdKaaBwoKcY3agOP
	 QimDxoOAwHTMxx4YO9V0oDmNGG9/Lu2bSZFF//EASPOs0NvmsMoj+UpPyAgBnxUt/nF3d
	 Xr1KREZEbPnp3g4GvF548A8rOS0/HvPQYW1FwQvciiImkwKJAvSDmGy7tI+fn91RCaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rgUMX9qHZUJbBmUpguL56XnLssX5w+QXcL03YNunXoQ=;
	b=VDo9/liDxzSxpBPEwEUUevvuTtBX4K7DwOn1ti5NfkPgtCyNZ//m/EzoQK3UVJNf/iTw
	 4ibWZO5wJptTPS0Tv8CJgJ9fqFtSXA39+rZcNqSQBa58R6s5dqY9z2dZ6wFo1ToG4ujVz
	 zrIuLT53e0NEJP45k+EigO8mp3FyWh6CTcEk8HN94S2XAZWWfsHetXlHeydUV7YFqX77r
	 /GYZgaEwGxUv+TgRGRfYNrPuT/+/G6uOQqpIxi5X/ZQvtqUZAZMplgIuY8wZemtCV+CMr
	 aEd3ZkIb9b7g0/wJrH4obr8KgneAPPPTfC+BWfRoGJ29mzH2obqN7HplLCAKZUYCoPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=EURERcJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCED606A32A
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 18:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BCED606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=EURERcJH
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6dd8e918218so48004eaf.1
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 10:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795199370; cv=none;
        d=google.com; s=arc-20260327;
        b=e1zZyY32CQYxWNYU8N+lKxi5+l94a/jWY9C3x0yNUmKLAhrFBaB+u2e031iDx/QKRa
         Gr4HtLYg+mVBWSy1h7IsF/7J96zuxqZ4FOyFJ8NeMmjxGXaByAla5mzsw0YLXXLjOk7R
         QWUwuCcigQ5a5kmZq3k7pdV/e+yW8E09p5H1Pmhjy7Y6pABacqZkkiKY/w88TDhQsQ8u
         4scbVfJCIhidj0TJO83EJOiCN0HvERGEqlmDdjvAjjJiQAeCNkFePQcAxIXA4BEsUnmt
         VWvJXQ9h4LndOuzNBEk7z6PU4sl/hmVUCccTws7gqSsz0zCNaGVxZonu39hlvoQ3LjrJ
         Gdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgUMX9qHZUJbBmUpguL56XnLssX5w+QXcL03YNunXoQ=;
        fh=oR7zkHOSnfRWVAUXqpolmEKTLdi+to2y+MuQzVtv7Qk=;
        b=Tk02uAlUQhzXah+t3QtzWKgDEhpMMeHQmi3dKBSn+iWg5QtAsbCobeif6l0tSxHTuu
         sUKde4huS23G1j+Wq6T+Km5At6bWYC9LS2WzDkH3A7s/eLzLs9j3+jMWQnTmR3A+WGEl
         c93h7R+DtSld9RbemDCrKkKdFTntJnnmOyO7hdYT2F7gQRmEASOCnDub6GJxFHjnWwg6
         avN1Q+FZ/uPdAx2SJXVdxhexbtsabQesanJlQLi2O0xjCH8O6a78BGzWajt5sBRqnylT
         3pMePfGnEIqWNDI0TPZa/ez4opz0rYTFn0sWHzFBEB7r+obLhDXcvaHXH1apepTHEHGi
         ISIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795199370; x=1795804170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgUMX9qHZUJbBmUpguL56XnLssX5w+QXcL03YNunXoQ=;
        b=EURERcJHBg/we6G4bCd9KT0WhwgCqkCqdasBxX1RwqaGtm2cTV8z2rS3D6RBus6cbf
         2drAznMT1+UywPsyrUg/PgNwnaHMYM7ooA4Ux30lxYwXp3BmZYM82xapVrnn25CRj6ZR
         vnh8DOUreOt2ltczLQp1DRj3Uy8s6ijcaOpN51zrZp0NUx1LSIhZkfZNl8gzND/Spo1T
         uH7Z0+fqMGnzvYbGylTnSSugza8bMEtSv+HIOD4m0rIu/dhY3R+W8fd/w5Tl7OQ6iecw
         NlpDGMYSkVOa01kd8jLggDMQvv1hScyPc6gpHqoII4vjxZsLWp+5zq9n1U8Hb+yFv7B6
         jpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199370; x=1795804170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgUMX9qHZUJbBmUpguL56XnLssX5w+QXcL03YNunXoQ=;
        b=NIvklysXcM7WP9hzQiaG2gDeOxDPvbhzzmrqQiVOFR43GTsC1nV6n/PKIn9nLlTxJo
         EAbrRYmCDYrdRb3G4Veht/xGt4nOG6D+bIg9SJkrvN6fmCJNU32/wXAj05nAc0yZTScm
         JJURVQ8P0EilzxZPRyi6azyKCs/BGhH68ryA7nDn2TXXGTVii5jPhutrqMFOc7IXHyX/
         LbhQ4SpyOnKBXGOaHdk37ksYQ7lMWwWnGMb6pmLrPo8ioFSa8KhUyCBE2tCSMLolUAhZ
         nQsBv9yaqMqgzYEvaR2+0/9+GaOz2Eg+aQj9JxqunWApU8DXhSrhqOtTez6s625Zv/7w
         1RmQ==
X-Forwarded-Encrypted: i=1; AL+hErEm4nBt8C/6i/Nh2h81aX37NCDCM2P3Y9EsyOh83X8C1bJ0JavK9lkyBYYYgQvxBCmMXUCIM2knCe27lw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8UFazrxNFzPslDBO9fxfIXOgvQCd53KnCGa+B8IT22LdAkV+B
	TSRUHrwk7ZyYRr/HEg+rPfv8opkB/K6OppmsmUu6ia7saUIAjd7pc5XvqSECM0wj8hylx2X7RR5
	gVH6/qmzgw8qYSW03cAxbOEFlCpfEPVyBkNAWYeRJDw==
X-Gm-Gg: AYBFou06wUa8T9j9MEkO4J49iuqVR6UIi2Ege2lxzUPjbwX9KHMkEQforTW07GmSke7
	Y6T+UyQWwngL24UekU6vXK38uwa+ajyxzrpyS5RatKIcQhQUMs6AFB2/C5mXuA0x4SVeGYGwSMn
	TkvTPlltWUt+nuxdLUY1r+PK4JUQfaSo3Qy8Lx2bxe7OeGIwcXwYKL0hJabkCM5cBBVBWK7hjI8
	FeZwZuGsdDjiWzJhWGD0qzYEb3wcT9AYPcq9rtK9030Fpm3P3AXsmV6bQwzSq0yRZ28H0pNG0IE
	ZBnxu4hMzJNSoC+wLUs0sT/Efi6G9C4UG+uJdVrfbe/F3kGwjoAEVdA0c3bmM9P3pIUiZLKyVff
	rEoNELZ041yd6tTJwKyiNZRxIO/cwev8l/lUz
X-Received: by 2002:a05:6820:c2c9:10b0:70c:bf79:3e6e with SMTP id
 006d021491bc7-71b39033ddbmr4203075eaf.0.1795199369899; Fri, 20 Nov 2026
 10:29:29 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120064806.752251-1-csander@purestorage.com> <awBuiVyOQj_YHCZD@infradead.org>
In-Reply-To: <awBuiVyOQj_YHCZD@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 10:29:18 -0800
X-Gm-Features: AclHuK-s6j1YsrlPtwSKf7apfEUcNespK_RTRNAYp4u75GuQefesSFhUkseeyTs
Message-ID: <CADUfDZonvcOkM7DD76Gg=Z6NHhM87a+n0xPirfTYS+wLLnHfmQ@mail.gmail.com>
Subject: Re: [PATCH] block/t10-pi: deduplicate blk_reftag_remap_{prepare,complete}()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 8:00=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Good idea.  But I think the new function name is a bit misleading and the
> double ternary operators on a single initialization line obfuscate the
> code compared to the old if/else.
>
> Can we do something like this instead?
>
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index a19b4e102a83..f24ededd70a8 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -436,69 +436,32 @@ static void blk_tuple_remap_end(union pi_tuple *tup=
le, void *ptuple,
>         bvec_iter_advance(bip->bip_vec, iter, len);
>  }
>
> -static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
> -                                 u64 ref_tag)
> +static void blk_set_ext_remap_ref(struct crc64_pi_tuple *pi, u64 from, u=
64 to)
>  {
>         u64 ref =3D get_unaligned_be48(&pi->ref_tag);
>
> -       if (ref =3D=3D lower_48_bits(ref_tag) && ref !=3D lower_48_bits(v=
irt))
> -               put_unaligned_be48(virt, pi->ref_tag);
> +       if (ref =3D=3D lower_48_bits(from) && ref !=3D lower_48_bits(to))
> +               put_unaligned_be48(to, pi->ref_tag);
>  }
>
> -static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
> -                                 u32 ref_tag)
> +static void blk_set_t10_remap_ref(struct t10_pi_tuple *pi, u32 from, u32=
 to)
>  {
>         u32 ref =3D get_unaligned_be32(&pi->ref_tag);
>
> -       if (ref =3D=3D ref_tag && ref !=3D virt)
> -               put_unaligned_be32(virt, &pi->ref_tag);
> +       if (ref =3D=3D from && ref !=3D to)
> +               put_unaligned_be32(to, &pi->ref_tag);
>  }
>
> -static void blk_reftag_remap_complete(struct blk_integrity *bi,
> -                                     union pi_tuple *tuple, u64 virt, u6=
4 ref)
> +static void blk_tuple_remap(struct blk_integrity *bi, union pi_tuple *tu=
ple,
> +                            u64 from, u64 to)
>  {
>         switch (bi->csum_type) {
>         case BLK_INTEGRITY_CSUM_CRC64:
> -               blk_set_ext_unmap_ref(&tuple->crc64_pi, virt, ref);
> +               blk_set_ext_remap_ref(&tuple->crc64_pi, from, to);
>                 break;
>         case BLK_INTEGRITY_CSUM_CRC:
>         case BLK_INTEGRITY_CSUM_IP:
> -               blk_set_t10_unmap_ref(&tuple->t10_pi, virt, ref);
> -               break;
> -       default:
> -               WARN_ON_ONCE(1);
> -               break;
> -       }
> -}
> -
> -static void blk_set_ext_map_ref(struct crc64_pi_tuple *pi, u64 virt,
> -                               u64 ref_tag)
> -{
> -       u64 ref =3D get_unaligned_be48(&pi->ref_tag);
> -
> -       if (ref =3D=3D lower_48_bits(virt) && ref !=3D ref_tag)
> -               put_unaligned_be48(ref_tag, pi->ref_tag);
> -}
> -
> -static void blk_set_t10_map_ref(struct t10_pi_tuple *pi, u32 virt, u32 r=
ef_tag)
> -{
> -       u32 ref =3D get_unaligned_be32(&pi->ref_tag);
> -
> -       if (ref =3D=3D virt && ref !=3D ref_tag)
> -               put_unaligned_be32(ref_tag, &pi->ref_tag);
> -}
> -
> -static void blk_reftag_remap_prepare(struct blk_integrity *bi,
> -                                    union pi_tuple *tuple,
> -                                    u64 virt, u64 ref)
> -{
> -       switch (bi->csum_type) {
> -       case BLK_INTEGRITY_CSUM_CRC64:
> -               blk_set_ext_map_ref(&tuple->crc64_pi, virt, ref);
> -               break;
> -       case BLK_INTEGRITY_CSUM_CRC:
> -       case BLK_INTEGRITY_CSUM_IP:
> -               blk_set_t10_map_ref(&tuple->t10_pi, virt, ref);
> +               blk_set_t10_remap_ref(&tuple->t10_pi, from, to);
>                 break;
>         default:
>                 WARN_ON_ONCE(1);
> @@ -524,9 +487,9 @@ static void __blk_reftag_remap(struct bio *bio, struc=
t blk_integrity *bi,
>                 ptuple =3D blk_tuple_remap_begin(&tuple, bi, bip, &iter);
>
>                 if (prep)
> -                       blk_reftag_remap_prepare(bi, ptuple, virt, *ref);
> +                       blk_tuple_remap(bi, ptuple, virt, *ref);
>                 else
> -                       blk_reftag_remap_complete(bi, ptuple, virt, *ref)=
;
> +                       blk_tuple_remap(bi, ptuple, *ref, virt);

Sure, happy to switch to an if statement instead of the ternaries to
initialize from and to. However, the code generation is worse with the
2 calls to blk_reftag_remap()/blk_tuple_remap(). The compiler doesn't
notice that the calls are identical except for the swapped arguments
and emits 2 out-of-line calls to the function instead of inlining it.

Best,
Caleb

>
>                 blk_tuple_remap_end(&tuple, ptuple, bi, bip, &iter);
>                 (*intervals)--;
> --
> 2.53.0
>
