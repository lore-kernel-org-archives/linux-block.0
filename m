Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 15:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbiDKP6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348376AbiDKP6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 11:58:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D21F61C;
        Mon, 11 Apr 2022 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bNnKT3FMsfwzN5V/FDXQTcsUJdznUaKk7ddayE2Frck=; b=B3E7qLlSNcHWD6zGJG4DGcOOLW
        jPVaqk71dYhTVW/sUBJTeiXwSGg3lgI+UFjokJiryLIBxjL2P95YQ/n+Tta67kfIDYeksAxq478TP
        qf+0Se4WEBTzVgtNJbX1Jt/OS8IvKAA6guLIrSX7rhdCoI4V96/EMPAuhjVDGlb4OD/rHV4vJCriZ
        juopfLh1/T+ui143iKZgkZApP0kqMisPxLEWloB5G8ALb4KOiINv3AFiqQ1WAeOAkNVm+zu4w3OMU
        eAyd7amySJQQTTrwDZgkGhaCrRIZtG90TkpVJGsasXOJxBlBaEK666iHayRZyjRBPICbZMJ3bSUxL
        WG6xyhTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndwOd-009gdV-8R; Mon, 11 Apr 2022 15:56:07 +0000
Date:   Mon, 11 Apr 2022 08:56:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs: kernel-parameters: update description of root=
Message-ID: <YlRPlwbr6tVhddRG@infradead.org>
References: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
 <1649475581-12139-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649475581-12139-3-git-send-email-yangtiezhu@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 09, 2022 at 11:39:40AM +0800, Tiezhu Yang wrote:
> root=UUID or root=LABEL is not supported without initrd.
> It is better to update description of root= to explicitly
> tell the users.

These are not supported at all by the kernel.  Maybe some code running
in an initramfs might do some magic with these, but they have no meaning
for the kernel and shouldn't really be documented here.
