Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD0AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00C36115A
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhJTGOr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:14:46 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D95C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4XgCjOVVI2i6LFaS23D6eX/1MUnCAyZzPwcwAsrPgo=; b=DwLrSRx3Klyyir9MMRSehVYdqu
        FQJB327Vfi0YddEdSMia8SE3Mwg43z+IZwepC6NP++/L10LQY9ftxJhwSH7rs1tFttL+IOm2qf8ak
        fHd686SIjdITZ16dHuP5PumCW4D4kwkpky98dzrPoKhspITiWieOpna8ogqHC1CDF/lfpAjsoS6+4
        TsGM0AtSXy6qV9jp/axQJgydluzD+OhQpCJlF2DzbtABU5pQSBhVbXBr1WlsZmWoj8Ay0nFua+xCC
        kKNt4WjmuQ+Q16p1xHeh83f87O5+Q76iR3f3hJJhSV/lo9hwc0qTmEp+m21jykrBGG5MPEJLFEwdl
        +57J98PA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4q0-003Sa8-Mh; Wed, 20 Oct 2021 06:12:32 +0000
Date:   Tue, 19 Oct 2021 23:12:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/16] block: don't bloat enter_queue with percpu_ref
Message-ID: <YW+zUKSJQe3sEk4P@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <49bff6b10644a6c789414bf72452edb7d54c132f.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bff6b10644a6c789414bf72452edb7d54c132f.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:13PM +0100, Pavel Begunkov wrote:
> percpu_ref_put() are inlined for performance and bloat the binary, we
> don't care about the fail case of blk_try_enter_queue(), so we can
> replace it with a call to blk_queue_exit().

Does this make a difference for you?

That being said using the proper helpers always seems like a good idea,
so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
