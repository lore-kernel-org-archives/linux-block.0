Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiCXRZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCXRZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 13:25:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28DB2FFC5
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:23:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B63BF68C7B; Thu, 24 Mar 2022 18:23:35 +0100 (CET)
Date:   Thu, 24 Mar 2022 18:23:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220324172335.GA28299@lst.de>
References: <20220324075119.1556334-1-hch@lst.de> <20220324075119.1556334-13-hch@lst.de> <20220324141321.pqesnshaswwk3svk@quack3.lan> <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 11:24:43PM +0900, Tetsuo Handa wrote:
> On 2022/03/24 23:13, Jan Kara wrote:
> >> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> >> index b3170e8cdbe95..e1eb925d3f855 100644
> >> --- a/drivers/block/loop.c
> >> +++ b/drivers/block/loop.c
> >> @@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
> >>  	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
> >>  	 * command to fail with EBUSY.
> >>  	 */
> >> -	if (atomic_read(&lo->lo_refcnt) > 1) {
> >> +	if (disk_openers(lo->lo_disk) > 1) {
> 
> This is sometimes "if (0) {" due to not holding disk->open_mutex.

Yes, as clearly documented in the commit log.  In fact turning it
into an explicit if 0 (that is removing this code) might be a not
bad idea either - the code was added to work around a

	if (lo->lo_refcnt > 1)  /* we needed one fd for the ioctl */
		return -EBUSY;

that already did not make much sense to start with (but goes
back to before git history).

But for now I'd really prefer to stop moving the goalpost further and
further.
