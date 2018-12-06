Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB187C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788F20700
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFZ3b5jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788F20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLFQUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:20:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HTO5sUWLYTRQvoU4XCieX4K/3NvSFUsz03OUfs1Ed3U=; b=dFZ3b5jgtyw6FaIcQjGzUEysgf
        FeHSVUyOuJBjDebdFl9jcMkBn0I8vt8gGaPZktnZZ4IVtfYCHq70nnSnbDwPXzlpKjgWdfnJx494n
        FqADsy6M8RQywUnw7+VuFQcDlLpx0kzVij4dXnzLYRHFmWJtPe+rmJ51nq3G4SjwQTObY51uTi2kt
        m+4QQAKJbta4RQWo1ZnahCyo9H9z+GDuRZgkRRPM252P5jlPimYJQ4i259t/hFr2xuqKkpyIguqn/
        981DDXpsym5xBLAcgyI95uXGN9ub1dvYMfWT9dYMoWZIoa6RsDJAq8Hot7ZnLKHw2iMIQ9q2t0gay
        3A91Or+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUwNb-0005aF-IZ; Thu, 06 Dec 2018 16:19:59 +0000
Date:   Thu, 6 Dec 2018 08:19:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Weiping Zhang <zwp10758@gmail.com>, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] block: add documentation for io_timeout
Message-ID: <20181206161959.GB16308@infradead.org>
References: <20181205141701.GA33910@192.168.3.9>
 <20181205144006.GA18123@infradead.org>
 <CAA70yB5WQPYzptck=miwiBrV7=uixvLKpJrzGEOP9zBU5Y2CwQ@mail.gmail.com>
 <CAA70yB7rD_vqMXUvHrQ8SwH-jAyDZeL58TkqABqJ0Y=-p_pjyg@mail.gmail.com>
 <1544112376.185366.230.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544112376.185366.230.camel@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 08:06:16AM -0800, Bart Van Assche wrote:
> On Wed, 2018-12-05 at 22:59 +0800, Weiping Zhang wrote:
> > Weiping Zhang <zwp10758@gmail.com> 于2018年12月5日周三 下午10:49写道：
> > > Christoph Hellwig <hch@infradead.org> 于2018年12月5日周三 下午10:40写道：
> > > > Can you please also send a patch to not show this attribute for
> > > > drivers without a timeout handler?  Thanks!
> > 
> > Is there a simple way do that ?
> 
> How about checking the timeout member of struct blk_mq_ops for blk-mq and
> checking the rq_timed_out_fn member in struct request_queue for the legacy
> block layer?

Just the former given that the legacy code is gone in for-next.

> > Shall we return -ENOTSUPP when user read/write this attribute when
> > driver has no timeout handler ?
> 
> A much more elegant solution is to introduce a sysfs attribute group for the
> io_timeout attribute and to make that group visible only if a timeout handler
> has been defined. See e.g. disk_attr_group in block/genhd.c for an example.

Agreed, that is the way to go.
