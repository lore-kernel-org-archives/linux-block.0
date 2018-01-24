Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:50744 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933170AbeAXLNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jan 2018 06:13:50 -0500
Message-ID: <1516792426.8378.40.camel@perches.com>
Subject: Re: [PATCH v2] bsg: use pr_debug instead of hand craftet macros
From: Joe Perches <joe@perches.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date: Wed, 24 Jan 2018 03:13:46 -0800
In-Reply-To: <20180124080347.hgv6vow4x2wajvku@linux-x5ow.site>
References: <20180123105538.24860-1-jthumshirn@suse.de>
         <1516711552.8378.30.camel@perches.com> <1516749137.3339.62.camel@wdc.com>
         <1516762398.8378.34.camel@perches.com>
         <20180124080347.hgv6vow4x2wajvku@linux-x5ow.site>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2018-01-24 at 09:03 +0100, Johannes Thumshirn wrote:
> On Tue, Jan 23, 2018 at 06:53:18PM -0800, Joe Perches wrote:
> > On Tue, 2018-01-23 at 23:12 +0000, Bart Van Assche wrote:
> > > On Tue, 2018-01-23 at 04:45 -0800, Joe Perches wrote:
> > > > Perhaps the email subject could be improved to describe
> > > > the new macro and as well, this macro, without a pr_fmt
> > > > define somewhat above it loses the __func__ output too.
> > > 
> > > Hmm ... I thought that the pr_debug() output can be configured to include
> > > the function name (__func__)? From
> > 
> > Exactly right.
> > 
> > > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html:
> > 
> > which is what I wrote when I said use +f.
> > 
> > It's just nice to mention these changes in the
> > commit message.
> 
> Sorry Joe but this slowly approaches the bikeshedding area. Why should I
> duplicate the dynamic debug howto?

Up to you if you want your commit messages to be
more descriptive of the changes you are making.
