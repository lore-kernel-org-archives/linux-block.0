Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F961C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiAQIUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiAQIUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:20:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B22EC061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 00:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EegJr8UhSStfFwxllMqQCzqTRQtySKQs5A+cFGYBt5U=; b=rNKe8+qvo99/RcoV+RxfgS4nQc
        wQSTgnFdb1tUWDqt87mpxUV/YIBboIPPGg9+2Ksj5wP7p9lNHncFJxEzbM+DRA29ilUoQq7EoD/Km
        DSR354GdZ0DI9fh86RqdqigSO2vTKqfGVbE0VeJ70jZrqChK8OT6HkxEVRPjE6ZCMXKQ+SBGTlv+p
        ytDBlQnsU6BvHcHqVZ5VZqbe++ywe2ZEuqM4M7ADW7SkPuNESUayeCDLnpC79zbU2iYnjjdGJe+nj
        IYINg90hXVWijPozqbPmQleJu6FeMvYAxZvg6K9GWTVb0RK18v8zZuNdUKeN2euw+T/MQpAkWWB0s
        qW5Fuc0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9NFF-00E35S-HB; Mon, 17 Jan 2022 08:20:05 +0000
Date:   Mon, 17 Jan 2022 00:20:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [RFC PATCH 1/7] block: move submit_bio_checks() into
 submit_bio_noacct
Message-ID: <YeUmtWfqD2Gkdy0F@infradead.org>
References: <20220111115532.497117-1-ming.lei@redhat.com>
 <20220111115532.497117-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111115532.497117-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 07:55:26PM +0800, Ming Lei wrote:
> It is more clean & readable to check bio when starting to submit it,
> instead of just before calling ->submit_bio() or blk_mq_submit_bio().
> 
> Also it provides us chance to optimize bio submission without checking
> bio.

This looks ok, but I'd just remove submit_bio_checks entirely while
we're at it.
