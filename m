Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E8C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD4564F4D
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhBDJZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234639AbhBDJZS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 04:25:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57C5064F48;
        Thu,  4 Feb 2021 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612430677;
        bh=aZtUwWBZmGXotz0RgFdl6y7IYsluhOoeGnALH1Ct6Ow=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pTAbiKIEaWCiqgPOeS+psDFR7Sw3iFQ5REMg5L5WljJfEvlrAQznL3Emr/pAM9gqp
         nc6VoZLptP992HfuqkNpKOUj/cmwNbrNyZzrhk8jFqC9//j8tAjiYQbbk1i4NwA9Mg
         rLyloW1zH6tJQkWk771z8Hkk6abdky6spivIegHN31H/nKfdKYNjJ7m3+z/Br+CMgr
         wQ7hAZxCU1mtgM9jydVP+mz0oHTUX3ZlwzFgta7Od5uYi7J6iBGvSTeg8t+hrrVv2/
         FHebxERM9bt69A82CEq3y5+lw9xGf84X//NGjRbDAxL2Y1TcHPOVEVPLBAeFePKIEi
         o5FJ1ffxFSINw==
Date:   Thu, 4 Feb 2021 10:24:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>,
        Kurt Garloff <kurt@garloff.de>
Subject: Re: [PATCH] floppy: reintroduce O_NDELAY fix
In-Reply-To: <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
Message-ID: <nycvar.YFH.7.76.2102041024000.28696@cbobk.fhfr.pm>
References: <20160610230255.GA27770@djo.tudelft.nl> <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm> <20160614184308.GA6188@djo.tudelft.nl> <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm> <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm> <20160615224722.GA9545@djo.tudelft.nl> <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm> <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm> <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm> <5cb57175-7f0b-5536-925d-337241bcda93@linux.com> <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm> <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm> <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
 <nycvar.YFH.7.76.2101211603590.5622@cbobk.fhfr.pm> <nycvar.YFH.7.76.2101221209060.5622@cbobk.fhfr.pm> <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Jan 2021, Denis Efremov wrote:

> Applied. I'll send it to Jens soon with a couple of cleanup patches.
> 
> https://github.com/evdenis/linux-floppy/commit/e32f6163c47efbdbad06258560aa00d1c7e5b699

Denis,

I don't see this fix in Jens' tree yet. Is there any problem with the 
patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs

