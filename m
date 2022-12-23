Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA8C4332F
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 15:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLWP4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 10:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWP4m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 10:56:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6A379E1
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BNX8VLljCWB7Hky5keRLcIjg+3UcTIifKDcoXrG5Ok8=; b=q7E7VpPzOKI/IYW6NZOGgqKoYR
        0mk1h8/n2FlHPdDr3dTjxB2zT3RCbo1T4rK9AyGL+mE5XShABvRb5LCMMyVskuFYGkXAo7Qw1fRQD
        9IDn0AjDsriHMd7lAWU6ZVoJlAd7iSRSJf8BI9kzLZD9oUoEeLmDiZBNtjZvoqkaO9c22822c80w3
        Uh0S0MTKMmwQslDtLB/Z0Za9rEvGVz42MQyfnAhAZMlMO8cG2gRWvU+hNfZM6EFziGy3DOjDX/4R+
        /LIuNoprqK0XX7yfDZ2rEHpLR/4xQtfBpMmFlXG8B2aFdznBXtBCMmrF6RVNWTFf5sVLb5sODjNEk
        kXAKKoxg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8kPT-009hVz-AM; Fri, 23 Dec 2022 15:56:35 +0000
Date:   Fri, 23 Dec 2022 07:56:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>, bvanassche@acm.org
Cc:     osandov@fb.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme
 character device
Message-ID: <Y6XPs3MoyltFvEYT@bombadil.infradead.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
 <CGME20221221103532epcas5p2c806adb12a32e259438511a584216c11@epcas5p2.samsung.com>
 <20221221103441.3216600-3-mcgrof@kernel.org>
 <20221223131137.GA27984@green>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223131137.GA27984@green>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 23, 2022 at 06:41:37PM +0530, Kanchan Joshi wrote:
> On Wed, Dec 21, 2022 at 02:34:37AM -0800, Luis Chamberlain wrote:
> > This does basic rand-read testing of the character device of a
> > conventional NVMe drive.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> > tests/nvme/046     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > tests/nvme/046.out |  2 ++
> > 2 files changed, 44 insertions(+)
> > create mode 100755 tests/nvme/046
> > create mode 100644 tests/nvme/046.out
> > 
> > diff --git a/tests/nvme/046 b/tests/nvme/046
> > new file mode 100755
> > index 000000000000..3526ab9eedab
> > --- /dev/null
> > +++ b/tests/nvme/046
> > @@ -0,0 +1,42 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
> > +#
> > +# This does basic sanity test for the nvme character device. This is a basic
> > +# test and if it fails it is probably very likely other nvme character device
> > +# tests would fail.
> > +#
> > +. tests/nvme/rc
> > +
> > +DESCRIPTION="basic rand-read io_uring_cmd engine for nvme-ns character device"
> > +QUICK=1
> > +
> > +requires() {
> > +	_nvme_requires
> > +	_have_fio
> > +}
> > +
> > +device_requires() {
> > +	_require_test_dev_is_nvme
> > +}
> > +
> > +test_device() {
> > +	echo "Running ${TEST_NAME}"
> > +	local ngdev=${TEST_DEV/nvme/ng}
> > +	local fio_args=(
> > +		--size=1M
> > +		--cmd_type=nvme
> > +		--filename="$ngdev"
> > +		--time_based
> > +		--runtime=10
> > +	) &&
> 
> Is this && needed?

This form was inspired by commit 238c7e0b by Bart, but yeah you're
right, I can't see any reason for it, so we can clean zbd/010 from it too.
> 
> > +	_run_fio_rand_iouring_cmd "${fio_args[@]}" >>"${FULL}" 2>&1 ||
> 
> Something to change here (and therefore in other patches too).
> If we change "cmd_type = something_random", test continues to show the
> success while it should show failure.

Definitely no bueno.

> How about changing above line to:
> _run_fio_rand_iouring_cmd "${fio_args[@]}" || fail=true

We'd loose the 046.full log then.

If we just return $? at the end of _run_fio_rand_iouring_cmd() that
seems to fix the undetected error. Whatyda think?

I noticed an odd thing in the last two patches which work for zone
storage, if I change the runtime it doesn't take longer, so I think
something is still off there too... can you take a look?

  Luis
