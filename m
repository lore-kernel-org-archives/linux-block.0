Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34449 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdEEWZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2017 18:25:04 -0400
Received: by mail-oi0-f49.google.com with SMTP id b204so2396245oii.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2017 15:25:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494016773.30303.69.camel@hpe.com>
References: <20170427063054.soejyqocqqrihfdw@gmail.com> <149340820800.28724.16189291963486607562.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1494016773.30303.69.camel@hpe.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 May 2017 15:25:03 -0700
Message-ID: <CAPcyv4igCk9EBXSCVr8W1B-oNwq8q5kr7AMTkwvnMAhdwMgjRA@mail.gmail.com>
Subject: Re: [PATCH v2] x86, uaccess: introduce copy_from_iter_wt for pmem /
 writethrough operations
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "jack@suse.cz" <jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, May 5, 2017 at 1:39 PM, Kani, Toshimitsu <toshi.kani@hpe.com> wrote:
> On Fri, 2017-04-28 at 12:39 -0700, Dan Williams wrote:
>> The pmem driver has a need to transfer data with a persistent memory
>> destination and be able to rely on the fact that the destination
>> writes are not cached. It is sufficient for the writes to be flushed
>> to a cpu-store-buffer (non-temporal / "movnt" in x86 terms), as we
>> expect userspace to call fsync() to ensure data-writes have reached a
>> power-fail-safe zone in the platform. The fsync() triggers a REQ_FUA
>> or REQ_FLUSH to the pmem driver which will turn around and fence
>> previous writes with an "sfence".
>>
>> Implement a __copy_from_user_inatomic_wt, memcpy_page_wt, and
>> memcpy_wt, that guarantee that the destination buffer is not dirty in
>> the cpu cache on completion. The new copy_from_iter_wt and sub-
>> routines will be used to replace the "pmem api" (include/linux/pmem.h
>> + arch/x86/include/asm/pmem.h). The availability of
>> copy_from_iter_wt() and memcpy_wt() are gated by the
>> CONFIG_ARCH_HAS_UACCESS_WT config symbol, and fallback to
>> copy_from_iter_nocache() and plain memcpy() otherwise.
>>
>> This is meant to satisfy the concern from Linus that if a driver
>> wants to do something beyond the normal nocache semantics it should
>> be something private to that driver [1], and Al's concern that
>> anything uaccess related belongs with the rest of the uaccess code
>> [2].
>>
>> [1]: https://lists.01.org/pipermail/linux-nvdimm/2017-January/008364.
>> html
>> [2]: https://lists.01.org/pipermail/linux-nvdimm/2017-April/009942.ht
>> ml
>>
>> Cc: <x86@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Jeff Moyer <jmoyer@redhat.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Matthew Wilcox <mawilcox@microsoft.com>
>> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>> Changes since the initial RFC:
>> * s/writethru/wt/ since we already have ioremap_wt(),
>> set_memory_wt(), etc. (Ingo)
>
> Sorry I should have said earlier, but I think the term "wt" is
> misleading.  Non-temporal stores used in memcpy_wt() provide WC
> semantics, not WT semantics.

The non-temporal stores do, but memcpy_wt() is using a combination of
non-temporal stores and explicit cache flushing.

> How about using "nocache" as it's been
> used in __copy_user_nocache()?

The difference in my mind is that the "_nocache" suffix indicates
opportunistic / optional cache pollution avoidance whereas "_wt"
strictly arranges for caches not to contain dirty data upon completion
of the routine. For example, non-temporal stores on older x86 cpus
could potentially leave dirty data in the cache, so memcpy_wt on those
cpus would need to use explicit cache flushing.
