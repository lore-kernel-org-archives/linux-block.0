Return-Path: <SRS0=wt6W=PH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE38C43387
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBFE20855
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 09:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QvM6Q14T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeL3JHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Dec 2018 04:07:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeL3JHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Dec 2018 04:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ya7Ovsd1iNircJb+H2ZNRkZATC5DHDHfQwaCnup1ihI=; b=QvM6Q14TurZyIT21EdDig8khx
        Ev1ZBZZ8CZ5AfzRPCvC+2nqJv1aeEb6YfESQ30ioM0IziRcihhJmkmK7ZnNVFd5bECww/U8ql3UP9
        y2FgVnVwIltXoq2VQ4sSdP1MC8eYrh8gFZRu54BNRrmt2jN/zc984DGM0uoLJAxvh6GyOZkzkyD9F
        XIhoe3/4Yvh0yMThv0ESxeDIf4zSZ5Bim6Xwbfud8SfrekMxUvFArq1KBG0Z0yPzn9ULkXf7kNZ1A
        SyUKfgsvbSpu9GA5x2Np4NiR4x+gU47jolbN69JPg2zEu09mHkXK9XB354cJVR/3EZuOiHh1ljxqr
        JJqAJ6ybw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gdX3W-0001yd-LD; Sun, 30 Dec 2018 09:06:46 +0000
Date:   Sun, 30 Dec 2018 01:06:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Subject: Re: [git pull] device mapper changes for 4.21
Message-ID: <20181230090646.GB1022@infradead.org>
References: <20181227160944.GA12190@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227160944.GA12190@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 27, 2018 at 11:09:44AM -0500, Mike Snitzer wrote:
> - Fix various DM targets to check for device sector overflow if
>   CONFIG_LBDAF is not set.

Question to Jens and Linus:

is there any good reason to keep the CONFIG_LBDAF=n option around?
Less than 2gig block devices seem to be an absolutele niche, and I
wonder if it is still worth maintaining the special case just for that.
