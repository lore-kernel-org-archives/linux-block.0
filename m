Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:60073 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750892AbeAVVEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 16:04:25 -0500
Message-ID: <1516655059.8378.21.camel@perches.com>
Subject: Re: [PATCH TRIVIAL] bsg: use pr_debug instead of hand crafted macros
From: Joe Perches <joe@perches.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@fb.com" <axboe@fb.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date: Mon, 22 Jan 2018 13:04:19 -0800
In-Reply-To: <1516653723.2545.37.camel@wdc.com>
References: <20180122075348.6974-1-jthumshirn@suse.de>
         <1516652629.8378.14.camel@perches.com> <1516653723.2545.37.camel@wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2018-01-22 at 20:42 +0000, Bart Van Assche wrote:
> On Mon, 2018-01-22 at 12:23 -0800, Joe Perches wrote:
> > On Mon, 2018-01-22 at 08:53 +0100, Johannes Thumshirn wrote:
> > > Use pr_debug instead of hand crafted macros. This way it is not needed to
> > > re-compile the kernel to enable bsg debug outputs and it's possible to
> > > selectively enable specific prints.
> > 
> > Perhaps better to use
> > 
> > #define bsg_dbg(bd, fmt, ...) \
> > 	pr_debug(bd->name, fmt, ##__VA_ARGS__)

That was written with my brain switched off
and was obviously incorrect.

> Hello Joe,

Hi Bart.

> Why do you think that would be better?

All of the messages save one already emit bd->name
(and that one that doesn't use bd->name could likely
use it too)

So maybe this is better:

#define bsg_dbg(bd, fmt, ...) \
	pr_debug("%s: " fmt, (bd)->name, ##__VA_ARGS__)

cheers, Joe
