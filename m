Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D656C25B48
	for <linux-block@archiver.kernel.org>; Thu, 26 Oct 2023 21:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJZVOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Oct 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJZVOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:14:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954A10E;
        Thu, 26 Oct 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=STBT4USV80X7xjDyPQBrhAt8zpR20Z1FI+DoegQb6k0=; b=hi92sel8fx6a1xWS0qj0ZTLs/C
        aBvXQcKQ5GoQ5MvYk1e7qacr3FeQXgWQK63i1ubM4FgoNQlD17p7gmdLEtJ4/YE8q4tv7UU8xvLyS
        CUyB/qwwB6tcIYmvkc4s7TuS0yfKgaJOaF2tiTLw6PHrxCoGabYCD5BGbhJkHQHHQwtTm5mY/hmVL
        ZDkSBZphBgFjFVDpGGFoQEQjNy1VJHGMyGdfLiKiGwIW1Y7gMwWwLLiP/K9vW8+nU2eccdpNv6XZt
        3CjL14h0Oda8aQA6e4Zt7gCu5CKzSvd4eqmSnzkhoDF1QAjfpdzkft9JkoLqCx6pgNtO5Ac6nihTW
        z4xJgRJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qw7gZ-00FA7v-32;
        Thu, 26 Oct 2023 21:14:35 +0000
Date:   Thu, 26 Oct 2023 14:14:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     axboe@kernel.dk, hare@suse.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block: Set memalloc_noio to false in the error path
Message-ID: <ZTrWu2v6Qp0QVCYw@bombadil.infradead.org>
References: <20231025075436.2212468-1-zhongjinghua@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025075436.2212468-1-zhongjinghua@huaweicloud.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 25, 2023 at 03:54:36PM +0800, Zhong Jinghua wrote:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> In del_gendisk, memalloc_noio is set to false, so it would be better to do
> the same thing in the error path.

The commit does not mention what happens if this is not done.

  Luis
