Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1D2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 17:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbiEJRdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbiEJRdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 13:33:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D27291E5D;
        Tue, 10 May 2022 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQO7/niJrUBpu2+Gosv4JX0Ptlav7tay6E7B6qWXJJ0=; b=LTeIHcyvwxvrhORF5SZATmiJTQ
        hiuhAdAES7FIwDE5pAwAOC66j4wE5PN3KVTFNseRxc5Qmgi5SvJQcJ3RjeFEIDWMCWv7h/n7uULvv
        9mV7UCFbOtR7/WL4acpMn48WAEFO57TQqNRxU/HUq9beB+xlSnP6IKbOt43yeHYMyJz17T1KxsiG+
        ZQ7nj952v/31JPYo5kwGrOFHqfglAKrnCeXFx4+W8kH9e4jtKmcsODfkUfzkMe6bi0ZtzrGZ1/h2+
        wqtUF6KaDeXDV5xJlYrSs6tqCoCmJZOr1OxjntYVbykL9qXuEfkuzs5J+HIRoP6Mx5pAtsCma8rPo
        poabCTNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noTfh-004fLH-Es; Tue, 10 May 2022 17:29:17 +0000
Date:   Tue, 10 May 2022 18:29:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.17 20/21] block: Do not call folio_next() on an
 unreferenced folio
Message-ID: <Ynqg7RRxiFIKrDqX@casper.infradead.org>
References: <20220510154340.153400-1-sashal@kernel.org>
 <20220510154340.153400-20-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510154340.153400-20-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 10, 2022 at 11:43:39AM -0400, Sasha Levin wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> [ Upstream commit 170f37d6aa6ad4582eefd7459015de79e244536e ]

ACK the backport of this patch.  The problem is latent in earlier
kernels, but there's no need to leave the trap lying around.
