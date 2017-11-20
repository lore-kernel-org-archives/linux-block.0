Return-Path: <linux-block-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:33502 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbdKTVfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Nov 2017 16:35:07 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glb-linux-block@m.gmane.org>)
        id 1eGtiN-0008Ju-U8
        for linux-block@vger.kernel.org; Mon, 20 Nov 2017 22:34:51 +0100
To: linux-block@vger.kernel.org
From: Holger =?iso-8859-1?q?Hoffst=E4tte?=
        <holger@applied-asynchrony.com>
Subject: Re: 4.14: can bcc not trace blk-mq?
Date: Mon, 20 Nov 2017 21:34:40 +0000 (UTC)
Message-ID: <pan$a7e00$59f63f1e$37f96ac8$d74f99c8@applied-asynchrony.com>
References: <pan$5f543$fb3c6749$bbc89546$ed0909b8@applied-asynchrony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 20 Nov 2017 18:19:37 +0000, Holger Hoffstätte wrote:

> Sorry if this is a dumb question, but I've started playing with bcc
> (release 0.4.0) and can trace everything (cpu, xfs, net..) so it works
> fine - except apparently block traffic. I've tried all the bio* tools
> and none of them seem to trace/collect anything, despite the fact
> that they contain blk-mq tracepoint references.
> I have set CONFIG_SCSI_MQ_DEFAULT=y and everything works fine otherwise.
> Is this supposed to work, broken in bcc/blk-mq/something else?
> Haven't tried to boot with scsi_mod.use_blk_mq=0 yet, just wanted
> to ping for possible confirmation.

Disabling blk-mq didn't help at all either, and since the bcc-provided
docker image doesn't work either I guess it's just broken.

-h
