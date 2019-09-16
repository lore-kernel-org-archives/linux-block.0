Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6F1C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 06:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB37214AF
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 06:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="PLsaCF/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfIPGW7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 02:22:59 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17926 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728106AbfIPGW7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 02:22:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568614966; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=q7cO6nl0+/+L5iKEuWg2kOdVW3GnIEu9TUY5Zn92WkZaL2CDV2tkAfIYRqnkZlTjSTRqHSCm8h3Lm5pIez32EtESfLxiGRyjxEbvX40S4lKSYgt8SFLKl/nhYHIfiyhQaV1HMeyYwHpKp0WDVP1reuUxD6wTxWnGi+IHtQFhn+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1568614966; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=KFnu+vV3Emgd9lQvV4LU1uDFKh1nPCY+rE9r8UbqdJc=; 
        b=kN/vs5B8WKat/YTMyvNaGzUA4gL1qR3Pc4k6qKxy/rV0EEJ86lcBXuU5fdOG9myk/Yzg9BdCPxe07Dr2GUFiKg/uvSjvleruMgPbVKJCK/ZbgUseOjssA1FCsuuk7ZuaM0XexuVQWrvGQtHSyM0k720dxHyR1bg3CiTwMKMjAtE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=euphon.net;
        spf=pass  smtp.mailfrom=fam@euphon.net;
        dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1568614966;
        s=zoho; d=euphon.net; i=fam@euphon.net;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=456; bh=KFnu+vV3Emgd9lQvV4LU1uDFKh1nPCY+rE9r8UbqdJc=;
        b=PLsaCF/ZNUaXdsuUfQT3RjukIynRsfmhNBSiKf8447Pu6MBrmXP5GYoIQG+u4vta
        /Ecmn1jKpIICFeiODXTk9uDSYEcNha4vDSUAv0HdTV++zTLfJvNXO9Ka3pz+em7fUDY
        DEr46E6GelXjTAaSmgAfyiZ9tI3z109JX4JpxaPA=
Received: from localhost (120.52.147.46 [120.52.147.46]) by mx.zoho.com.cn
        with SMTPS id 156861496368045.56814894994807; Mon, 16 Sep 2019 14:22:43 +0800 (CST)
Date:   Mon, 16 Sep 2019 14:22:42 +0800
From:   Fam Zheng <fam@euphon.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bfq: Fix bfq linkage error
Message-ID: <20190916062242.GA25284@magic>
References: <9afc7a2cd013344290096d9dfe9355bcb57b3bbd.1568482098.git.asml.silence@gmail.com>
 <333de59c-d4ca-3bc2-fffa-35d60bd14126@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333de59c-d4ca-3bc2-fffa-35d60bd14126@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ZohoCNMailClient: External
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 09/14 11:32, Jens Axboe wrote:
> On 9/14/19 11:31 AM, Pavel Begunkov (Silence) wrote:
> > From: Pavel Begunkov <asml.silence@gmail.com>
> > 
> > Since commit 795fe54c2a828099e ("bfq: Add per-device weight"), bfq uses
> > blkg_conf_prep() and blkg_conf_finish(), which are not exported. So, it
> > causes linkage error if bfq compiled as a module.
> 
> Thanks, I'll apply and add the Fixes tag.

Thanks!  This is indeed my oversight.

Fam

