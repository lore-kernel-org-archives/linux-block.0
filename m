Return-Path: <ps@pks.im>
Date: Fri, 27 Jul 2018 14:35:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180727123533.GA1588@xps>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
 <20180726083850.GB1674@ncase>
 <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 01:51:48PM +0000, Bart Van Assche wrote:
> On Thu, 2018-07-26 at 10:38 +-0200, Patrick Steinhardt wrote:
> +AD4- That still leaves the other problem of broken suspend. I've just
> +AD4- checked with v4.17.10, and it's still there: as soon as I resume
> +AD4- from suspend, the kernel oopses and reboots the machine. I guess
> +AD4- I'll have to do another debugging session and see where it fails
> +AD4- exactly (and no, this time there are no more changes to the
> +AD4- kernel tree).
>=20
> Can you share the kernel oops details before you start running a bisect?

I've already done the bisect a few months ago, which resulted in
commit 765e40b675a9 (block: disable runtime-pm for blk-mq July
2017). I've never been able to get the Oops, as the screen was
blank, but I tried a little harder with pstore today and finally
got hold of it. Please see below for the Oops and previous dmesg
entries. Kernel version was v4.17.10.

Thanks
Patrick

<6>[   49.088931] PM: suspend entry (deep)
<6>[   49.088933] PM: Syncing filesystems ... done.
<6>[   49.093066] Freezing user space processes ... (elapsed 0.001 seconds)=
 done.
<6>[   49.094283] OOM killer disabled.
<6>[   49.094284] Freezing remaining freezable tasks ... (elapsed 0.001 sec=
onds) done.
<6>[   49.095470] Suspending console(s) (use no_console_suspend to debug)
<6>[   50.350548] ACPI: EC: interrupt blocked
<6>[   50.383913] ACPI: Preparing to enter system sleep state S3
<6>[   50.397529] ACPI: EC: EC stopped
<6>[   50.397529] ACPI: EC: event blocked
<6>[   50.397530] PM: Saving platform NVS memory
<6>[   50.397605] Disabling non-boot CPUs ...
<6>[   50.414940] smpboot: CPU 1 is now offline
<6>[   50.445153] smpboot: CPU 2 is now offline
<6>[   50.471702] smpboot: CPU 3 is now offline
<6>[   50.473710] ACPI: Low-level resume complete
<6>[   50.473770] ACPI: EC: EC started
<6>[   50.473771] PM: Restoring platform NVS memory
<6>[   50.476149] Enabling non-boot CPUs ...
<6>[   50.476175] x86: Booting SMP configuration:
<6>[   50.476176] smpboot: Booting Node 0 Processor 1 APIC 0x2
<4>[   50.478031]  cache: parent cpu1 should not be sleeping
<6>[   50.478333] CPU1 is up
<6>[   50.478348] smpboot: Booting Node 0 Processor 2 APIC 0x1
<4>[   50.478950]  cache: parent cpu2 should not be sleeping
<6>[   50.479194] CPU2 is up
<6>[   50.479206] smpboot: Booting Node 0 Processor 3 APIC 0x3
<4>[   50.479824]  cache: parent cpu3 should not be sleeping
<6>[   50.480470] CPU3 is up
<6>[   50.490620] ACPI: Waking up from system sleep state S3
<6>[   53.334256] ACPI: EC: interrupt unblocked
<6>[   53.411349] ACPI: EC: event unblocked
<1>[   53.411700] BUG: unable to handle kernel NULL pointer dereference at =
00000000000001a8
<6>[   53.411705] PGD 0 P4D 0=20
<4>[   53.411711] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC PTI
<4>[   53.411716] CPU: 3 PID: 1600 Comm: kworker/u8:48 Tainted: G     U    =
        4.17.10 #9
<4>[   53.411717] Hardware name: Dell Inc. XPS 13 9343/0310JH, BIOS A15 01/=
23/2018
<4>[   53.411724] Workqueue: events_unbound async_run_entry_fn
<4>[   53.411733] RIP: 0010:blk_set_runtime_active+0x2d/0x50
<4>[   53.411736] RSP: 0000:ffff88020ef37df0 EFLAGS: 00010046
<4>[   53.411739] RAX: 0000000000000000 RBX: ffff880210a9a000 RCX: 00000000=
00000000
<4>[   53.411742] RDX: 00000000fffedf06 RSI: 0000000000000009 RDI: ffff8802=
10a9a1b0
<4>[   53.411745] RBP: ffffffff815158d0 R08: ffffffff81c13ce0 R09: 00000000=
00000000
<4>[   53.411747] R10: 0000000000004400 R11: 0000000000005cd3 R12: ffff8802=
141671e8
<4>[   53.411749] R13: 0000000000000000 R14: ffff880215414c98 R15: 00000000=
00000000
<4>[   53.411753] FS:  0000000000000000(0000) GS:ffff88021e780000(0000) knl=
GS:0000000000000000
<4>[   53.411755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   53.411757] CR2: 00000000000001a8 CR3: 000000000300a003 CR4: 00000000=
003606e0
<4>[   53.411758] Call Trace:
<4>[   53.411766]  scsi_bus_resume_common+0xf8/0x110
<4>[   53.411771]  ? scsi_bus_thaw+0x10/0x10
<4>[   53.411776]  dpm_run_callback.isra.16+0x27/0x70
<4>[   53.411781]  device_resume+0xab/0x170
<4>[   53.411785]  async_resume+0x14/0x40
<4>[   53.411788]  async_run_entry_fn+0x34/0x100
<4>[   53.411793]  process_one_work+0x14d/0x2c0
<4>[   53.411797]  worker_thread+0x29/0x370
<4>[   53.411800]  ? process_one_work+0x2c0/0x2c0
<4>[   53.411803]  kthread+0x109/0x120
<4>[   53.411806]  ? __kthread_create_on_node+0x190/0x190
<4>[   53.411810]  ret_from_fork+0x35/0x40
<4>[   53.411813] Code: 89 fb 48 8b bf b8 01 00 00 e8 30 8c 4e 00 48 8b 83 =
40 02 00 00 be 09 00 00 00 c7 83 48 02 00 00 00 00 00 00 48 8b 15 03 31 cf =
00 <48> 89 90 a8 01 00 00 48 8b bb 40 02 00 00 e8 00 1e 1e 00 48 8b=20
<1>[   53.411873] RIP: blk_set_runtime_active+0x2d/0x50 RSP: ffff88020ef37d=
f0
<4>[   53.411874] CR2: 00000000000001a8
<4>[   53.411877] ---[ end trace bbd10b6fcf31d6c4 ]---

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltbEZUACgkQEXxntp6r
8SwtlxAAi7rfRRnAONQcEGDOtUbMU1X5JE8POORiRCpmjIP9E5AkXJY89IpF8XJU
8iAYCyhfMePH4q5kGPp41SdIV6vpvuGLyL+4qA1mw3rk1cke6VGARKS1KfMkBdZr
dnuY/aPPDbk9NtvMV+MLV6BrfIVv7M4BXo6l5XKb8SrczGDRlg4n3UxPnQAmY58G
Kdd182KrvWxg1spSjjPCMa9qOzDBV8YFnRzGREtyt4oemFZbrNZJdtTBcqIhtiRJ
nfe3QAZiuf4NsekBj3CzyJdqfPbaYrU81IMEeR8dJELTRdfYr9bI/0A9TnWfhnPw
QajcAKd6pYjocQdz1WgDYTpiarpR2INWrVPUK+49q1pLE5808hnSfUzK2poXiMmc
CnLXc+tDDzpn+qUaud7uhK1M3GgiAq0NZC9W2eKck2PcD8KKxervpN1qu2GyMXLB
EYg/+492vC+zHU5Fm2vMQpMg9PA4mA08RL+d1F6onmNHmJ2bS3ACa8uzZ3BWQWCF
0tEBeydrvwIiOvTYc63E+bo52p0NhrZESm12OzbU9gq1A3p8nqjFrxCLJbXh4pmP
42jw+5S9ly6PhJNXnQHpzpOQDyWr/9v33fXXpHrR373CTjIpWT85FOC7ysWnM7yI
oq0/6VSos6FvGdvGz7tykK2w1RDUFJC9repxFyfVvXqUSgw1wF8=
=YebW
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
