Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700CC54FCB
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59EE2082E
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 17:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDVRkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:40:47 -0400
Received: from verein.lst.de ([213.95.11.211]:53916 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgDVRkr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 13:40:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 321EB68C4E; Wed, 22 Apr 2020 19:40:45 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:40:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v2 3/5] loop: Move loop_set_status_from_info() and
 friends up
Message-ID: <20200422174044.GC30852@lst.de>
References: <20200422100636.46357-1-maco@android.com> <20200422100636.46357-4-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422100636.46357-4-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
