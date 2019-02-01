Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3DBC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACC720870
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbOnUBYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfBAHfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:35:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBAHfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 02:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yhcrCBsItI1oofff7jkxut7eb58YFbSGqr2tagpYPhU=; b=EbOnUBYdk6J5BhpwhK6ij09us
        ZT16beEfLdSCqkqTzZ3YtZHuPeENTVTKfjHpX8ROyk8y0K8DgvPn8rcSQNjvRfl94cQK7R4Qu0gpe
        4qQyGHtGRBvouma+1dDRssNVcSzKdeL3znT300hnBqV5wwbq89PMOS3fHDpZeZq9BNpLG/5o6hc4r
        dnEPy+K0YC+hGwCZvll3s4s0uvf+4Q+M7h1QW5TVYAJ+PFyB7W0DHfy2OI6l6s8BxFSS8IWGN9Ybq
        dXJ0UDpkA0uz422mP8D9KR5zMIpaS2kKLAsYVSZ6WCUc1KfXfuNKxfxLZFaolFgrEfUKfCOZSr0BJ
        1tobPOOfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpTMF-00056g-QY; Fri, 01 Feb 2019 07:35:27 +0000
Date:   Thu, 31 Jan 2019 23:35:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
Message-ID: <20190201073527.GA14758@infradead.org>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com>
 <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
 <20190131103924.GA22503@infradead.org>
 <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 02:41:52PM -0500, John Dorminy wrote:
> > On Wed, Jan 30, 2019 at 09:08:50AM -0500, John Dorminy wrote:
> > > (I use WRITE_SAME to fill devices with a particular pattern in order
> > > to catch failures to initialize disk structures appropriately,
> > > personally, but it's just for convenience/speed.)
> >
> > How do you use it?  We don't have a user interface to generate
> > REQ_OP_WRITE_SAME requests.
> 
> A not-checked-in test module, similar to Zhang Xiaoxu's reproducer,
> exposing a sysfs node to trigger filling a block device with a test
> pattern.

Any reason you don't just use SCSI/NVMe passthrough directly from
userspace for that?
