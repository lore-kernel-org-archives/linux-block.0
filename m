Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE971C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 06:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A8760FDA
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 06:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhJNGPL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 02:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNGPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 02:15:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1750EC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qz7CninZkaTZ3XVXyGu5+d69HyJLXiLepgAZ9ratY6E=; b=tD0adRd9/6V6b6BjMCxH/qoEBb
        hyHX7dd7o/rRGDjTFtQqzo9IIO0D4fdkm4zMoFw/ClNn0uo5NwD0VziI4AClmsMmN7LGyA9jBSy/1
        9urlEEaHw7lyash+nFpgl8cjln3AstYeUXPWVNEM7ccsX1XXO5WqJc3FHcHFQMG0xBFy7jGWwU03Y
        MUWR2+1MiX6uRffqktU/wVNqokUtFH1pMl0Ef8c08wUo6Ukcnhs9FBGHNNkNBB8uOFViL0K9SkU77
        lPJMqqBsFzTLnO0MlWNtdCxUynb1pTl7FSigtesTJEeUrgx36Moelu24p4zbr6jtcnxINThZEszFQ
        ny5jVrhA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1matwh-0084wS-Gl; Thu, 14 Oct 2021 06:10:54 +0000
Date:   Thu, 14 Oct 2021 07:10:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kernel NULL pointer triggered with blktests block/025 on latest
 linux-block/for-next
Message-ID: <YWfJ06KX3HT1nANX@infradead.org>
References: <CAHj4cs8poXTLdC+j6u7zypLKR7RpAaG-vxK4dWDz6bCMfPOjsQ@mail.gmail.com>
 <YWaiLsQkwe9aq8pE@infradead.org>
 <CAHj4cs-=DbnXS_552yyYxd5dae3wRXzoQftPUpUhSPjNfD-RBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-=DbnXS_552yyYxd5dae3wRXzoQftPUpUhSPjNfD-RBQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 09:36:27AM +0800, Yi Zhang wrote:
> Yeah,  the issue was fixed with the patchset, feel free to add:
> 
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

Can you post the tested-by in reply to the series?  Thanks!
