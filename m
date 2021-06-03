Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E496C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1406E6109F
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 14:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFCOsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:48:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFCOsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 10:48:31 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02727219FC;
        Thu,  3 Jun 2021 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622731606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgJ2ib9SlRW99rJ08mr0EJy7gSx81gKwPKfjTb2hPhQ=;
        b=BeI9uQMoAQJ2Oo+faRxnKrpj63a/Qq3LOgVprk3i29JiqUFtC6XVuwCVaFVe0V0zc6yX6o
        4+XKEI/3CO40oOfR85is+dOFgsLJPoPda5gzXqellCjMSOWqKHVs3/HccmPgokh33phQz4
        cUfGNlq3BDS6GdxIt2OMs4xdmoCvwS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622731606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgJ2ib9SlRW99rJ08mr0EJy7gSx81gKwPKfjTb2hPhQ=;
        b=bJi/FNkqlqga25F9rCjFWk8n6JT0ea9sXlXQzqsHDerhtoMMTnFS24FCIlJYEwuhX7DfQn
        ukrYDosuB75RyXAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C38A6A3B81;
        Thu,  3 Jun 2021 14:46:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C535CDA89C; Thu,  3 Jun 2021 16:44:04 +0200 (CEST)
Date:   Thu, 3 Jun 2021 16:44:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Message-ID: <20210603144404.GY31483@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
 <20210603095117.GU31483@twin.jikos.cz>
 <DM6PR04MB7081B69E31BB7ADDF02E2D9BE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210603100436.GV31483@twin.jikos.cz>
 <DM6PR04MB708127C72BDC03B446997DACE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB708127C72BDC03B446997DACE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 03, 2021 at 11:20:33AM +0000, Damien Le Moal wrote:
> On 2021/06/03 19:07, David Sterba wrote:
> > On Thu, Jun 03, 2021 at 10:00:08AM +0000, Damien Le Moal wrote:
> >> On 2021/06/03 18:54, David Sterba wrote:
> >>> On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:
> >>>> From: Niklas Cassel <niklas.cassel@wdc.com>
> >>>>
> >>>> Performing a BLKREPORTZONE operation should be allowed under the same
> >>>> permissions as read(). (read() does not require CAP_SYS_ADMIN).
> >>>>
> >>>> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd was
> >>>> successfully opened with FMODE_READ. This way BLKREPORTZONE will match
> >>>> the access control requirement of read().
> >>>
> >>> Does this mean that a process that does not have read nor write access
> >>> to the device itself (blocks) is capable of reading the zone
> >>> information? Eg. some monitoring tool.
> >>
> >> With this change, to do a report zones, the process will only need to have read
> >> access to the device. And if it has read access, it also means that it can read
> >> the zones content.
> > 
> > Ok, so this is a bit restricting. The zone information is like block
> > device metadata, comparing it to a file that has permissionx 0600 I can
> > see the all the stat info (name, tiemstamps) but can't read the data.
> > 
> > But as the ioctl work, it needs a file descriptor and there's probably
> > no way to separate the permissions to read blocks and just the metadata.
> > For a monitoring/reporting tool this would be useful. Eg. for btrfs it
> > could be part of filesystem status overview regarding full or near-full
> > zones and emitting an early warning or poking some service to start the
> > reclaim.
> 
> You lost me... the change is less restrictive than before because the process
> does not need SYS_CAP_ADMIN anymore. The block device file open is untouched, no
> change. So whatever process could open it before, will still be able to do so as
> is. More processes will be able to do report zones with the change. That is all
> really that changes, so I do not see what potentially breaks, nor how this may
> prevent writing some monitoring tool. Whoever can open the block device file has
> FMODE_READ rights, no ? Am I missing something here ?

I'm not saying the patch is wrong or not doing what it says. What caught
my attention was the fact that the admin capabilities is not that
different from requiring the read permissions. Which for a block device
is not easy to get. Normally block devices have 0660 and group is
'disk', so yeah I can add a monitoring daemon to the group. But that
still would allow it to read all block devices.

So yeah, the patch is making it easier but from my POV it's not that
practical. A more fine grained access control would be needed, or
another way how to read just the zone info. Reading the information from
eg. sysfs has it's own issues.
