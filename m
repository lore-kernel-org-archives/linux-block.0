Return-Path: <arvindkumar@vmware.com>
From: Arvind Kumar <arvindkumar@vmware.com>
To: Sitsofe Wheeler <sitsofe@gmail.com>, Tom Yan <tom.ty89@gmail.com>
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, Shaohua Li <shli@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, VMware PV-Drivers <pv-drivers@vmware.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Vandrovec
	<petr@vmware.com>
Subject: Re: BLKZEROOUT not zeroing md dev on VMDK
Date: Wed, 15 Jun 2016 18:17:37 +0000
Message-ID: <1466014718999.6976@vmware.com>
References: <20160518223616.GA409@sucs.org>
	<20160527041824.GC9418@birch.djwong.org>
	<CALjAwxgkgPZdXFkOuD-7Dsbxf9oVEGuXTDLnyqu8rTrJio_4mA@mail.gmail.com>
	<CAGnHSEn0ntEw_dwFNqG6CdgwcpHzQie88jgA21uioKhBbcByTg@mail.gmail.com>,<CALjAwxgdr1zSgZZzNA9BQ8Ta+UuutJ6iuBnqZfmV-BTCDL2PbA@mail.gmail.com>
In-Reply-To: <CALjAwxgdr1zSgZZzNA9BQ8Ta+UuutJ6iuBnqZfmV-BTCDL2PbA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

It is possibly some race. We saw a WRITE SAME related issue in past for whi=
ch Petr sent out a patch but looks like the patch didn't make it. :(=0A=
=0A=
https://groups.google.com/forum/#!topic/linux.kernel/1WGDSlyY0y0=0A=
=0A=
Thanks!=0A=
Arvind=0A=
________________________________________=0A=
From: Sitsofe Wheeler <sitsofe@gmail.com>=0A=
Sent: Tuesday, May 31, 2016 10:04 PM=0A=
To: Tom Yan=0A=
Cc: Darrick J. Wong; Shaohua Li; Jens Axboe; Arvind Kumar; VMware PV-Driver=
s; linux-raid@vger.kernel.org; linux-scsi@vger.kernel.org; linux-block@vger=
.kernel.org; linux-kernel@vger.kernel.org=0A=
Subject: Re: BLKZEROOUT not zeroing md dev on VMDK=0A=
=0A=
On 27 May 2016 at 10:30, Tom Yan <tom.ty89@gmail.com> wrote:=0A=
> There seems to be some sort of race condition between=0A=
> blkdev_issue_zeroout() and the scsi disk driver (disabling write same=0A=
> after an illegal request). On my UAS drive, sometimes `blkdiscard -z=0A=
> /dev/sdX` will return right away, even though if I then check=0A=
> `write_same_max_bytes` it has turned 0. Sometimes it will just write=0A=
> zero with SCSI WRITE even if `write_same_max_bytes` is 33553920 before=0A=
> I issue `blkdiscard -z` (`write_same_max_bytes` also turned 0, as=0A=
> expected).=0A=
>=0A=
> Not sure if it is directly related to the case here though.=0A=
=0A=
I'm not aware of hitting that particular problem myself directly on=0A=
the underlying "SCSI" device but the patch on=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.kernel.org=
_patch_9137311_&d=3DCwIBaQ&c=3DSqcl0Ez6M0X8aeM67LKIiDJAXVeAw-YihVMNtXt-uEs&=
r=3DbUMaNc7nC9xbXtaMJrOvIIPNpPH0chY2kdRsskQn6GY&m=3Drx_5ntfhkt2GOpfjpiQjoCb=
5n4gCY7jKznXO0gKYcVI&s=3DW1F45VBu8NDxu2ImcbKM5b3d6UnUCLGgH8xEM9e6JQk&e=3D  =
should be able to resolve=0A=
that issue. Could you test it and follow up on=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__permalink.gmane.org_g=
mane.linux.kernel_2229377&d=3DCwIBaQ&c=3DSqcl0Ez6M0X8aeM67LKIiDJAXVeAw-YihV=
MNtXt-uEs&r=3DbUMaNc7nC9xbXtaMJrOvIIPNpPH0chY2kdRsskQn6GY&m=3Drx_5ntfhkt2GO=
pfjpiQjoCb5n4gCY7jKznXO0gKYcVI&s=3D9ekqmTk18vzcwcY0SSMF8AZnJ_lWezFIM8tDvQqe=
DHI&e=3D  ? I'm hoping=0A=
more testing reports will lead to the patch being reviewed and=0A=
accepted sooner rather than later as it's currently stalled...=0A=
=0A=
--=0A=
Sitsofe | https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__sucs.org_-7=
Esits_&d=3DCwIBaQ&c=3DSqcl0Ez6M0X8aeM67LKIiDJAXVeAw-YihVMNtXt-uEs&r=3DbUMaN=
c7nC9xbXtaMJrOvIIPNpPH0chY2kdRsskQn6GY&m=3Drx_5ntfhkt2GOpfjpiQjoCb5n4gCY7jK=
znXO0gKYcVI&s=3DarwniVbdl5KJZfyreWLhq-WUlgvKAf_eW1i6D2GbFGQ&e=3D=0A=
