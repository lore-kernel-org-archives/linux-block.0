Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E71C433EA
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5034C2071A
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgE2OlZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 10:41:25 -0400
Received: from verein.lst.de ([213.95.11.211]:33325 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgE2OlZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:41:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6DA768BFE; Fri, 29 May 2020 16:41:21 +0200 (CEST)
Date:   Fri, 29 May 2020 16:41:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        alan.adamson@oracle.com
Subject: Re: [PATCHv3 1/2] blk-mq: export blk_mq_force_complete_rq
Message-ID: <20200529144121.GA4987@lst.de>
References: <20200529143744.3545429-1-kbusch@kernel.org> <20200529143744.3545429-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529143744.3545429-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 07:37:43AM -0700, Keith Busch wrote:
> For when drivers have a need to bypass error injection.

The subject doesn't quite match the content, and the commit log in
general could be a little more verbose.  The changes itself look
fine to me.
