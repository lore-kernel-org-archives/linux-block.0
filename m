Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDAC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAB2611CE
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhKDTea (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhKDTea (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 15:34:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192CC061714;
        Thu,  4 Nov 2021 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IgyRd2waBlNCrMjSSmERlQB54Ngi/imrPkns2njYLsc=; b=C9ECYipk7RiK3ASqcJXgqWTjH6
        pm+LTphZHRcWlFn10zbPEkhmzlX+UtmZIM0HWFnR5tNNkTUnOLPdlbsZ2sm+/RSMpyGhiUZ2GXZZ5
        Y46Q3JPPJWY8BLqvasbwD/sYaMfB4jQIBK2ojqTZtqTbhaoPd4ZVeV6wKTPcRTm4+/xKTSwN+nGB/
        dxBc0b8PssUdMNpLOm2zXBjFgiLckID3PHYezciIcMR8oL2i+V4njTCINb0neN7RMfDzsAHuX5N9M
        jB7vsXcurrnZa2C2bavoBxEYiIHPtZ9wrQlcNKOLsF80LZU2l3H9b09XBtgARrPsIEVxGAl6fQCxP
        I54esy4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miiSj-009szW-QI; Thu, 04 Nov 2021 19:31:49 +0000
Date:   Thu, 4 Nov 2021 12:31:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hare@suse.de, hch@infradead.org, wubo40@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix bd_holder_dir kobject_create_and_add() error
 handling
Message-ID: <YYQ1Jd+F+2Cksyyt@bombadil.infradead.org>
References: <20211104192959.2355827-1-mcgrof@kernel.org>
 <993a116a-72bf-9304-1577-3f2e4300daeb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993a116a-72bf-9304-1577-3f2e4300daeb@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 01:30:29PM -0600, Jens Axboe wrote:
> On 11/4/21 1:29 PM, Luis Chamberlain wrote:
> > Commit 83cbce957446 ("block: add error handling for device_add_disk /
> > add_disk") added error handling to device_add_disk(), however the goto
> > label for the bd_holder_dir kobject_create_and_add() failure did not set
> > the return value correctly, and so we can end up in a situation where
> > kobject_create_and_add() fails but we report success.
> 
> I'm just going to fold this one in, as it's top-of-tree.

Makes sense.

  Luis
