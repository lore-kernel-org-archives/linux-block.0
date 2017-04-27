Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36627 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbdD0Ga7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 02:30:59 -0400
Date: Thu, 27 Apr 2017 08:30:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: viro@zeniv.linux.org.uk, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-nvdimm@lists.01.org,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [RFC PATCH] x86, uaccess, pmem: introduce
 copy_from_iter_writethru for dax + pmem
Message-ID: <20170427063054.soejyqocqqrihfdw@gmail.com>
References: <20170425012230.GX29622@ZenIV.linux.org.uk>
 <149324377946.28224.12306514223331326459.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149324377946.28224.12306514223331326459.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> +#ifdef CONFIG_ARCH_HAS_UACCESS_WRITETHRU
> +#define __HAVE_ARCH_MEMCPY_WRITETHRU 1
> +void memcpy_writethru(void *dst, const void *src, size_t cnt);
> +#endif

This should be named memcpy_wt(), which is the well-known postfix for 
write-through.

We already have ioremap_wt(), set_memory_wt(), etc. - no need to introduce a 
longer variant with uncommon spelling.

Thanks,

	Ingo
