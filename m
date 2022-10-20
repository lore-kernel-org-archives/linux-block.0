Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 08:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJTIRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJTIRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 04:17:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B1169107
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XGpw+MPUsDD6yfCUxHt/UvpeYZn6UV8lfugIiNXndwA=; b=1PNIbmBVJDE2FYvsKoRwWPh6bH
        kXfPR5QbjWprfogX0xzZtpI/Wowu8UtStpkEIsjgkWE6T4C9OvYedw7fIEd5seM38b2eDwuuXcvy3
        HyDUvQjLdddAa32/voQG9sRqIafZ62m0NWoZCgdVYylvZOMmVMQafCoyVwB1B/CW4FOCluP9VzKrG
        rkO/86PVDGeAynpJcl72jREFN5EmQZtQVnBt3OYcsJs5Ua/yipDGxEeMaybDrVRwHYtTd9zFHIjYY
        b/1JaD875Oy5sy7YMegEka7euPPxawEDOLDckIxJFb4eLE6vJSEKRiuy8XjodQcoiJhdpLmXwA47M
        HdVADzAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQkJ-00C85f-NC; Thu, 20 Oct 2022 08:17:43 +0000
Date:   Thu, 20 Oct 2022 01:17:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [dm-devel] [git pull] device mapper changes for 6.1
Message-ID: <Y1EEJ6BEN2uOh8uj@infradead.org>
References: <Y07SYs98z5VNxdZq@redhat.com>
 <Y07twbDIVgEnPsFn@infradead.org>
 <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 11:54:49AM -0700, Linus Torvalds wrote:
> I wouldn't worry about maintainer sign-offs just for exporting a
> helper function, but I agree with the whole concept being a complete
> disaster and not a good idea at all.

It's not just a a "helper", it is internal magic for KASAN and low-level
code patching.  No driver has any business checking if something is a
module text/data address, and I'm fairly sure how they are using it is
actually wrong if DM is built in.

FYI, I also agree that the concept is a disaster as well.
