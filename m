Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:43566 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeENVBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 May 2018 17:01:38 -0400
Received: by mail-pg0-f53.google.com with SMTP id p8-v6so2470814pgq.10
        for <linux-block@vger.kernel.org>; Mon, 14 May 2018 14:01:38 -0700 (PDT)
Date: Mon, 14 May 2018 14:01:36 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 blktests] nvme: Add command timeout injection test
Message-ID: <20180514210136.GE13417@vader>
References: <20180514204241.15300-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514204241.15300-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 14, 2018 at 02:42:41PM -0600, Keith Busch wrote:
> This test will run a background IO process and inject an admin command
> with a very short timeout that is all but guaranteed to expire without
> a completion: the async event request.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> v1 -> v2:
> 
>   Changed description since its not a test for a specific
>   regression-fixing patch.
> 
>   Added fio requirement.
> 
>   Missing quotes around device name.

I tried this on my QEMU VM, which apparently doesn't emulate this
command:

$ sudo ./check nvme/006
nvme/006 => nvme0n1 (test nvme admin command timeout handling with in-flight io) [failed]
runtime     ...  20.505s
    --- tests/nvme/006.out      2018-05-14 13:43:31.150443366 -0700
    +++ results/nvme0n1/nvme/006.out.bad        2018-05-14 13:57:39.334671448 -0700
    @@ -1,3 +1,3 @@
     Running nvme/006
    -passthru: Interrupted system call
    +NVMe Status:INVALID_OPCODE(4001) Command Result:00000000
     Test complete

Can this test use a loopback target like the nvme tests Johannes has
added recently?

>  tests/nvme/005     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/005.out |  3 +++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nvme/005
>  create mode 100644 tests/nvme/005.out
> 
> diff --git a/tests/nvme/005 b/tests/nvme/005
> new file mode 100755
> index 0000000..f2fcf19
> --- /dev/null
> +++ b/tests/nvme/005
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +#
> +# Test for nvme timeout handling with inflight IO.
> +#
> +# Copyright (C) 2018 Keith Busch <keith.busch@intel.com>
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation, either version 3 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +DESCRIPTION="test nvme admin command timeout handling with in-flight io"
> +
> +QUICK=1
> +
> +requires() {
> +	_have_fio && _have_program nvme
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# start fio job
> +	_run_fio_rand_io --filename="${TEST_DEV}" --time_based --runtime=20 &
> +
> +	sleep 5
> +
> +	# send nvme admin command 'async event request', which  will surely time out
> +	nvme admin-passthru "${TEST_DEV}" -o 0xc --timeout=1
> +
> +	wait
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/005.out b/tests/nvme/005.out
> new file mode 100644
> index 0000000..f4ff837
> --- /dev/null
> +++ b/tests/nvme/005.out
> @@ -0,0 +1,3 @@
> +Running nvme/005
> +passthru: Interrupted system call
> +Test complete
> -- 
> 2.14.3
> 
