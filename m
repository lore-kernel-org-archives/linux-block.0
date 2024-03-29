Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD806A028
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714262; cv=none; b=WwzJgtiJOx/uVgguDnKYUu2FuPbaW1HMx+NoTYMMEA+xQQH1GvWI2q3TEmjLsjT9Ej7FtY0W2evgz6zV4VjU2z0wcGZDlpreoH7m5oXDZC0wzF48gJBlpR+MU/iGTlcQiGQ/O7Iw3LiQHTUuBHV7r0sx+h0YYutFnroRZZwzTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714262; c=relaxed/simple;
	bh=vXY+PY67OBmXbY1HgggxRR0X80dVFyU4YNIRC/YglVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uorEIrFz9kCadGdgWEnoikboe8JGqBNW0xItpVKG+rurqoFmmBliNf1LnCqevhZbD+N1kUQGmmtZivAcKGZXEMgKl9ZhvxE5hV5TjyfiZRBGrsaENRA3mhEKIDDGm/pVJvFezGZmyIN0cVkz0kAJ317pyxeZkRa045jd4ylaLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa4kVYZh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa4kVYZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F290C433C7;
	Fri, 29 Mar 2024 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711714262;
	bh=vXY+PY67OBmXbY1HgggxRR0X80dVFyU4YNIRC/YglVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sa4kVYZhi1wlo8u1o7/G7g2ZkNa4SSGyTi/yaRrYbeNJ3I/9BizRISg/XidCTBYCi
	 H8VEnrayfi7A/iq6dkLPHw5I7pFFlkJzt3KIJR7eIxnyEcVb1Z46QXmOn0VLsTatUF
	 ASS9RrB7av+o4wvrclwC8J9z6LFYcQKhir1h07di7Gr8DvqWtFFlhyKPRd8krs5Q+r
	 rA8qhUyrx5ttGFjnWfm2Vhh2x9+wEw2DG+B+IA8Lw8BS8/QqStmfOfTStcvYkJgTs9
	 BJoW+R4ofqLdO5uRRtvJWpnNp0kGgqXK3vyJZHxAh5nTdmidXSzJcMquY6MTSyDmw+
	 SfREZdQfC0fDw==
Date: Fri, 29 Mar 2024 13:10:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240329-erosion-zerreden-c65a45286fae@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <ZgZJ54rW2JcWsYPA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgZJ54rW2JcWsYPA@casper.infradead.org>

On Fri, Mar 29, 2024 at 04:56:07AM +0000, Matthew Wilcox wrote:
> On Sat, Mar 23, 2024 at 05:11:19PM +0100, Christian Brauner wrote:
> > Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> > default this option is set. When it is set the long-standing behavior
> > of being able to write to mounted block devices is enabled.
> > 
> > But in order to guard against unintended corruption by writing to the
> > block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> > off. In that case it isn't possible to write to mounted block devices
> > anymore.
> > 
> > A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> > which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> > bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> > the mode was passed around. Since we managed to get rid of the bdev
> > handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> > on whether the file was opened writable and writes to that block device
> > are blocked. That logic doesn't work because we do allow
> > BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> > 
> > So fix the detection logic. Use O_EXCL as an indicator that
> > BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> > for pidfds where O_EXCL means that this is a pidfd that refers to a
> > thread. For userspace open paths O_EXCL will never be retained but for
> > internal opens where we open files that are never installed into a file
> > descriptor table this is fine.
> > 
> > Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> > directly be raised by userspace. It is implicitly raised during
> > mounting.
> > 
> > Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> > unset.
> > 
> > Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> So v1 of this patch works fine.  I just got round to testing v2, and it
> does not.  Indeed, applying 2/2 causes root to fail to mount:
> 
> /dev/root: Can't open blockdev
> List of all bdev filesystems:
>  ext3
>  ext2
>  ext4
>  xfs
> 
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(254,0)
> 
> Applying only 1/2 boots but fails to fix the bug.

Thanks for testing this. This is odd because I tested with the setup you
provided.

I used the kernel config you sent to me in [2] with an xfs root device
with direct kernel boot and the following xfstests config in [3]. I'm
booting the vm with:

qemu-system-x86_64 -machine type=q35 -smp 1 -m 4G -accel kvm -cpu max -nographic -nodefaults \
        -chardev stdio,mux=on,id=console,signal=off -serial chardev:console -mon console \
        -kernel /home/ubuntu/data/mkosi-kernel2/mkosi.output.debian/image.vmlinuz \
        -drive file=/home/ubuntu/data/mkosi-kernel2/mkosi.output.debian/image.raw,format=raw,if=virtio \
        -append "console=ttyS0 root=/dev/vda2 module_blacklist=vmw_vmci systemd.tty.term.ttyS0=screen-256color systemd.tty.columns.ttyS0=96 systemd.tty.rows.ttyS0=46 debug loglevel=4 SYSTEMD_"

Note that the config you gave me in [2] didn't include
CONFIG_SCSI_VIRTIO=y which means I got the splat you did. I added this
missing config option and everything worked fine for me.

Can you please test what's in the vfs.fixes branch on
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git so we're
sure that we're testing the same thing?

The failures that I see are:

Failures: generic/042 generic/645 generic/682 generic/689 xfs/014
xfs/017 xfs/049 xfs/129 xfs/176 xfs/206 xfs/216 xfs/234 xfs/250 xfs/289
xfs/558 xfs/559
Failed 16 of 930 tests

* generic/645 fails because it requires an unrelated fix to fstests
  because we changed idmapped mounts to not not allow empty idmappings.
* generic/689 fails because the providec config doesn't compile tmpfs with POSIX ACL support
* xfs/558 and xfs/559 complain about missing logging
  about iomap validation and are unrelated
* All other failures are caused by loop devices which is expected unil
  a util-linux is released that contains Jan's fix in [1] so that
  mount(8) doesn't hold a writable fd to the loop device anymore and
  instead simply uses a read-only one.

[1]: https://github.com/util-linux/util-linux/commit/1cde32f323e0970f6c7f35940dcc0aea97b821e5
[2]: https://lore.kernel.org/r/Zf18I2UOGQxeN-Z1@casper.infradead.org
[3]:
#! /bin/bash

set -x

cd ~/src/git/xfstests-dev/
FIRST_DEV=/dev/vda3
SECOND_DEV=/dev/vda4
THIRD_DEV=/dev/vda5

echo "Testing xfs"
cat <<EOF >local.config
FSTYP=xfs
export TEST_DEV=${FIRST_DEV}
export SCRATCH_DEV=${SECOND_DEV}
export LOGWRITE_DEV=${THIRD_DEV}
export TEST_DIR=/mnt/test
export SCRATCH_MNT=/mnt/scratch
EOF

sudo mkfs.xfs -f ${FIRST_DEV}
sudo mkfs.xfs -f ${SECOND_DEV}
sudo mkfs.xfs -f ${THIRD_DEV}
sudo ./check -g quick
