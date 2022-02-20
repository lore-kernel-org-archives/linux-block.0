Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DAAC433EF
	for <linux-block@archiver.kernel.org>; Sun, 20 Feb 2022 04:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiBTEYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Feb 2022 23:24:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBTEYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 23:24:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8482C103;
        Sat, 19 Feb 2022 20:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c8v4ITuHVpAOp4laAy/uW+v8pdIIcHqFhG/m0vM+DvA=; b=d3/j6IIyNMVyujvlB9Q8bv9Ztz
        tXKaP1VPu4QEmA9TU+WAJjAxPySqIl5nLSCjFiLWXMI42EgrQUVjbQJR5nUCa8nKperiOz9Nz9gEm
        13tO5Uf+b+nugTJddTuLL9jAaLw+FJWGUAgll5eYUr8Y41kzoAbHejEIY7OE+iDornU0M8HAEPMQ/
        LZaGYHop8a3JNosyTZ81UkA/ros71CJlU15+WqYVhOY+RSE7ZL+mJa8o+N4VF3+1+NDMyuA2bx7ob
        zDVCaCLLFRJjNMWjfpDwD/+61+ALAG/CAl8/IMn5P94d/YCY3yTWe+ydw3P1b9sbuacBs8sOFECFv
        e6cgzjZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLdlG-000axH-Rn; Sun, 20 Feb 2022 04:23:50 +0000
Date:   Sun, 20 Feb 2022 04:23:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 04/13] fs: split off __alloc_page_buffers function
Message-ID: <YhHCVnTYNPrtbu08@casper.infradead.org>
References: <20220218195739.585044-1-shr@fb.com>
 <20220218195739.585044-5-shr@fb.com>
 <YhCdruAyTmLyVp8z@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhCdruAyTmLyVp8z@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 18, 2022 at 11:35:10PM -0800, Christoph Hellwig wrote:
> Err, hell no.  Please do not add any new functionality to the legacy
> buffer head code.  If you want new features do that on the
> non-bufferhead iomap code path only please.

I think "first convert the block device code from buffer_heads to iomap"
might be a bit much of a prerequisite.  I think running ext4 on top of a
block device still requires buffer_heads, for example (I tried to convert
the block device to use mpage in order to avoid creating buffer_heads
when possible, and ext4 stopped working.  I didn't try too hard to debug
it as it was a bit of a distraction at the time).
