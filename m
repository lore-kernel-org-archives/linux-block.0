Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753187AbdLDI30 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Dec 2017 03:29:26 -0500
Date: Mon, 4 Dec 2017 16:29:23 +0800
From: Eryu Guan <eguan@redhat.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] generic/473: test return EBUSY from BLKRRPART for
 mounted whole-dev
Message-ID: <20171204082923.GF2749@eguan.usersys.redhat.com>
References: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 29, 2017 at 08:02:26PM +0800, Xiao Yang wrote:
> If the entire block device is formatted with a filesystem and
> mounted, running "blockdev --rereadpt" should fail and return
> EBUSY instead of pass.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

As we have blktests[1] now, I think this may fit in blktests better?

Thanks,
Eryu

[1] https://github.com/osandov/blktests

> ---
>  tests/generic/473     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/473.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100755 tests/generic/473
>  create mode 100644 tests/generic/473.out
> 
> diff --git a/tests/generic/473 b/tests/generic/473
> new file mode 100755
> index 0000000..d7998cd
> --- /dev/null
> +++ b/tests/generic/473
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# FS QA Test No. 473
> +#
> +# Regression test for commit:
> +# 77032ca ("Return EBUSY from BLKRRPART for mounted whole-dev fs")
> +#
> +# If the entire block device is formatted with a filesystem and
> +# mounted, running "blockdev --rereadpt" should fail and return
> +# EBUSY.  On buggy kernel, it passes unexpectedly.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
> +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmpdir=`mktemp -d`
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 7 15
> +
> +_cleanup()
> +{
> +	# Umount
> +	$UMOUNT_PROG $tmpdir >>$seqres.full 2>&1
> +	# Destroy device
> +        _put_scsi_debug_dev
> +	rm -rf $tmpdir
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/scsi_debug
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_os Linux
> +_require_scsi_debug
> +
> +# Create and format
> +test_dev=`_get_scsi_debug_dev`
> +_mkfs_dev $test_dev >>$seqres.full 2>&1
> +
> +# Mount and check mounted whole-dev
> +_mount $test_dev $tmpdir
> +
> +out=$(blockdev --rereadpt $test_dev 2>&1)
> +res=$?
> +
> +echo $out | grep -q "Unknown command" && \
> +	_notrun "blockdev --rereadpt was not supported"
> +
> +[ $res -eq 0 ] && _fail "blockdev --rereadpt passed when checking mounted whole-dev"
> +
> +echo $out | grep -q "Device or resource busy" || \
> +	_fail "blockdev --rereadpt returned unexpected error when checking mounted whole-dev"
> +
> +echo $out >> $seqres.full
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/473.out b/tests/generic/473.out
> new file mode 100644
> index 0000000..854fbcd
> --- /dev/null
> +++ b/tests/generic/473.out
> @@ -0,0 +1,2 @@
> +QA output created by 473
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 6c3bb03..54b9404 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -472,3 +472,4 @@
>  467 auto quick exportfs
>  468 shutdown auto quick metadata
>  469 auto quick
> +473 auto quick blockdev
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
