Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFFBC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 08:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJTIQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJTIQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 04:16:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B6102DFD
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CZS8CR+I5rC/M2ogdtMccYBRhDkWgXtLf1tvCP6s+qs=; b=1X72yehe52eLAcvuiEvnWfE9rv
        4WO2W7lNdyPF8BeFNqv+QB47CsUK3MviciBXHqEnE2v10w/bSrHT63vlN0oeEvLnHI4u2LWg6HifP
        wVuIUZZ5Rrmc5Wk4kZCcV+t1j34aaszjLJhEWgxlVPZtIt9GdRBuoRN4MDGULw5NKSriiSxsWHVXM
        c1mwGruy40QGpJg2i0t2pKQVvZCf/Ls4COVyKL72caQX/kKO/LBcCG1cOIfGjEXGM8ckj2z9GF+3Z
        ouAr4a5SFNY1SWbZzxjfHhSZjOrScsA5lJGXuBJwXpQ4tHGFCEoz0roqy6+Us0/Dr8mMBpq386Ar5
        P2tAPSqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQij-00C7O0-B7; Thu, 20 Oct 2022 08:16:05 +0000
Date:   Thu, 20 Oct 2022 01:16:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [dm-devel] [git pull] device mapper changes for 6.1
Message-ID: <Y1EDxZvjEi47iWUN@infradead.org>
References: <Y07SYs98z5VNxdZq@redhat.com>
 <Y07twbDIVgEnPsFn@infradead.org>
 <Y0704chr07nUgx3X@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0704chr07nUgx3X@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 02:48:01PM -0400, Mike Snitzer wrote:
> > That really does not sound like a good idea at all.  And it does not
> > seem to have any MM or core maintainer signoffs.
> 
> Sorry, I should've solicited proper review more loudly.
> 
> But if you have a specific concern with how DM is looking to use
> is_vmalloc_or_module_addr() please say what that is.

If I understand the patch correct it tries to use it to detect if
a string is a string global.  Besides being nasty API abuse I can't
see how this would even work if DM is built in.
