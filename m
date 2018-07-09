Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750996AbeGIHPr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jul 2018 03:15:47 -0400
Date: Mon, 9 Jul 2018 09:15:45 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2] dir-locals.el: fix indenation with Emacs
Message-ID: <20180709071545.yudgrft6e55ijunb@linux-x5ow.site>
References: <20180706082128.11537-1-jthumshirn@suse.de>
 <20180706211744.GE25954@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180706211744.GE25954@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 06, 2018 at 02:17:44PM -0700, Omar Sandoval wrote:
> On Fri, Jul 06, 2018 at 10:21:28AM +0200, Johannes Thumshirn wrote:
> > A recent update of Emacs broke .dir-locals.el's shell indentation
> > setting.
> > 
> > Also set 'sh-indendation' not just 'sh-basic-offset' for this.
> 
> Another typo ;) fixed and applied, thanks.

*gah*
Thanks :-)

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
