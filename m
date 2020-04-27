Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9F4C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF82820656
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgD0O5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:57:35 -0400
Received: from verein.lst.de ([213.95.11.211]:48798 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgD0O5e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:57:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D1D068CFC; Mon, 27 Apr 2020 16:57:33 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:57:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 7/9] loop: Move loop_set_status_from_info() and
 friends up
Message-ID: <20200427145732.GG5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-8-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-8-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 09:42:20AM +0200, Martijn Coenen wrote:
> So we can use it without forward declaration. This is a separate commit
> to make it easier to verify that this is just a move, without functional
> modifications.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
