Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB2DC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208E20678
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 06:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g3y+GoEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgAaGXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:23:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgAaGXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 01:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1++zzGV6QkWMWMT/4u5YKU2pHSpkvi0FTAouJWOgaWQ=; b=g3y+GoEc9kZTB4RdA+dfNTO81
        uUCGBV1IhvklrE4xmWsd4chMSgGQWP6SH3n/sUs/WPFsuKy7IIRUh/V1k9kPdtDQ7+wQbrmjWe4M/
        T8I0xGaxhl5YjTX3lVaUjsyiPjadjjskrO/WWhx1LBWbbhisFz/Xla4o9iyc4XhqFxGs07rOqGhdS
        A3tT2BCG+xi8mSPFFK8Fpyvz2Q6NpfrgGjtne7EJ00Db828M/dFnk7o+CyRmWC95pDm4Zk/BTdsl6
        iAJvpmRLeCtEoQIm+Jm8HGeOldA3TRKdURn5y6VcDavodgzVtyENQe+MIF6ciY3Mx1sE7uUcVWyds
        NChhE2kPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixPiR-00036o-HH; Fri, 31 Jan 2020 06:23:43 +0000
Date:   Thu, 30 Jan 2020 22:23:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH block v2 2/3] block: Add support for REQ_NOZERO flag
Message-ID: <20200131062343.GA6267@infradead.org>
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
 <157917816325.88675.16481772163916741596.stgit@localhost.localdomain>
 <yq14kwpibf6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq14kwpibf6.fsf@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 21, 2020 at 01:14:05AM -0500, Martin K. Petersen wrote:
> I find there is some dissonance between using BLKDEV_ZERO_ALLOCATE to
> describe this operation in one case and REQ_NOZERO in the other.
> 
> I understand why not zeroing is important in your case. However, I think
> the allocation aspect is semantically more important. Also, in the case
> of SCSI, the allocated blocks will typically appear zeroed. So from that
> perspective REQ_NOZERO doesn't really make sense. I would really prefer
> to use REQ_ALLOCATE to describe this operation. I agree that "do not
> write every block" is important too. I just don't have a good suggestion
> for how to express that as an additional qualifier to REQ_ALLOCATE_?.

Agreed.  Nevermind the problem of a REQ_OP_WRITE_ZEROES operations with
a NOZERO flag causing a massive confusion to the reader.

> Also, adding to the confusion: In the context of SCSI, ANCHOR requires
> UNMAP. So my head hurts a bit when I read REQ_NOZERO|REQ_NOUNMAP and
> have to translate that into ANCHOR|UNMAP.
> 
> Longer term, I think we should consider introducing REQ_OP_SINGLE_RANGE
> or something like that as an umbrella operation that can be used to
> describe zeroing, allocating, and other things that operate on a single
> LBA range with no payload. Thus removing both the writiness and the
> zeroness from the existing REQ_OP_WRITE_ZEROES conduit.

What is the benefit of a multipler there?  Given all this flags
confusion I'm almost tempted to just split up REQ_OP_WRITE_ZEROES into
REQ_OP_ALLOCATE ("cheap") and REQ_OP_WRITE_ZEROES ("potentially
expensive") and just let the caller handle the difference.  Everytime
we try to encode semantic differences into flags we're eventually
running into trouble.  Sais the person that added REQ_UNMAP..
