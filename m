Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A92C7EE2C
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbjEZNv6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZNv5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 09:51:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3217ADF;
        Fri, 26 May 2023 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SvwLBZQXX5ZrheXLYNiefWyXW2iP0Eez24uoDSHmJys=; b=QOq0dPbaF4MbrSU0IR5MCnSpIN
        9ZgsKioa5yhKusHYaazZDNfy/HtaOcyxYylWmeU1/BGztXN5VeRcD4Hrl9pdcoMP4wEDG3Cq43xQ+
        RRSETT/cpkyKvtemimG7kSJO3lD5avg/GklZtHjmi6bi5AOYi0XNIoP3vk8sY3bzbfwYdnDgnHbLF
        myfa808HnvK2gd2yFScHuENe+yuFKglhe5svuRYn76FglwDNsK97NQ62KWFh3mZHWBBu9aH1EmDkc
        xwa8yHbERCtYmogfbt6+fuQOnwNTxdJ+BxJHsDoZF8Z2AwV422el39CTJSgH0pZOYTNkI+eUq0OLs
        GwAtmfDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2Xqw-002pbc-AG; Fri, 26 May 2023 13:51:34 +0000
Date:   Fri, 26 May 2023 14:51:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 1/8] page_flags: add is_folio_hwpoison()
Message-ID: <ZHC5Zm3t9JIITu3h@casper.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
 <20230526075552.363524-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526075552.363524-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 26, 2023 at 12:55:45AM -0700, Luis Chamberlain wrote:
> Provide a helper similar to is_page_hwpoison() for folios
> which tests the first head and if the folio is large any page in
> the folio is tested for the poison flag.

But it's not "is poison".  it's "contains poison".  So how about
folio_contains_hwpoison() as a name?

But what do you really want to know here?  In the Glorious Future,
individual pages get their memdesc pointer set to be a hwpoison
pointer.  Are we going to need to retain a bit in every memdesc to
say whether one of the pages in the memdesc has been poisoned?

Or can we get away with just testing individual pages as we look at
them?

