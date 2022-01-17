Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE639C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiAQIjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiAQIjT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:39:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C611C061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 00:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=hBpLbZVC0EI3tin40em2W5a1Uc
        jzUmmf35yJVB8LDe2zl9G0V4Cv55XqzXFn+zVSOjK41acmY6rwKLnJerQ0NIxza+JWXlZEvGzQzVj
        3V4OuC5/K/glmDYWXRLv5vql+z0vSeNEkJ3QhcmyLGibeZBmZqYtZ924nzjlewFDS2TivLMdLI30n
        88/fAOoHP8EmF4CCU2SXmw0iZjJ9une6obmS9wXlUYE5t4fKv9TDrzrH/tHsK3FzBMpWoSuGSIyXd
        qkwWWCmcPKAWz7X1lCF+QO11EoE67JOeEQHm70s0cmf+wGJ9kbLcJBG1xnsPrRZ5O/z0y0ISqlTtS
        QzTRJCBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9NXp-00E6nv-Rf; Mon, 17 Jan 2022 08:39:17 +0000
Date:   Mon, 17 Jan 2022 00:39:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: cleanup q->srcu
Message-ID: <YeUrNZHlovDb58Ce@infradead.org>
References: <20220111123401.520192-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111123401.520192-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
