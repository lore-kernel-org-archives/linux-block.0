Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA9C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjDTMqc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 08:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjDTMqb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 08:46:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185E61AB;
        Thu, 20 Apr 2023 05:46:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B599B68AFE; Thu, 20 Apr 2023 14:46:15 +0200 (CEST)
Date:   Thu, 20 Apr 2023 14:46:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, asml.silence@gmail.com,
        axboe@kernel.dk, leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <20230420124615.GA733@lst.de>
References: <20230419102930.2979231-1-leitao@debian.org> <20230419102930.2979231-2-leitao@debian.org> <20230420045712.GA4239@lst.de> <ZEEwHk32Y8IcT20n@gmail.com> <20230420123139.GA32030@lst.de> <ZEEyKolzQgfkEOwv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEEyKolzQgfkEOwv@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 20, 2023 at 05:38:02AM -0700, Breno Leitao wrote:
> Since we are not coping the payload anymore, this is not necessary. Now
> we are copying 64 bytes for the single SQE or 128 bytes for double SQE.
> 
> Do you prefer I create a helper that returns the SQE size, instead of
> doing the left shift?

I think a helper would be nice.  And adding another sizeof(sqe) seems
more self documenting then the shift, but if you really prefer the
shift at least write a good comment explaining it.
