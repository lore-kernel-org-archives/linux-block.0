Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34852 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeKGM7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Nov 2018 07:59:02 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
 <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
Date: Tue, 6 Nov 2018 19:30:29 -0800
MIME-Version: 1.0
In-Reply-To: <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> How about changing that expression into the following to make it easier
>> for the compiler to optimize this code?
>>
>> (offset | (bprv->bv_offset + bprv->bv_len)) & queue_virt_boundary(q)
> 
> Uhm I have to admit I'm not really able to parse the above expression.
> Sure GCC will do it but I think it's less readable (at least for me).
> Let's see what other's think.

I personally not a huge fan of decoding complicated expressions. But if
others are fine with it then I am too...
