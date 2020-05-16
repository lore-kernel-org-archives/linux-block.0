Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F173DC433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4BF206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgEPMxK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 08:53:10 -0400
Received: from verein.lst.de ([213.95.11.211]:60489 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgEPMxK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 08:53:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D41F268B05; Sat, 16 May 2020 14:53:07 +0200 (CEST)
Date:   Sat, 16 May 2020 14:53:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, damien.lemoal@wdc.com, hare@suse.com,
        hch@lst.de, axboe@kernel.dk, linux-bcache@vger.kernel.org,
        kbusch@kernel.org, Ajay Joshi <ajay.joshi@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [RFC PATCH v2 4/4] block: set bi_size to REQ_OP_ZONE_RESET bio
Message-ID: <20200516125307.GB13759@lst.de>
References: <20200516035434.82809-1-colyli@suse.de> <20200516035434.82809-5-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516035434.82809-5-colyli@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks ok, but I want to hear Damiens opinion.
