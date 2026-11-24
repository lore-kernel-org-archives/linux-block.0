Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795562209;
	b=cBTYqIu4iUfK1BEfodtZwNVEp9KC3CxtBUUiinny9/XIPSgmg4EOpeCLOteLuaonn8Fo
	 hKohbY8E7GRf1EtSjPIzGOLCiJGSRiPnrGxj0knWl5RMBwR1IHq6FblQBLvCjadEp0yNh
	 m8ZepAGdlt7AhcgC0f/HLUXkUR8h+McTp9qS4aCilcTDrFMxN7YOOHZH9g8+p9rZwpIDM
	 7Zak0+W6akJLjx0mB9HQkKCvEqGDtJ1/Z4nsEG9B9W1aMmWMx+EinfH1q/hLs12fThaiF
	 ROWCs5emwJMGXWiLH5MwANAWHZPyVWlP9e4He47xatFVgIu4q557VdgQWM/vXs/36Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZoFyEnud89IUcB6sarqMzo8JRRy8dWijZef5NdeWRGU=;
	b=E5TN7EJeziPi2kaOL0mlkF+b7sTPZpCHQy9UYeCc3/5oZgzmObjh/Q/FvNH6t12jg0kc
	 Ma7EtJTLni5jX7nXbTPNECqrshtTjTgR1JvwM4uOrNjhpSPeO9GYCPLbS7unMRc/zeosH
	 psweHNYQ1sJ6uLzSUNjtmJJ3criICGkI2TSe0o/r578B/SMDmuf/7/bLE4L0UMWqFrgP/
	 Jy5aqPkFgsaqHI065GU6BDaffjPQwJyDeQFzWg1L5Fsmhh0Pcgpy+uefhBgQmlVCpkNst
	 rwc8+xgFx1vZI3SAWniZbdswb60OD5hA6vCOSyBi+MbIUVcOUck94WdHU3CWDdLSbwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTeDWynZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9A606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 23:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FC9A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTeDWynZ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491846221ffso4346917f8f.3
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 15:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795562207; cv=none;
        d=google.com; s=arc-20260327;
        b=Sn3aYN8mL1ngbeBQbhRFHQltkVS8qf8uf7vi7Ayeox5M1AnHwpYB3gmk/p7Ns1Np3C
         mmJZhkZeB8nsLQlvq8uvKUasMQgwoHAD0rXNpmSpvZe/LuQyN0lbQvEI+yP14if0F7Wj
         faid8towoKZq5KRT/f1KjzdJHfrEdElFag98V4Fn+wmzyl2BBFKmJB97gn1e0mUuEoJ0
         gw2Dh1ll2xrdhMiUSZNUtgjqtELg034fDYLNcX4Y/f0nII7SsXaO7K3Z7C7faM58nFM6
         Y9u48Z6ZBgXf6bwA/V6IBTgIVjR7mseyTsNPFjiafs3qd5VVuP70DoQAeiPudAXwjWRS
         aWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZoFyEnud89IUcB6sarqMzo8JRRy8dWijZef5NdeWRGU=;
        fh=rYie2Ik09Rnpjx5ZiKAz2tU1HAHSZ7sLu0z4bHkWYf8=;
        b=al5YA6H/RRh5ej5ZxCTDMudYmoWmdiQtiqSBu+anznNaL/0soKE8BNdbmLV97C+X6B
         cHdPcZA1mwcJQ45aIpiRrNYmUyX346ssYtybrYUpkrqj3pzAsK9HHq3AzMhIrEQiihHI
         o3UrWAviRjlgr65RGGsNJvwu7o1SlvoKv7bj3htS7+pWWwb3UysNtSvMWC5mLTcQQ62b
         fQFPw1pVRIQXlKw8tmIvuLiKjUXHUDPaSXnU6FN4FnejZazH/gYIBzqyeQFkvDAx55V3
         PRjDIO7p5G420jr43yAD5rw+UMkzeefhXRkecquRYrGfsTh1vZQ13/aGEz26Ris43uRz
         OZKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795562207; x=1796167007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZoFyEnud89IUcB6sarqMzo8JRRy8dWijZef5NdeWRGU=;
        b=jTeDWynZO3vHIqs2S2mBHa2gfaQygVXW8WCpN3BC3BNkQhL1zK3M4r1dq7ew6LnH8u
         4uFz90Y6pY4MEFd1w3n/bj0+LeDZl/wmm5tB9VsPIR8v4bd82NQbYoXglCtdLsWaTG8z
         P01vZ5ffmDgw0P/rdva2bS7RTOcZCHm3qnAw8YC5BZn3rf8fCemRb98hovE+UrSmL6pB
         tQ0EL7D9z5lAA1Gcgt2H+ElGKRVtVefcYcPXFXbdL4MF/yVs7CTY9nXo0YMGTsLhsR2o
         4fcXxWP6DODx7NVZ9zaKQsVDCltulVr5TPGRZpgN1vCzEAX9UPT+/EJxDWlBA5Y9leUB
         BB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795562207; x=1796167007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoFyEnud89IUcB6sarqMzo8JRRy8dWijZef5NdeWRGU=;
        b=1qkgqbvxUuH25PXCHxr7FC58E2OC4hTs21YYw6TQqOvUsiogXYMhGgP/WxOSDc7d02
         MaLaSHNTfQezWouiphGAKvjfnwgiaitt4s+LkfXfyB/dRlP1T4FVVyNTOTLBEZyApAXI
         jundZjLTcAQi310yap17Jo60fWz3QO0tOdkBAjhFXi8QzniggNbPWwJsWHujj8WugrnS
         E7sLMXhY3uGdhP2xNsbsDPcYhds51UHDWBpblxYNoq8PyZzf3u2T9dmO8uN3VDbhFlXj
         aVH9GPDbWtoLSr+Gum3OTSr0XSi8U1xWKNY+Q1l411dEvuh8Z4aVRAwiyRc1MOwRi6fd
         JggQ==
X-Forwarded-Encrypted: i=1; AL+hErFz4j0Nw7EnLvirmY05wvZVLou1/37vflfSyrZEMaMKN8QX2dVaujB6IcMtFEiSGuT7vQ33UR0QLVaItQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pWUtXukBDGUxWviYg00Ptos2gUtKv5hzdIyiFZXs81xJplgVJ
	aPavkfw8PTS1hxHD7sZb2rJqgvMePptLuE5xqCEhdyj5/7WeXmPgxgttOa+eotir6raALiF8zat
	asP54dWh0cAvVn+QSS+Lo/x4oYHscywc=
X-Gm-Gg: AZFdTZc5WTYYAe6oagh6fjJ2QFE7Y+wpAKcRcHPO40VzOQQ+8XAnWPVC1/EJYPUUfng
	ZqvcPTG7yphfqupT3t4tIlNKAwJxDKUSKJlGDld52bURI+gknDDlY5t7zUz/AjM1rZZKoU2xysb
	2eLdrMboJiRMUe9lHO3UZ/LcU53jxwgDl/0J13OWkAXZS3q8SF/qslt6b7Twk4lv8oBJrUDF2/A
	IkxaXThNYya8pwrtb5gGyXCRpb2Qqh6DJGgx8lVFlWE9yRyviRzz8xcnT+reLT6fToYi97ZQ3hR
	lHK1ct7qsohEyVfpKIYNiDUwuBjRlrlbGtDNmYEsindn8g48jcj746okU4a6yb5uXdZicB55Nb5
	P5WH3b5PX40X609qT3WdXq2732K/qElkuAeISmpYZA7TtcnGDqLqqDy5M8Zy3NJ/sAFDXOq/Qkl
	vzte4yx8gwyfug0LEv2HlU+CM+9uv8QHbuUBUj3l7enY/kwXy83EuE
X-Received: by 2002:a05:6000:290b:b0:4b7:8363:682 with SMTP id
 ffacd0b85a97d-4b7836306d3mr6416284f8f.16.1795562206537; Tue, 24 Nov 2026
 15:16:46 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
In-Reply-To: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Nov 2026 16:16:34 -0700
X-Gm-Features: Aa3M54rNAfJPEtIYBNS8z0FncYPJyb1XKCgONajpLzKwfERL2NRMGTo5_-rczOI
Message-ID: <CAKEwX=MJJVBfdE+LL-j+jwfkNP=OHaV21XLJxEOBv4XwsBLiiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zsmalloc: free a zspage's pages in one batch
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry@kernel.org>, 
	Hongfeng Chen <hongfengchen@xiaomi.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 10:36=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> __free_frozen_pages() and dec_zone_page_state() take about 22% of the
> profile [1].
>
> Collect the pages of a multi-page zspage in a folio_batch and free
> them with folios_put(), which takes the pcp lock once per run of
> same-zone pages, and update NR_ZSPAGES once per such run as well
> A zspage never has more pages than a folio_batch holds.
>
> Single-page zspages, incompressible or power of 2 size classes, use
> the current inline path.  There is nothing to batch there, and
> folio_batch is not free, hence the batch path lives in its own
> noinline function.
>
> munmap() test:
>                     next-20261119      v7.4-rc3
>   256 MiB           -2.0% .. -4.1%     -4.4%
>   1 GiB             -2.8% .. -4.4%     -3.8%
>
> [1] https://lore.kernel.org/20261109105957.2577351-1-chenhongfeng0212@gma=
il.com
>
> Reported-by: Hongfeng Chen <hongfengchen@xiaomi.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

That's nice!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

[...]

> ---
> +       zpdesc =3D get_first_zpdesc(zspage);
> +       if (get_next_zpdesc(zpdesc)) {
> +               free_page_chain(zpdesc);
> +       } else {
> +               /* Single-page zspage, e.g. a huge object: nothing to bat=
ch */

I wonder if it's worth keeping the old logic for incompressible case.

>                 VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpd=
esc));
> -               next =3D get_next_zpdesc(zpdesc);
>                 reset_zpdesc(zpdesc);
>                 zpdesc_unlock(zpdesc);
>                 zpdesc_dec_zone_page_state(zpdesc);
>                 zpdesc_put(zpdesc);
> -               zpdesc =3D next;
> -       } while (zpdesc !=3D NULL);
> +       }
