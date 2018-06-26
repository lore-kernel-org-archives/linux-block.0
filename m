Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33779 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeFZH1J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 03:27:09 -0400
Date: Tue, 26 Jun 2018 09:27:07 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
Message-ID: <20180626072707.555hshtnr3fgnsxk@linux-x5ow.site>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
 <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
 <20180626013719.GA31259@ming.t460p>
 <430584e255cc8d25a748bd5d76febb3fd23f8df2.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <430584e255cc8d25a748bd5d76febb3fd23f8df2.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 26, 2018 at 02:16:26AM +0000, Bart Van Assche wrote:
> On Tue, 2018-06-26 at 09:37 +0800, Ming Lei wrote:
> > I run SRP test on Fedora 27, and not run any LIO specific commands
> > to load it, seems it is done automatically.
> > 
> > So looks it might not a good idea to fail SRP test if LIO is loaded,
> > just wondering why your SRP test can't make the two co-exist?
> 
> The LIO configuration is system-wide. Only one configuration can be
> loaded at any given time. I don't think that the SRP tests should wipe
> any existing LIO configuration data if e.g. blktests is run accidentally
> on a production server. I think that wiping LIO configuration data should
> be a manual step.

I think this should be handled in requires(). I.e. check if LIO is
already configured and then skip the test if it is.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
