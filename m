Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A34C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhLFHmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhLFHmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 02:42:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8DC0613F8
        for <linux-block@vger.kernel.org>; Sun,  5 Dec 2021 23:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lGI+c5un0a6ccc/9Hs51h9xYaU9wDB+HD4c7sLwemWs=; b=eRorUO98HQSxLYiCxSWFDgTc6r
        MeoLbeWsMeYXF2mYpaCBWGl8uOpSk+Yran9zeVXd474P1lUUsFiVtAJ8y2c7RV9Nthi5oO2EZ9EQP
        EPwjaFtiCjOUvayiH/jaJ5fRKDy4yYQ09M3LNRvE3Uv/XhOhvESZ51Ts3U3RkoH4RIGZlgd/8UjDL
        NkIX66gTdOpe7MlhcC6C6BTZTALm35X4u9+vdGHvN/z7THc7qlSVTw0rSvg+FZjTzt05QsNsf1C8E
        4VUWzSMWK+e/LGswv30nLPURAJeer3J4vuoNFlZ+QXfuFIjBVep3H4hLlLl3tyWuU78i70PlSZbXP
        ZP/KDCYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu8a0-002mSE-UM; Mon, 06 Dec 2021 07:38:32 +0000
Date:   Sun, 5 Dec 2021 23:38:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
Message-ID: <Ya29+OXo3SBh7UNo@infradead.org>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203214544.343460-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As mentioned last time I really don't like the proliferation of
tiny helpers with just two callers.  See my patch I responded with
for my alternative.
