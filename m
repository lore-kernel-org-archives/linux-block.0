Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62071C0015E
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGMNnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjGMNnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 09:43:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03753C0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 06:43:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 063F46732D; Thu, 13 Jul 2023 15:43:04 +0200 (CEST)
Date:   Thu, 13 Jul 2023 15:43:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: don't allow enabling a write back cache on devices that don't
 support it
Message-ID: <20230713134303.GA25950@lst.de>
References: <20230707094239.107968-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094239.107968-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, does this make sense to you?  Without this we can deliver
flush requests to drivers not supporting them, which is a bit nasty
even if it's not exploitable without root-equivalent access.
