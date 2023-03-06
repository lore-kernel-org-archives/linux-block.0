Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EDEC6FA99
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCFRln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCFRlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 12:41:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5006905E
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35wcz5hc61ZFy76pubbDiDGaen0LBiU13LJduClKJGU=; b=ijji4yrgPfBLZR16xJkRIrI85g
        mZt4yX3h9WWj9BAQFjekwmEnW4jqQspkLGrhLoid+gw/MjVmCBsfJ63bisKx9/PD7xhEWL7nCBrNd
        k9hnPAMl0aVuMAOzz8OF7WV0DR5GoFh4NcNH2Mjfl/Wy9D3PoBs2IBsNOxZafOLt9cBfUHrnQ1ebv
        wcRIZs/Hhfr4FAgSEOtrbz0EZMrBV91VU6JvFBj3H1xijihU8ZJN917A+qmYk4UtnAWbqsx3pQdqw
        Rn/oN41kPhJ29OpEdVDfhBXMZ++FArVWduPw3r08u1F9FozdINg9LGSv8DZq2koPXTyIF3r3e6cVf
        +uq4Ku5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZEoe-005XQI-JT; Mon, 06 Mar 2023 17:40:04 +0000
Date:   Mon, 6 Mar 2023 17:40:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] brd: limit maximal block size to 32M
Message-ID: <ZAYldLT52jAc82Xj@casper.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-5-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 06, 2023 at 01:01:26PM +0100, Hannes Reinecke wrote:
> Use an arbitrary limit of 32M for the maximal blocksize so as not
> to overflow the page cache.

The page allocator tops out at MAX_ORDER (generally 4MB), so that might
be a better limit.  Also, this has nothing to do with the page cache,
right?
