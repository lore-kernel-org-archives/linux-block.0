Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421ADC0015E
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjHIVtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 17:49:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D41FD2
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 14:49:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 37AA56732D; Wed,  9 Aug 2023 23:49:14 +0200 (CEST)
Date:   Wed, 9 Aug 2023 23:49:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chuck Lever <cel@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Message-ID: <20230809214913.GA9902@lst.de>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net> <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk> <20230809161105.GA2304@lst.de> <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Oh well.  I don't feel like we're going to find the root cause
given that its late in the merge window and I'm running out of
time I have to work due to the annual summer vacation.  Unless
someone like Chengming who knows the flush code pretty well
feels like working with chuck on a few more iterations we'll
have to revert it.  Which is going to be a very painful merge
with Chengming's work in the for-6.6 branch.

