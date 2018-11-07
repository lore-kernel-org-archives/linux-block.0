Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37744 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGMmw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Nov 2018 07:42:52 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Ming Lei <tom.leiming@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
 <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f670cdbd-ece6-9051-e6f8-0814a44fe82b@grimberg.me>
Date: Tue, 6 Nov 2018 19:14:22 -0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> blktrace won't help on this issue because .bv_offset isn't recorded.
> 
> This patch makes sense on >4KB PAGE_SIZE. If your issue happens on
> ARCH with 4K PAGE_SIZE, maybe you should root cause why it makes a
> difference on iSer. And it is highly possible there is bug somewhere.

I don't suspect that this is the case. unless all the vec elements
happen to have an offset but if that is the case I don't think that
this patch would've solved this.

It can't really be an iser issue because iser does not control bio
splitting/merging... it can only ask the block layer to obay the
virt_boundary.
