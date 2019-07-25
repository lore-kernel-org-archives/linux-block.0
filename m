Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A17C76191
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA6C218EA
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 19:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGYTbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:31:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42550 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfGYTbb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 15:31:31 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqjSU-00040j-4r; Thu, 25 Jul 2019 13:31:22 -0600
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
 <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
 <20190725192613.GF30641@bombadil.infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a4bb9e66-9165-3557-ae43-02a916b4fa0e@deltatee.com>
Date:   Thu, 25 Jul 2019 13:31:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725192613.GF30641@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, kbusch@kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, gregkh@linuxfoundation.org, sagi@grimberg.me, willy@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-07-25 1:26 p.m., Matthew Wilcox wrote:
> On Thu, Jul 25, 2019 at 01:24:22PM -0600, Logan Gunthorpe wrote:
>>>> Assuming that there is a open handle somewhere out there...
>>
>> Yes, that would be a step backwards from an interface. The user would
>> then need a special process to open the fd and pass it through configfs.
>> They couldn't just do it with basic bash commands.
> 
> echo 3 3</dev/nvme3 >/configfs/foor/bar/whatever

Neat. I didn't know you could do that.

Logan
