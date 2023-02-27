Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C117C64ED8
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 14:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjB0Ok6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 09:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjB0Ok5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 09:40:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB8820571
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 06:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OiKDjMY7dvSQ7W6cY5BYoTE6RSYnW9h6AGoIRXw/Xro=; b=5GlnoxHPHpgeVPg254Qbx2MkQa
        5gV69nMK/suevZrCYUObN+CEDSCiuXaAst/YpKa/YaXcPjEjYtbfZjwVKS0mBYPiXmp1NKP7n8fJc
        d+1XJbjVFGvu/zw8r1MZcrBZugqQnFLrMFn+FA766zfwW++gw7JmoWNl203w7wq3mWI1bXj2SJp0f
        Ck6fB+0PFzsY5S5W4Gm5uamrsBqrk/kXzLS2U/C//MlsD9n1+w3FsIBim9VwzmjYnh+JThPK7mBMT
        vLTfltcci+HWvKio0Y7HS24sDamMZFHkdwn1QKbJFP6ooUUz5zVlKU2w9vkysM0gJTWHPG9P+8Bla
        28CGWRJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWegM-00A1Fj-Kn; Mon, 27 Feb 2023 14:40:50 +0000
Date:   Mon, 27 Feb 2023 06:40:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y/zA8v/xUYtC6Iu0@infradead.org>
References: <20230222185224.2484590-1-ushankar@purestorage.com>
 <Y/Zp8lb3yUiPUNBv@kbusch-mbp.dhcp.thefacebook.com>
 <20230223193446.GA2719882@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223193446.GA2719882@dev-ushankar.dev.purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 23, 2023 at 12:34:46PM -0700, Uday Shankar wrote:
> I chose to add blk_queue_get_max_segments as a public function because
> it parallels blk_queue_get_max_sectors. If you don't want two functions,
> I could manually inline the (2) uses of blk_rq_get_max_segments(rq),
> converting them to blk_queue_get_max_segments(rq->q, req_op(rq)).

I'd be much happier with a single function that takes a request instead
of two decoded arguments.  This should not be a public API in any form.
