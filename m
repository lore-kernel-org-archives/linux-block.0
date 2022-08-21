Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48148C00140
	for <linux-block@archiver.kernel.org>; Sun, 21 Aug 2022 05:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiHUFt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Aug 2022 01:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHUFtz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Aug 2022 01:49:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574311A38B
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 22:49:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB21B68C4E; Sun, 21 Aug 2022 07:49:52 +0200 (CEST)
Date:   Sun, 21 Aug 2022 07:49:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests v3 4/6] common,tests: replace _have_driver()
 with _have_drivers()
Message-ID: <20220821054952.GC25878@lst.de>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com> <20220819093920.84992-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819093920.84992-5-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I always found _have_modules rather strange as multiple lines to check
for one driver at a time seems more readable. 
