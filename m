Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 27 Jan 2017 11:49:19 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4 RFC] BDI lifetime fix
Message-ID: <20170127194919.GA21371@vader.DHCP.thefacebook.com>
References: <20170126174532.15189-1-jack@suse.cz>
 <CAPcyv4hJR_4WZFhKkfbnAz0iLtu-bgSJVE804+ywaFTeYC51bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <CAPcyv4hJR_4WZFhKkfbnAz0iLtu-bgSJVE804+ywaFTeYC51bQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2017 at 10:15:06PM -0800, Dan Williams wrote:
> On Thu, Jan 26, 2017 at 9:45 AM, Jan Kara <jack@suse.cz> wrote:
> > Hello,
> >
> > this patch series attempts to solve the problems with the life time of a
> > backing_dev_info structure. Currently it lives inside request_queue structure
> > and thus it gets destroyed as soon as request queue goes away. However
> > the block device inode still stays around and thus inode_to_bdi() call on
> > that inode (e.g. from flusher worker) may happen after request queue has been
> > destroyed resulting in oops.
> >
> > This patch set tries to solve these problems by making backing_dev_info
> > independent structure referenced from block device inode. That makes sure
> > inode_to_bdi() cannot ever oops. The patches are lightly tested for now
> > (they boot, basic tests with adding & removing loop devices seem to do what
> > I'd expect them to do ;). If someone is able to reproduce crashes on bdi
> > when device goes away, please test these patches.
> 
> This survives a several runs of the libnvdimm unit tests which stress
> del_gendisk() and blk_cleanup_queue(). I'll keep testing since the
> failure was intermittent, but this is looking good.
> 
> > I'd also appreciate if people had a look whether the approach I took looks
> > sensible.
> 
> Looks sensible, just the kref comment.
> 
> I also don't see a need to try to tag on the bdi device name reuse
> into this series. I'm wondering if we can handle that separately with
> device_rename(bdi->dev, ...) when we know scsi is done with the old
> bdi but it has not finished being deleted

What's the status of the device name issue? We're hitting it a lot here.
It's really easy to reproduce with scsi_debug, script attached. I'd be
happy to test out any patches.

--HcAYCG3uE/tztfnV
Content-Type: application/x-sh
Content-Disposition: attachment; filename="stress_test_scsi_debug.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aset -eu=0A=0Ausage () {=0A	USAGE_STRING=3D"Usage: $0 [-H H=
OSTS] [-t TARGETS]=0A$0 -h=0A=0AOptions:=0A  -H    number of SCSI hosts (de=
fault: 1)=0A  -t    number of SCSI targets per host (default: 1)=0A=0AMisce=
llaneous:=0A  -h    display this help message and exit"=0A=0A	case "$1" in=
=0A		out)=0A			echo "$USAGE_STRING"=0A			exit 0=0A			;;=0A		err)=0A			echo =
"$USAGE_STRING" >&2=0A			exit 1=0A			;;=0A	esac=0A}=0A=0Anum_hosts=3D1=0Anu=
m_targets=3D1=0A=0Awhile getopts "hH:t:" OPT; do=0A	case "$OPT" in=0A		H)=
=0A			num_hosts=3D"$OPTARG"=0A			;;=0A		t)=0A			num_targets=3D"$OPTARG"=0A	=
		;;=0A		h)=0A			usage "out"=0A			;;=0A		*)=0A			usage "err"=0A			;;=0A	esa=
c=0Adone=0A=0Amodprobe -r scsi_debug=0Amodprobe scsi_debug add_host=3D"${nu=
m_hosts}" num_tgts=3D"${num_targets}"=0A=0Ahosts=3D()=0Afor scsi_host in /s=
ys/class/scsi_host/*; do=0A	if grep '^scsi_debug' "${scsi_host}/proc_name" =
>/dev/null 2>&1; then=0A		host=3D"$(basename "${scsi_host}")"=0A		hosts+=3D=
("${host#host}")=0A	fi=0Adone=0A=0Atargets=3D()=0Afor host in "${hosts[@]}"=
; do=0A	for scsi_disk in "/sys/class/scsi_disk/${host}:"*; do=0A		targets+=
=3D("$(basename "${scsi_disk}")")=0A	done=0Adone=0A=0Aecho "Hosts: ${hosts[=
@]}"=0Aecho "Targets: ${targets[@]}"=0A=0Aprocesses=3D()=0Afor target in "$=
{targets[@]}"; do=0A	(=0A	host=3D"${target%%:*}"=0A	scan=3D"${target#*:}"=
=0A	scan=3D"${scan//:/ }"=0A	while true; do=0A		echo 1 > "/sys/class/scsi_d=
isk/${target}/device/delete"=0A		echo "${scan}" > "/sys/class/scsi_host/hos=
t${host}/scan"=0A	done=0A	) &=0A	processes+=3D($!)=0Adone=0Await=0A
--HcAYCG3uE/tztfnV--
