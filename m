Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 11 Jun 2018 13:40:09 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>
Subject: Re: [PATCH] block/021: test setting 'nr_requests'
Message-ID: <20180611204009.GA10337@vader>
References: <20180602050204.20786-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180602050204.20786-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 02, 2018 at 01:02:04PM +0800, Ming Lei wrote:
> 'nr_requests' can be a bit different for 'none' scheduler,
> and especially current blk-mq can only decrease this value
> for 'none.'
> 
> The patch of 'blk-mq: fix read/write 'nr_requests' in case of 'none' scheduler'
> has been sent out for fixing this issue.

Applied with a couple of fixes mentioned below.

> Cc: Marco Patalano <mpatalan@redhat.com>
> Cc: "Ewan D. Milne" <emilne@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/021     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/021.out |  2 ++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/block/021
>  create mode 100755 tests/block/021.out
> 
> diff --git a/tests/block/021 b/tests/block/021
> new file mode 100755
> index 000000000000..b72d9bd8b41d
> --- /dev/null
> +++ b/tests/block/021
> @@ -0,0 +1,51 @@
> +#!/bin/bash
> +#
> +# Test blk-mq request allocation when hardware tags are limited. Regression
> +# test for commit e6fc46498784 ("blk-mq: avoid starving tag allocation after
> +# allocating process migrates").

This wasn't updated for this test. I fixed it.

> +# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
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
> +DESCRIPTION="read/write nr_requests on null-blk with different scheduler"
> +QUICK=1
> +
> +requires() {
> +	_have_module null_blk
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	modprobe -r null_blk
> +	modprobe null_blk
> +
> +	local scheds
> +	# shellcheck disable=SC2207
> +	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
> +
> +	for sched in "${scheds[@]}"; do
> +		echo "Testing $sched" >> "$FULL"
> +		echo "$sched" > /sys/block/nullb0/queue/scheduler
> +		max_nr=`cat /sys/block/nullb0/queue/nr_requests`

I changed this to the preferred $() style command substitution.

> +		for nr in `seq 4 $max_nr`; do

I changed this to the preferred bash for loop syntax.

> +			echo $nr > /sys/block/nullb0/queue/nr_requests
> +		done
> +	done
> +
> +	modprobe -r null_blk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/021.out b/tests/block/021.out
> new file mode 100755
> index 000000000000..3a397c5c8ff5
> --- /dev/null
> +++ b/tests/block/021.out
> @@ -0,0 +1,2 @@
> +Running block/021
> +Test complete
> -- 
> 2.9.5
> 
