Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:49004 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1955462AbdDZGP6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2017 02:15:58 -0400
Date: Wed, 26 Apr 2017 14:14:03 +0800
From: Ye Xiaolong <xiaolong.ye@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kbuild test robot <lkp@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        kbuild-all@01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [kbuild-all] [PATCH v3] axon_ram: add dax_operations support
Message-ID: <20170426061403.GI29367@yexl-desktop>
References: <149264111867.36586.15762148888692084363.stgit@dwillia2-desk3.amr.corp.intel.com>
 <201704201000.drxGPNHB%fengguang.wu@intel.com>
 <CAPcyv4jWN9-JrckBR1wa1Tp7eqB0Hyb61nUhHak5rotVsTgQ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4jWN9-JrckBR1wa1Tp7eqB0Hyb61nUhHak5rotVsTgQ7A@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/19, Dan Williams wrote:
>On Wed, Apr 19, 2017 at 8:01 PM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Dan,
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.11-rc7 next-20170419]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>>
>> url:    https://github.com/0day-ci/linux/commits/Dan-Williams/axon_ram-add-dax_operations-support/20170420-091615
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>
>Hi kbuild team, yes this is the wrong base. It's part of a larger
>series [1] and I'm just re-sending a few select patches with updates
>from review, rather than the full 33 patch series. Any better way to
>send individual updates to a patch in a series without re-sending the
>whole series?

Thanks for the feedback, as it's a common practice in community, we are
developing a new feature to recognize the updated patch of a patch series, and
apply it together with the whole patchset other than applying it individually.

Thanks,
Xiaolong

>
>[1]: https://lkml.org/lkml/2017/4/14/495
>_______________________________________________
>kbuild-all mailing list
>kbuild-all@lists.01.org
>https://lists.01.org/mailman/listinfo/kbuild-all
