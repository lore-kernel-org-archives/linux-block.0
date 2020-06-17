Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED774C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D001A20DD4
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 12:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQMrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:47:09 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:37576 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQMrI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 08:47:08 -0400
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 08:47:07 EDT
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 05HCWhGj000918;
        Wed, 17 Jun 2020 14:32:43 +0200
Date:   Wed, 17 Jun 2020 14:32:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wade Mealing <wmealing@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "zram: convert remaining CLASS_ATTR() to
 CLASS_ATTR_RO()"
Message-ID: <20200617123243.GA915@1wt.eu>
References: <20200617103412.GA2027053@kroah.com>
 <20200617123100.GB852@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617123100.GB852@1wt.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 17, 2020 at 02:31:00PM +0200, Willy Tarreau wrote:
> Hi Greg,
> 
> On Wed, Jun 17, 2020 at 12:34:12PM +0200, Greg Kroah-Hartman wrote:
> > From: Wade Mealing <wmealing@redhat.com>
> > 
> > Turns out that the permissions for 0400 really are what we want here,
> > otherwise any user can write to this file.
>                          ^^^^^^^^
> s/write to/read from/
> 
> As Wade reported, it's sufficient to read from it to create a zram entry.

Bah I just saw your v2 now, sorry for the noise.

Willy
