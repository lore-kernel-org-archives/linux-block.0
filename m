Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388872AbeKGAVi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Nov 2018 19:21:38 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
Date: Tue, 6 Nov 2018 15:56:00 +0100
MIME-Version: 1.0
In-Reply-To: <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/11/2018 15:53, Bart Van Assche wrote:
> How about changing that expression into the following to make it easier
> for the compiler to optimize this code?
> 
> (offset | (bprv->bv_offset + bprv->bv_len)) & queue_virt_boundary(q)

Uhm I have to admit I'm not really able to parse the above expression.
Sure GCC will do it but I think it's less readable (at least for me).
Let's see what other's think.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
