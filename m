Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75BC43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 07:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CFC2073D
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 07:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VVQq6MsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfACH16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:27:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfACH15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jan 2019 02:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1TPZzdOpDPWLPOhH8mxvDnHt4hhXxuCtSeUDHqDjyNs=; b=VVQq6MsKqREbh+OCjpKp2k/0m
        TFSob1y3qINFvFlX7fOdPuuA2DiHb7+7/PWkhYBW2Qx5DHpKIX4xE6E3Q/2fX9Er++4j+H329h7BW
        Z5S4OZ2k4GAyLsXLiGL5/S3rg3QC/XRX5+UwMbgn/Y0HbdNMQ7CHeZM3gkpGEQNomnNc0PqCpqriH
        HYpDsBc0Ovg2spG2HXE6SwkJi1kEV0wfmhkH+8lvgVnkZs5m1ZydjXxe5EnncUKoH+NtJC1GP1zqV
        W9RhhDR2iAxgwwqn7eto7sDfC/Ss/CTNT/3Lf203qTaPIHe4iTTYhLd+MIm9K7bO6JW9omGMp9vHG
        AA852GB4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gexQ2-00023L-V4; Thu, 03 Jan 2019 07:27:54 +0000
Date:   Wed, 2 Jan 2019 23:27:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Subject: Re: [git pull] device mapper changes for 4.21
Message-ID: <20190103072754.GA2667@infradead.org>
References: <20181227160944.GA12190@redhat.com>
 <20181230090646.GB1022@infradead.org>
 <alpine.LRH.2.02.1812301413220.7178@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh89gmqGaK4K7+ns9S6CSeCfuUmiy8GPeVz8_ntMz-DYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh89gmqGaK4K7+ns9S6CSeCfuUmiy8GPeVz8_ntMz-DYg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 30, 2018 at 04:25:46PM -0800, Linus Torvalds wrote:
> On Sun, Dec 30, 2018 at 11:15 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > But you're right that 2TiB devices are common and that perhaps this option
> > should go away.
> 
> 2TiB devices are definitely not common in the one situation where this
> option might matter: small embedded devices.
> 
> I don't think the cost of 64 bit is in the arithmetic, but it might be
> in some of the data structures.
> 
> But my gut feel is that it probably doesn't much matter, and we could
> get rid of the config option without anybody ever noticing. I don't
> think we have that many data structures with 'sector_t' in them.
> 
> We might try to first just force the option on, and see if anybody even cares.

Our smallest embedded devices use raw flash using the MTD subsystem,
and even that is using 64-bit size types everywhere.  So I'd be really
surprised if it is an issue.

> 
>                   Linus
---end quoted text---
