Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbdALKPR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 05:15:17 -0500
Date: Thu, 12 Jan 2017 11:15:09 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 01/10] block: move existing elevator ops to union
Message-ID: <20170112101509.GF3598@linux-x5ow.site>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484170803-9311-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 11, 2017 at 02:39:54PM -0700, Jens Axboe wrote:
> Prep patch for adding MQ ops as well, since doing anon unions with
> named initializers doesn't work on older compilers.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
