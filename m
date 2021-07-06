Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC716C07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69F061988
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGFF2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhGFF2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 01:28:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC2C061574;
        Mon,  5 Jul 2021 22:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V9RQWVqTQeoAkXWE4Ne/8f/6vQUcvWf8z6pk/6TsLT0=; b=g787ZCRwxrrOMFbum+GrK7ZTBw
        HhsrDl6Ucf1UNaYQJZTcDWa7fcb+NxrQv1VXAVkCNyKeeYJro3+P5MZcSb/dogGbNtfH3EXf9HFD1
        esxHkyJccGdewMrAdZVvGQ0OvDLPQYnQTLmsecxcqZtEahFR+Mo6FT765bhN0sPwq+msyDz6DkfMK
        YKozDJoKMrhkkrmoRPqaSfMl1YJsz8R3WDVt2j5qSt4+y18lbr2LZ1fJ/XUnb9jxjwHThWcZ0DJZ/
        MBwY10Bth1TMSk53G/n468zN1q5st7NXtgf3xexqzFcxpxoaC7DlDovv4hqi1ZHO7/BqaHZTn1h54
        YnlQWIJw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0dZz-00Ardc-Db; Tue, 06 Jul 2021 05:25:11 +0000
Date:   Tue, 6 Jul 2021 06:25:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: fix the problem of io_ticks becoming smaller
Message-ID: <YOPpM6et9rFNrBOn@infradead.org>
References: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 05:47:26AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> On the IO submission path, blk_account_io_start() may interrupt
> the system interruption. When the interruption returns, the value
> of part->stamp may have been updated by other cores, so the time
> value collected before the interruption may be less than part->
> stamp. So when this happens, we should do nothing to make io_ticks
> more accurate? For kernels less than 5.0, this may cause io_ticks
> to become smaller, which in turn may cause abnormal ioutil values.
> 
> v3: update the commit log
> v2: sorry, fix compile error due to the missed ')'
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

The change looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I still have trouble understanding the commit log, especially
the last sentence.
