Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A4C64EC4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 17:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCFRjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCFRjr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 12:39:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABA2D70
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jWH/ATEoP1EursY7MbBIuCscVP87dVrLzUWURdHMIf8=; b=KU/g0LQJ2ohUoNjax8Dp51j3uo
        3hfgZ1V1+adJsSoPAi+J1akYsjFXXHyEBK7eDgDmigJ3Xu25A+dSVJSNRIEIzZjKr1kcfQZYgRB8F
        MDiT0ayvwkYpgFe2RcCzL1S5YHTE+lDme57UG5bFB2aCD2xhQnYozQwqgFG8zMhFd4wWcuMLJAyCx
        L3u+y0hr0/xXTDQR3iTGwjZdIAx20VL0OzNTweWgmrKpmWjeoyeFy3aAdOXVVEmsrCLJ8MylrYbY0
        NMevUp8xTWy2D98Rl4FwQM56tpJkxSQaf68wYT0vvpWzSJoexb53X3jwMUdTiPcEdWpC7nMQqPVX/
        W0WctAWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZEmN-005XKw-Bo; Mon, 06 Mar 2023 17:37:43 +0000
Date:   Mon, 6 Mar 2023 17:37:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] brd: convert to folios
Message-ID: <ZAYk5wOUaXAIouQ5@casper.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-2-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
> -	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> -	if (!page)
> +	folio = folio_alloc(gfp | __GFP_ZERO, 0);
> +	if (!folio)

Did you drop HIGHMEM support on purpose?
