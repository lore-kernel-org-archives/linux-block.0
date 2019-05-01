Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F1FC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1134A21670
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2C2Y2q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfEAMbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 08:31:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfEAMbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 08:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xGAes7InMneADD9D0ysHSzJVmOpHAxF/Pt3N0Surabk=; b=W2C2Y2q034vHDrIbssKXmYBAN
        7UpnYkLaohZMXMc+6VBuXvK0qhRsmXDmbEBsuMyzExyIj4VEzagQIiJP9T42d4Zl9wE6JSvDFWXFp
        y1QS6TYPTmsQ+ssCs7xguNnqn0jrcbT2I+6LDStCdR8aEhFYT7/p3f0zOwJaEBjtnMa4y5U+Nnq+9
        GjXZvwVq4ONGC3QVx9b1GJgXgndULJBuEZVr2XqrmqqN3dQEVnXLvVkDET9r1P7lH1KP2ZV5JTNAr
        iT1llWBwlboe+YBJD59SGlMTVlmKNmje+8I1qc9EKadfINnqeLJm34bj4m8hPE0EWoJ7sHumKHipX
        YwcBwBQgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLoO8-0005wW-Nw; Wed, 01 May 2019 12:31:04 +0000
Date:   Wed, 1 May 2019 05:31:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
Message-ID: <20190501123104.GA17987@infradead.org>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
 <20190501042831.5313-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501042831.5313-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 30, 2019 at 09:28:15PM -0700, Chaitanya Kulkarni wrote:
> @@ -104,7 +120,12 @@ struct blk_io_trace {
>  	__u64 time;		/* in nanoseconds */
>  	__u64 sector;		/* disk offset */
>  	__u32 bytes;		/* transfer length */
> +
> +#ifdef CONFIG_BLKTRACE_EXT
> +	__u64 action;		/* what happened */
> +#else
>  	__u32 action;		/* what happened */
> +#endif /* CONFIG_BLKTRACE_EXT */

You can't use CONFIG_ symbols in UAPI headers, as userspace
applications won't set it.  You also can't ever change the layout of an
existing structure in UAPI headers in not backward compatible way.
