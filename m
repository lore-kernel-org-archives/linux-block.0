Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932756AbdIFPWI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Sep 2017 11:22:08 -0400
Date: Wed, 6 Sep 2017 17:22:06 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 4/6] lightnvm: pblk: free padded entries in write buffer
Message-ID: <20170906152206.w23ym6u2tpf4wdfa@linux-x5ow.site>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
 <1504710066-4699-5-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504710066-4699-5-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 05:01:04PM +0200, Javier Gonz�lez wrote:
> the completion pah. This might require some sectors to be padded in
                 ^ path

Looks good otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
