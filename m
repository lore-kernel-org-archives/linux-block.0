Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3517EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 08:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGTIlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjGTIcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 04:32:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE7FD
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fWvec+Yh/nqYl6+g7IlB0qiNBD
        BjLFAXCFhUFcaIlZa8WoIXYLHGBHVn7YCnHaDt23L1nzC6akRqYl60k9MWDYmiLvY8p3exHNRzul3
        1sb8Lv7Cxt73cKRGwzcyHzEQo45l47x6aIY99wuazXn2TqzHogaywrZwbO5qCpUuDWBwPlacQbm4R
        Chx2vuvixDwf3B8YWaDZclXldQQKkgCZX4b1q7BkkILHFESmyN4UhCfK9jk3yMlWSlH0Y3EJeS/kD
        0Ticw4kJFP7dHV1bJIQ+eAPccRk0JMaahbw5EsvQxiXdaTTN+1YGUknAvVkSnxMd+WnSKa1cwpYPc
        Ns81RI5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMP4o-00AKsx-0G;
        Thu, 20 Jul 2023 08:31:58 +0000
Date:   Thu, 20 Jul 2023 01:31:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH RESEND 2/2] loop: do not enforce max_loop hard limit by
 (new) default
Message-ID: <ZLjw/r8QjxS72Ihx@infradead.org>
References: <20230717191628.582363-1-mfo@canonical.com>
 <20230717191628.582363-3-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717191628.582363-3-mfo@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

