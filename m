Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDEBC4724C
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47729208D6
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgEARaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 13:30:35 -0400
Received: from verein.lst.de ([213.95.11.211]:47993 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgEARaf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 13:30:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9B8968C65; Fri,  1 May 2020 19:30:32 +0200 (CEST)
Date:   Fri, 1 May 2020 19:30:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] loop: Refactor loop_set_status() size
 calculation
Message-ID: <20200501173032.GD22792@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-5-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-5-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some reason this fails to apply for me against both
Jens' for-5.8/block and Linus' current tree.

What is the baseline for this series?
