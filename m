Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA51A9F99;
	Tue, 12 Aug 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984266; cv=none; b=RhJyDE5aNDZRmHPAlhFKXZt9zNKk/tagDPWxMkq8t1Xj40Qr/LQEnWRd32YnoH3sBpA8I5Mjcd25I98dyemNTk8cSTzgzuq37TEePvRQr3hlZrSUxbeeujgbuVM7Z6g5N6qT5keuqfe8Y+m6Rf96NM9ymxdN227WCL/+c0wDYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984266; c=relaxed/simple;
	bh=YF2BOgtvsRz+yT+YAwLFEroi8NzBJol25StSpW8uatM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axeL+tspsNUCfNNdSWbyRjBjye+BtAay5Eyt282pUM71zDzVC7gNMAdCuQThgKHjYaiz95DofS1FlnOllSbMGBwhRhXRh4OE3nzKDjVdQyO8ewpvKktWe75sTSLnonw9hIAE5xx9YzwRjAtvCdUJjqkHqRgv9ouB1VlgrbxCc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=R2AMMGg3; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="R2AMMGg3"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 89CA1635B040;
	Tue, 12 Aug 2025 09:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1754984254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ko8fbK5GyQxFcouQBC+uaA5wBDCuoavWYQ2EzMwpjWI=;
	b=R2AMMGg3UcI+D1Q0kO3yhjRvyygTC1w++Aaq90YxKJqFZseG8At7rRfbGdaSW+zLfWooYT
	tJKBdsrKFfPWu+xWmebP5lZPTbF89Ein4L0rHp6/4CcTq97EWKMpcB5DpT6hZaO7HLbolf
	oMhtdV2QQXFYdZIbIqWZmydi3U/+cRE=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: David Rientjes <rientjes@google.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject:
 Re: [REGRESSION][BISECTED] Unexpected OOM instead of reclaiming inactive file
 pages
Date: Tue, 12 Aug 2025 09:37:22 +0200
Message-ID: <3553647.iZASKD2KPV@natalenko.name>
In-Reply-To: <33b6c9a3-3165-4ce8-9667-afdbaff2c3ae@kernel.org>
References:
 <5905724.LvFx2qVVIh@natalenko.name> <15056829.uLZWGnKmhe@natalenko.name>
 <33b6c9a3-3165-4ce8-9667-afdbaff2c3ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3246356.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3246356.PYKUYFuaPT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 12 Aug 2025 09:37:22 +0200
Message-ID: <3553647.iZASKD2KPV@natalenko.name>
In-Reply-To: <33b6c9a3-3165-4ce8-9667-afdbaff2c3ae@kernel.org>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 12. srpna 2025 2:45:02, st=C5=99edoevropsk=C3=BD letn=C3=
=AD =C4=8Das Damien Le Moal wrote:
> On 8/12/25 5:42 AM, Oleksandr Natalenko wrote:
> > On pond=C4=9Bl=C3=AD 11. srpna 2025 18:06:16, st=C5=99edoevropsk=C3=BD =
letn=C3=AD =C4=8Das David Rientjes wrote:
> >> On Mon, 11 Aug 2025, Oleksandr Natalenko wrote:
> >>> I'm fairly confident that the following commit
> >>>
> >>> 459779d04ae8d block: Improve read ahead size for rotational devices
> >>>
> >>> caused a regression in my test bench.
> >>>
> >>> I'm running v6.17-rc1 in a small QEMU VM with virtio-scsi disk. It ha=
s got 1 GiB of RAM, so I can saturate it easily causing reclaiming mechanis=
m to kick in.
> >>>
> >>> If MGLRU is enabled:
> >>>
> >>> $ echo 1000 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> >>>
> >>> then, once page cache builds up, an OOM happens without reclaiming in=
active file pages: [1]. Note that inactive_file:506952kB, I'd expect these =
to be reclaimed instead, like how it happens with v6.16.
> >>>
> >>> If MGLRU is disabled:
> >>>
> >>> $ echo 0 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> >>>
> >>> then OOM doesn't occur, and things seem to work as usual.
> >>>
> >>> If MGLRU is enabled, and 459779d04ae8d is reverted on top of v6.17-rc=
1, the OOM doesn't happen either.
> >>>
> >>> Could you please check this?
> >>>
> >>
> >> This looks to be an MGLRU policy decision rather than a readahead=20
> >> regression, correct?
> >>
> >> Mem-Info:
> >> active_anon:388 inactive_anon:5382 isolated_anon:0
> >>  active_file:9638 inactive_file:126738 isolated_file:0
> >>
> >> Setting min_ttl_ms to 1000 is preserving the working set and triggerin=
g=20
> >> the oom kill is the only alternative to free memory in that configurat=
ion. =20
> >> The oom kill is being triggered by kswapd for this purpose.
> >>
> >> So additional readahead would certainly increase that working set.  Th=
is=20
> >> looks working as intended.
> >=20
> > OK, this makes sense indeed, thanks for the explanation. But is inactiv=
e_file explosion expected and justified?
> >=20
> > Without revert:
> >=20
> > $ echo 3 | sudo tee /proc/sys/vm/drop_caches; free -m; sudo journalctl =
=2Dkb >/dev/null; free -m
> > 3
> >                total        used        free      shared  buff/cache   =
available
> > Mem:             690         179         536           3          57   =
      510
> > Swap:           1379          12        1367
> > /* OOM happens here */
> >                total        used        free      shared  buff/cache   =
available
> > Mem:             690         177          52           3         561   =
      513
> > Swap:           1379          17        1362=20
> >=20
> > With revert:
> >=20
> > $ echo 3 | sudo tee /proc/sys/vm/drop_caches; free -m; sudo journalctl =
=2Dkb >/dev/null; free -m
> > 3
> >                total        used        free      shared  buff/cache   =
available
> > Mem:             690         214         498           4          64   =
      476
> > Swap:           1379           0        1379
> > /* no OOM */
> >                total        used        free      shared  buff/cache   =
available
> > Mem:             690         209         462           4         119   =
      481
> > Swap:           1379           0        1379
> >=20
> > The journal folder size is:
> >=20
> > $ sudo du -hs /var/log/journal
> > 575M    /var/log/journal
> >=20
> > It looks like this readahead change causes far more data to be read tha=
n actually needed?
>=20
> For your drive as seen by the VM, what is the value of
> /sys/block/sdX/queue/optimal_io_size ?
>=20
> I guess it is "0", as I see on my VM.

Yes, it's 0.

> So before 459779d04ae8d, the block device read_ahead_kb was 128KB only, a=
nd
> 459779d04ae8d switched it to be 2 times the max_sectors_kb, so 8MB. This =
change
> significantly improves file buffered read performance on HDDs, and HDDs o=
nly.

Right, max_sectors_kb is 4096.

> This means that your VM device is probably being reported as a rotational=
 one
> (/sys/block/sdX/queue/rotational is 1), which is normal if you attached an
> actual HDD. If you are using a qcow2 image for that disk, then having
> rotational=3D=3D1 is questionable...

Yes, it's reported as rotational by default.

I've just set -device scsi-hd,drive=3Dhd1,rotation_rate=3D1 so that guest w=
ill see the drive as non-rotational from now on, which brings old behaviour=
 back.

> The other issue is the device driver for the device reporting 0 for the o=
ptimal
> IO size, which normally happens only for SATA drives. I see the same with
> virtio-scsi, which is also questionable given that the maximum IO size wi=
th it
> is fairly limited. So virtio-scsi may need some tweaking.
>=20
> The other thing to question, I think, is setting read_ahead_kb using the
> optimal_io_size limit (io_opt), which can be *very large*. For most SCSI
> devices, it is 16MB, so you will see a read_ahead_kb of 32 MB. But for SC=
SI
> devices, optimal_io_size indicates a *maximum* IO size beyond which perfo=
rmance
> may degrade. So using any value lower than this, but still reasonably lar=
ge,
> would be better in general I think. Note that lim->io_opt for RAID arrays
> actually indicates the stripe size, so generally a lot smaller than the
> component drives io_opt. And this use changes the meaning of that queue l=
imit,
> which makes things even more confusing and finding an adequate default ha=
rder.

Thank you for the explanation.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart3246356.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmia7zIACgkQil/iNcg8
M0tTChAAwRcANFL3mXoAdtvq28I6ZKLSmHdY2tZhwVBttLRFWCXreDnNiYJV/+GH
gIW7xVzpfYxVZ2jXjA+pNfEng7WrXYFQKrwXKdaexfUDS0/NS0uq8ICh9uCLb+Bp
00F4E8IOL/DkrzC/AfxuXYgDo9LsCIi0+8sPWkMAuYLCxCWL52cal3yVxCq6wtlY
JgxHcpxfC/zu6avLp0CrsPVxIYG2i5QV4F/9orZHUhIlitcjbvscsInu7KulDME5
DT2gm+bEKxIHCLxCzNMqGm4b1fd5OF0nFaNypnOUhy30qvLawTTqmxd/UUoHpW6p
BgViyIsGv4XukLKKJOKu3/A02rzT055QixDTXybSGDLowBD7Ia9tTV1+V4JrEuw9
M/+V1zqwqIoyhsIIiu6LaKANaMATCFVrd4wSN8TkXyMh/yZzHjYuJDkrKrVjQzbv
QO9qbhJ/CEyhU2bNIiAp/eITvI5Dr+S9Yj3uChZ0uJ0SYyYSF/YHq8fA8MsNwGBV
gu4OIzi815wN5k+WBxhq22DFPuoDBxFmnmw/mJCXln8UG0VRdJbFvKzj5mJsj7ZZ
VC1jpqT80ASM+2Cp7++uPK6rjOKr5wIYu1mxOYfyqCl3bXCd3CPQ3gHtZHi5EORn
XYG2Mf/twoUjnFOIMhMz5jL438qvyA2aOyvZziDrai+fWB5VvF0=
=58kA
-----END PGP SIGNATURE-----

--nextPart3246356.PYKUYFuaPT--



