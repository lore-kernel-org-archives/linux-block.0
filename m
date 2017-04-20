Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35192 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938624AbdDTDQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 23:16:25 -0400
Received: by mail-oi0-f41.google.com with SMTP id j201so31853799oih.2
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2017 20:16:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201704201000.drxGPNHB%fengguang.wu@intel.com>
References: <149264111867.36586.15762148888692084363.stgit@dwillia2-desk3.amr.corp.intel.com>
 <201704201000.drxGPNHB%fengguang.wu@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Apr 2017 20:16:24 -0700
Message-ID: <CAPcyv4jWN9-JrckBR1wa1Tp7eqB0Hyb61nUhHak5rotVsTgQ7A@mail.gmail.com>
Subject: Re: [PATCH v3] axon_ram: add dax_operations support
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 19, 2017 at 8:01 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Dan,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.11-rc7 next-20170419]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
>
> url:    https://github.com/0day-ci/linux/commits/Dan-Williams/axon_ram-add-dax_operations-support/20170420-091615
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next

Hi kbuild team, yes this is the wrong base. It's part of a larger
series [1] and I'm just re-sending a few select patches with updates
from review, rather than the full 33 patch series. Any better way to
send individual updates to a patch in a series without re-sending the
whole series?

[1]: https://lkml.org/lkml/2017/4/14/495
