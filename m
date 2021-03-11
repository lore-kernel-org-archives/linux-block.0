Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B49C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B3E64ED1
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhCKPyf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:54:35 -0500
Received: from verein.lst.de ([213.95.11.211]:41584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhCKPya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 10:54:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80D7168B05; Thu, 11 Mar 2021 16:54:27 +0100 (CET)
Date:   Thu, 11 Mar 2021 16:54:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] block: Suppress uevent for hidden device when
 removed
Message-ID: <20210311155427.GA23641@lst.de>
References: <20210311151917.136091-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311151917.136091-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
