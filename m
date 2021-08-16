Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF1C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AAD60F4B
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 15:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhHPPvy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhHPPuO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 11:50:14 -0400
X-Greylist: delayed 1375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Aug 2021 08:49:39 PDT
Received: from lounge.grep.be (lounge.grep.be [IPv6:2a01:4f8:200:91e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A1C061764;
        Mon, 16 Aug 2021 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
        s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vmThffkGGDgcWcG0Dk35BzlpwCbQj80Wk0DEcCCbVK8=; b=h3dSssa2xKXPzlkXUPxsujpovQ
        xZdcqiP40AquCSI/eUYTz59WMBzqnGOolC/9EAvHoAppQty/bmdfNZpnLp4tUnym+TXUBr4QiEcBv
        iq6sEDb3WCbNdBszNbDtd9/GIN/k6r6XPQWCst2g7ln2dXtsABC1oJ+RGqKnPT0/mJL/BnCdUrDgF
        NiZPhcof8aZoQ9HNHeUgdMPMXrRorUkfI7KO7GXhGzxkFV9VfnmiDmq1jb5D0eVGVKUmJfRQAF3af
        Z3wbdgqxdt/sBQ/XXLVDPVlcWALll2Ib9eJprVvHUQZaf+FHPL8t7MbUaM/VuwKqipoW9R47OMKLD
        WgGD8T0w==;
Received: from [102.39.40.13] (helo=pc181009)
        by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <w@uter.be>)
        id 1mFeVY-003uLJ-Tc; Mon, 16 Aug 2021 17:26:36 +0200
Received: from wouter by pc181009 with local (Exim 4.94.2)
        (envelope-from <w@uter.be>)
        id 1mFeVM-000K3X-FY; Mon, 16 Aug 2021 17:26:24 +0200
Date:   Mon, 16 Aug 2021 17:26:23 +0200
From:   Wouter Verhelst <w@uter.be>
To:     Eric Blake <eblake@redhat.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, josef@toxicpanda.com,
        axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
Message-ID: <YRqDn2AVd3ApchWF@pc181009.grep.be>
References: <20210812091501.22648-1-paskripkin@gmail.com>
 <7f9a6877-12d9-0177-d09a-6522e5a557ec@gmail.com>
 <20210812153525.hlged76ivhqtffyg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812153525.hlged76ivhqtffyg@redhat.com>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 12, 2021 at 10:35:25AM -0500, Eric Blake wrote:
> On Thu, Aug 12, 2021 at 12:42:38PM +0300, Pavel Skripkin wrote:
> > 
> > Fun thing: I got a reply to this email from
> > nsd-public@police.gov.hk, which is Hong Kong Police office email. Does
> > anyone know what is going on? :) It's a bit scary...
> 
> You are not alone.  Apparently, someone subscribed that address to the
> nbd@other.debian.org list and it is auto-responding to every message
> it receives; hopefully, a list administrator (I am not one) will be
> willing to forcefully unsubscribe that address.

FWIW, this has now happened, so you should no longer see such autoreplies.

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}
