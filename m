Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0535C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 06:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70F920735
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 06:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgEFGIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 02:08:25 -0400
Received: from verein.lst.de ([213.95.11.211]:39067 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEFGIY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 02:08:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E89E68C4E; Wed,  6 May 2020 08:08:23 +0200 (CEST)
Date:   Wed, 6 May 2020 08:08:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/10] loop: Clean up LOOP_SET_STATUS lo_flags
 handling.
Message-ID: <20200506060822.GF10771@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-10-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-10-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 04:03:40PM +0200, Martijn Coenen wrote:
> LOOP_SET_STATUS(64) will actually allow some lo_flags to be modified; in
> particular, LO_FLAGS_AUTOCLEAR can be set and cleared, whereas
> LO_FLAGS_PARTSCAN can be set to request a partition scan. Make this
> explicit by updating the UAPI to include the flags that can be
> set/cleared using this ioctl.
> 
> The implementation can then blindly take over the passed in flags,
> and use the previous flags for those flags that can't be set / cleared
> using LOOP_SET_STATUS.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
