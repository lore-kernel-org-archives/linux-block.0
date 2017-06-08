Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Fix loop device flush before configure v3
To: James Wang <jnwang@suse.com>, efault@gmx.de
Cc: ming.lei@redhat.com, hare@suse.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, mgorman@suse.com
References: <20170608065251.13961-1-jnwang@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7f7d3164-3e0b-25a1-10fd-1cbdf7d2167d@kernel.dk>
Date: Thu, 8 Jun 2017 08:04:57 -0600
MIME-Version: 1.0
In-Reply-To: <20170608065251.13961-1-jnwang@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 12:52 AM, James Wang wrote:
> While installing SLES-12 (based on v4.4), I found that the installer
> will stall for 60+ seconds during LVM disk scan.  The root cause was
> determined to be the removal of a bound device check in loop_flush()
> by commit b5dd2f6047ca ("block: loop: improve performance via blk-mq").
> 
> Restoring this check, examining ->lo_state as set by loop_set_fd()
> eliminates the bad behavior.
> 
> Test method:
> modprobe loop max_loop=64
> dd if=/dev/zero of=disk bs=512 count=200K
> for((i=0;i<4;i++))do losetup -f disk; done
> mkfs.ext4 -F /dev/loop0
> for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
> for f in `ls /dev/loop[0-9]*|sort`; do \
> 	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
> 	done
> 
> Test output:  stock          patched
> /dev/loop0    18.1217e-05    8.3842e-05
> /dev/loop1     6.1114e-05    0.000147979
> /dev/loop10    0.414701      0.000116564
> /dev/loop11    0.7474        6.7942e-05
> /dev/loop12    0.747986      8.9082e-05
> /dev/loop13    0.746532      7.4799e-05
> /dev/loop14    0.480041      9.3926e-05
> /dev/loop15    1.26453       7.2522e-05
> 
> Note that from loop10 onward, the device is not mounted, yet the
> stock kernel consumes several orders of magnitude more wall time
> than it does for a mounted device.
> (Thanks for Mike Galbraith <efault@gmx.de>, give a changelog review.)

Added for 4.12, thanks.

-- 
Jens Axboe
