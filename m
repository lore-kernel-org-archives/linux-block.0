Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A9C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 07:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4B761354
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 07:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhDTHD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhDTHDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 03:03:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7417C06174A;
        Tue, 20 Apr 2021 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Oihx25ixLmgK896s6BkBU4Zy4ZTSxg7BY07q9IT2hQ=; b=hFqirIfh+nlo9lCAUemEoOwmcU
        ZMdFNj8RgdzR2qM5APmrrVtR2OeTcERwNN38u6nFxezVx5GJo/xAtYA7HD2DxH0kqehLO52bXBwLe
        4/yxCWMoy1FXMYDGSBjvTS3E9tGAd58v9GOpMqgE+YHl2Vwv1VS5Gu+Zq+IQHvZlk/l2dqxTnG4FG
        MHw2JbqYRC17ffhqd08MnBFxZTB/JNwajHFljefrZWjdnheFvlycOhNYNrNFZHVPMf0UJTWMTKfYK
        P8u11hg1IsH0zaSL1KL7F3EnxipCucT9Xw4ZAr0PB8sF+LfvSOvdTbzuzkN4XE+OubYIRqGoz37Mw
        Jw7zA3AA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYkO1-00Eplv-KX; Tue, 20 Apr 2021 07:01:54 +0000
Date:   Tue, 20 Apr 2021 08:01:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Enrico Granata <egranata@google.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
Message-ID: <20210420070129.GA3534874@infradead.org>
References: <20210416194709.155497-1-egranata@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416194709.155497-1-egranata@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just to despit my 2 cents again:  I think the way this is specified
in the virtio spec is actively harmful and we should not suport it in
Linux.

If others override me we at least need to require a detailed
documentation of these fields as the virto spec does not provide it.

Please also do not add pointless over 80 character lines, and follow
the one value per sysfs file rule.
