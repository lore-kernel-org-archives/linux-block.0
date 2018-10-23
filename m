Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:48602 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeJWVT6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 17:19:58 -0400
Date: Tue, 23 Oct 2018 08:56:24 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] common/rc: allow the loop driver to be built
 into the kernel
Message-ID: <20181023125624.GB6850@thunk.org>
References: <20181022105004.29324-1-tytso@mit.edu>
 <20181022230830.GD10074@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181022230830.GD10074@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 22, 2018 at 04:08:30PM -0700, Omar Sandoval wrote:
> On Mon, Oct 22, 2018 at 06:50:04AM -0400, Theodore Ts'o wrote:
> > A number of kernel modules used by blktests must be compiled as
> > modules, since the module needs to be loaded with specific options, or
> > part of the test is to exercise what what happens when the kernel
> > module is loaded.  This is not true for the loop driver, so add a new
> > bash function, _have_kernel_module which works like _have_module but
> > will not fail if the driver is compiled directly into the kernel.
> 
> `modprobe loop` works for me if the module is built in, are you using
> one from busybox or something? According to strace, it looks at the
> depmod information (namely, /lib/modules/$(uname -r)/modules.builtin.bin).

Ah, you're right.  When I was first trying to use blktests, I was
integrating it into my xfstests test appliance, and normally I build a
completely module-free kernel.  This allows me to boot directly into a
kernel by using kvm's "--kernel /path/to/bzImage" option without
having to deal with the extra work of trying to install modules into a
test appliance.

So when I noticed that modprobe loop wasn't working, this was because
I didn't have any of /lib/modules/($uname -r)/ in existence at all.
After I patched blktests to not complain when modprobe loop was
failing, I noticed that something like only 3 tests were being run,
and when I looked at most of the tests, I realized that there was no
way to avoid using modules for a large number of tests (at least not
without doing a lot of work to enhance things like scsi_debug to be
dynamically reconfigurable).

So you're right; there's no need for this patch.  The chances that
someone will only want to run the loop tests using !CONFIG_MODULES
kernel are... remote.  :-)

						- Ted
