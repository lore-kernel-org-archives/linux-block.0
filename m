Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4DC04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0711B20815
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 11:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbfETLRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 07:17:36 -0400
Received: from verein.lst.de ([213.95.11.211]:51590 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbfETLRg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 07:17:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1348068B05; Mon, 20 May 2019 13:17:15 +0200 (CEST)
Date:   Mon, 20 May 2019 13:17:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Message-ID: <20190520111714.GA5369@lst.de>
References: <20190516084058.20678-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516084058.20678-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

is this ok for 5.2?  If not we need to hack around the sector
accounting in nvme, and possibly virtio.
