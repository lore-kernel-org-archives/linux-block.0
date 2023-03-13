Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76EBC61DA4
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCMPQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCMPQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 11:16:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41E2CFF1;
        Mon, 13 Mar 2023 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eQO4dib77fwpq45HsemPbGF1tK
        B+NFfyH2P44jYfEUE2nMfCjsiuccczw3afR9tVukGid8aWh+Dhr0Ge4SUC7rA3i3QGZUze1NCFOuC
        7hajc8KEK+DKGhs5uaaxOEdT+81HoJHQ7wS/CaaLQRvxZVuJyNM/TmIi+MMMW9Sp0lmJJMPD4D7Qv
        eH8OGlLUx3OFWfk+ss5Cr5HccxxTQ4eXFEdOmPRMw5LDoJSfEss0qEYzF0mWlD+S0m81gtRguFJaK
        5DBrYDs2GoivzyJpWBK68NPJw5e1NWZ48ogQyGOfLyvmp0IxwBF0o5oMXS3ZWghCUeU8fl1DIVNk/
        7YM738OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbjuP-006OLK-TF; Mon, 13 Mar 2023 15:16:21 +0000
Date:   Mon, 13 Mar 2023 08:16:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 4/5] pktcdvd: Remove CONFIG_CDROM_PKTCDVD_WCACHE from
 uapi header
Message-ID: <ZA8+RdetyyaNd539@infradead.org>
References: <20230310160757.199253-1-thuth@redhat.com>
 <20230310160757.199253-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310160757.199253-5-thuth@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
