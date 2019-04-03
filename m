Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4192C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ADC2084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="aDYM57vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDCRtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:49:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42137 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCRtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 13:49:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so10705783qkg.9
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+514+2lqNMNTuj5sabZ2RkXSxdhWR/VQGts8wdfq6AA=;
        b=aDYM57vo/h3E5OZ4fkR0ji2SMTjIxbLCU7upfbDF5883YqMYAlvzh+axC9ewpv1WmB
         3BkfrM/5NZnzowHYAip7/Fh2gkk9hSH2SD87jqZ2vq2HYevFzrM3ooGA8MCZPJeXoBuZ
         uv9aVPoVfZQaYdnvV2g/9S6WxKsGIU9J6uq+0M0naBWqTyV+cKEUH3xr5iwc2lY56a41
         GW9L8XFtEeSln+lAZsSAp2qj2zP1yCgpuCo0cUp4zbQ0iuqZWKvRxo86C9Z3+Gf2dUvO
         tN09BgKAy2Yzi5zmWciFFNydtFUCUB8GHowG35EKlGVinDCn0KK+Y18y8f0dEgyNOkS/
         EPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+514+2lqNMNTuj5sabZ2RkXSxdhWR/VQGts8wdfq6AA=;
        b=IqvyK+Zp44XQEIs50UbzBonjjHgxuhAYan8XUqyl+pT6OWZ/DWNYERA0LxMCraL6za
         GqyWTEkjadbThjPIEturpQ7cYiz+C2HdJ/RBw3Y85jiECRRTW4NUEGqdr52mSGMaXW8+
         ZXTXMolTuVLj5QQk7Zqg96R95647NXNxSuA79Yvy8I8bfPJbaF5qRxDeOWzku3sSkIXK
         KuE95Lmjdq2QA5zAyfCmFkjib0+O573ahy43xmcrgPkndxG9/0nNmePcZkXPHE1xX/R2
         UZBIccyye2D9xq/CMZyqRvNVLD//TJmLt4aBjbisRl7XQymeP0C+XjJORPWxPiRLArsn
         EW1w==
X-Gm-Message-State: APjAAAVqD/ePXc+kusdKovzQSeHcdCdl4wzpSTx3R9u5AIpQtH0IH7Gm
        /kkeKH2UBULHcbWmoqfH1gmt2Q==
X-Google-Smtp-Source: APXvYqyP6vQYoDaZm+jvFCOAoIAKFB44H4O+dwpNwG7a7dXM9U2S8GWq4xZPrCH5MRKVfaNmWg9vGw==
X-Received: by 2002:a37:69c3:: with SMTP id e186mr1252442qkc.308.1554313751651;
        Wed, 03 Apr 2019 10:49:11 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 11sm11759536qtu.5.2019.04.03.10.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:49:10 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:49:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Adriana Kobylak <anoo@linux.ibm.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, medadyoung@gmail.com,
        openbmc@lists.ozlabs.org, nbd@other.debian.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd:clear NBD_BOUND flag when NBD connection is closed
Message-ID: <20190403174908.jk6xuhzvn2gm2l2g@MacBook-Pro-91.local>
References: <1544509023-18923-1-git-send-email-medadyoung@gmail.com>
 <a1da3fff285fe13d04522f1a6e72bdc1@linux.vnet.ibm.com>
 <7e192d24976532141c8c985329f5ca1c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e192d24976532141c8c985329f5ca1c@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 03, 2019 at 12:13:53PM -0500, Adriana Kobylak wrote:
> Adding Josef (updated email address in the maintainers file).
> 
> On 2018-12-13 08:21, Adriana Kobylak wrote:
> > On 2018-12-11 00:17, medadyoung@gmail.com wrote:
> > > From: Medad <medadyoung@gmail.com>
> > > 
> > >     If we do NOT clear NBD_BOUND flag when NBD connection is closed,
> > >     then the original NBD device could not be used again.
> > > 
> > > Signed-off-by: Medad <medadyoung@gmail.com>

This doesn't sound right, this is just making sure we don't use the IOCTL
configuration stuff with the netlink stuff.  Once the disconnect happens the
configuration should go away and it doesn't matter anymore.  What are you doing
to reproduce this problem?  Thanks,

Josef
