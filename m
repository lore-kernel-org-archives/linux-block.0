Return-Path: <SRS0=RXFR=WA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF23C433FF
	for <linux-block@archiver.kernel.org>; Sun,  4 Aug 2019 22:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9957420880
	for <linux-block@archiver.kernel.org>; Sun,  4 Aug 2019 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564956968;
	bh=nZTSrb/LTY2MAB6nAXO0fol/JfFShvONnnQGkzjOUa4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=nDQ+a/kCE1efVO45foULCcLYab8CV10dqKEVthrLs4u2YqL5n+B9qYRGnMMen9T4U
	 M3v+dLt1AaRIDHsyQI7iBj15ze7g64+vOXTRNNW7jdCpM2i8/exk/b4+v3IUwOBgpJ
	 Cvhl1BUQT8Q8EU+1OZ+wOY5nVEHBbNfYXqgnDuSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHDWPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Aug 2019 18:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfHDWPU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 4 Aug 2019 18:15:20 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE15520880;
        Sun,  4 Aug 2019 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564956919;
        bh=nZTSrb/LTY2MAB6nAXO0fol/JfFShvONnnQGkzjOUa4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dqaJuMpQupF/rvtPwFx9HqozchB7AHHAWObO+7ekInaLVD/YidquVA8O3XFxP+cIZ
         Z0j7jhUeL8CTuBfQn1Op04anAzluRoUpRJLi0Pz2ipPu9DVEn59D0ltfLIRFIkO7DZ
         dTHsnBb5T4uQmi96cmd9trbNT2XGVc9Ug6hFVfjU=
Date:   Mon, 5 Aug 2019 00:15:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Will Deacon <will@kernel.org>,
        Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Message-ID: <nycvar.YFH.7.76.1908050013270.5899@cbobk.fhfr.pm>
References: <20190712185523.7208-1-efremov@ispras.ru> <20190713080726.GA19611@1wt.eu> <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru> <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com> <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 31 Jul 2019, Denis Efremov wrote:

> Well, without jokes about Thunderdome, I've got time, hardware and
> would like to maintain the floppy. Except the for recent fixes,
> I described floppy ioctls in syzkaller. I've already spent quite
> a lot of time with this code. Thus, if nobody minds
> 
> -- >8 --
> From: Denis Efremov <efremov@linux.com>
> Subject: [PATCH] MAINTAINERS: floppy: take over maintainership
> 
> I would like to maintain the floppy driver. After the recent fixes,
> I think I know the code pretty well. Nowadays I've got 2 physical 3.5"
> readers to test all the changes.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Awesome, thanks a lot Denis for offering to carry the torch I dropped. 
Obviously:

	Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs

