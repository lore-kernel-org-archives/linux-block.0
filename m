Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943C1DF72C;
	Sun,  7 Jun 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814519; cv=none; b=cFTw6zaiT3aXOC4mfWEw3SFbOzXkVqblriVDZZVvTqm+pwH6PNICEYI/6M7MBHGIwmfLToUTdI20JZ0DHtFS1lRNkFhZ9tFoILNagsylkv0NsSmy2WB0sp5aDsvAv0axxXpQ92sldv8ojs/mnozi8X+S1AOQNmq11LBY1aJb79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814519; c=relaxed/simple;
	bh=oHHJ+Sc2rYBaM3A0kjhc6S4a4tqZmx7TLrTVjEhfNoU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ryXojoOxGr5seDGVzmkR31KJoUh1xImPqSBpIHG0Ehlr9GEVxGbd3EI0taZdaiJAp3I3eFuYHv7EcZM8htfnTEPrIhyGPslNDFBpwIQ2spNh6Q+khRj+23pjZER7vRfdCrxqIT70w0K5C+X4k3VJTrJc9lPst5MPoQK1PiSxdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=V6srsEGH; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="V6srsEGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2vu56xwhdzg3rffb2d7mvzc5xe.protonmail; t=1780814510; x=1781073710;
	bh=OGqXjRWjrutttY1n5fsm0/T9elTRL0atCpK5debHX6g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=V6srsEGHiwxsgY/0Ja+tDxKune0vJhoCMgxjnyoYTONtv+7OoGN9XEAfKA2RTrhrE
	 81bsmR9mP428X8IQ69XbgeV0+2ppc9DKTCjiJd3dIUr2QJ7xApQIqgGbTau4XEyrMZ
	 bNijoVewCPO8IWsDubT5RreE4lLM5WKTCLL8SlPXieZs45GbmwgTZFxNrQnl/oagAO
	 tcZ9J6SvPMU5OQG2iVuetcbcx/s2fJ1GkXNE6E/6AAv15tQyg9z3/rSfe1FHITFIwv
	 f3Pvxpcte1UHUyXXPFl2IVhsM227toV+BMbGoDC86HTURWM4Dh0uBU8aeLszf6snUE
	 57tgbDzmrIcag==
Date: Sun, 07 Jun 2026 06:41:43 +0000
To: Jens Axboe <axboe@kernel.dk>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Philippe De Muyter <phdm@macqel.be>, Kees Cook <kees@kernel.org>, Michael Bommarito <michael.bommarito@gmail.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions: aix: bound the pp_count scan to the ppe array
Message-ID: <20260607064137.302574-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: f9681506637c14767eb4f36722ede7bf39ec4d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

aix_partition() reads the physical volume descriptor into a fixed-size
struct pvd and then scans its physical-partition-extent array:

=09int numpps =3D be16_to_cpu(pvd->pp_count);
=09...
=09for (i =3D 0; i < numpps; i +=3D 1) {
=09=09struct ppe *p =3D pvd->ppe + i;
=09=09...
=09=09lp_ix =3D be16_to_cpu(p->lp_ix);

pvd points at a single kmalloc()'d struct pvd whose ppe[] member holds a
fixed ARRAY_SIZE(pvd->ppe) (1016) entries, but the loop runs up to the
on-disk pp_count.  pp_count is an unvalidated __be16 read straight from
the descriptor, so a crafted AIX image with pp_count larger than 1016
drives the loop to read pvd->ppe[i] past the end of the allocation (up to
65535 entries, ~2 MB out of bounds).

The partition scan runs without mounting anything, when a block device
with a crafted AIX/IBM partition table appears (an attacker-supplied
image attached with losetup -P, or a device auto-scanned by udev), via
msdos_partition() -> aix_partition().

Clamp the scan to the number of entries the ppe[] array can hold.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproduced on v7.1-rc6 with KASAN (CONFIG_PARTITION_ADVANCED +
CONFIG_AIX_PARTITION).  A crafted disk image whose AIX/IBM partition table
sets pp_count to 0xffff, attached with `losetup -fP image.img` (in-kernel
partition scan, no mount), is reported by KASAN:

  BUG: KASAN: slab-out-of-bounds in aix_partition+0xb6e/0xee0
  Read of size 2 at addr ... by task losetup
   aix_partition
   msdos_partition
   bdev_disk_changed
   loop_reread_partitions
   loop_configure
   lo_ioctl
   __x64_sys_ioctl

i.e. a read past the end of the kmalloc(sizeof(struct pvd)) object.  A cont=
rol
image with pp_count =3D=3D 1016 (=3D=3D ARRAY_SIZE(pvd->ppe)) is clean.  Wi=
th this
patch the crafted image is parsed with no out-of-bounds access.

This is the read-loop sibling of the lvd scan bounded by Michael Bommarito'=
s
"partitions: aix: bound the lvd scan to one sector"; that change does not
touch the pp_count/ppe[] loop, so the two are complementary (separate hunks=
).

 block/partitions/aix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 29b8f4cebb63..f3c4174e003e 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -226,6 +226,15 @@ int aix_partition(struct parsed_partitions *state)
 =09=09int next_lp_ix =3D 1;
 =09=09int lp_ix;
=20
+=09=09/*
+=09=09 * pvd was read into a fixed-size struct pvd whose ppe[] array
+=09=09 * holds ARRAY_SIZE(pvd->ppe) entries.  pp_count is an
+=09=09 * unvalidated on-disk __be16, so clamp the scan to the array
+=09=09 * size to avoid walking past the allocation.
+=09=09 */
+=09=09if (numpps > ARRAY_SIZE(pvd->ppe))
+=09=09=09numpps =3D ARRAY_SIZE(pvd->ppe);
+
 =09=09for (i =3D 0; i < numpps; i +=3D 1) {
 =09=09=09struct ppe *p =3D pvd->ppe + i;
 =09=09=09unsigned int lv_ix;
--=20
2.43.0


