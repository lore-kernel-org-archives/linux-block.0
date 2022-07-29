Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6025BC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 14:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiG2OXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiG2OXX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:23:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13DA6C138
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:23:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 41C2D68AA6; Fri, 29 Jul 2022 16:23:20 +0200 (CEST)
Date:   Fri, 29 Jul 2022 16:23:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 4/5] ublk_drv: add two parameter types
Message-ID: <20220729142320.GD32321@lst.de>
References: <20220729072954.1070514-1-ming.lei@redhat.com> <20220729072954.1070514-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729072954.1070514-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Another change is that discard support becomes not enabled at default,
> and it needs userspace to send ublk_discard_param for enabling it.

FYI, independent of my deep diѕagreement with the model I agree
with that change.
