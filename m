Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1842C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989D92070B
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 07:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfCZHkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:40:03 -0400
Received: from verein.lst.de ([213.95.11.211]:34742 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbfCZHkD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 03:40:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 06B8C68D0D; Tue, 26 Mar 2019 08:39:55 +0100 (CET)
Date:   Tue, 26 Mar 2019 08:39:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     luferry <luferry@163.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make blk_mq_map_queues more friendly for cpu topology
Message-ID: <20190326073954.GD21617@lst.de>
References: <20190325152640.48120-1-luferry@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325152640.48120-1-luferry@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Why isn't this using the automatic PCI-level affinity assignment to
start with?
