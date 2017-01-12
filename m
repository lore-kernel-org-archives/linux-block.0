Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33857 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdALWnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 17:43:04 -0500
Received: by mail-oi0-f46.google.com with SMTP id m124so3823390oif.1
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2017 14:43:04 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Jan 2017 14:43:03 -0800
Message-ID: <CAPcyv4hWNL7=MmnUj65A+gz=eHAnUrVzqV+24QiNQDW--ag8WQ@mail.gmail.com>
Subject: [LSF/MM TOPIC] Memory hotplug, ZONE_DEVICE, and the future of struct page
To: Linux MM <linux-mm@kvack.org>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Back when we were first attempting to support DMA for DAX mappings of
persistent memory the plan was to forgo 'struct page' completely and
develop a pfn-to-scatterlist capability for the dma-mapping-api. That
effort died in this thread:

    https://lkml.org/lkml/2015/8/14/3

...where we learned that the dependencies on struct page for dma
mapping are deeper than a PFN_PHYS() conversion for some
architectures. That was the moment we pivoted to ZONE_DEVICE and
arranged for a 'struct page' to be available for any persistent memory
range that needs to be the target of DMA. ZONE_DEVICE enables any
device-driver that can target "System RAM" to also be able to target
persistent memory through a DAX mapping.

Since that time the "page-less" DAX path has continued to mature [1]
without growing new dependencies on struct page, but at the same time
continuing to rely on ZONE_DEVICE to satisfy get_user_pages().

Peer-to-peer DMA appears to be evolving from a niche embedded use case
to something general purpose platforms will need to comprehend. The
"map_peer_resource" [2] approach looks to be headed to the same
destination as the pfn-to-scatterlist effort. It's difficult to avoid
'struct page' for describing DMA operations without custom driver
code.

With that background, a statement and a question to discuss at LSF/MM:

General purpose DMA, i.e. any DMA setup through the dma-mapping-api,
requires pfn_to_page() support across the entire physical address
range mapped.

Is ZONE_DEVICE the proper vehicle for this? We've already seen that it
collides with platform alignment assumptions [3], and if there's a
wider effort to rework memory hotplug [4] it seems DMA support should
be part of the discussion.

---

This topic focuses on the mechanism to enable pfn_to_page() for an
arbitrary physical address range, and the proposed peer-to-peer DMA
topic [5] touches on the userspace presentation of this mechanism. I
might be good to combine these topics if there's interest? In any
event, I'm interested in both as well Michal's concern about memory
hotplug in general.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2016-November/007672.html
[2]: http://www.spinics.net/lists/linux-pci/msg44560.html
[3]: https://lkml.org/lkml/2016/12/1/740
[4]: http://www.spinics.net/lists/linux-mm/msg119369.html
[5]: http://marc.info/?l=linux-mm&m=148156541804940&w=2
