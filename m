Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874AC3565A
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 14:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FF82073A
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 14:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgBUOMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:12:10 -0500
Received: from verein.lst.de ([213.95.11.211]:55615 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgBUOMK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 09:12:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D93C68C4E; Fri, 21 Feb 2020 15:12:08 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:12:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Message-ID: <20200221141207.GA6968@lst.de>
References: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
