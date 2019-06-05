Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A1C282DE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48304206B8
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 10:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfFEKJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:09:56 -0400
Received: from verein.lst.de ([213.95.11.211]:41928 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfFEKJ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 06:09:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 69D4368B20; Wed,  5 Jun 2019 12:09:29 +0200 (CEST)
Date:   Wed, 5 Jun 2019 12:09:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: too large sg segments with commit 09324d32d2a08
Message-ID: <20190605100928.GA9828@lst.de>
References: <alpine.LFD.2.21.1906051057200.2118@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1906051057200.2118@schleppi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem is that we don't communicate the block level max_segment
size to the iommu, and the commit really is just the messenger.

I'll cook up a series to fix this as papering over it in every driver
does not seem sustainable.
