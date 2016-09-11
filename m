Return-Path: <rrs@researchut.com>
Return-Path: <rrs@researchut.com>
Message-ID: <1473587720.8183.5.camel@researchut.com>
Subject: Re: wb-buf-throttle feedback
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date: Sun, 11 Sep 2016 15:25:20 +0530
In-Reply-To: <09938f88-2a74-cb95-4498-5fc883eba115@kernel.dk>
References: <1473447658.8897.13.camel@researchut.com>
	 <7cb20dd5-a5a3-25d3-987b-d36e54cae2f7@fb.com>
	 <09938f88-2a74-cb95-4498-5fc883eba115@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Jens,


On Fri, 2016-09-09 at 14:19 -0600, Jens Axboe wrote:
> > What drive is hosting the system and kernel build? I think the current
> > branch isn't aggressive enough on SATA style QD=32 devices with write
> > back caching, so if that's what you are running, it'd be great if you
> > could try a patch or two so we can improve this situation for you.
> >
> > The v4.7 branch is outdated. Let me spin a new one, that's probably the
> > best way to start.
> 

The drive is:

Sep 10 18:19:32 chutzpah kernel: ata1: SATA link up 6.0 Gbps (SStatus 133
SControl 300)
Sep 10 18:19:32 chutzpah kernel: ata1.00: ATA-9: HGST HTS725050A7E630, GH2OA910,
max UDMA/133
Sep 10 18:19:32 chutzpah kernel: ata1.00: 976773168 sectors, multi 16: LBA48 NCQ
(depth 31/32), AA
Sep 10 18:19:32 chutzpah kernel: ata1.00: configured for UDMA/133
Sep 10 18:19:32 chutzpah kernel: scsi 0:0:0:0: Direct-Access     ATA      HGST
HTS725050A7 A910 PQ: 0 ANSI: 5
Sep 10 18:19:32 chutzpah kernel: sd 0:0:0:0: [sda] 976773168 512-byte logical
blocks: (500 GB/466 GiB)
Sep 10 18:19:32 chutzpah kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
Sep 10 18:19:32 chutzpah kernel: sd 0:0:0:0: [sda] Write Protect is off
Sep 10 18:19:32 chutzpah kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Sep 10 18:19:32 chutzpah kernel: sd 0:0:0:0: [sda] Write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
Sep 10 18:19:32 chutzpah kernel: usb 1-4: new full-speed USB device number 2
using xhci_hcd
Sep 10 18:19:32 chutzpah kernel:  sda: sda1 sda2 sda3 sda4 < sda5 >
Sep 10 18:19:32 chutzpah kernel: sd 0:0:0:0: [sda] Attached SCSI disk


> The 4.7 branch has now been updated, it's fully uptodate with the
> current 4.8 based branch. Would be great if you could try that. If you
> still see slowdowns, try and change RWB_DEF_DEPTH. It's currently at 16,
> scale it down to 4 or something like that.


I pulled in your changes from the axboe/wb-buf-throttle-v4.7 branch.

I can confirm now that, with these changes, the machine is very well responsive.
I tried both, the kernel build and the dd tests. Both of them worked fine.

Thank you very much.

Ritesh

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX1SoIAAoJEKY6WKPy4XVpleIQAJJMvcOz/O64CFH9VhMsBiR0
Pu3CufAgy8rNOlNBXrGdTKwH3rRnQSZiHkKd/o3uq1BjVPSKHK4YQnigImQwgzbe
SJdWmpaKKX1Pw5eo3LMU7Q+TU/CT5jzmiMk1s1HHeuqdW4DNOmYWQi4CqsLEp3ry
CDP5b1vygWGprrRNeADTQo6NzTS/TG32pFDQjj+/07gXPz61YfBtAnOD56u9328N
N8OJaPjWcdPPERFSoFW3HZVfyMtKNQ8OGKUf9oFWe/0eX+Bqji1L8Om5NebJw/Yv
YTzNTsC7WXARoifCI8GnmgoGgf51o+7qwdWG60iAJ+IO9FI8AAgFM4zRd3PPItqw
kOJWj6zN1Zr1YeAU9m8Z0muhyZ5a+Gj4J+4AuIRHLOaXRm05jm4mnVovpnP/i/dE
N4eTs/I6UWgGkTb/8FAfzr/Ql5l07EiZ8HItWX3YT4RfyoA6R7GZy7kf4E3kueFq
v2HwoLfBqj2NuLN714X106pAMEfw2pIbkWdtTUq47ybeh5YRvlkz46WjcRB88YKq
piRLSXVYpVIfG16rYQArDlum6RfZXyrRVjEczpOMVr+ZqZNWmFSqNCuYOPqfD5Mg
s/gTUwgNdAf/J725/GUdfQVDjootIAFY96vyUbVWEQpKz3HedME+sebhF8/OveQg
ziTHWyJWU9t642fTeNLC
=mW9B
-----END PGP SIGNATURE-----
