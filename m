Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55C0C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B992067D
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kT/xV0hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVTOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:14:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKVTOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 14:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gOyQruMzd8cHJN8Wf5sPNmqzqGIJ/LKI5zHiYqR3hGI=; b=kT/xV0hGuxZ7gwzWbRz3dvrNK
        bm7Yd1zPV7vGh/tZW0S463Dye7peW+iCv96x7ScnJTuoyrbAKXpx0uu1VXzTGJq25fKAo5+rVuEmX
        W7+8XOq2e4w92yQdEI6Po5ektSt6l0hRzNspcf84eaof8gNeWrDZLWJnPU36/NfLl7b5PiT78/I+9
        nMR+jqOdEfooVW5BuROqc7uzduyjg+jOwbtInR9hot2SfI15Rmd1bA8SDrlTuySW69mTUzkk0YRYH
        VKZ8S9yniPuvTdekcr1rhxX29d3OBHwXp9W/SCzBxDkQ56OOft2P8oM+SyqTzwumqekod55YEO4D0
        jkCJWJXNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYEO2-0002hz-81; Fri, 22 Nov 2019 19:14:34 +0000
Date:   Fri, 22 Nov 2019 11:14:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <20191122191434.GA10150@infradead.org>
References: <20180824211535.GA22251@beast>
 <201911221052.0FDE1A1@keescook>
 <20191122190707.GA2136@infradead.org>
 <94976fb5-12d3-557d-7f31-347d6116b18c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94976fb5-12d3-557d-7f31-347d6116b18c@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 12:09:14PM -0700, Jens Axboe wrote:
> On 11/22/19 12:07 PM, Christoph Hellwig wrote:
> > On Fri, Nov 22, 2019 at 10:53:22AM -0800, Kees Cook wrote:
> >> Friendly ping! I keep tripping over this. Can this please get applied so
> >> we can silence syzbot and avoid needless WARNs? :)
> > 
> > What call stack reaches this?  Upper layers should never submit a write
> > bio on a read-only queue, and we need to fix that in the upper layer.
> 
> It's an fsync, the trace is here:
> 
> https://syzkaller.appspot.com/x/log.txt?x=159503d2e00000

Oh.  I think this is a bug in the block layer, we should not treat
a sync as write for the purposes of is read-only checks, as it never
writes data to the device.  At the request layer we alread use
the proper REQ_OP_FLUSH, but at the bio layer we are still abusing
empty writes apparently.  I'll try to cook up something over the
weekend.
