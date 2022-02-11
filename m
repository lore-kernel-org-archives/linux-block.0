Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C3CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 06:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiBKG5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 01:57:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiBKG5f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:57:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE852101F
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0qj6zCTDiQxY9nSQvu/16pjct4dR5M+HddcJv8X8HiE=; b=0drdrthJsYoQP9KLryLpFy/TJ6
        Lsys4K8fwuAsosam250V52XtY+B2t4piH/+O3uZieaS9hpTHE0fnmXUrDFMw/zO/QaKMyPCVsN1/h
        ItDeVe6P8CaMVgjkJiHLeT8aWlHMiGPsZMwG6bcW9bAsv3sS+cbVa9C8oBHZqOhcpMyNV61B756ME
        ixnP0BhSBtOkSbLIRNbPwsp7sF3eOA5bXbMJXO/WkfeGNO/VwB9YTjyDDVg9MWcPUWGecjEu4+xw7
        +8srEFG84zsFdRsdHcL+JJMvRc0Sp/0y8mrO7ThAMRRj/JDBSuLFtS8rD9bfgz+ZMPFY1vvg8rh30
        A4z+t8gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPs7-0062uv-Ir; Fri, 11 Feb 2022 06:57:35 +0000
Date:   Thu, 10 Feb 2022 22:57:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/14] dm: prep for following changes
Message-ID: <YgYI302Vqn/4ICyK@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-10-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-10-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 10, 2022 at 05:38:27PM -0500, Mike Snitzer wrote:
> Rename dm_io struct's 'endio_lock' member to 'lock' to reuse spinlock
> to protect new member used to flag if IO accounting has been started.
> 
> Also move kicking of the suspend queue out to dm_io_dec_pending (the
> only caller) since end_io_acct will soon only be called if IO
> accounting was started.
> 
> Some comment tweaks and removal of local variables. No functional
> change.

The changes looks fine to me, but for the reader it would be much nicer
if the lock rename, kicking changes and local variable tweaks were split
into separate patches.
