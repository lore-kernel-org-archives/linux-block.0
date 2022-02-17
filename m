Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02089C4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 08:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiBQInY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiBQInX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 03:43:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E9222DC9;
        Thu, 17 Feb 2022 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=srOPsA2UG/DyG90LXGGf2coqIfcpStSnhfATvzutOpo=; b=Oi0y9I30bfF8XTa3KuI8sK89ov
        Db1xrUrYgQ3MvGtT9SGZrjouxcnZR4obZFG9Oynu8WSAjGon5BgzYF0IddnJtDkPknFPhyEGCrAhg
        IAYH+oh5OVt1k/pa4wnP7ELans2RzRVZJXewnuzu9FkGgbubxsfTsGUsCGgz4QU4sPOre7ITEcl+E
        5gsjiHpYf5jcZgkJwAv/mQm1kjRCztwdTdNQIZHz6G+XsRwVyIYzWie7L/X3hTZPiUliIi9Y5HgfT
        pbEmBI629DkZ/COtR/fVQtRzj3mv+WbLP83gscr1yVg7JBRqRQKoyGlJr8ei00wUPvBbmF1NNGuOq
        MU5o5UOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcNT-009X9N-Qc; Thu, 17 Feb 2022 08:43:03 +0000
Date:   Thu, 17 Feb 2022 00:43:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 0/6] blk: make blk-rq-qos policies pluggable and modular
Message-ID: <Yg4Kl6EHWS5N3WoH@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-1-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 17, 2022 at 11:13:43AM +0800, Wang Jianchao (Kuaishou) wrote:
> Hi Jens
> 
> blk-rq-qos is a standalone framework out of io-sched and can be used to
> control or observe the IO progress in block-layer with hooks. blk-rq-qos
> is a great design but right now, it is totally fixed and built-in and shut
> out peoples who want to use it with external module.

And that's got.  External modules do not matter.

That being said this series has a bunch of nice cleanups, but we really
do not need the exports and modular build.
