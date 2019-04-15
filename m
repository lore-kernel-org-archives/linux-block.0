Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F6C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979BF2147C
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555340571;
	bh=1fVV1JgqcVW29uOqxVTY3nmm1k5uTLEoPYMGOLAIEPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=miTVDjslvuagyE19iiNTxae0nKjtL0T1Hc2QJDHsix2WvH+J70N3EUjIcI+f4gK2q
	 PcA/uYTjP/s+wio21X9YW1pJXJFb2+VwKBj9bdB+LxSM92kgzihgtyitG7Z3pT/HTr
	 eZYbud8tZxSudddkpziXNga+ce1rl/NGsstOD60Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfDOPCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:02:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:11131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfDOPCu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 11:02:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 08:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="149582185"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 08:02:49 -0700
Date:   Mon, 15 Apr 2019 09:04:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: fix use-after-free on gendisk
Message-ID: <20190415150440.GB7312@localhost.localdomain>
References: <20190402120634.51040-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402120634.51040-1-yuyufen@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 05:06:34AM -0700, Yufen Yu wrote:
> commit 2da78092dda "block: Fix dev_t minor allocation lifetime"
> specifically moved blk_free_devt(dev->devt) call to part_release()
> to avoid reallocating device number before the device is fully
> shutdown.
> 
> However, it can cause use-after-free on gendisk in get_gendisk().
> We use md device as example to show the race scenes:
> 
> Process1		Worker			Process2
> md_free
> 						blkdev_open
> del_gendisk
>   add delete_partition_work_fn() to wq
>   						__blkdev_get
> 						get_gendisk
> put_disk
>   disk_release
>     kfree(disk)
>     						find part from ext_devt_idr
> 						get_disk_and_module(disk)
>     					  	cause use after free
> 
>     			delete_partition_work_fn
> 			put_device(part)
>     		  	part_release
> 		    	remove part from ext_devt_idr
> 
> Before <devt, hd_struct pointer> is removed from ext_devt_idr by
> delete_partition_work_fn(), we can find the devt and then access
> gendisk by hd_struct pointer. But, if we access the gendisk after
> it have been freed, it can cause in use-after-freeon gendisk in
> get_gendisk().
> 
> We fix this by adding a new helper blk_invalidate_devt() in
> delete_partition() and del_gendisk(). It replaces hd_struct
> pointer in idr with value 'NULL', and deletes the entry from
> idr in part_release() as we do now.
> 
> Thanks to Jan Kara for providing the solution and more clear comments
> for the code.
> 
> Fixes: 2da78092dda1 ("block: Fix dev_t minor allocation lifetime")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
