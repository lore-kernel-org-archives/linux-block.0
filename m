Return-Path: <linux-block-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37730 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbdGGAeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2017 20:34:25 -0400
Date: Fri, 7 Jul 2017 01:34:21 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] libnvdimm for 4.13
Message-ID: <20170707003421.GC10672@ZenIV.linux.org.uk>
References: <1499386957.6081.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1499386957.6081.29.camel@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 07, 2017 at 12:22:38AM +0000, Williams, Dan J wrote:
> Hi Linus, please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.13
> 
> to receive, libnvdimm updates for the latest ACPI and UEFI
> specifications. This pull request also includes new 'struct
> dax_operations' enabling to undo the abuse [1] of copy_user_nocache()
> for copy operations to pmem. The dax work originally missed 4.12 to
> address concerns raised by Al.
> 
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2017-January/008364.html
> 
> All of the commits in this pull request have appeared in one or more
> -next releases with no errors reported, however, Stephen did report a
> late merge conflict between nvdimm.git and the vfs.git tree. Stephen's
> merge resolution is here:�http://marc.info/?l=linux-kernel&m=1499064115
> 07301&w=2, but to match Al's changes we appear to also need the
> incremental change below.
> 
> Please pull, I believe any straggling _flushcache() feedback at this
> point can be fixed up post -rc1. I include commit 0aed55af8834 "x86,
> uaccess: introduce copy_from_iter_flushcache for pmem / cache-bypass
> operations" at the end of this message for reference.

There will be some followup, but let's do that on top of your branch.
