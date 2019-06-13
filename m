Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808DC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D465D20B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="jWjpQvqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfFMPA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:00:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36136 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbfFMOp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 10:45:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so28240776edq.3
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvmsidGoJnOuVrNH93gzDhxt94b4IkyqxQH7sIQgBJY=;
        b=jWjpQvqFJpy3JZ8v3eJX/wY/JM7UzO7PqMYyaXZ3zvjJxFfOHON2tSICAV3Md/FBuR
         Y4oPZ1USj/EWpQnKcOs7XBvas6TOzv2l5znmvTTKTFx3uKVRdProUC4XDiCaAWgM/rGc
         Kk4IdyKh8ubR8hhiNJoQU8VlFscolUuaDwjyQc/O7ksT6ViPYNrMM34FNuw5ExZO7Mcu
         Erv24mDt50rY0r4Gd/JvyvqmL0Qm/Bd3QNiZXD9mjX3hTflwIfnOR/JGqFMUCA4Qb20+
         npVhj+/bkWt/M+IngqB4do4HipI95akb14e9EpKZcAxnnz7WxF0eVp4EpyGGC9XYZN4a
         YiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvmsidGoJnOuVrNH93gzDhxt94b4IkyqxQH7sIQgBJY=;
        b=dVuCPGiq5gImbQAAJgtr5iiH+P3xhy6lYh0XnDQPaQNaAMraqXynnB4eUpKBvXcjav
         4iEAP+IZFex7dPka2mg3Wx2CchVSbGHqBGgsOiGbWoeI9mM5UW7BGqgMEzyDjvkGoCDY
         D6CLClw8zgGjF2SN+grERWc4XGQ7FMUsxddCMGg4gEJsov3p0lFO1R6ZWqCZjhaOxoba
         E9dtaKcw+9tcm/64fCBXBLpNVLT0n83BhgaWfDtUvSXQrYiQ5IVTijKJQiXB8g3HgAbA
         9/E2ndbByhfNWiQLa44lEXICtVEG3OllhuWXilqdOvm1tCj+uUEfAQgsfgqn0DCOfZPI
         MkMA==
X-Gm-Message-State: APjAAAXHbpVfHvZx3gs/W9+FgLsn77f7A9pQPJOaHJf9R6EJcYUDqTL5
        MSuowMNhlVBLZNXue7aith6CueWIdYJomXYhL4Qe7Q==
X-Google-Smtp-Source: APXvYqz/zNSaR5+4fJBic3BvwE8nvJYsPFgWJWIxdv0FXnRWV5GHARWaC/J29mUuifA2I9vWNxUsSCX69SK23Ui//Ww=
X-Received: by 2002:a17:906:3d69:: with SMTP id r9mr34377374ejf.28.1560437124696;
 Thu, 13 Jun 2019 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com> <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
In-Reply-To: <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Thu, 13 Jun 2019 17:45:13 +0300
Message-ID: <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 4:52 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Jun 12, 2019 at 07:31:44PM +0300, roman.stratiienko@globallogic.com wrote:
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > Adding support to nbd to use it as a root device. This code essentially
> > provides a minimal nbd-client implementation within the kernel. It opens
> > a socket and makes the negotiation with the server. Afterwards it passes
> > the socket to the normal nbd-code to handle the connection.
> >
> > The arguments for the server are passed via kernel command line.
> > The kernel command line has the format
> > 'nbdroot=[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
> > SERVER_IP is optional. If it is not available it will use the
> > root_server_addr transmitted through DHCP.
> >
> > Based on those arguments, the connection to the server is established
> > and is connected to the nbd0 device. The rootdevice therefore is
> > root=/dev/nbd0.
> >
> > Patch was initialy posted by Markus Pargmann <mpa@pengutronix.de>
> > and can be found at https://lore.kernel.org/patchwork/patch/532556/
> >
> > Change-Id: I78f7313918bf31b9dc01a74a42f0f068bede312c
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > Reviewed-by: Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>
>
> Just throw nbd-client in your initramfs.  Every nbd server has it's own
> handshake protocol, embedding one particular servers handshake protocol into the
> kernel isn't the answer here.  Thanks,
>
> Josef

Hello Josef,

Let me share some of my thoughts that was the motivation for providing
this solution::

We choose NBD as a tool to run CI tests on our platforms.
We have a wide range of different BSP's with different kind of images
where using NFSROOT is hard or even impossible.
Most of these BSPs are not using initramfs and some of them are Android-based.

Taking all this into account we have to put significant efforts to
implement and test custom initramfs and it will not cover all our
needs.

Much easier way is to embed small client into the kernel and just
enable configuration when needed.

I believe such solution will be very useful for wide range of kernel users.

Also, as far as I know mainline nbd-server daemon have only 2
handshake protocols. So called OLD-STYLE and NEW-STYLE. And OLD-STYLE
is no longer supported. So it should not be a problem, or please fix
me if I'm wrong.

Regards,
Roman
