Return-Path: <SRS0=iG2v=ZY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0077C43215
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DCD20718
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfLBSXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:23:46 -0500
Received: from verein.lst.de ([213.95.11.211]:39661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfLBSXp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Dec 2019 13:23:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE8A468BE1; Mon,  2 Dec 2019 19:23:43 +0100 (CET)
Date:   Mon, 2 Dec 2019 19:23:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: don't send uevent for empty disk when not
 invalidating
Message-ID: <20191202182343.GB9639@lst.de>
References: <20191202182134.4004-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202182134.4004-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
