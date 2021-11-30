Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5253C433EF
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbhK3PHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:07:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37818 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbhK3PGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 10:06:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0BB512177B;
        Tue, 30 Nov 2021 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638284563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uRMHtv68A8E7IdS+IKPaMfDBhleG9ZJz9BFZ4OPPFM=;
        b=Ws8SQ0eQlRGTanoCN78rOVbppZ5bPPbADNGxxFR427lv9eadd3VTxebPdCQ6MyfTZzVNIW
        xTjt57eiMhIY0kpcGFTmBY22SJVmxpB7xM+doGZ9w6bVASF220ddBvotl4D0VUvltDiwEt
        EJWnyetnYaRDGLaKRVr0rrDOR+CFSgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638284563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uRMHtv68A8E7IdS+IKPaMfDBhleG9ZJz9BFZ4OPPFM=;
        b=IPlUfRbZRUqUIayy0JxFEiQhS6X+VNNs8PdjBOEKHNwwzvsGp9EeeutPSOSSUIS0GJSuUF
        TlgIIVlYw0mfqRAg==
Received: from quack2.suse.cz (jack.udp.ovpn2.prg.suse.de [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id F053CA3B92;
        Tue, 30 Nov 2021 15:02:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C4B001E1494; Tue, 30 Nov 2021 16:02:42 +0100 (CET)
Date:   Tue, 30 Nov 2021 16:02:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] block: simplify struct io_context refcounting
Message-ID: <20211130150242.GJ7174@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130124636.2505904-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-11-21 13:46:31, Christoph Hellwig wrote:
> Don't hold a reference to ->refcount for each active reference, but
> just one for all active references.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
