Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44074 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeJXDP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 23:15:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id d23-v6so1035114pls.11
        for <linux-block@vger.kernel.org>; Tue, 23 Oct 2018 11:51:20 -0700 (PDT)
Date: Tue, 23 Oct 2018 11:51:17 -0700
From: Omar Sandoval <osandov@osandov.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] common/rc: allow the loop driver to be built
 into the kernel
Message-ID: <20181023185117.GE10074@vader>
References: <20181022105004.29324-1-tytso@mit.edu>
 <20181022230830.GD10074@vader>
 <20181023125624.GB6850@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181023125624.GB6850@thunk.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 23, 2018 at 08:56:24AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Oct 22, 2018 at 04:08:30PM -0700, Omar Sandoval wrote:
> > On Mon, Oct 22, 2018 at 06:50:04AM -0400, Theodore Ts'o wrote:
> > > A number of kernel modules used by blktests must be compiled as
> > > modules, since the module needs to be loaded with specific options, or
> > > part of the test is to exercise what what happens when the kernel
> > > module is loaded.  This is not true for the loop driver, so add a new
> > > bash function, _have_kernel_module which works like _have_module but
> > > will not fail if the driver is compiled directly into the kernel.
> > 
> > `modprobe loop` works for me if the module is built in, are you using
> > one from busybox or something? According to strace, it looks at the
> > depmod information (namely, /lib/modules/$(uname -r)/modules.builtin.bin).
> 
> Ah, you're right.  When I was first trying to use blktests, I was
> integrating it into my xfstests test appliance, and normally I build a
> completely module-free kernel.  This allows me to boot directly into a
> kernel by using kvm's "--kernel /path/to/bzImage" option without
> having to deal with the extra work of trying to install modules into a
> test appliance.

FWIW, I have a VM setup that uses --kernel and a virtfs mount in the
guest to use modules without needing a manual install step:
https://github.com/osandov/osandov-linux#running-custom-kernel-builds.
