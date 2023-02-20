Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF320C636D6
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 06:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBTGP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Feb 2023 01:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBTGPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 01:15:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2537CC26;
        Sun, 19 Feb 2023 22:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3uV+RiYyUQ+pVL8HkgHHPaj8uV
        bsLxmcouCEsinuTs+Y7nnLwDcIcvq7d6ILXyNegFP3aD9C4P4CoXZemffyTHsLu/zET+mIrTJ8beo
        v8o1OPRTe6kzyfLsfu61SUB9Cc+nbxW0MO3NBW4ZDyT8en5Hn6alh9fZZiqL3xspVbgNC/bCzQwxU
        tksjX8hgNwooMVQiEY4RFK/cjiyPrTPNeauEUrgdV1NSEtZihqYWNh3wGUvvXyauw3QYHUbjlRjvM
        g3ZxNRzPKMCcEXcRmF30FRy++KdP/B3CAzVc2SSpV3Xfq+I4lG5URwZICoMMhZEma/+mxYeGee7fK
        pC3tLSnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTzSC-0037gl-5F; Mon, 20 Feb 2023 06:15:12 +0000
Date:   Sun, 19 Feb 2023 22:15:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 2/4] Move ep_take_care_of_epollwakeup() to fs/eventpoll.c
Message-ID: <Y/MP8DwANiHoRGxR@infradead.org>
References: <20230217202301.436895-1-thuth@redhat.com>
 <20230217202301.436895-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217202301.436895-3-thuth@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
