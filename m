Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33099 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdBEWbw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Feb 2017 17:31:52 -0500
Received: by mail-wr0-f196.google.com with SMTP id i10so1895458wrb.0
        for <linux-block@vger.kernel.org>; Sun, 05 Feb 2017 14:31:52 -0800 (PST)
Subject: Re: [PATCH] nbd: handle single path failures gracefully
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, nbd-general@lists.sourceforge.net
References: <1486156702-9417-1-git-send-email-jbacik@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c660d5d9-90d3-300d-4362-f34ee22b8ee7@grimberg.me>
Date: Mon, 6 Feb 2017 00:31:48 +0200
MIME-Version: 1.0
In-Reply-To: <1486156702-9417-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Currently if we have multiple connections and one of them goes down we will tear
> down the whole device.  However there's no reason we need to do this as we
> could have other connections that are working fine.  Deal with this by keeping
> track of the state of the different connections, and if we lose one we mark it
> as dead and send all IO destined for that socket to one of the other healthy
> sockets.  Any outstanding requests that were on the dead socket will timeout and
> be re-submitted properly.

Hey Josef,

are you trying to address link failures?

Any reason not to leave DM for this kind of work? Note that the rest
of the block drivers implement periodic reconnects and let DM handle
multipathing.

It took a long time remove all the driver specific multipathing in the
stack.
