Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4807DC2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CE021D7D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIWOyP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 10:54:15 -0400
Received: from verein.lst.de ([213.95.11.211]:48769 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWOyO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 10:54:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D27F86736F; Wed, 23 Sep 2020 16:54:11 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:54:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marc Hartmayer <mhartmay@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: linux-next: possible bug in 'block: remove the BIO_NULL_MAPPED
 flag'
Message-ID: <20200923145411.GA15735@lst.de>
References: <87tuvo8xjo.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuvo8xjo.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've reproduced this on x86 and am looking into the issue now.
