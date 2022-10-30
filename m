Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A932C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ3Pce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ3Pcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:32:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F660D0
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:32:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DF0C68AA6; Sun, 30 Oct 2022 16:32:30 +0100 (CET)
Date:   Sun, 30 Oct 2022 16:32:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: misc elevator code cleanups
Message-ID: <20221030153229.GC9676@lst.de>
References: <20221030100714.876891-1-hch@lst.de> <20221030140357.1327019-1-nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030140357.1327019-1-nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 30, 2022 at 10:03:57PM +0800, Jinlong Chen wrote:
> Hi, Christoph!
> 
> Only elevator_find_get is calling __elevator_find after applying the
> series. Maybe we can just remove __elevator_find and move the list
> iterating logic into elevator_find_get?

We could. But then we'd need another local variable to track what
was found, so I'm not sure it is a win.  In general having a pure
list lookup in a helper while all the locking and refcounting in
a wrapper around it tends to be a quite nice pattern.
