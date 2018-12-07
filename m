Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71DC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFEE20672
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TWAClJXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFEE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLGTnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:43:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGTnW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 14:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xrlUeBG9RxpToZxxkwQB1g05pKAVkCJc/pXEr8EWaqE=; b=TWAClJXv1OT0Rn3BDfECrsbum
        5CXQEgV8UwFGGgL6XaZmvlHm1xuyTuhrpPBYS2YvIgI51gFAQXkE55Lg3SXgHeI1OYc+QLfEFgiZW
        ShHSN9cYolqhNoxNbOvx5KpLShQpKPIgpdE8IDSV0yS8DITlFYTds5zf9i8cI9p5yA9x2W9NAN8EG
        9s9AE1GPqW44F5VGPs6WKpFxa+qwJOMmjPZz4IhqUlNkgp7Oetv5fHooM5wgmVpkfuIEczKDgm7xH
        FStq3ABSPDK7baCPu8J56NtC9d1CQJZxSY9dyhlGQ6KbLbwS2lS3xeD6xKrV/MfEMRgMb9w9G+nu1
        9YC0kUz1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVM1w-0003n7-5Z; Fri, 07 Dec 2018 19:43:20 +0000
Date:   Fri, 7 Dec 2018 11:43:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Eric Wheeler <dm-devel@lists.ewheeler.net>, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH] dm crypt: fix lost ioprio when queuing crypto
 bios from task with ioprio
Message-ID: <20181207194319.GA1690@infradead.org>
References: <20181206221507.5423-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206221507.5423-1-snitzer@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 05:15:07PM -0500, Mike Snitzer wrote:
> From: Eric Wheeler <dm-devel@lists.ewheeler.net>
> 
> Since dm-crypt queues writes (and sometimes reads) to a different kernel
> thread (workqueue), the bios will dispatch from tasks with different
> io_context->ioprio settings than the submitting task, thus giving
> incorrect ioprio hints to the io scheduler.
> 
> By assigning the ioprio to the bio before queuing to a workqueue, the
> original submitting task's io_context->ioprio setting can be retained
> through the life of the bio.  We only set the bio's ioprio in dm-crypt
> if not already set (by somewhere else, higher in the stack).

The scheme looks a little odd to me.  Instead of requring a driver
call why don't we just make sure bios always have the submitting
tasks priority set and then make sure the lower layers can rely on it?
