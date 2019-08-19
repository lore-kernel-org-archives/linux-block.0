Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B7C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD6822CE3
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 16:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSQYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:24:37 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:43504 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfHSQYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 12:24:37 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1hzkSS-0002vb-1q by authid <merlin>; Mon, 19 Aug 2019 09:24:36 -0700
Date:   Mon, 19 Aug 2019 09:24:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     o1bigtenor <o1bigtenor@gmail.com>
Cc:     linux-block@vger.kernel.org,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top of Perc 5/i raid0/jbod
Message-ID: <20190819162436.GE5431@merlins.org>
References: <20190819070823.GH12521@merlins.org> <CAPpdf5-82P0ri7KB34g_eWS6SKdVapCgUtYphwOL6E+HUwimcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpdf5-82P0ri7KB34g_eWS6SKdVapCgUtYphwOL6E+HUwimcg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 06:42:23AM -0500, o1bigtenor wrote:
> On Mon, Aug 19, 2019 at 2:35 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > (Please Cc me on replies so that I can see them more quickly)
> >
> > Dear Block Folks,
> >
> > I just inherited a Dell 2950 with a Perc 5/i.
> > I really don't want to use that Perc 5/i card, but from all the reading
> > I did, there is no IT/unraid mode for it, so I was stuck setting the 6
> > 2TB drives as 6 independent raid0 drives using the card.
> > I wish I could just bypass the card and connect the drives directly to a
> > sata card, but the case and backplane do not seem to make this possible.
> 
> Not to discourage you from a possibly interesting and fruitful endeavor
> but when I bought myself a slightly newer dell server I traded out the
> PERC card for a newer version (model 700 IIRC) and then I things
> were quite a big different. Said board, bought used, wasn't very
> expensive. YMMV

Thanks for that suggestion. Indeed, I'd like nothing more than to get rid of
that Perc 5/i card, even if it can't be as bad as what I'm seeing.
That said, from some reading, an H700 isn't just a swap in replacement, it
doesn't use the same cables from what I can tell.

https://www.serversupply.com/products/part_search/pid_lookup.asp?pid=312363&gclid=CjwKCAjwkenqBRBgEiwA-bZVtsIuJabv8vB5F8teo0XxgozYWxwNCS7N5Ar1fVQjvaBkRsQtelRlBhoC3f0QAvD_BwE
Perc 6/i does use the same cables, but it's barely a better card than 5/i
https://www.newegg.com/p/14G-000T-001F5?item=9SIA9AX8NB4437&source=region&nm_mc=knc-googlemkp-pc&cm_mmc=knc-googlemkp-pc-_-pla-splus+technologies-_-hard+drive+controllers+%2f+raid+cards-_-9SIA9AX8NB4437&gclid=CjwKCAjwkenqBRBgEiwA-bZVtnNFqB4fWVPzKkZn_utZwhgYrnBDyKRrafTgRdX2AlHK9NiXr4sxGxoCDqgQAvD_BwE&gclsrc=aw.ds

Best,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
