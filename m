Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41181 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeDYPaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Apr 2018 11:30:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id m21so10587089pgv.8
        for <linux-block@vger.kernel.org>; Wed, 25 Apr 2018 08:30:39 -0700 (PDT)
Date: Wed, 25 Apr 2018 08:30:36 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] nvme: add a regression test for UUID ns
 descriptops
Message-ID: <20180425153036.GA30070@vader>
References: <20180424161251.6502-1-jthumshirn@suse.de>
 <20180424161251.6502-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180424161251.6502-3-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 24, 2018 at 10:12:51AM -0600, Johannes Thumshirn wrote:
> Add a regression test for NVMe 1.3's UUID Namespace Descriptors.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Thanks, Johannes, applied. A couple of comments below for future
reference.

> ---
>  tests/nvme/004     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/004.out |  4 +++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tests/nvme/004
>  create mode 100644 tests/nvme/004.out
> 
> diff --git a/tests/nvme/004 b/tests/nvme/004
> new file mode 100755
> index 000000000000..cc1c3fd41b25
> --- /dev/null
> +++ b/tests/nvme/004
> @@ -0,0 +1,74 @@
> +#!/bin/bash
> +#
> +# Regression test for commits d934f9848a77 ("nvme: provide UUID value to
> +# userspace") and 6484f5d16f9d ("nvme: also provide a UUID in the WWID sysfs
> +# attribute")
> +#
> +# Copyright (C) 2018 Johannes Thumshirn
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
> +# TODO: fill in a very brief description of what this test does. The
> +# description should complete the sentence "This test will...". For example,
> +# "run a mixed read/write workload" would be a good description.

The TODO comment was leftover here, I removed it.

> +DESCRIPTION="Test nvme and nvmet UUID NS descriptors"
> +
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_module nvme-loop && _have_module loop \
> +	    && _have_configfs
> +}
> +
> +_find_nvme_loop_dev() {
> +	for dev in /sys/block/nvme*; do
> +		dev="$(basename $dev)"

There's some missing quoting around "$dev" here. There's also some more
missing quoting, `make shellcheck` will catch this sort of thing.
