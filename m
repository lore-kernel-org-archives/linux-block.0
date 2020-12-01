Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC16C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 19:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C642151B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 19:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgLATgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:36:02 -0500
Received: from verein.lst.de ([213.95.11.211]:51118 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgLATgC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 14:36:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B69E68AFE; Tue,  1 Dec 2020 20:35:20 +0100 (CET)
Date:   Tue, 1 Dec 2020 20:35:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 0/4] nvme: enable per-namespace char device
Message-ID: <20201201193519.GB3171@lst.de>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've applied patches 1-3 to nvme-5.11.
