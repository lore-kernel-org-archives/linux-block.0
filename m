Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v4.11-rc blk-mq lockup?
Date: Tue, 28 Mar 2017 16:25:49 +0000
Message-ID: <1490718332.2573.6.camel@sandisk.com>
References: <1490651076.7897.11.camel@sandisk.com>
	 <20170328140655.GB27578@kernel.dk>
In-Reply-To: <20170328140655.GB27578@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-03-28 at 08:06 -0600, Jens Axboe wrote:
> On Mon, Mar 27 2017, Bart Van Assche wrote:
> > Hello Jens,
> >=20
> > If I leave the srp-test software running for a few minutes using the
> > following command:
> >=20
> > # while ~bart/software/infiniband/srp-test/run_tests -d -r 30; do :; do=
ne
> >=20
> > then after some time the following complaint appears for multiple
> > kworkers:
> >=20
> > INFO: task kworker/9:0:65 blocked for more than 480 seconds.
> > =A0=A0=A0=A0=A0=A0Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0I=A0=A0=A0=A0=
=A04.11.0-rc4-dbg+ #5
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > kworker/9:0=A0=A0=A0=A0=A0D=A0=A0=A0=A00=A0=A0=A0=A065=A0=A0=A0=A0=A0=
=A02 0x00000000
> > Workqueue: dio/dm-0 dio_aio_complete_work
> > Call Trace:
> > =A0__schedule+0x3df/0xc10
> > =A0schedule+0x38/0x90
> > =A0rwsem_down_write_failed+0x2c4/0x4c0
> > =A0call_rwsem_down_write_failed+0x17/0x30
> > =A0down_write+0x5a/0x70
> > =A0__generic_file_fsync+0x43/0x90
> > =A0ext4_sync_file+0x2d0/0x550
> > =A0vfs_fsync_range+0x46/0xa0
> > =A0dio_complete+0x181/0x1b0
> > =A0dio_aio_complete_work+0x17/0x20
> > =A0process_one_work+0x208/0x6a0
> > =A0worker_thread+0x49/0x4a0
> > =A0kthread+0x107/0x140
> > =A0ret_from_fork+0x2e/0x40
> >=20
> > I had not yet observed this behavior with kernel v4.10 or older. If thi=
s
> > happens and I check the queue state with the following script:
>=20
> Can you include the 'state' file in your script?
>=20
> Do you know when this started happening? You say it doesn't happen in
> 4.10, but did it pass earlier in the 4.11-rc cycle?
>=20
> Does it reproduce with dm?
>=20
> I can't tell from your report if this is new in the 4.11 series,
>=20
> > The kernel tree I used in my tests is the result of merging the
> > following commits:
> > * commit 3dca2c2f3d3b=A0from git://git.kernel.dk/linux-block.git
> >   ("Merge branch 'for-4.12/block' into for-next")
> > * commit f88ab0c4b481 from git://git.kernel.org/pub/scm/linux/kernel/gi=
t/mkp/scsi.git
> >   ("scsi: libsas: fix ata xfer length")
> > * commit ad0376eb1483 from git://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
> >   ("Merge tag 'edac_for_4.11_2' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/bp/bp")
>=20
> Can we try and isolate it a bit - -rc4 alone, for instance?

Hello Jens,

Sorry but performing a bisect would be hard: without recent SCSI and block
layer fixes this test triggers other failures before the lockup reported in
this e-mail is triggered. See e.g.
https://marc.info/?l=3Dlinux-scsi&m=3D148979716822799.

I do not know whether it would be possible to modify the test such that onl=
y
the dm driver is involved but no SCSI code.

When I reran the test this morning the hang was triggered by the 02-sq-on-m=
q
test. This means that dm was used in blk-sq mode and that blk-mq was used f=
or
the ib_srp SCSI device instances.

Please find below the updated script and its output.

---

#!/bin/bash

show_state() {
=A0=A0=A0=A0local a dev=3D$1

=A0=A0=A0=A0for a in device/state queue/scheduler; do
	[ -e "$dev/$a" ] && grep -aH '' "$dev/$a"
=A0=A0=A0=A0done
}

cd /sys/class/block || exit $?
for dev in *; do
=A0=A0=A0=A0if [ -e "$dev/mq" ]; then
	echo "$dev"
	pending=3D0
	for f in "$dev"/mq/*/{pending,*/rq_list}; do
	=A0=A0=A0=A0[ -e "$f" ] || continue
	=A0=A0=A0=A0if { read -r line1 && read -r line2; } <"$f"; then
		echo "$f"
		echo "$line1 $line2" >/dev/null
		head -n 9 "$f"
		((pending++))
	=A0=A0=A0=A0fi
	done
	(
	=A0=A0=A0=A0busy=3D0
	=A0=A0=A0=A0cd /sys/kernel/debug/block >&/dev/null &&
	=A0=A0=A0=A0for d in "$dev"/mq/*; do
		[ ! -d "$d" ] && continue
		grep -q '^busy=3D0$' "$d/tags" && continue
		((busy++))
	=A0=A0=A0=A0=A0=A0=A0=A0for f in "$d"/{dispatch,tags*,cpu*/rq_list}; do
		=A0=A0=A0=A0[ -e "$f" ] && grep -aH '' "$f"
		done
	=A0=A0=A0=A0done
	=A0=A0=A0=A0exit $busy
	)
	pending=3D$((pending+$?))
	[ "$pending" -gt 0 ] && show_state "$dev"
=A0=A0=A0=A0fi
done

---

sda
sdb
sdc
sdd
sde
sde/mq/2/dispatch:ffff8803f5b65d00 {.cmd_flags=3D0xca01, .rq_flags=3D0x2040=
, .tag=3D37, .internal_tag=3D-1}
sde/mq/2/tags:nr_tags=3D62
sde/mq/2/tags:nr_reserved_tags=3D0
sde/mq/2/tags:active_queues=3D0
sde/mq/2/tags:
sde/mq/2/tags:bitmap_tags:
sde/mq/2/tags:depth=3D62
sde/mq/2/tags:busy=3D31
sde/mq/2/tags:bits_per_word=3D8
sde/mq/2/tags:map_nr=3D8
sde/mq/2/tags:alloc_hint=3D{54, 43, 44, 43, 22, 42, 52, 4, 10, 7, 16, 32, 1=
1, 17, 44, 26, 51, 59, 9, 45, 9, 55, 10, 44, 22, 46, 25, 25, 21, 18, 52, 32=
}
sde/mq/2/tags:wake_batch=3D7
sde/mq/2/tags:wake_index=3D0
sde/mq/2/tags:ws=3D{
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/2/tags:}
sde/mq/2/tags:round_robin=3D0
sde/mq/2/tags_bitmap:00000000: 7f00 0000 e0ff ff1f
sde/mq/2/cpu9/rq_list:ffff8803f5b67440 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D38, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f5b68b80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D39, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f5b6a2c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D40, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f5b6ba00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D41, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f5b6d140 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D42, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f5b6e880 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D43, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac0000 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D44, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac1740 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D45, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac2e80 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D46, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac45c0 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D47, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac5d00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D48, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac7440 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D49, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ac8b80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D50, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373aca2c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D51, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373acba00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D52, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373acd140 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D53, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff880373ace880 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D54, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f4950000 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D55, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f4951740 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D56, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f4952e80 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D57, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f49545c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D58, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f4955d00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D59, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff8803f4957440 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D60, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe0000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D0, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe1740 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D1, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe2e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D2, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe45c0 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D3, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe5d00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D4, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe7440 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D5, .internal_tag=3D-1}
sde/mq/2/cpu9/rq_list:ffff88036bfe8b80 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D6, .internal_tag=3D-1}
sde/device/state:running
sde/queue/scheduler:[none]=A0
sdf
sdf/mq/2/tags:nr_tags=3D62
sdf/mq/2/tags:nr_reserved_tags=3D0
sdf/mq/2/tags:active_queues=3D0
sdf/mq/2/tags:
sdf/mq/2/tags:bitmap_tags:
sdf/mq/2/tags:depth=3D62
sdf/mq/2/tags:busy=3D31
sdf/mq/2/tags:bits_per_word=3D8
sdf/mq/2/tags:map_nr=3D8
sdf/mq/2/tags:alloc_hint=3D{54, 43, 44, 43, 22, 42, 52, 4, 10, 7, 16, 32, 1=
1, 17, 44, 26, 51, 59, 9, 45, 9, 55, 10, 44, 22, 46, 25, 25, 21, 18, 52, 32=
}
sdf/mq/2/tags:wake_batch=3D7
sdf/mq/2/tags:wake_index=3D0
sdf/mq/2/tags:ws=3D{
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdf/mq/2/tags:}
sdf/mq/2/tags:round_robin=3D0
sdf/mq/2/tags_bitmap:00000000: 7f00 0000 e0ff ff1f
sdf/device/state:running
sdf/queue/scheduler:[none]=A0
sdg
sdh
sdi
sdj
sr0
