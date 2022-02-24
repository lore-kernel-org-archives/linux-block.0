Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 13:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiBXNrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiBXNrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 08:47:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13F260E;
        Thu, 24 Feb 2022 05:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gxscHiRXDPIyMrsKXNUkNH4px+oy0V+KUOkv72mWuVw=; b=W5s183Ho0CMMKKdZeTEai8uAkD
        6rkQXwgL+y7l9Y5rwLXIDauHK/Bkor0tliB1UBHmxMO03lhT3dKbRNdBUhy8dkYzwWxCwvkqj2WF1
        XC4XXkDmI9IrI06at45scfu0bIqHucDoeEOh8LfT50g5Q8tELVTpJ24GCwGBKno9u+OnK6YEJ5V4x
        ZlsSrUckXdvpEpyUQ/d2JCle9cD6MOaf/pniPDY4cPXgkqtdZTfx9UYsmuu/Vmd9ey3LkirsXt+Rz
        zmkeXrmQuf3P9fz4tbGRoeIQvXXaYIh+m6963EssX0PCAIwomRD8RR+MvdsX7Dvunz6b7lgop7/is
        UAkAqYmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNERy-000zvW-8x; Thu, 24 Feb 2022 13:46:30 +0000
Date:   Thu, 24 Feb 2022 05:46:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V5 10/16] blk-wbt: get rid of wbt_enable/disable_default()
Message-ID: <YheMNqrhxp6r/AhH@infradead.org>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
 <20220224090654.54671-11-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224090654.54671-11-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 24, 2022 at 05:06:48PM +0800, Wang Jianchao (Kuaishou) wrote:
> wbt_enable_default() is used to open wbt feature by default.
> wbt_disable_default() is only employed by bfq which has similar
> writeback throttling mechanism. This kind of policy should be
> selected by the user instead of being set in kernel. This patch
> get rid of the interfaces and let the user configure appropricate
> blk-rq-qos policy by themselves.

This drastically changes the user visible behavior.
