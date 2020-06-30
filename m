Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB75C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B346620720
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgF3FMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:12:18 -0400
Received: from verein.lst.de ([213.95.11.211]:34486 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgF3FMS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:12:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6719768B02; Tue, 30 Jun 2020 07:12:16 +0200 (CEST)
Date:   Tue, 30 Jun 2020 07:12:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        rostedt@goodmis.org, snitzer@redhat.com, agk@redhat.com,
        axboe@kernel.dk, paolo.valente@linaro.org, ming.lei@redhat.com,
        bvanassche@acm.org, fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 08/11] block: fix the comments in the trace event
 block.h
Message-ID: <20200630051216.GE27033@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-9-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629234314.10509-9-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 04:43:11PM -0700, Chaitanya Kulkarni wrote:
> This is purely cleanup patch which fixes the comment in trace event
> header for block_rq_issue() and block_rq_merge() events.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
