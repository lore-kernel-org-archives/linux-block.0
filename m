Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/10] block: Fix block device shutdown related races
Date: Thu, 09 Feb 2017 12:52:47 -0200
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-Id: <3243095.TlNvkxZ2GK@morokweng>
List-ID: <linux-block@vger.kernel.org>

Hello Jan,

Am Donnerstag, 9. Februar 2017, 13:44:23 BRST schrieb Jan Kara:
> People, please have a look at patches. The are mostly simple however the
> interactions are rather complex so I may have missed something. Also I'm
> happy for any additional testing these patches can get - I've stressed th=
em
> with Omar's script, tested memcg writeback, tested static (not udev manag=
ed)
> device inodes.

Thank you for these fixes. I will have them tested and report back how it=20
goes.

Can you tell which branch I should apply them on? I tried a number of branc=
hes=20
in linux-block (and applied the bdi lifetime v3 patches if the branch didn'=
t=20
already had them) but this series either didn't apply or the build failed=20
with:

/home/bauermann/trabalho/src/linux-2.6.git/fs/block_dev.c: In function=20
=E2=80=98bd_acquire=E2=80=99:
/home/bauermann/trabalho/src/linux-2.6.git/fs/block_dev.c:1063:13: error:=20
passing argument 1 of =E2=80=98bd_forget=E2=80=99 from incompatible pointer=
 type [-
Werror=3Dincompatible-pointer-types]
   bd_forget(bdev);
             ^
In file included from /home/bauermann/trabalho/src/linux-2.6.git/include/
linux/device_cgroup.h:1:0,
                 from /home/bauermann/trabalho/src/linux-2.6.git/fs/
block_dev.c:14:
/home/bauermann/trabalho/src/linux-2.6.git/include/linux/fs.h:2351:13: note=
:=20
expected =E2=80=98struct inode *=E2=80=99 but argument is of type =E2=80=98=
struct block_device *=E2=80=99
 extern void bd_forget(struct inode *inode);
             ^
cc1: some warnings being treated as errors


=2D-=20
Thiago Jung Bauermann
IBM Linux Technology Center
