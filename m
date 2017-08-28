Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbdH1VEJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 17:04:09 -0400
Date: Mon, 28 Aug 2017 14:04:07 -0700
From: Shaohua Li <shli@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] block/nullb: delete unnecessary memory free
Message-ID: <20170828210407.ksbt6ayak3ziurwb@kernel.org>
References: <9df1970109b84fc170530a5ffa5c07e4480e445f.1503953204.git.shli@fb.com>
 <2614b8bd-ed7a-7953-6d14-7e05850fe88b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2614b8bd-ed7a-7953-6d14-7e05850fe88b@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 28, 2017 at 02:55:59PM -0600, Jens Axboe wrote:
> On 08/28/2017 02:49 PM, Shaohua Li wrote:
> > Commit 2984c86(nullb: factor disk parameters) has a typo. The
> > nullb_device allocation/free is done outside of null_add_dev. The commit
> > accidentally frees the nullb_device in error code path.
> 
> Is the code in nullb_device_power_store() correct after this?

Yes, for runtime disk configuration, we allocate the device in
nullb_group_make_item and free the device in nullb_device_release. the
nullb_device_power_store only does null_add_dev/null_del_dev, not allocate/free
dev.

> Also, looks like the second else if in there should be using
> 'dev' instead of to_nullb_device(item)->power.

Ah, yes, it should be 'dev->power'. dev == to_nullb_device(item). Do you want
me to send a separate patch to do the cleanup?

Thanks,
Shaohua
