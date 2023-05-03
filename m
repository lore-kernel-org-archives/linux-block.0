Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70258C77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjECPwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjECPwm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:52:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5CB10E5;
        Wed,  3 May 2023 08:52:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DAC268AA6; Wed,  3 May 2023 17:52:38 +0200 (CEST)
Date:   Wed, 3 May 2023 17:52:38 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] block: bio: rename page_is_mergeable to
 bio_page_is_mergeable and make non-static
Message-ID: <20230503155238.GA31700@lst.de>
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4> <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p2> <20230503100049epcms2p2c830ebb7b50beaa2663abd0cd274293c@epcms2p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503100049epcms2p2c830ebb7b50beaa2663abd0cd274293c@epcms2p2>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +bool bio_page_is_mergeable(const struct bio_vec *bv, struct page *page,
> +			   unsigned int len, unsigned int off,
> +			   bool *same_page)

No bio involved here, just a bvec.  But I don't really see the need
to rename it, just declare it in block/blk.h where f2fs has no chance
of ever seeing it.
