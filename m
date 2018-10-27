Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: recent issues with heavy delete's causing soft lockups
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2800911.LnhMzhikfW@natasha>
Date: Sat, 27 Oct 2018 13:20:10 -0600
Cc: linux-block@vger.kernel.org
Message-Id: <BE7DD8B0-3D16-4AAC-9B49-E809EA30A0B6@kernel.dk>
References: <2800911.LnhMzhikfW@natasha>
To: Thomas Fjellstrom <thomas@fjellstrom.ca>
List-ID: <linux-block@vger.kernel.org>

On Oct 27, 2018, at 12:40 PM, Thomas Fjellstrom <thomas@fjellstrom.ca> wrote=
:
>=20
> Hi
>=20
> As of the past few months or so I've been dealing with my workstation lock=
ing=20
> up for upwards of minutes at a time when deleting a large directory tree. I=
=20
> don't recall this being a problem before.
>=20
> Current setup is 3 SATA SSDs in an lvm vg. most space is allocated to an e=
xt4=20
> /home where my work projects live.
>=20
> The main use case causing problems is deleting the "out" directory of an=20=

> android AOSP build tree. It can be upwards of 95GB in size with 240k or mo=
re=20
> files. If I run a `rm -fr out` or `make clean` it will lock up anything=20=

> attempting to use the disk (eg: plasma, intellij, android studio, chrome, e=
tc)=20
> for sometimes minutes.
>=20
> I have tried different block scheduler settings including none, mq-deadlin=
e,=20
> kyber and bfq none of which seem to improve things much at all.
>=20
> It may be worth noting that disk space is starting to run low, perhaps the=
re's=20
> some interaction going on with free space handling or ssd wear leveling...=

>=20
> That said, it seems to have started happening (or at least made worse) som=
e=20
> time around when mq was made the default and only implementation for sata.=

>=20
> if it helps, my system specs are:
>=20
> Kernel: Debian Sid's 4.18.0-2-amd64 (4.18.10-2)
> CPU: AMD FX-8320 OCed to 4.4Ghz
> RAM: 32GB DDR3 1866
> MB: Asus 970 Aura Pro Gaming
> Storage: Kingston HyperX 3K 240G + Samsung 850 Evo 250G + SanDisk X300 500=
G
>=20
> I'm thinking of testing with a different or older kernel, what would be th=
e=20
> best to test with?

Can you try 4.19? A patch went in since 4.18 that fixes a starvation issue a=
round requeue conditions, which SATA is the one to most often hit.=20

Jens=
