Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6986BC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C360F45
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 08:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKDItx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDItx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 04:49:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CEC061714;
        Thu,  4 Nov 2021 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=S4REKNn574lvMvEEX+xf3RM7R6
        xl/lnOMTtQ2uxUKckQ85Bk4LIUJb8T7Iwe1Ur1Fxlv5S3K9NImQ13h8gYbEARyLziVZLQfL+Sy09b
        gxckRdBb0lcWBFgIxHh5zeJGs2hdx64gZlhURYGZjr21TGYPykH7igJ4iVq/56lHpnxfgFcfaqzhU
        g8VSa5SJittuB0HV3N2yOnn58bETgiTtM2SoDT52e+SiQWNnwPXbPT9AHi/bY52/b0yVoNk4qYJ94
        HwdK4FNQZw8ZzHbuv9RtyIzOvIc4zuvtfxcNpMwxMpOiAOBXydkGcQ2APMKwAtbubcpDciKJTjtXJ
        2/io3SQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYOv-008MFy-B1; Thu, 04 Nov 2021 08:47:13 +0000
Date:   Thu, 4 Nov 2021 01:47:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wu Bo <wubo40@huawei.com>
Cc:     lars.ellenberg@linbit.com, axboe@kernel.dk, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] drbd: Fix double free problem in drbd_create_device
Message-ID: <YYOeEZwKAcgxtczz@infradead.org>
References: <1636013229-26309-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636013229-26309-1-git-send-email-wubo40@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
