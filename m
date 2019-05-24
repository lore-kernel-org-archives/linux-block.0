Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D4C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5134A21848
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 18:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EilJ+NyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfEXSZh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 14:25:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEXSZh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 14:25:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so10326334wmm.2;
        Fri, 24 May 2019 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uJ+VGq1vbaaeAJrHBIkzRJvOH5+OfhWi163jL1Ew+9E=;
        b=EilJ+NyIwMui1YXmYNwyHPdjvszha9reG3CiapmuyGYBzhUtrPKNEpU2t7QGD9nq5/
         QRmAwjPEE/ITKTBd7O9YtT0Pl7A/+1CfWWlmyyUlQfQchTNUGIKCHM9EbnSXavP/JmyU
         6uZDexXet3ML4LOfMlAzD7Xg4SKjxl15Bjlnh/ELX2IHIS4LryoA0qro5oS6bqbEyUco
         sz6rBT5fHHdO2eZW8zSAJZNiCaHnhb22bklI1wF2q7us1w7NiEyYq2y3TexuehaLIbt6
         V+8+zNcUyWQrB1FPaZSYSwV9+rD0koIr9cSc7kVizIS0J3ZoU8MrX32jK4Ph1B2r+yeJ
         WJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJ+VGq1vbaaeAJrHBIkzRJvOH5+OfhWi163jL1Ew+9E=;
        b=QMJEYkBO3g85g1vPP9VLN5w0t1HquSgnh0PXKQ7q3c4Mz6IY05/3S4XISJUb4ruDz3
         vp4YtLVXTOhUA56sodAb9iy6hFAJi+W8wYTSRwv6XTbtvOa5IZRQM6D5TvQQAaXaYkzN
         9lm1jt6D263FKORZAkEGVl0USBVmORu2HQ4Dt1je+senvdu3K2ukTsUd/L24y2o0coff
         z2sLlKxzmtuA36oeF39TOo/1t3hZ1ks7VLE8uh0g1uaQt4r/RoM2thUiaA7ngqI+jep6
         6nJ4CY3IzFWuo3qQT8/FWdu6tCix8Urrl9UBGpu89/E8kMnjw02hKuHT2Y+jGrs5QNLe
         zCew==
X-Gm-Message-State: APjAAAXbE2xzeTdemm6n+OixuRwmRWujcQLhrlxfYqT6IC3HihqgzS74
        r6neVT+GfEmTjuTDGxYZWQ==
X-Google-Smtp-Source: APXvYqzWIPhAoLe8BnB4nilKaC7gvhOWPTFfvesV7R2V/Fe7j3s2Mc1rYyuAf80aBL4pzVy0Kikahw==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr953080wml.164.1558722335009;
        Fri, 24 May 2019 11:25:35 -0700 (PDT)
Received: from avx2 ([46.53.250.220])
        by smtp.gmail.com with ESMTPSA id 67sm4726241wmd.38.2019.05.24.11.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:25:34 -0700 (PDT)
Date:   Fri, 24 May 2019 21:25:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Setting up default iosched in 5.0+
Message-ID: <20190524182530.GA2658@avx2>
References: <20190518093310.GA3123@avx2>
 <x49ftp329lt.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <x49ftp329lt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 24, 2019 at 10:46:54AM -0400, Jeff Moyer wrote:
> Hi, Alexey,
> 
> Alexey Dobriyan <adobriyan@gmail.com> writes:
> 
> > 5.0 deleted three io schedulers and more importantly CONFIG_DEFAULT_IOSCHED
> > option:
> >
> > 	commit f382fb0bcef4c37dc049e9f6963e3baf204d815c
> > 	block: remove legacy IO schedulers
> >
> > After figuring out that I silently became "noop" customer enabling just
> > BFQ didn't work: "noop" is still being selected by default.
> >
> > There is an "elevator=" command line option but it does nothing.
> >
> > Are users supposed to add stuff to init scripts now?
> 
> A global parameter was never a good idea, because systems often have
> different types of storage installed which benefit from different I/O
> schedulers.  The goal is for the default to just work.

Kernel can by default complain about "noop" for HDD disks and setup
"noop" for SSD. And then let admins customise it further.

> If you feel that the defaults don't work for you, then udev rules are
> the way to go.
> 
> If you also feel that you really do want to set the default for all
> devices, then you can use the following udev rule to emulate the old
> elevator= kernel command line parameter:
> 
> https://github.com/lnykryn/systemd-rhel/blob/rhel-8.0.0/rules/40-elevator.rules

The following udev rules seem to work, thanks:

	$ cat /etc/udev/rules.d/01-iosched.rules
	SUBSYSTEM=="block", ACTION=="add", KERNEL=="sda", ATTR{queue/scheduler}="bfq"
	SUBSYSTEM=="block", ACTION=="add", KERNEL=="sdb", ATTR{queue/scheduler}="bfq"
