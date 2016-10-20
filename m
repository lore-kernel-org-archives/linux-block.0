Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33113 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756108AbcJTWuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 18:50:20 -0400
Received: by mail-yw0-f173.google.com with SMTP id t192so76328476ywf.0
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2016 15:50:20 -0700 (PDT)
MIME-Version: 1.0
From: Neo Anderson <aneo1510@gmail.com>
Date: Thu, 20 Oct 2016 15:50:18 -0700
Message-ID: <CA+yEoUmrhMzXh0-xF8dKZUABv_yXLb1E40CMNNn2J-eoapUPwA@mail.gmail.com>
Subject: Need a help regarding block layer development setup.
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I'm new to kernel development. I'm trying to modify the block layer
code and add some new functionality to it.

The problem I'm facing now, block layer code is an integral part of
the kernel and it gets compiled with kernel.

Is there any way that I can isolate the the block layer code and
compile as a separate module for development so that every time I make
code changes I don't have to recompile the block layer along with
kernel and and reboot the system ?

In summary I'm trying to understand how can someone create a block
layer development setup ? where I can just treat entire block layer
code as one standalone codebase and should be able to
make/insmod/rmmod it as I make code changes.
