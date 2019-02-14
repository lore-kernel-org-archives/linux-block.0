Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E05C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 16:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FD4222DD
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404678AbfBNQTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:19:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:40952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729942AbfBNQTw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 11:19:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC0A1AE58;
        Thu, 14 Feb 2019 16:19:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37164DA892; Thu, 14 Feb 2019 17:21:11 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:21:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190214162109.GC9874@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20190213180754.GX23000@mit.edu>
 <20190214105507.GA9739@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214105507.GA9739@linux-x5ow.site>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 11:55:07AM +0100, Johannes Thumshirn wrote:
> On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
> > 2) Documenting what are known failures should be for various tests on
> > different file systems and kernel versions.  I think we all have our
> > own way of excluding tests which are known to fail.  One extreme case
> > is where the test case was added to xfstests (generic/484), but the
> > patch to fix it got hung up because it was somewhat controversial, so
> > it was failing on all file systems.
> 
> How about having a wiki page, either in the respective filesystems wiki or a
> common wiki, that show's the list of test that are expected to fail for kernel
> version X?
> 
> This is something I'm desperately looking for for brtfs for example.

https://btrfs.wiki.kernel.org/index.php/Development_notes#.28x.29fstests

Feel free to add what you're missing to that page. Though I'm not sure
wiki is the best way to track such information, but it can be a start.
Without people regularly checking that the information is accurate, it
will be obsolete and fallback to own scripts and exclusion lists would
happen.
