Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40959 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeFZVBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 17:01:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so8633226pfe.7
        for <linux-block@vger.kernel.org>; Tue, 26 Jun 2018 14:01:33 -0700 (PDT)
Date: Tue, 26 Jun 2018 14:01:30 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 15/15] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180626210130.GF1218@vader>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <20180622221946.10987-16-bart.vanassche@wdc.com>
 <20180626085757.ih6toex5ovpefwez@linux-x5ow.site>
 <eed94957-58cd-3fe0-3447-a1d97cd0b9a9@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eed94957-58cd-3fe0-3447-a1d97cd0b9a9@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 26, 2018 at 08:25:40AM -0700, Bart Van Assche wrote:
> On 06/26/18 01:58, Johannes Thumshirn wrote:
> > On Fri, Jun 22, 2018 at 03:19:46PM -0700, Bart Van Assche wrote:
> > >   tests/srp/functions | 1288 +++++++++++++++++++++++++++++++++++++++++++
> > 
> > Can you please move these into common/srp?
> 
> Let's do that once other tests than those in tests/srp need one or more of
> the functions defined in that file.
> 
> Bart.

I moved things around just now to accomodate this sort of thing.
tests/foo/group is now tests/foo/rc, and that's where group-specific
functions should go, in addition to the group_requires() and
group_device_requires() definitions.
