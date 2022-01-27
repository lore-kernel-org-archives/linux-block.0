Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8492C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 10:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiA0KT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:19:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33022 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiA0KT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 05:19:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83334218E1;
        Thu, 27 Jan 2022 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643278797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aDuIpB8Rni/QDWuAxELn0cTt6ve2k6PNzUVHG7BfQc=;
        b=yUTzkEmDf1Lwgc4is4fxCpi/S7U0nzSJRY/uoaXEbrbLC+Qw/IA7wOc2pYzMz8F4jC71Xx
        OCEDIFr6YY4i1PoK81wa0p9BJm3fby8ffpLAP+HFEEYwtCCA+uG4COWGYyIqJKr5QBk9+B
        0iAXkyoqP0NhOgP8XXz+C8kSf3ULSsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643278797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aDuIpB8Rni/QDWuAxELn0cTt6ve2k6PNzUVHG7BfQc=;
        b=Xwqj+KYgOj73wal58ENmHylZDRSeSxWAN6Ssfl7C/ANEQQa5dTzWTI9yf3/jp6Sgih6uF0
        ytugaCEEZKlRweAw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75535A3B81;
        Thu, 27 Jan 2022 10:19:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A92CA05E6; Thu, 27 Jan 2022 11:19:57 +0100 (CET)
Date:   Thu, 27 Jan 2022 11:19:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/8] loop: only take lo_mutex for the last reference in
 lo_release
Message-ID: <20220127101957.3t4zdq7hizgu3myn@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-5-hch@lst.de>
 <20220127094813.ra7nslwycdcaw2gi@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127094813.ra7nslwycdcaw2gi@quack3.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 27-01-22 10:48:13, Jan Kara wrote:
> On Wed 26-01-22 16:50:36, Christoph Hellwig wrote:
> > lo_refcnt is only incremented in lo_open and decremented in lo_release,
> > and thus protected by open_mutex.  Only take lo_mutex when lo_release
> > actually takes action for the final release.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Yup, good idea. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

On a second thought I retract this... See below:

> > index d3a7f281ce1b6..43980ec69dfdd 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1740,10 +1740,10 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
> >  {
> >  	struct loop_device *lo = disk->private_data;
> >  
> > -	mutex_lock(&lo->lo_mutex);
> > -	if (atomic_dec_return(&lo->lo_refcnt))
> > -		goto out_unlock;
> > +	if (!atomic_dec_and_test(&lo->lo_refcnt))
> > +		return;
> >  
> > +	mutex_lock(&lo->lo_mutex);

There's a subtle race here like:

Thread 1				Thread2 (mount)
lo_release()
  if (!atomic_dec_and_test(&lo->lo_refcnt))
  - sees we are last one
					lo_open()
					  mutex_lock_killable(&lo->lo_mutex);
					  atomic_inc(&lo->lo_refcnt);
					  mutex_unlock(&lo->lo_mutex);
					ioctl(LOOP_GET_STATUS)
					  sees everything is fine
  mutex_lock(&lo->lo_mutex);
  if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
    cleans up the device
  }
					  is unhappy, mount fails

Just after writing this I have realized that the above sequence is not
actually possible due to disk->open_mutex protecting us and serializing
lo_release() with lo_open() but it needs at least a comment to explain that
we rely on disk->open_mutex to avoid races with lo_open().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
