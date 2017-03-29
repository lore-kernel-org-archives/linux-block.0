Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v4.11-rc blk-mq lockup?
Date: Wed, 29 Mar 2017 20:36:01 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA12B902@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <1490651076.7897.11.camel@sandisk.com>
 <20170328140655.GB27578@kernel.dk> <1490718332.2573.6.camel@sandisk.com>
 <1757f63c-7603-86e8-afde-0cb948ba8f66@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/28/2017 09:30 AM, Jens Axboe wrote:=0A=
> On 03/28/2017 10:25 AM, Bart Van Assche wrote:=0A=
>> I do not know whether it would be possible to modify the test such that =
only=0A=
>> the dm driver is involved but no SCSI code.=0A=
> =0A=
> How about the other way around? Just SCSI, but no dm?=0A=
=0A=
Hello Jens,=0A=
=0A=
Sorry but it could take a long time to figure out how to reproduce this=0A=
issue if I start modifying the test. BTW, the patch I just posted =0A=
("blk-mq: Export queue state through /sys/kernel/debug/block/*/state") =0A=
allows me to trigger a blk-mq queue run from user space. If the lockup=0A=
occurs and I use that facility to trigger a queue run the test proceeds.=0A=
The command I used to trigger a queue run is as follows:=0A=
=0A=
for a in /sys/kernel/debug/block/*/state; do echo 1 >$a; wait=0A=
=0A=
> Thanks for running it again, but it's the wrong state file. I should have=
=0A=
> been more clear. The one I'm interested in is in the mq/<num>/ directorie=
s,=0A=
> like the 'tags' etc files.=0A=
> =0A=
> Ala:=0A=
>  =0A=
>  	        for f in "$d"/{dispatch,state,tags*,cpu*/rq_list}; do=0A=
=0A=
Ah, thanks, that makes it clear :-)=0A=
 =0A=
> Also, can you include the involved dm devices as well for this state=0A=
> dump?=0A=
=0A=
I would like to, but the 02-sq-on-mq test configures the dm device =0A=
nodes in single queue mode and there is only information available =0A=
under /sys/kernel/debug/block/ for blk-mq devices ...=0A=
=0A=
Anyway, the updated script:=0A=
=0A=
#!/bin/bash=0A=
=0A=
show_state() {=0A=
    local a dev=3D$1=0A=
=0A=
    for a in device/state queue/scheduler; do=0A=
	[ -e "$dev/$a" ] && grep -aH '' "$dev/$a"=0A=
    done=0A=
}=0A=
=0A=
cd /sys/class/block || exit $?=0A=
for dev in *; do=0A=
    if [ -e "$dev/mq" ]; then=0A=
	echo "$dev"=0A=
	pending=3D0=0A=
	for f in "$dev"/mq/*/{pending,*/rq_list}; do=0A=
	    [ -e "$f" ] || continue=0A=
	    if { read -r line1 && read -r line2; } <"$f"; then=0A=
		echo "$f"=0A=
		echo "$line1 $line2" >/dev/null=0A=
		head -n 9 "$f"=0A=
		((pending++))=0A=
	    fi=0A=
	done=0A=
	(=0A=
	    busy=3D0=0A=
	    cd /sys/kernel/debug/block >&/dev/null &&=0A=
	    for d in "$dev"/mq/*; do=0A=
		[ ! -d "$d" ] && continue=0A=
		grep -q '^busy=3D0$' "$d/tags" && continue=0A=
		((busy++))=0A=
	        for f in "$d"/{dispatch,state,tags*,cpu*/rq_list}; do=0A=
		    [ -e "$f" ] && grep -aH '' "$f"=0A=
		done=0A=
	    done=0A=
	    exit $busy=0A=
	)=0A=
	pending=3D$((pending+$?))=0A=
	if [ "$pending" -gt 0 ]; then=0A=
	    grep -aH '' /sys/kernel/debug/block/"$dev"/state=0A=
	    show_state "$dev"=0A=
	fi=0A=
    fi=0A=
done=0A=
=0A=
=0A=
And the output for the test run of today:=0A=
=0A=
sda=0A=
sdb=0A=
sdd=0A=
sdd/mq/0/dispatch:ffff88036437d140 {.cmd_flags=3D0xca01, .rq_flags=3D0x2040=
, .tag=3D53, .internal_tag=3D-1}=0A=
sdd/mq/0/state:0x4=0A=
sdd/mq/0/tags:nr_tags=3D62=0A=
sdd/mq/0/tags:nr_reserved_tags=3D0=0A=
sdd/mq/0/tags:active_queues=3D0=0A=
sdd/mq/0/tags:=0A=
sdd/mq/0/tags:bitmap_tags:=0A=
sdd/mq/0/tags:depth=3D62=0A=
sdd/mq/0/tags:busy=3D31=0A=
sdd/mq/0/tags:bits_per_word=3D8=0A=
sdd/mq/0/tags:map_nr=3D8=0A=
sdd/mq/0/tags:alloc_hint=3D{48, 48, 38, 44, 54, 6, 52, 23, 30, 6, 51, 26, 6=
1, 45, 9, 56, 55, 13, 44, 45, 12, 12, 23, 42, 44, 24, 41, 0, 54, 4, 4, 45}=
=0A=
sdd/mq/0/tags:wake_batch=3D7=0A=
sdd/mq/0/tags:wake_index=3D0=0A=
sdd/mq/0/tags:ws=3D{=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sdd/mq/0/tags:}=0A=
sdd/mq/0/tags:round_robin=3D0=0A=
sdd/mq/0/tags_bitmap:00000000: ffff 7f00 0000 e01f=0A=
sdd/mq/0/cpu7/rq_list:ffff88036437e880 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D54, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f7ef0000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D55, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f7ef1740 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D56, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f7ef2e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D57, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f7ef45c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D58, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f7ef5d00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D59, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f7ef7440 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D60, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff880386760000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D0, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff880386761740 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D1, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff880386762e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D2, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803867645c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D3, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff880386765d00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D4, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff880386767440 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D5, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff880386768b80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D6, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff88038676a2c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D7, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff88038676ba00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D8, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff88038676d140 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D9, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff88038676e880 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D10, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f8650000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D11, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f8651740 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D12, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f8652e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D13, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f86545c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D14, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f8655d00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D15, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f8657440 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D16, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f8658b80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D17, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f865a2c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D18, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f865ba00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D19, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f865d140 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D20, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803f865e880 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D21, .internal_tag=3D-1}=0A=
sdd/mq/0/cpu7/rq_list:ffff8803fb630000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D22, .internal_tag=3D-1}=0A=
/sys/kernel/debug/block/sdd/state:SAME_COMP STACKABLE IO_STAT INIT_DONE POL=
L=0A=
sdd/device/state:running=0A=
sdd/queue/scheduler:[none] =0A=
sde=0A=
sde/mq/0/state:0x0=0A=
sde/mq/0/tags:nr_tags=3D62=0A=
sde/mq/0/tags:nr_reserved_tags=3D0=0A=
sde/mq/0/tags:active_queues=3D0=0A=
sde/mq/0/tags:=0A=
sde/mq/0/tags:bitmap_tags:=0A=
sde/mq/0/tags:depth=3D62=0A=
sde/mq/0/tags:busy=3D31=0A=
sde/mq/0/tags:bits_per_word=3D8=0A=
sde/mq/0/tags:map_nr=3D8=0A=
sde/mq/0/tags:alloc_hint=3D{48, 48, 38, 44, 54, 6, 52, 23, 30, 6, 51, 26, 6=
1, 45, 9, 56, 55, 13, 44, 45, 12, 12, 23, 42, 44, 24, 41, 0, 54, 4, 4, 45}=
=0A=
sde/mq/0/tags:wake_batch=3D7=0A=
sde/mq/0/tags:wake_index=3D0=0A=
sde/mq/0/tags:ws=3D{=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:	{.wait_cnt=3D7, .wait=3Dinactive},=0A=
sde/mq/0/tags:}=0A=
sde/mq/0/tags:round_robin=3D0=0A=
sde/mq/0/tags_bitmap:00000000: ffff 7f00 0000 e01f=0A=
/sys/kernel/debug/block/sde/state:SAME_COMP STACKABLE IO_STAT INIT_DONE POL=
L=0A=
sde/device/state:running=0A=
sde/queue/scheduler:[none] =0A=
sdf=0A=
sdg=0A=
sdh=0A=
sdi=0A=
sdj=0A=
sdk=0A=
sr0=0A=
