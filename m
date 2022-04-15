Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB90C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349537AbiDOFJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352189AbiDOFGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:06:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542DD74
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5AmW0r/V26ZmGzi1QFOe5Qvot0b94Lo2yVwGhzL7kks=; b=yLtnAgiSiM3OoeQvPwpweJiyrx
        Lz2N7yXgJJliuFap0vauHrwcTHzwMKUCpwEapsJiVTveq6su/96YHuOnrSO8MQ5origiMw1QciSxt
        zKYzSunKdzIzBSAprwsS7d1+HpzD2f9cvj1Xp3dc/SAmTe4BmuQ2VIPYzAOIgAR/ClCUSG9iqrwgF
        jeZuY2ukfE1kAnpdqWkWcJVd/QtPpTrzShvATTWNojzJbjZILSpvnibmBuFw0EChJuNX9ohr6yUHH
        OEE+neDBNgQETWfBupEmWaUacu+WzL/dTM60mnLoFu083NP+5Ee3H9El2thn/5XYFILezuAaR0uSG
        BUDsAlIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfE73-008X2e-BJ; Fri, 15 Apr 2022 05:03:17 +0000
Date:   Thu, 14 Apr 2022 22:03:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 0/9 v7] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <Ylj8lRf8Q86iJaaw@infradead.org>
References: <20220401102325.17617-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401102325.17617-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm not really a blk-cgroup expert, but these do look good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and I'd like to get this staged for other blk-cgroup changs I have
pending :))
