Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33020 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdEEOME (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2017 10:12:04 -0400
Received: by mail-io0-f176.google.com with SMTP id p24so9995260ioi.0
        for <linux-block@vger.kernel.org>; Fri, 05 May 2017 07:12:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170505065404.llj4ym3thrmmlhyo@gmail.com>
References: <20170427063054.soejyqocqqrihfdw@gmail.com> <149340820800.28724.16189291963486607562.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170505065404.llj4ym3thrmmlhyo@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 May 2017 07:12:03 -0700
Message-ID: <CAPcyv4j=8cR-=73Nbz1VKd2MiZ5eT=gp1rWS14EJmSzY=u6VWw@mail.gmail.com>
Subject: Re: [PATCH v2] x86, uaccess: introduce copy_from_iter_wt for pmem /
 writethrough operations
To: Ingo Molnar <mingo@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        X86 ML <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        jmoyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 4, 2017 at 11:54 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> The pmem driver has a need to transfer data with a persistent memory
>> destination and be able to rely on the fact that the destination writes
>> are not cached. It is sufficient for the writes to be flushed to a
>> cpu-store-buffer (non-temporal / "movnt" in x86 terms), as we expect
>> userspace to call fsync() to ensure data-writes have reached a
>> power-fail-safe zone in the platform. The fsync() triggers a REQ_FUA or
>> REQ_FLUSH to the pmem driver which will turn around and fence previous
>> writes with an "sfence".
>>
>> Implement a __copy_from_user_inatomic_wt, memcpy_page_wt, and memcpy_wt,
>> that guarantee that the destination buffer is not dirty in the cpu cache
>> on completion. The new copy_from_iter_wt and sub-routines will be used
>> to replace the "pmem api" (include/linux/pmem.h +
>> arch/x86/include/asm/pmem.h). The availability of copy_from_iter_wt()
>> and memcpy_wt() are gated by the CONFIG_ARCH_HAS_UACCESS_WT config
>> symbol, and fallback to copy_from_iter_nocache() and plain memcpy()
>> otherwise.
>>
>> This is meant to satisfy the concern from Linus that if a driver wants
>> to do something beyond the normal nocache semantics it should be
>> something private to that driver [1], and Al's concern that anything
>> uaccess related belongs with the rest of the uaccess code [2].
>>
>> [1]: https://lists.01.org/pipermail/linux-nvdimm/2017-January/008364.html
>> [2]: https://lists.01.org/pipermail/linux-nvdimm/2017-April/009942.html
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
>> * s/writethru/wt/ since we already have ioremap_wt(), set_memory_wt(),
>>   etc. (Ingo)
>
> Looks good to me. I suspect you'd like to carry this in the nvdimm tree?
>
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks, Ingo!. Yes, I'll carry it in nvdimm.git for 4.13.
