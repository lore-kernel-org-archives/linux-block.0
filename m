Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44357 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932965AbeFZI57 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 04:57:59 -0400
Date: Tue, 26 Jun 2018 10:57:57 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 15/15] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180626085757.ih6toex5ovpefwez@linux-x5ow.site>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <20180622221946.10987-16-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180622221946.10987-16-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 22, 2018 at 03:19:46PM -0700, Bart Van Assche wrote:
>  tests/srp/functions | 1288 +++++++++++++++++++++++++++++++++++++++++++

Can you please move these into common/srp?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
