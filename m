Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34605 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbeAXIDt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jan 2018 03:03:49 -0500
Date: Wed, 24 Jan 2018 09:03:47 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Joe Perches <joe@perches.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] bsg: use pr_debug instead of hand craftet macros
Message-ID: <20180124080347.hgv6vow4x2wajvku@linux-x5ow.site>
References: <20180123105538.24860-1-jthumshirn@suse.de>
 <1516711552.8378.30.camel@perches.com>
 <1516749137.3339.62.camel@wdc.com>
 <1516762398.8378.34.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1516762398.8378.34.camel@perches.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 23, 2018 at 06:53:18PM -0800, Joe Perches wrote:
> On Tue, 2018-01-23 at 23:12 +0000, Bart Van Assche wrote:
> > On Tue, 2018-01-23 at 04:45 -0800, Joe Perches wrote:
> > > Perhaps the email subject could be improved to describe
> > > the new macro and as well, this macro, without a pr_fmt
> > > define somewhat above it loses the __func__ output too.
> > 
> > Hmm ... I thought that the pr_debug() output can be configured to include
> > the function name (__func__)? From
> 
> Exactly right.
> 
> > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html:
> 
> which is what I wrote when I said use +f.
> 
> It's just nice to mention these changes in the
> commit message.

Sorry Joe but this slowly approaches the bikeshedding area. Why should I
duplicate the dynamic debug howto?

This was literally a drive-by patch I did while riding on the subway to the
office which was indented to ease debugging problems in the field for our (and
other) support engineers (and they are usually well aware of the +f switch).

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
