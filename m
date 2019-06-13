Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C7C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE3207E0
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="MW29uUt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbfFMO67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:58:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38565 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732616AbfFMOzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 10:55:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so12931043qkk.5
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=syRsM5x5t36T0uwBQ8w3WtlVORO0dY2X14fOyDlfmP4=;
        b=MW29uUt3jByNSY9EdjIpGnBKSihl9HASLR+/ooJTV2ZJHETpBMlzK4M/8DVRozclGw
         qI7jOYKnXbNco1i2jnu7jmHoEfvTNvCUFClQyrHEPDqCbosgl7YIZBBZ4vXEhgTljPIY
         0Dlm6d90sHKdN6FETsRaV3IKYSAf2RT31FEXpzCgcw+y/DjEU1WFd6x468IKtWYaPO8R
         2YwfQJ3pvmC2AkBTSNwSkBpurq4xsKkXzFn8sN3RjOx2JNLAsHUfTigkazfpHHg6HrzE
         gpKP1GXUcLCaX6Bt6MuT7XDxJw0hZ4no5tVThuZ3BPlKt82LNfbzNwu0LDHQnKHktq59
         yHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=syRsM5x5t36T0uwBQ8w3WtlVORO0dY2X14fOyDlfmP4=;
        b=lDj1KQYlB/PqSW6XQwM7dkFdAxurElCI6ZOCTBetiyMmILk4rgEDx3s4ZBgVZyYV40
         LNNHVGpXSvKXfm7MZZ1rmftU6sb7UwhWkn9MiZ7eIEI2FQRbVuQ3q2cj6zVDBMEF/YE7
         Yus+WCAIzuL31mH2l47ynY9JOXirn28jn5VYq0+6hkSWBDUsCL/GqGnn3PjQ/VmmqitF
         15PtgHBFTWGpYoLYHzqD8HlK2Cy6oOawhDdWZFfdIiZ6yP+O377FdiTj5FaoIK2/kom1
         wlcIZD6XMdicSGtGAOrZLKkQLXl233RYMXJqM/plGqlkZS5VcgtxUE+PohelzypgZZbI
         7pzQ==
X-Gm-Message-State: APjAAAXCDDjYO+M5de7hekhQyu60pQEq9uXxtAo1JpGDEzpBahfPPogB
        v3kDyZ4jgKCjodBOj6eIXQ1UvA==
X-Google-Smtp-Source: APXvYqyBEJXlITHzA9ZejAG6r56aunWdCYC9tOvEIffA6U0RZhtD9cozUHnyThUCVBCpbzxPxUSPyQ==
X-Received: by 2002:a37:9c50:: with SMTP id f77mr71923542qke.6.1560437738450;
        Thu, 13 Jun 2019 07:55:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id a15sm1981399qtb.43.2019.06.13.07.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:55:37 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:55:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
Message-ID: <20190613145535.tdesq3y2xy6ycpw7@MacBook-Pro-91.local>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
 <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:45:13PM +0300, Roman Stratiienko wrote:
> On Thu, Jun 13, 2019 at 4:52 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Jun 12, 2019 at 07:31:44PM +0300, roman.stratiienko@globallogic.com wrote:
> > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > >
> > > Adding support to nbd to use it as a root device. This code essentially
> > > provides a minimal nbd-client implementation within the kernel. It opens
> > > a socket and makes the negotiation with the server. Afterwards it passes
> > > the socket to the normal nbd-code to handle the connection.
> > >
> > > The arguments for the server are passed via kernel command line.
> > > The kernel command line has the format
> > > 'nbdroot=[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
> > > SERVER_IP is optional. If it is not available it will use the
> > > root_server_addr transmitted through DHCP.
> > >
> > > Based on those arguments, the connection to the server is established
> > > and is connected to the nbd0 device. The rootdevice therefore is
> > > root=/dev/nbd0.
> > >
> > > Patch was initialy posted by Markus Pargmann <mpa@pengutronix.de>
> > > and can be found at https://lore.kernel.org/patchwork/patch/532556/
> > >
> > > Change-Id: I78f7313918bf31b9dc01a74a42f0f068bede312c
> > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > > Reviewed-by: Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>
> >
> > Just throw nbd-client in your initramfs.  Every nbd server has it's own
> > handshake protocol, embedding one particular servers handshake protocol into the
> > kernel isn't the answer here.  Thanks,
> >
> > Josef
> 
> Hello Josef,
> 
> Let me share some of my thoughts that was the motivation for providing
> this solution::
> 
> We choose NBD as a tool to run CI tests on our platforms.
> We have a wide range of different BSP's with different kind of images
> where using NFSROOT is hard or even impossible.
> Most of these BSPs are not using initramfs and some of them are Android-based.
> 
> Taking all this into account we have to put significant efforts to
> implement and test custom initramfs and it will not cover all our
> needs.
> 
> Much easier way is to embed small client into the kernel and just
> enable configuration when needed.
> 
> I believe such solution will be very useful for wide range of kernel users.
> 
> Also, as far as I know mainline nbd-server daemon have only 2
> handshake protocols. So called OLD-STYLE and NEW-STYLE. And OLD-STYLE
> is no longer supported. So it should not be a problem, or please fix
> me if I'm wrong.
> 

I don't doubt you have a good reason to want it, I'm just not clear on why an
initramfs isn't an option?  You have this special kernel with your special
option, and you manage to get these things to boot your special kernel right?
So why is a initramfs with a tiny nbd-client binary in there not an option?

Also I mean that there are a bunch of different nbd servers out there.  We have
our own here at Facebook, qemu has one, IIRC there's a ceph one.  They all have
their own connection protocols.  The beauty of NBD is that it doesn't have to
know about that part, it just does the block device part, and I'd really rather
leave it that way.  Thanks,

Josef
