Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEDC433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2DD21475
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFQHnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:43:31 -0400
Received: from verein.lst.de ([213.95.11.211]:42240 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQHnb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 03:43:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D47BE68AEF; Wed, 17 Jun 2020 09:43:28 +0200 (CEST)
Date:   Wed, 17 Jun 2020 09:43:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617074328.GA13474@lst.de>
References: <20200615233424.13458-1-keith.busch@wdc.com> <20200615233424.13458-6-keith.busch@wdc.com> <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier González wrote:
> On 16.06.2020 08:34, Keith Busch wrote:
>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>> in NVM Express TP4053. Zoned namespaces are discovered based on their
>> Command Set Identifier reported in the namespaces Namespace
>> Identification Descriptor list. A successfully discovered Zoned
>> Namespace will be registered with the block layer as a host managed
>> zoned block device with Zone Append command support. A namespace that
>> does not support append is not supported by the driver.
>
> Why are we enforcing the append command? Append is optional on the
> current ZNS specification, so we should not make this mandatory in the
> implementation. See specifics below.

Because Append is the way to go and we've moved the Linux zoned block
I/O stack to required it, as should have been obvious to anyone
following linux-block in the last few months.  I also have to say I'm
really tired of the stupid politics tha your company started in the
NVMe working group, and will say that these do not matter for Linux
development at all.  If you think it is worthwhile to support devices
without Zone Append you can contribute support for them on top of this
series by porting the SCSI Zone Append Emulation code to NVMe.

And I'm not even going to read the rest of this thread as I'm on a
vacation that I badly needed because of the Samsung TWG bullshit.
