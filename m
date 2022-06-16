Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA07C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376598AbiFPMYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiFPMYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 08:24:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C32181A
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 05:24:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A85FF21B6D;
        Thu, 16 Jun 2022 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655382251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GVisrk//QJS74/WoPyxLKCQPsh2bDPiF6ZjfKPlXKwo=;
        b=BejUCZBPo7Ld5QHH9+yeWMK/dxIi/ELhj3e01CdX91tIavAMbn16MPBMC8ybaI7/uTGHIP
        6f9mYfNuZepu6K0R8L/G/ifUExZc0Jfik8uMX3IqhlFZXGRRj4MgUgM4w6PyVH2WVbHiQ2
        AkWgs4w6RLNXr65KvZC019YfbIIUn7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655382251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GVisrk//QJS74/WoPyxLKCQPsh2bDPiF6ZjfKPlXKwo=;
        b=8nA4Z3jhYKyC459LIT7M3QMS7OzQB54uy0UyZxfSfE6wxc9uDtQlalCAxZhQk94p9X4cJE
        ew4KVg+JAbn3wgDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45D652C141;
        Thu, 16 Jun 2022 12:24:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 72538A062E; Thu, 16 Jun 2022 14:24:05 +0200 (CEST)
Date:   Thu, 16 Jun 2022 14:24:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Message-ID: <20220616122405.qifuahpn2mhzogwd@quack3.lan>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616112303.wywyhkvyr74ipdls@quack3.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-06-22 13:23:03, Jan Kara wrote:
> On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
> > On 6/16/22 01:16, Jan Kara wrote:
> > > +	if (ioprio_class == IOPRIO_CLASS_NONE)
> > > +		bio->bi_ioprio = get_current_ioprio();
> > >   }
> > >   /**
> > 
> > Beside this comment, I am still scratching my head regarding what the user
> > gets with ioprio_get(). If I understood your patches correctly, the user may
> > still see IOPRIO_CLASS_NONE ?
> > For that case, to be in sync with the man page, I thought the returned
> > ioprio should be the effective one based on the task io nice value, that is,
> > the value returned by get_current_ioprio(). Am I missing something... ?
> 
> The trouble with returning "effective ioprio" is that with IOPRIO_WHO_PGRP
> or IOPRIO_WHO_USER the effective IO priority may be different for different
> processes considered and it can be also further influenced by blk-ioprio
> settings. But thinking about it now after things have settled I agree that
> what you suggests makes more sense. I'll fix that. Thanks for suggestion!

Oh, now I've remembered why I've done it that way. With IOPRIO_WHO_PROCESS
(which is probably the most used and the best defined variant), we were
returning IOPRIO_CLASS_NONE if the task didn't have set IO priority until
commit e70344c05995 ("block: fix default IO priority handling"). So my
patch was just making behavior of IOPRIO_WHO_PGRP & IOPRIO_WHO_USER
consistent with the behavior of IOPRIO_WHO_PROCESS. I'd be reluctant to
change the behavior of IOPRIO_WHO_PROCESS because that has the biggest
chances for userspace regressions. But perhaps it makes sense to keep
IOPRIO_WHO_PGRP & IOPRIO_WHO_USER inconsistent with IOPRIO_WHO_PROCESS and
just use effective IO priority in those two variants. That looks like the
smallest API change to make things at least somewhat sensible...

								Honza

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
