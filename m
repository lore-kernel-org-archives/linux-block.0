Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9437C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDE52084E
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AW/aZxf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDE52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeLJVx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:53:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 16:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k9BOrQy+T3fm4BTSDW4eDiw2aCCIgnyRvnT5+2h2cc8=; b=AW/aZxf5VGR2wlEsXbwVWV0Zp
        UDTh4c5KKOcvdx9Blf+jjLAXC/y3By3WUIXiXA/vrGFRgKKXlfFcQKv8fcYNQEB/Oj4aGJBK/qk9A
        PQPhqKm7MCnrCriEb56jK3GsD5u5OX/DBlZmxUNxSh7zzn86z54iRieJYsyLeuccx5sw3CHxK89L+
        VApVUhi31HYzG0F5OBkjp6Yrl231g2NxJikDDLAlTcsqsTBMQRV/xNMDUag9ShQlhC/5R+CKG/O0L
        n7Jm8H9EOhhWZB2FykARlGfa9zLZqJsWnzyGzayHZPS+86bt3WRekFuDiSABdE8TNANTHrQ3KVMUy
        O/rz50jmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWTUz-0005FW-2k; Mon, 10 Dec 2018 21:53:57 +0000
Date:   Mon, 10 Dec 2018 13:53:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, snitzer@redhat.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: xfstests generic/347 seems unhappy on todays block for-next tree
Message-ID: <20181210215356.GA20174@infradead.org>
References: <20181210213724.GA27905@infradead.org>
 <f7854d23-cba0-d5ce-e136-6cacd052a6da@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7854d23-cba0-d5ce-e136-6cacd052a6da@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 10, 2018 at 02:39:39PM -0700, Jens Axboe wrote:
> On 12/10/18 2:37 PM, Christoph Hellwig wrote:
> > This test is described as:
> > 
> > # Test very basic thin device usage, exhaustion, and growth
> 
> Does that tree have:
> 
> commit c616cbee97aed4bc6178f148a7240206dcdb85a6
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Dec 6 22:17:44 2018 -0700
> 
>     blk-mq: punt failed direct issue to dispatch list
> 
> ?

yes.

The latest commit is 6f75723190d88e1319bea623bfe0292bf3917965
