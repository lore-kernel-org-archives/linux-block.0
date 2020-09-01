Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA5C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B106204EC
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 07:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgIAHlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:41:46 -0400
Received: from verein.lst.de ([213.95.11.211]:52257 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHlq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 03:41:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB8ED68B05; Tue,  1 Sep 2020 09:41:43 +0200 (CEST)
Date:   Tue, 1 Sep 2020 09:41:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Some clean-ups for bio merge
Message-ID: <20200901074143.GA30547@lst.de>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
