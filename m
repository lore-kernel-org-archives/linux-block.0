Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BCBC7EE2C
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbjEZPko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbjEZPkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 11:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE7F3;
        Fri, 26 May 2023 08:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B749865120;
        Fri, 26 May 2023 15:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDDFC4339E;
        Fri, 26 May 2023 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685115641;
        bh=S624nhijQGtzKeaSOXuQkD5+GZH07PgA64D+RGxJD9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9xl9MVccduxlpE1tkKGE6enbEiSQ5iBOl+BE1eZMTWltCoNzDZM3sXXfi+29yUv1
         R7r6oH89U7DivMiZZLr06Rn6A66e4qEEoTPRB3xxgwFvziIbck72vuw4GrERE1Fvt5
         uzzhNiYLs83E69EWkIn+bRUEbV+Zc6KxDWRgYp2RFg0/9f7PAJNkWzloBKl2tZ9Sov
         hTKcICXi0f1W5cGrALum66A9aj5SXZrgJmx2huBo9u1wD+BADvwie1ZuIH1BkmdQKR
         zHjXvjFZfw+GL/PBV8ZkJsW1lelwYwt2jSWQhutUn2+L3bb1uvngb7HanslyBZOFvq
         SqAqprlkugXRQ==
Date:   Fri, 26 May 2023 09:40:37 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, brauner@kernel.org, djwong@kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 1/8] page_flags: add is_folio_hwpoison()
Message-ID: <ZHDS9XpOElkRK4ry@kbusch-mbp.dhcp.thefacebook.com>
References: <20230526075552.363524-1-mcgrof@kernel.org>
 <20230526075552.363524-2-mcgrof@kernel.org>
 <ZHC5Zm3t9JIITu3h@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHC5Zm3t9JIITu3h@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 26, 2023 at 02:51:34PM +0100, Matthew Wilcox wrote:
> On Fri, May 26, 2023 at 12:55:45AM -0700, Luis Chamberlain wrote:
> > Provide a helper similar to is_page_hwpoison() for folios
> > which tests the first head and if the folio is large any page in
> > the folio is tested for the poison flag.
> 
> But it's not "is poison".  it's "contains poison".  So how about
> folio_contains_hwpoison() as a name?

Would a smaller change in tense to "is poisoned" also work? I think
that's mostly synonymous to "contains poison".
