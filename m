Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F4FC43217
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 11:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLALoN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLALoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 06:44:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32A8EE55
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 03:44:11 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FAF01FD7A;
        Thu,  1 Dec 2022 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669895050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElbA0CekaGG29yenYWBlQ+HYcAU0SzdgJzJfSXPyKeU=;
        b=EISwxfX1sKv0eZVtg+2DmZpynG745eKE/XkrVVRKImOJSfnV/oOdlYx3GcmqdNjQtUyzSH
        Zs7DwK65yi69ESomCcymxL07OnGfbZODLUWDinGxbc+698eXb4J+AJT0KLzfIPRQuL2qOX
        5gR/2l+b5btPMDKQUGKOI6OXBiKOM9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669895050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElbA0CekaGG29yenYWBlQ+HYcAU0SzdgJzJfSXPyKeU=;
        b=vTVIHWooZSlo6YAExNSlZ0K2e6zssSF727E/GpIqwYpoyHmjpZl3rlab0q4190rmJR9br9
        zo41zAYNqkG0d2CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6218D1320E;
        Thu,  1 Dec 2022 11:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Ul/rF4qTiGM9VwAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 11:44:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E668A06E4; Thu,  1 Dec 2022 12:44:09 +0100 (CET)
Date:   Thu, 1 Dec 2022 12:44:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <20221201114409.bp36h7ds6az7opq3@quack3>
References: <20221130175653.24299-1-jack@suse.cz>
 <Y4hTSppjf0in7tzW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4hTSppjf0in7tzW@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

I'm sorry but this patch has a brownpaper bag bug because BLKRRPART now
bails also if there is no exlusive opener (which didn't have any adverse
effects on my test system because the BLKRRPART calls issued by
systemd-udev are mostly a pointless exercise as I've found out). I'll send
a fixup patch.  Either fold it into this patch or just add on top. Thanks
and I'm sorry for the trouble!
								Honza

On Wed 30-11-22 23:10:02, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
