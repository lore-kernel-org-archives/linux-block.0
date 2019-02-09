Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8456AC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 18:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534F620855
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 18:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h2m5HGI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBISTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:19:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33474 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbfBISTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 13:19:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 13FA88EE0FC;
        Sat,  9 Feb 2019 10:19:04 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YDP7zEuHDrhk; Sat,  9 Feb 2019 10:19:03 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 861A28EE0ED;
        Sat,  9 Feb 2019 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549736342;
        bh=e2qwHDHyJArKxT7FoILGXi+KoprcfrOt/AnWFbLtB+U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h2m5HGI+1uzNUdJ9JrJ7dABWVMShnCpYOvrenF7L6vs9gL5XU5LR3dkihSmp9+xx3
         mDd9L9abG4IiEFPN08mVfpMdPQR/JjkVBmSeQaFi4M36dtw9BC5W18ewNL90qoMiHz
         hMhnmsEJHrz52iB0KhozhWVBWOYNwNCcOF9k+71k=
Message-ID: <1549736341.2971.7.camel@HansenPartnership.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes
 5 minute delay during boot on Sun Blade 2500
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mikael Pettersson <mikpelinux@gmail.com>,
        Linux SPARC Kernel Mailing List 
        <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 09 Feb 2019 10:19:01 -0800
In-Reply-To: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 2019-02-09 at 18:04 +0100, Mikael Pettersson wrote:
> 4.20 and earlier kernels boot fine on my Sun Blade 2500 (UltraSPARC
> IIIi), but the 5.0-rc kernels consistently experience a 5 minute
> delay
> late during boot, after enabling networking but before allowing user
> logins.  E.g. 5.0-rc5 dmesg has:
> 
> [Fri Feb  8 17:13:17 2019] random: dbus-daemon: uninitialized urandom
> read (12 bytes read)
> [Fri Feb  8 17:18:14 2019] random: crng init done

I've had the same problem on several of my test systems.  Are you sure
it's not this bug report:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=912087

?

The solution for me was to install the haveged package which does
active entropy gathering during boot and can make /dev/urandom
available much earlier.

> During this interval the machine answers pings but won't allow user
> logins either on the console or over the network.
> 
> A git bisect identified commit
> f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Nov 1 16:36:27 2018 -0600
> 
>     scsi: kill off the legacy IO path
> 
> as the point where this 5m delay was introduced.

I think the reason for this is that the block mq path doesn't feed the
kernel entropy pool correctly, hence the need to install an entropy
gatherer for systems that don't have other good random number sources.

James

