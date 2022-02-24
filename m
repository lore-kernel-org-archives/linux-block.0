Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C092C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiBXNih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiBXNig (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 08:38:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9C2325E0;
        Thu, 24 Feb 2022 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pSG9VKsocbOb9dm1C22kjN5wJ/oQIWKQqoMqe/mbDA8=; b=OzmIl/GNUNU0vvCVFKVqdMI3m+
        DHasNp+W9LIDbUjs3qJ6FOLJ3SASd5FS5tdeS2MfOf1a9Y5HC9V6YAIWMFa/CgJ8yuNPGRt1IaDtE
        snQlA17ADB0sNun9C23QvpwqGsbotLtorej/26vVjjGyjFSLOWzdv7XDVu+dc12vSbxZOiH3HBClC
        x85zsvbSEId7P2W32kRWhyboKVQgwKMEoUSFa6+TX0qVOrr3YWZKQV29qyghyLMmThwqVXlSafRZ2
        LaBlJ+sncUbSnuO8N+DO8B5KxBzyVHk2FWaWPOMbBOEsWWPatMyZM03bf/qHxrL0UAo0rxgOdB3Sy
        xtk26jhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNEJl-000xpW-C5; Thu, 24 Feb 2022 13:38:01 +0000
Date:   Thu, 24 Feb 2022 05:38:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V5 01/16] blk: make the whole blk_mq_submit_bio under
 q_usage_counter
Message-ID: <YheKOdJdibfxSr5R@infradead.org>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
 <20220224090654.54671-2-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224090654.54671-2-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 24, 2022 at 05:06:39PM +0800, Wang Jianchao (Kuaishou) wrote:
> This is to protect the rqos list against the rqos open/close. We
> need to drain all of the caller of blk_mq_submit_bio() before
> we can operate the rqos list.

This means ever I/O now has to d an extra refcount roundtrip.
