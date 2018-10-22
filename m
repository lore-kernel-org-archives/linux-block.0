Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42050 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWH3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 03:29:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so19705206pgq.9
        for <linux-block@vger.kernel.org>; Mon, 22 Oct 2018 16:08:32 -0700 (PDT)
Date: Mon, 22 Oct 2018 16:08:30 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] common/rc: allow the loop driver to be built
 into the kernel
Message-ID: <20181022230830.GD10074@vader>
References: <20181022105004.29324-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181022105004.29324-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 22, 2018 at 06:50:04AM -0400, Theodore Ts'o wrote:
> A number of kernel modules used by blktests must be compiled as
> modules, since the module needs to be loaded with specific options, or
> part of the test is to exercise what what happens when the kernel
> module is loaded.  This is not true for the loop driver, so add a new
> bash function, _have_kernel_module which works like _have_module but
> will not fail if the driver is compiled directly into the kernel.

`modprobe loop` works for me if the module is built in, are you using
one from busybox or something? According to strace, it looks at the
depmod information (namely, /lib/modules/$(uname -r)/modules.builtin.bin).
