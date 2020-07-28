Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C7C433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 07:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4162070B
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 07:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JntUi9p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgG1H26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgG1H25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 03:28:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B364CC061794
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PnTiI6x/sak0R2gLWnrCW4hEpYzYXmbXoG/zi1RknDY=; b=JntUi9p6NoVZq27KVEEHRoIwhs
        n6rgc4o+g8b5uI1HUxxMYelzAQUOH2OZLQBGdfvkNdqeRyRfEg43qjUV6/vhDqYgSJtGPkY3BAvM5
        vVMjUK3fxkb6t54FoPoKYIN8I94B8JoHLm9xez+vEN7eUGQRRC0UZlZn+ZBO51Z+0HxFHeJ1Kl6tE
        KHRs+WVqPJMa1ueH7c+NgKQSRc90fQdtNB6zQkBCVYxXCUvysEZXVbpVhuw+d7nqnI1j1/DXX4FQ+
        iiZp2DENGZQfmESuIItnV7oXtpJ56lp9XfeKAn8y7C8nIxH5DlQbxQXdRA/SYU1u8XJ9M/1yiiIqX
        IxkX1ICg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0K2h-0001Lv-MB; Tue, 28 Jul 2020 07:28:55 +0000
Date:   Tue, 28 Jul 2020 08:28:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritika Srivastava <RITIKA.SRIVASTAVA@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH 1/1] block: return BLK_STS_NOTSUPP if operation is not
 supported
Message-ID: <20200728072855.GA4774@infradead.org>
References: <1595608402-16457-1-git-send-email-ritika.srivastava@oracle.com>
 <20200726151003.GB20628@infradead.org>
 <1C19DDD2-C7E9-45B5-9FBE-641E7BAB974D@ORACLE.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C19DDD2-C7E9-45B5-9FBE-641E7BAB974D@ORACLE.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 12:11:19PM -0700, Ritika Srivastava wrote:
> Hence block layer issues write zeroes in blkdev_issue_zeroout()
> 
> In response, the storage returns the following SCSI error
> Sense Key : Illegal Request [current]
> Add. Sense: Invalid command operation code
> 
> Once this error is received, the write zero capability of the device is disabled and write_zeroes_max_bytes is set to 0.
> DM device queue limits are also set to 0 and device-mapper fails the path.
> To avoid this, if BLK_STS_NOTSUPP could be returned, then device-mapper would not fail the paths.
> 
> Once the write zero capability has been disabled, blk-lib issues zeroes via __blkdev_issue_zero_pages().
> 
> Please let me know if I missed something.

Oh, the stupid SCSI runtime detection case again.  Can you please
document this in a comment?

Also please switch blk_cloned_rq_check_limits to just return the
blk_status_t directly.
