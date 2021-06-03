Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E534EC47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 10:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C015E6121D
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 10:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCKJD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:09:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42414 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCKJD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 06:09:03 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3199E1FD4D;
        Thu,  3 Jun 2021 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622714838;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x+tyGtuKQivyTVwpYXg7bis6FjooMqzN5iLMRFOcQec=;
        b=kedhPNIKxxlLkgtanscuy8Da/1hGttsm7IZX+nwk7mrI7UCxyR1qdFdHwilJq+U5sZavyJ
        V93s+waeZztWccmCqxWILsnKVGDH7jMnHuL9+oY9xXDzRlw6PgCWFvnnltWODLGtdjbEc3
        SitUzEZe64ITaLQhSR8OKR+ydOe/Qdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622714838;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x+tyGtuKQivyTVwpYXg7bis6FjooMqzN5iLMRFOcQec=;
        b=zx/L4dGILHdCZS13FlebeyvZZm8lMOYlmZEJMOzL0cMZ//ee0B+HMoNGqcE8/A18QxxdOD
        BrRL9I1o/jnlt2Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2A820A3B81;
        Thu,  3 Jun 2021 10:07:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A518DA72C; Thu,  3 Jun 2021 12:04:37 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:04:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Message-ID: <20210603100436.GV31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
 <20210603095117.GU31483@twin.jikos.cz>
 <DM6PR04MB7081B69E31BB7ADDF02E2D9BE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB7081B69E31BB7ADDF02E2D9BE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 03, 2021 at 10:00:08AM +0000, Damien Le Moal wrote:
> On 2021/06/03 18:54, David Sterba wrote:
> > On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:
> >> From: Niklas Cassel <niklas.cassel@wdc.com>
> >>
> >> Performing a BLKREPORTZONE operation should be allowed under the same
> >> permissions as read(). (read() does not require CAP_SYS_ADMIN).
> >>
> >> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd was
> >> successfully opened with FMODE_READ. This way BLKREPORTZONE will match
> >> the access control requirement of read().
> > 
> > Does this mean that a process that does not have read nor write access
> > to the device itself (blocks) is capable of reading the zone
> > information? Eg. some monitoring tool.
> 
> With this change, to do a report zones, the process will only need to have read
> access to the device. And if it has read access, it also means that it can read
> the zones content.

Ok, so this is a bit restricting. The zone information is like block
device metadata, comparing it to a file that has permissionx 0600 I can
see the all the stat info (name, tiemstamps) but can't read the data.

But as the ioctl work, it needs a file descriptor and there's probably
no way to separate the permissions to read blocks and just the metadata.
For a monitoring/reporting tool this would be useful. Eg. for btrfs it
could be part of filesystem status overview regarding full or near-full
zones and emitting an early warning or poking some service to start the
reclaim.
