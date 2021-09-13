Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792A0C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5825860F51
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 15:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbhIMPue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbhIMPuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 11:50:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB31C028C3E
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nkfa8MwxM6Nj1LLWeK2CkNG59h1RbMMNklrqm7CaNzw=; b=Z/xhKylwA6D36vLVrEMyr9Trvn
        dcacxWftwcy5KE7QZ3zNb5QrmjjTPf86CjuSD6+/9NYNgUrTH5N2bfE8hrStOsVDgMBiGDv6GQLde
        7qNC9Nv10xX52MXZkJuKGwJkVe4FJbGM0gVmpKcQPx5W9kSVMWWc8rY55JcWDyxdX8iXQZe2O4OUG
        TwNuheOXopIqy8Q8NY8pJBG+nw3AzPDUz/IlFjMkweKK7rBZf/oBnT3Xf0iNPm6Sb/eyCyWM94ihx
        m4NXX/3zIBDdlpYJEeBCaVeHwWan6QHVlfuTpdh35HFjJKq7sb8IoT/1uQ/i6N88Oi48w2ZP6+lpA
        bUaahU8g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPnwf-00DhY1-Nc; Mon, 13 Sep 2021 15:32:45 +0000
Date:   Mon, 13 Sep 2021 16:32:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH 3/3] nbd: Use invalidate_gendisk() helper on disconnect
Message-ID: <YT9vEVF0BxIv5qDS@infradead.org>
References: <20210913112557.191-1-xieyongji@bytedance.com>
 <20210913112557.191-4-xieyongji@bytedance.com>
 <YT9HFOTnBFWMUE74@infradead.org>
 <CACycT3uo6GqLx8i=rtn9P2kaSGHjnNnamX3KR0Xgq_5QEhWWUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3uo6GqLx8i=rtn9P2kaSGHjnNnamX3KR0Xgq_5QEhWWUA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 09:04:12PM +0800, Yongji Xie wrote:
> On Mon, Sep 13, 2021 at 8:43 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Sep 13, 2021 at 07:25:57PM +0800, Xie Yongji wrote:
> > > +             invalidate_gendisk(nbd->disk);
> > > +             if (nbd->config->bytesize)
> > > +                     kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
> >
> > I wonder if the invalidate helper should just use
> > set_capacity_and_notify to take care of the notification in the proper
> > way.  This adds an uevent to loop, and adds the RESIZE=1 argument to
> > nbd, but it feels like the right thing to do.
> 
> Looks like set_capacity_and_notify() would not do notification if we
> set capacity to zero.

True.

> How about calling kobject_uevent() directly in
> the helper?

That's probably and improvement over letting the driver do it, so let's
go with that for now instead of adding ever more work to your plate.
