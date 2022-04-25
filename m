Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEACC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 07:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiDYHwE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiDYHvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 03:51:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C91116
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 00:48:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70EA868AA6; Mon, 25 Apr 2022 09:48:42 +0200 (CEST)
Date:   Mon, 25 Apr 2022 09:48:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <20220425074842.GA9787@lst.de>
References: <20220423143952.3162999-1-ming.lei@redhat.com> <20220423143952.3162999-3-ming.lei@redhat.com> <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de> <YmUX/Q9o08rOSTaQ@T590> <682a215d-de50-40f1-b6f8-48801617bcad@suse.de> <YmU86/YZ18CtbLgb@T590> <YmVUl8m0Kak4JeKa@kroah.com> <YmX5O0dzHs09aFbh@T590> <YmYtVnC3QzfukbSu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmYtVnC3QzfukbSu@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 25, 2022 at 07:10:46AM +0200, Greg Kroah-Hartman wrote:
> > But what is wrong with the test? Isn't it reasonable to keep debugfs dir
> > when blktrace is collecting log?
> 
> How can you collect something from a device that is gone?
> 
> > After debugfs dir is removed, blktrace may not collect intact log, and
> > people may complain it is one kernel regression.
> 
> What exactly breaks?  The device is removed, why should a trace continue
> to give you data?

This is a good question.  All but one of the block device drivers
really only have a concept of a block "queue" that is attached to a
live block device.  In that case the awnser is simple and obvious.

But SCSI allocates these queues before the block device, and they can
outlive it, because SCSI is a layered architecture where the "upper level"
drivers like sd and st are only bound to the queue based on information
returned from it, and the queue can outlive unbinding these drivers
(which is a bit pointless but possible due to full device model
integration).

So there might be some uses cases to keep on tracing.  I don't think they
are very valid, though, because if you really want to trace that raw
queue you can do it using the /dev/sg node.

