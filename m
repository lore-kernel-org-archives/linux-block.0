Return-Path: <nikolaus@rath.org>
Message-Id: <1522918273.1829962.1327322736.4F60CFBA@webmail.messagingengine.com>
From: Nikolaus Rath <nikolaus@rath.org>
To: Jens Axboe <axboe@kernel.dk>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Michael Lyle <mlyle@lyle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: bcache and hibernation (was: bcache: bad block header)
In-Reply-To: <e9abd200-1718-7975-b3e5-d05473e7d2d4@kernel.dk>
References: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
 <e9abd200-1718-7975-b3e5-d05473e7d2d4@kernel.dk>
Date: Thu, 05 Apr 2018 09:51:13 +0100
List-ID: <linux-block@vger.kernel.org>

Hi,

I have a hypothesis of what happened. My swap volume is also on LVM, and th=
us also eventually backed by bcache. Hibernation and resume work fine. But =
when the hibernation image is read during resume, the contents of the cache=
 device change because with bcache reading is no longer a read-only operati=
on. When the hibernation image is loaded, the kernel looses track of these =
changes so that what's on the cache disk no longer matches the structures i=
n the kernel. Therefore, on the first boot after the successful resume, hav=
oc ensures.

I needed the system running again, so I've now detached the backing volumes=
, re-initialized the cache volume and re-attached the backing volumes. Unfo=
rtunately there was too much filesystem damage, so I restored everything fr=
om backup.

Is there a way to prevent this from happening? Could eg the kernel detect t=
hat the swap devices is (indirectly) on bcache and refuse to hibernate? Or =
is there a way to do a "true" read-only mount of a bcache volume so that on=
e can safely resume from it?
=20
Best,
-Nikolaus

--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB

On Tue, 3 Apr 2018, at 23:38, Jens Axboe wrote:
> CC'ing Mike
>=20
> On 4/3/18 1:01 PM, Nikolaus Rath wrote:
> > [ Re-send to both linux-block and linux-bcache ]
> >=20
> > Hi,
> >=20
> > A few days ago, my system refused to boot because it couldn't find the =
root filesystem anymore. The root filesystem is ext4 on LVM on dm-crypt on =
bcache, using kernel 4.9.92 (from Debian stretch). Booting from a recovery =
medium with Kernel 4.16, I got:
> >=20
> > [=C2=A0=C2=A0 84.551715] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [=C2=A0=C2=A0 84.553188] bcache: register_bcache() error /dev/sdc2: dev=
ice already registered
> > [=C2=A0=C2=A0 84.616438] bcache: error on 1330b5f6-0c13-43ec-b925-2ee27=
34b135f:
> > [=C2=A0=C2=A0 84.616440] bad btree header at bucket 85065, block 0, 0 k=
eys
> > [=C2=A0=C2=A0 84.616442] , disabling caching
> > [=C2=A0=C2=A0 84.616445] bcache: register_cache() registered cache devi=
ce sdb2
> > [=C2=A0=C2=A0 84.616597] bcache: cache_set_free() Cache set 1330b5f6-0c=
13-43ec-b925-2ee2734b135f unregistered
> > [=C2=A0=C2=A0 85.375933]=C2=A0 sdb: sdb1 sdb2 sdb4 < sdb5 >
> > [=C2=A0=C2=A0 85.416610] bcache: error on 1330b5f6-0c13-43ec-b925-2ee27=
34b135f:
> > [=C2=A0=C2=A0 85.416612] bad btree header at bucket 85065, block 0, 0 k=
eys
> > [=C2=A0=C2=A0 85.416614] , disabling caching
> > [=C2=A0=C2=A0 85.416618] bcache: register_cache() registered cache devi=
ce sdb2
> > [=C2=A0=C2=A0 85.416624] bcache: register_bcache() error /dev/sdc2: dev=
ice already registered
> > [=C2=A0=C2=A0 85.416626] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [=C2=A0=C2=A0 85.416796] bcache: cache_set_free() Cache set 1330b5f6-0c=
13-43ec-b925-2ee2734b135f unregistered
> > [=C2=A0=C2=A0 85.488246] bcache: error on 1330b5f6-0c13-43ec-b925-2ee27=
34b135f:
> > [=C2=A0=C2=A0 85.488249] bad btree header at bucket 85065, block 0, 0 k=
eys
> > [=C2=A0=C2=A0 85.488251] , disabling caching
> > [=C2=A0=C2=A0 85.488254] bcache: register_cache() registered cache devi=
ce sdb2
> > [=C2=A0=C2=A0 85.488429] bcache: cache_set_free() Cache set 1330b5f6-0c=
13-43ec-b925-2ee2734b135f unregistered
> > [=C2=A0=C2=A0 85.560003] bcache: error on 1330b5f6-0c13-43ec-b925-2ee27=
34b135f:
> > [=C2=A0=C2=A0 85.560006] bad btree header at bucket 85065, block 0, 0 k=
eys
> > [=C2=A0=C2=A0 85.560008] , disabling caching
> > [=C2=A0=C2=A0 85.560013] bcache: register_cache() registered cache devi=
ce sdb2
> > [=C2=A0=C2=A0 85.560017] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [=C2=A0=C2=A0 85.560217] bcache: cache_set_free() Cache set 1330b5f6-0c=
13-43ec-b925-2ee2734b135f unregistered
> > [=C2=A0=C2=A0 85.571950] bcache: register_bcache() error /dev/sdc2: dev=
ice already registered
> > [=C2=A0=C2=A0 85.580628] bcache: register_bcache() error /dev/sdc2: dev=
ice already registered
> > [=C2=A0=C2=A0 85.761969] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [=C2=A0=C2=A0 85.792749] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [=C2=A0=C2=A0 85.952931] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [=C2=A0=C2=A0 85.955640] bcache: register_bcache() error /dev/sda4: dev=
ice already registered
> > [...]
> >=20
> > These are the first messages that mention bcache. Note that the first m=
essage is that the device is already registered - is that normal?
> >=20
> > smartctl does not report any errors on backing or caching disks, and th=
e system was shutdown cleanly.
> >=20
> > The only possibly related thing that comes to mind is that a few days a=
go I hibernated and resumed the system (this is something I normally don't =
do). Resume worked fine as far as I could tell though, and there have been =
no unclean shutdowns.
> >=20
> > Is there a way to narrow down what may have caused this corruption?
> >=20
> > And, is there a way to gracefully recover from this situation without w=
iping everything? Since the message mentions only problems with one block, =
can I maybe tell bcache to just ignore/drop this specific block?
> >=20
> > Thanks!
> > -Nikolaus
> > --
> > GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB
> >=20
>=20
>=20
> --=20
> Jens Axboe
>=20
