Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF9226165
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123225; cv=none; b=Msq63p++xr6YseqrTnJNMOvKx2L4HRj9m7YJLSXaS+d56LiOaDdZxFiUTxP1+8b1KT0ZSQDvQ7gTUY7ZJzlOIb7dUx6qJRismz4/f+6HJZSaunDxDlV/QCBnI5Kemo08+NKJp6Us0vjfq6/VutluBImR3xGO7BxpHpPmEmYWtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123225; c=relaxed/simple;
	bh=eaKF3+iwje++PxkLmHGfLcnZ2dLjEPxqiYq20JrteMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoROxNEx0efHhXiiCgP1oPCYuGOalWbAGWqjfEBmmP2qecEZfYmWrHo/Bl+Y6LZK4ev9t3uau/rAxgr/NfSLtcUdpy+lzKI68f6+NwDlVu3Nvl+9Ji/5PW5qF6TKD0czTQfKbpMSSdrSU0NWgfPf0cyN+kfhTEbxrsG4dkPffIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BBHc5wXr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BBHc5wXr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so5854802f8f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770123223; x=1770728023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaKF3+iwje++PxkLmHGfLcnZ2dLjEPxqiYq20JrteMU=;
        b=BBHc5wXrzI77HugTckS0smYf++iTZPOtrSxd1O0Zud3cJA2r6no0S9HSULF660oYyG
         H+iA4AYSX8h8tu3KSzN5sUWzdNNWSGqU3ZHyBbgPVsrfpUfMjhCKN8YMNDalCQcfitOR
         e0PPWCfDKPL59klWknazAX6fixwGs+hdnwvQrbAU62y8pdWVbLaCkb75423lu8HvBX1N
         SC7q0StqznmIZTqmrPZIJ4GjL9lpi0e4ZSDmm045NlBI0WFRjbO7rOkBwMkhU/o8tJ5Y
         G1nf2QpxY21YZ8KU0KruBSha7EY9dyIrC0jw37wth5nzK+353LYxV2km0TblhE66I5Xf
         jC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123223; x=1770728023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaKF3+iwje++PxkLmHGfLcnZ2dLjEPxqiYq20JrteMU=;
        b=Wn1InecYRE0EF7kiRP6Xt3BT/7FUrffboh/bG2p2mijvGGxG2y6CX75PXCtsd8nlHA
         8H3bhtuamVntO+9iD6yWVlFFB0sdjQ4kn9APnVXFB5rNrXMeGiSiaXtOrmSILTGWyWAw
         9DyBbNG6EWBvbTDIbG0NFDhS9IWkwbs+J9ZACefPbFdpbVQO4xlhl5vm1Ox6FenUXgHh
         PGQtOnBWSGWvLhqbgBm5v+6uat0eTERAQuDobnzUsiOq/au92dPYU9bHUGac2IWrzkxm
         aAld86aX3lX2X0g5gW6Xt0tSEUf0oZymHGLOD7QCMPSRJ1WtDuKttR2BvOK7V6e2CHGo
         hcZg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+lFEHIs7blRzVctKRMroNL4IpXjL9w1m+i2GP7WIHRNx3PO1dwoz+2J3FcZiJPBOfAyvCcMMGqvqpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BBYWfpYgAhlkzPgMhKosMg5r0pCPATJ7i76bUTRsvGGqgFwY
	4wucgHTJA5oZEFPVuRA/Hx8eBpTxhkbB0Wyl6jTBRvtvOvQLZxCqOIpkmxjqdnx/Dv4=
X-Gm-Gg: AZuq6aKnge+DSqN/0AEKnR2PnYpJ4mwk9vb1PQNfm9c9imyoS/tHFP/EJdUND2l9wYS
	ddndBXa9RzhKFI964SAIWI2IjBX6EQbTQ84SVDSUdXFpx/ZuokjSUk8auP6nNWbTHvjX6nTgNTS
	J/vmGjvmhEVH/YSqGNJErBFT0pTgP/NLLCa45cCMBjFA9OGdNa/qLU7KjebZzD+OhOdEDSnMUSd
	nDNxwBWDY5U3LCqcnifAKcsTqkGiEJohUen6+7bKtf2snvqOP9xv/DPkZ0nBJoVp/zVipyI66Ty
	uGV/YH8HllqktLG0hml17iWnjfrxvtjDlYb1QjxF8HrpktV7OAGNqCpUB8+ve8NKFTfSldOBM0Y
	7XjoPx+qAgZdB4eZ44dO5+NdIkXK/5U5FI3ekKEmkailLScOqyZug95rqbhnffqGEflfbar5Hdg
	6N3ucDn++Jb5UBY0m++6CdrWbIcOS/+GC2RSkahn70HA==
X-Received: by 2002:a05:6000:2008:b0:430:fa58:a03d with SMTP id ffacd0b85a97d-435f3ad87b4mr22479946f8f.63.1770123222670;
        Tue, 03 Feb 2026 04:53:42 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf4asm52836675f8f.28.2026.02.03.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:53:42 -0800 (PST)
Date: Tue, 3 Feb 2026 13:53:40 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, 
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ebaw6z25hlofpdyb"
Content-Disposition: inline
In-Reply-To: <aYHXzyRJbzFSohNm@fedora>


--ebaw6z25hlofpdyb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 07:11:11PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> RCU supports this way, here is just 2-stage RCU chain, and everything
> is deterministic.

The time when RCU callback runs is noisy, moreover when chained after
each other.
(I don't mean it doesn't work but it's debugging/testing nuisance. And
it also looks awkward.)

> I thought about this way, but ->lqueued is lockless, and in theory the `blkg_iostat_set`
> can be added again after WRITE_ONCE(bisc->lqueued, false) happens, so this way looks
> fragile.

Right, I brushed up on the cycles from the commit 20cb1c2fb7568
("blk-cgroup: Flush stats before releasing blkcg_gq") and it'd be a step
back.

Does anything prevent doing the each-cpu flush in blkg_release() (before
__blkg_release())?

Regards,
Michal

--ebaw6z25hlofpdyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYHvzxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhLNgD+Jo7Zrh2P2G7VGLqyly8P
XTVQkInFUVhIXBJcbQ/2lisA/1YN137HA3xAXvFsClkiW7neHkMtJTthP9N0mKp+
WlQK
=goom
-----END PGP SIGNATURE-----

--ebaw6z25hlofpdyb--
