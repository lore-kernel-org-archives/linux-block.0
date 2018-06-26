Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43764 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeFZVAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 17:00:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so8138005pgw.10
        for <linux-block@vger.kernel.org>; Tue, 26 Jun 2018 14:00:10 -0700 (PDT)
Date: Tue, 26 Jun 2018 14:00:08 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
Message-ID: <20180626210008.GE1218@vader>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
 <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
 <20180626013719.GA31259@ming.t460p>
 <430584e255cc8d25a748bd5d76febb3fd23f8df2.camel@wdc.com>
 <20180626072707.555hshtnr3fgnsxk@linux-x5ow.site>
 <ee7ddc2e-888e-952e-db22-7ff20d72265c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee7ddc2e-888e-952e-db22-7ff20d72265c@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 26, 2018 at 08:24:51AM -0700, Bart Van Assche wrote:
> On 06/26/18 00:27, Johannes Thumshirn wrote:
> > On Tue, Jun 26, 2018 at 02:16:26AM +0000, Bart Van Assche wrote:
> > > On Tue, 2018-06-26 at 09:37 +0800, Ming Lei wrote:
> > > > I run SRP test on Fedora 27, and not run any LIO specific commands
> > > > to load it, seems it is done automatically.
> > > > 
> > > > So looks it might not a good idea to fail SRP test if LIO is loaded,
> > > > just wondering why your SRP test can't make the two co-exist?
> > > 
> > > The LIO configuration is system-wide. Only one configuration can be
> > > loaded at any given time. I don't think that the SRP tests should wipe
> > > any existing LIO configuration data if e.g. blktests is run accidentally
> > > on a production server. I think that wiping LIO configuration data should
> > > be a manual step.
> > 
> > I think this should be handled in requires(). I.e. check if LIO is
> > already configured and then skip the test if it is.
> 
> As far as I know the requires() function is per test and there is no such
> function at the group level. I prefer to define this test once at the group
> level instead of copy/pasting the same test thirteen times in each test.
> 
> Bart.

That's exactly what group_requires() is for, you even defined it :)
