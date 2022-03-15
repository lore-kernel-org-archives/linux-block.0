Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7EEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350568AbiCOR32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350567AbiCOR31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 13:29:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E6BC27;
        Tue, 15 Mar 2022 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UdiN65fSr7/2X7e8bWyjvwKNEav4vFsCDC4wSv4RZJs=; b=fEMleCZDbMYrZwksya0ZIFBBNS
        K5vA6jNhIkAy5g3b0ejE0EtDWSrajgOXoj9lTH3tUyxqxXAUEyxVv3iRt4Pp1f4GbVBpmDSb0sZrc
        s7x/QV8qfT3PJ6c3XTpI5F4kO5e11W1Bf/oedv+r4hmBXvzvT2QhqC5AKumnRIM/XuxKSUbO2C7qF
        ZpSzvuXuy0U7t2nRAEDKrsBmCX1X3Jr1bJli/1AYIwH9NuKhWrlZ4a0lHMO4GZsytnJh26BAvql/A
        SP93idpVVPu98SwaiQA0Er0XZ/Ax2X3q+TKN/BGXQ93GgFzxxw81kFZAVKTtp/d3Z84nVM3GYmE8E
        pPhrPCVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUAxn-005EY0-Uf; Tue, 15 Mar 2022 17:28:03 +0000
Date:   Tue, 15 Mar 2022 17:28:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linnux-mm@kvack.org
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
Message-ID: <YjDMo35Q/cvPLkxu@casper.infradead.org>
References: <20220315172221.9522-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315172221.9522-1-bgeffon@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> Today it's only possible to write back as a page, idle, or huge.
> A user might want to writeback pages which are huge and idle first
> as these idle pages do not require decompression and make a good
> first pass for writeback.

We're moving towards having many different sizes of page in play,
not just PMD and PTE sizes.  Is this patch actually a good idea in
a case where we have, eg, a 32kB anonymous page on a system with 4kB
pages?  How should zram handle this case?  What's our cut-off for
declaring a page to be "huge"?

