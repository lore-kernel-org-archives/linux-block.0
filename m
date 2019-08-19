Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A7CC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 19:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A02087E
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHSTQ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:16:29 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:44969 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfHSTQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 15:16:28 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1hzn8j-0003S7-DJ by authid <merlin>; Mon, 19 Aug 2019 12:16:25 -0700
Date:   Mon, 19 Aug 2019 12:16:25 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top of Perc 5/i raid0/jbod
Message-ID: <20190819191625.GH5431@merlins.org>
References: <20190819070823.GH12521@merlins.org> <20190819233709.76900bbf@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819233709.76900bbf@natsu>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 11:37:09PM +0500, Roman Mamedov wrote:
> > > Default Cache Policy: WriteBack, ReadAheadNone, Direct, No Write Cache if Bad BBU
> > > Current Cache Policy: WriteBack, ReadAheadNone, Direct, No Write Cache if Bad BBU
> > > Default Access Policy: Read/Write
> > > Current Access Policy: Read/Write
> > > Disk Cache Policy   : Disabled
> 
> So does it have a BBU? (Battery backup unit)
 
Yes, it does and it's working.
But because I found that with write caching enabled, it seemd to take all
the writes from the raid rebuild in a big queue, and starving I/O for others
requests that I wanted to happen "right now" (like /bin/ls actually being
loaded and running), and reading how the perc 5/i is a crap card, I turned
off its IO caching, leaving the work to linux' block buffer and the 32GB of
RAM in the server that are mostly allocated to disk IO caching.

> > I tried to disable the card's write cache to let linux and its 32GB of
> > RAM, do it better, but I didn't see a real improvement:
> 
> I'd expect that on the contrary, you should look for ways to enable it, and
> force-enable even without that BBU (in case of lack of one), because it feels
> like what you did is disable disks' own write buffering, and not (only) the
> card's!

Yes, you may be correct on that. I can re-enable it, but it was terrible
with it on, too.

> What you are observing seems to me like what "dd" does with "oflag=dsync" (and
> comparable performance that it gets). Definitely feels like it's in some
> "extra safe mode" and, say, every 4KB piece of data leads to full flush to
> disk before accepting to write the next 4KB.

That sounds plausible indeed.

> More things to try, check if it's possible to set up disks not as 1-member
> RAID0, but 1-member "linear" ("JBOD"), or even 1-member RAID1, who knows maybe
> some of this would work better.

Assuming I can do this without losing the entire filesystem, I can try, but
if it can't do single drive raid0, I doubt changing this to single drive
raid1 would make things much better.
Then again, once you're hitting things that aren't working as they should...

I have an H700 in the mail that should arrive tonight, I'll try swapping
that first and see what happens.

Thanks for the answer,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
