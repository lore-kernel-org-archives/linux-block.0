Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88971C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 07:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A40208C3
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 07:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfHFHGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:06:25 -0400
Received: from verein.lst.de ([213.95.11.211]:53899 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731834AbfHFHGZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 03:06:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2E07227A81; Tue,  6 Aug 2019 09:06:22 +0200 (CEST)
Date:   Tue, 6 Aug 2019 09:06:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] lightnvm: move metadata mapping to lower level
 driver
Message-ID: <20190806070622.GB15546@lst.de>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com> <1564566096-28756-3-git-send-email-hans@owltronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564566096-28756-3-git-send-email-hans@owltronix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 11:41:34AM +0200, Hans Holmberg wrote:
> Now that blk_rq_map_kern can map both kmem and vmem, move
> internal metadata mapping down to the lower level driver.
> 
> Signed-off-by: Hans Holmberg <hans@owltronix.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
