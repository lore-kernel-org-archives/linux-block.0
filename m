Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	PDS_TONAME_EQ_TOLOCAL_VSHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1DC433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A4E61422
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhD1Gpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:45:45 -0400
Received: from verein.lst.de ([213.95.11.211]:48044 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhD1Gpp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 02:45:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 18B5368C7B; Wed, 28 Apr 2021 08:44:59 +0200 (CEST)
Date:   Wed, 28 Apr 2021 08:44:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     taochiu <taochiu@synology.com>
Cc:     hch@lst.de, chaitanya.kulkarni@wdc.com, kbusch@kernel.org,
        axboe@fb.com, sagi@grimberg.me, james.smart@broadcom.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Cody Wong <codywong@synology.com>,
        Leon Chien <leonchien@synology.com>
Subject: Re: [PATCH v2 1/2] nvme-core: Move nvmf queue ready check routines
 to core
Message-ID: <20210428064458.GB5988@lst.de>
References: <20210426025310.3005573-1-taochiu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426025310.3005573-1-taochiu@synology.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied the series to nvme-5.13.
