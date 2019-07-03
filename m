Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C2C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 12:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C8218A0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 12:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGCMQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:16:10 -0400
Received: from verein.lst.de ([213.95.11.211]:51029 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfGCMQK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 08:16:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B139E68B05; Wed,  3 Jul 2019 14:16:08 +0200 (CEST)
Date:   Wed, 3 Jul 2019 14:16:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: remove bi_phys_segments and related cleanups
Message-ID: <20190703121608.GC7671@lst.de>
References: <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com> <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk> <20190702133406.GC15874@lst.de> <bfe8a4b5-901e-5ac4-e11c-0e6ccc4faec2@kernel.dk> <20190702182934.GA20763@lst.de> <ef4a5fb5-9d79-75e1-1231-fdfc14f91835@kernel.dk> <20190703000055.GA28981@lst.de> <a01c861b-8c5c-0f6d-4ca8-00e97bcecbd9@kernel.dk> <cdc56c4e-37ad-812c-076b-cb2c7eb0c01a@kernel.dk> <20190703013536.GA31366@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703013536.GA31366@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 03, 2019 at 03:35:36AM +0200, Christoph Hellwig wrote:
> I didn't run with online discard, but I tried FITRIM (with XFS).
> 
> I'll try looking into ext4.  I remember we had some weird one offs in that
> area for the different ways the physical segments are calculated, so this
> makes sense.  Off to dinner now, but I'll look into it tomorrow.

ext4 reproduced the bug instantly, but it was Write Zeroes, not Discard.
Which explains the whole thing as ext4 is the only major user of Write
Zeroes.  A oatch will be on its way shortly.
