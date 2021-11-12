Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF7C433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D68A60F45
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 06:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhKLGjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhKLGjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 01:39:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38120C061766;
        Thu, 11 Nov 2021 22:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Db8t6F5Pbuj2JoJiAWFEwe5cDXdV62Gu4CZa5mkhUh4=; b=c9DyYwf5ZnZWztWVdZUh5hclM+
        BCUeh4UhA2/Npd7iLsfqFjsLSlpluvMUcLhpjKQR1JyfsIJOt8l5wmK6ZI7+HMpO1+wkcnqXS0/d1
        ukyVyPJMIM1WXxFnT+aIgs99Ch/NlJoNdbs82duR9Voc4XzrKGcHBrIMUS9yp5EkTBlcFTwldBR9L
        YY6OUowYS7II4/HUvNd+gApruf81teCcBEkBkD+bPsLLKClDI5m1/szCFeQ2kspSt2LvlDczk6k7h
        hgwT05zfgtGzVUn/h2zIgZNUvFjdqW8vaPQSRUl8PRbir1YEPisIN0efgxmAPuCvp62fQF9aYhFCv
        ZCwolUrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlQAc-009XEz-19; Fri, 12 Nov 2021 06:36:18 +0000
Date:   Thu, 11 Nov 2021 22:36:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: general protection fault in del_gendisk
Message-ID: <YY4LYofN+yppiHDy@infradead.org>
References: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
 <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
 <90d72173-edd8-79d9-b680-b1d47ab78150@kernel.dk>
 <YYDehlqjWUKizzmB@infradead.org>
 <0423c908-00c9-e22b-38cc-bae899f18834@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0423c908-00c9-e22b-38cc-bae899f18834@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 08, 2021 at 11:19:35AM -0800, Tadeusz Struk wrote:
> I have ran this on the latest mainline. I can confirm that the errors are
> nicely handled there. It triggers a warning and panics in device_add_disk()
> because of:
> return WARN_ON_ONCE(ret); /* keep until all callers handle errors */
> and
> Kernel panic - not syncing: panic_on_warn set ...

The WARRN_ON will go away once all drivers are fixed.  And no, it does
not panic the kernel unless you set an obscure sysctl asking for it to
panic on warnings, in which case you get what you ask for.
