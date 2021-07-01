Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F0C11F67
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BE061406
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 14:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhGAOXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhGAOXI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 10:23:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BC2C61405;
        Thu,  1 Jul 2021 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625149238;
        bh=SQSq9ogWmtmPuajCoHS0DChPgVVgS9fw7xgf2VjK3D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAhdiWbK1ZiMKr2FqSbt0icJkvnU02QPQ+Cc2kzZ1o0JoSsBn5JbGiBh0oOCQlvoH
         GQmnDLeCG78Bmgak2CYaDn2Btgbfhv5Eb4H5mP208C9uxPsa6C7NwRTvrPQD/h9Qco
         LeYRope8VBm3ibGlSxtxYafpRPIePK52exKYJItlOIatgPjIsr6qsHIEl99VL6KmLk
         o+J3Bzi8U0Oa2i84+8EnKjgQQsf2YHR9ZClAtyW6QfpnxKhFIvWYdfv+fhZGsU2M9z
         L6JsVA2i66XPjjkZ9mHY8xUrM8wbUalHqWHga0tyfWCUtOkna3VGU++X2Yzwe945gR
         agVkT71rVbwsw==
Date:   Thu, 1 Jul 2021 07:20:35 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <20210701142035.GA3370360@dhcp-10-100-145-180.wdc.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
 <0f8be11b-c6de-1c2b-323b-1e059c2ac4f8@grimberg.me>
 <CH2PR04MB70781FC64AC0621F7E55B408E7019@CH2PR04MB7078.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR04MB70781FC64AC0621F7E55B408E7019@CH2PR04MB7078.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 09:57:05PM +0000, Damien Le Moal wrote:
> On 2021/07/01 3:58, Sagi Grimberg wrote:
> > 
> >>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> >>> index 21140132a30d..600c5dd1a069 100644
> >>> --- a/include/linux/blk-mq.h
> >>> +++ b/include/linux/blk-mq.h
> >>> @@ -403,6 +403,7 @@ enum {
> >>>   	 */
> >>>   	BLK_MQ_F_STACKING	= 1 << 2,
> >>>   	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
> >>> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
> >>
> >> My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.
> > 
> > Maybe BLK_MQ_F_UNMANAGED_IRQ?
> 
> Even better :)

Since most drivers are unmanaged, shouldn't that be the default? The
managed irq drivers should get to set a flag instead.
