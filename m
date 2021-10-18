Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D87C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C001F60FF2
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJRKYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:24:48 -0400
Received: from verein.lst.de ([213.95.11.211]:33222 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhJRKYs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:24:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89C7D68AFE; Mon, 18 Oct 2021 12:22:35 +0200 (CEST)
Date:   Mon, 18 Oct 2021 12:22:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
Message-ID: <20211018102235.GA7331@lst.de>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk> <20211013045822.GA24761@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013045822.GA24761@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do you plan to respin and resend this one?
