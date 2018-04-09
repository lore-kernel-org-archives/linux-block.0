Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751609AbeDIXvS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Apr 2018 19:51:18 -0400
Date: Tue, 10 Apr 2018 07:51:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Message-ID: <20180409235100.GE6450@ming.t460p>
References: <595a10cfb387e6b2ab4d2053b84fed9b3da9e079.camel@wdc.com>
 <20180406014644.GA16112@animx.eu.org>
 <20180406020651.GB16112@animx.eu.org>
 <fb0640c203409a84ab1bfbbc41078a5416138ad2.camel@wdc.com>
 <20180407165335.GA2515@animx.eu.org>
 <1ff8d234cc565ba9701ce31899fca5faa597e050.camel@wdc.com>
 <20180408160254.GA22869@animx.eu.org>
 <f9467e78ce05446e7a89f06713c36fb638d1b6ad.camel@wdc.com>
 <20180409233436.GC6450@ming.t460p>
 <20180409234301.GA17037@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409234301.GA17037@animx.eu.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 09, 2018 at 07:43:01PM -0400, Wakko Warner wrote:
> Ming Lei wrote:
> > On Mon, Apr 09, 2018 at 09:30:11PM +0000, Bart Van Assche wrote:
> > > Hello Ming,
> > > 
> > > Can you have a look at this? The start of this e-mail thread is available at
> > > https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg72574.html.
> > 
> > Sure, thanks for your sharing.
> > 
> > Wakko, could you test the following patch and see if there is any
> > difference?
> 
> Sure, one question, is this against 4.15 or does it matter.  Last I looked,
> 4.16 hasn't changed from 4.15 for that file.

It is two-line change, and I am sure it can be applied on 4.15 cleanly. 

Thanks,
Ming
