Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC3FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 11:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF5A60F4A
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 11:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhINLn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhINLn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 07:43:57 -0400
Received: from lounge.grep.be (lounge.grep.be [IPv6:2a01:4f8:200:91e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26FC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
        s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OyulxNPZRJQgaxJ96lzfK3AcGP7GDS0fymvFsAXQtFY=; b=pUqwFGX7BXtZE0/dUsE09428Y/
        gKHcYX0z89Hh1muNfQlGW6+2HKw61W8NtlUMh1SW3Gp1CZ3AfUoYI9eprCp1N6zWjIQAkBsXi3PdF
        g0+s5/EANhnD3A6fZrbfZBq2hV6oZvIn+sReHR3D+MuBI7CgtvAhkbhyzR4x6YGU4umIK8HvDcExh
        kwFNjJmzfAqVdnk4C72xmqB7MwhUAVIutqCnboejoIpP8YDhT5HpgFaZpFMyXwFXEc8bgnXu0/YoR
        zLZcKuPnajBi62nPh6qi4PeVHSjWN9CJz3c4F6rMDGZqDaS8N1whKLVGUgvTE2EMIoT2zeTw8WIn/
        2mkZJiqQ==;
Received: from [196.251.239.242] (helo=pc181009)
        by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <w@uter.be>)
        id 1mQ6pa-00HJIn-Vx; Tue, 14 Sep 2021 13:42:30 +0200
Received: from wouter by pc181009 with local (Exim 4.95-RC2)
        (envelope-from <w@uter.be>)
        id 1mQ6pX-0005AP-Lg;
        Tue, 14 Sep 2021 13:42:27 +0200
Date:   Tue, 14 Sep 2021 13:42:27 +0200
From:   Wouter Verhelst <w@uter.be>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
Message-ID: <YUCKoySdM9WZlUH9@pc181009.grep.be>
References: <20210904122519.1963983-1-houtao1@huawei.com>
 <20210904122519.1963983-4-houtao1@huawei.com>
 <20210906093051.GC30790@lst.de>
 <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com>
 <20210906102521.GA3082@lst.de>
 <730dae5e-5af8-3554-18bf-e22ff576e2b1@huawei.com>
 <20210909064035.GA26290@lst.de>
 <6434d4e8-984d-97df-34e5-b86a0e69cf58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6434d4e8-984d-97df-34e5-b86a0e69cf58@huawei.com>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 12:32:37PM +0800, Hou Tao wrote:
> Hi Christoph,
> 
> On 9/9/2021 2:40 PM, Christoph Hellwig wrote:
> > On Tue, Sep 07, 2021 at 11:04:16AM +0800, Hou Tao wrote:
> >> Let me explain first. The reason it works is due to genl_lock_all() in netlink code.
> > Btw, please properly format your mail.  These overly long lines are really
> > hard to read.
> Thanks for reminding.
> >> If the module removal happens before calling try_module_get(), nbd_cleanup() will
> >>
> >> call genl_unregister_family() first, and then genl_lock_all(). genl_lock_all() will
> >>
> >> prevent ops in nbd_connect_genl_ops() from being called, because the calling
> >>
> >> of nbd ops happens in genl_rcv() which needs to acquire cb_lock first.
> > Good.
> >
> >> I have checked multiple genl_ops, it seems that the reason why these genl_ops
> >>
> >> don't need try_module_get() is that these ops don't create new object through
> >>
> >> genl_ops and just control it. However genl_family_rcv_msg_dumpit() will try to
> >>
> >> call try_module_get(), but according to the history (6dc878a8ca39 "netlink: add reference of module in netlink_dump_start"),
> >>
> >> it is because inet_diag_handler_cmd() will call __netlink_dump_start().
> > And now taking a step back:  Why do we even need this extra module
> > reference?  For the case where nbd_alloc_config is called from nbd_open
> > we obviously don't need it.  In the case where it is called from
> > nbd_genl_connect that prevents unloading nbd when there is a configured
> > but not actually nbd device.  Which isn't reallyed need and counter to
> > how other drivers work.
> Yes, the purpose of module ref-counting in nbd_alloc_config() is to force
> the user to disconnect the nbd device manually before module removal.
> And loop device works in the same way. If a file is attached to a loop device,
> an extra module reference will be taken in loop_configure() and the removal
> of loop module will fail. The only difference is that loop driver takes the
> extra ref-count by ioctl, and nbd does it through netlink.

Haven't checked the actual patch, but just wanted to point out:

nbd should do it through netlink *and* ioctl -- the older way to
configure nbd was through ioctl, which we should still support for
backcompat reasons.

(if that's already the case, then ignore what I said :-)

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}
