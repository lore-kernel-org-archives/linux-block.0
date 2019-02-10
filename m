Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D87EC282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D1621773
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dFEsAfPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBJPog (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:44:36 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38602 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfBJPog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 10:44:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DC5068EE241;
        Sun, 10 Feb 2019 07:44:35 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GmAphG2JzslT; Sun, 10 Feb 2019 07:44:35 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 51B058EE11D;
        Sun, 10 Feb 2019 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549813475;
        bh=bfAHZlIHFh1pAdRQzDP3gBnaZhpc94Phapk8wrxA9mo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dFEsAfPK9N/4fd487b9z45FRp3pcGUNeW8yLZm+Yx1gHC2gj/DfI1gijLqTVB/tK+
         EfAIvzBNbNdiVxKCT/NjAK/59ENEVgJ0YjIKqBuCUHE+RbGURe9P14b6bSVG0RaRTU
         Psoawfb6ILtyDBe54HwxfXcS3iMUsydGybp7UXZA=
Message-ID: <1549813472.4142.3.camel@HansenPartnership.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes
 5 minute delay during boot on Sun Blade 2500
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 Feb 2019 07:44:32 -0800
In-Reply-To: <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
         <1549736341.2971.7.camel@HansenPartnership.com>
         <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > I think the reason for this is that the block mq path doesn't feed
> > the kernel entropy pool correctly, hence the need to install an
> > entropy gatherer for systems that don't have other good random
> > number sources.
> 
> That does sound plausible, I admit I didn't even consider the
> possibility that the old block I/O path also was an entropy source.

In theory, the new one should be as well since the rotational entropy
collector is on the SCSI completion path.   I'd seen the same problem
but had assumed it was something someone had done to our internal
entropy pool and thus hadn't bisected it.

James

