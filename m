Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C9C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 10:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B0E218D3
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 10:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E1F7orNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfAaKjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:39:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfAaKjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 05:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RAiBI2LQgZe/iheI2xTgzG0F2Mhi9rtYYjPEo43NxfI=; b=E1F7orNwFk/sGGyHgY/g7URRu
        lEtpZ+TPTTyAvyORILjwPbmyab5YmTcXt5U/4/ZyKCKY5BFc9wywkRaVInCJwrcuNV3YJjwlqxlIn
        ltL+p/Cmwx7U+4DUIW7w/EZqGQJu3GfdBUgMH6CrhPTJagEzPBqBQoCmppCm3BpkQEFQuoCAom+iV
        itFgDXD2eiL54A08uA4Lnmg3pR0Tx7T3vcaYw/YlByN9yv8Js2n35MXei4yeYkrLqucXktXV+4u6t
        XGfi+DW4zZlVY2+ALkwVRWtF8ijqe2f62Fr+K3USvWQuwDzd00NpjbyTaiXf0NPVVbH0Di1BAKQlx
        ZuEmZjZaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gp9ki-0006Ao-Lj; Thu, 31 Jan 2019 10:39:24 +0000
Date:   Thu, 31 Jan 2019 02:39:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
Message-ID: <20190131103924.GA22503@infradead.org>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com>
 <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 09:08:50AM -0500, John Dorminy wrote:
> (I use WRITE_SAME to fill devices with a particular pattern in order
> to catch failures to initialize disk structures appropriately,
> personally, but it's just for convenience/speed.)

How do you use it?  We don't have a user interface to generate
REQ_OP_WRITE_SAME requests.
