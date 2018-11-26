Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E25AC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A4820672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A4820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeK0EvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:51:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:61962 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0EvE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 23:51:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 09:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="asc'?scan'208";a="95176535"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2018 09:56:11 -0800
Message-ID: <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     hverkuil@xs4all.nl, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org,
        intel-wired-lan@lists.osuosl.org, linux-alpha@vger.kernel.org,
        dmaengine@vger.kernel.org, jiangqi903@gmail.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-media@vger.kernel.org
Date:   Mon, 26 Nov 2018 09:56:28 -0800
In-Reply-To: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w/yFab8vycJu1U8x0saQ"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--=-w/yFab8vycJu1U8x0saQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-26 at 17:56 +0530, Anshuman Khandual wrote:
> At present there are multiple places where invalid node number is
> encoded
> as -1. Even though implicitly understood it is always better to have
> macros
> in there. Replace these open encodings for an invalid node number
> with the
> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions
> like
> 'invalid node' from various places redirecting them to a common
> definition.
>=20
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

For the 'ixgbe' driver changes.

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>


> ---
> Changes in V2:
>=20
> - Added inclusion of 'numa.h' header at various places per Andrew
> - Updated 'dev_to_node' to use NUMA_NO_NODE instead per Vinod
>=20
> Changes in V1: (https://lkml.org/lkml/2018/11/23/485)
>=20
> - Dropped OCFS2 changes per Joseph
> - Dropped media/video drivers changes per Hans
>=20
> RFC - https://patchwork.kernel.org/patch/10678035/
>=20
> Build tested this with multiple cross compiler options like alpha,
> sparc,
> arm64, x86, powerpc, powerpc64le etc with their default config which
> might
> not have compiled tested all driver related changes. I will
> appreciate
> folks giving this a test in their respective build environment.
>=20
> All these places for replacement were found by running the following
> grep
> patterns on the entire kernel code. Please let me know if this might
> have
> missed some instances. This might also have replaced some false
> positives.
> I will appreciate suggestions, inputs and review.
>=20
> 1. git grep "nid =3D=3D -1"
> 2. git grep "node =3D=3D -1"
> 3. git grep "nid =3D -1"
> 4. git grep "node =3D -1"
>=20
>  arch/alpha/include/asm/topology.h             |  3 ++-
>  arch/ia64/kernel/numa.c                       |  2 +-
>  arch/ia64/mm/discontig.c                      |  6 +++---
>  arch/ia64/sn/kernel/io_common.c               |  3 ++-
>  arch/powerpc/include/asm/pci-bridge.h         |  3 ++-
>  arch/powerpc/kernel/paca.c                    |  3 ++-
>  arch/powerpc/kernel/pci-common.c              |  3 ++-
>  arch/powerpc/mm/numa.c                        | 14 +++++++-------
>  arch/powerpc/platforms/powernv/memtrace.c     |  5 +++--
>  arch/sparc/kernel/auxio_32.c                  |  3 ++-
>  arch/sparc/kernel/pci_fire.c                  |  3 ++-
>  arch/sparc/kernel/pci_schizo.c                |  3 ++-
>  arch/sparc/kernel/pcic.c                      |  7 ++++---
>  arch/sparc/kernel/psycho_common.c             |  3 ++-
>  arch/sparc/kernel/sbus.c                      |  3 ++-
>  arch/sparc/mm/init_64.c                       |  6 +++---
>  arch/sparc/prom/init_32.c                     |  3 ++-
>  arch/sparc/prom/init_64.c                     |  5 +++--
>  arch/sparc/prom/tree_32.c                     | 13 +++++++------
>  arch/sparc/prom/tree_64.c                     | 19 ++++++++++-------
> --
>  arch/x86/include/asm/pci.h                    |  3 ++-
>  arch/x86/kernel/apic/x2apic_uv_x.c            |  7 ++++---
>  arch/x86/kernel/smpboot.c                     |  3 ++-
>  arch/x86/platform/olpc/olpc_dt.c              | 17 +++++++++--------
>  drivers/block/mtip32xx/mtip32xx.c             |  5 +++--
>  drivers/dma/dmaengine.c                       |  4 +++-
>  drivers/infiniband/hw/hfi1/affinity.c         |  3 ++-
>  drivers/infiniband/hw/hfi1/init.c             |  3 ++-
>  drivers/iommu/dmar.c                          |  5 +++--
>  drivers/iommu/intel-iommu.c                   |  3 ++-
>  drivers/misc/sgi-xp/xpc_uv.c                  |  3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 +++--
>  include/linux/device.h                        |  2 +-
>  init/init_task.c                              |  3 ++-
>  kernel/kthread.c                              |  3 ++-
>  kernel/sched/fair.c                           | 15 ++++++++-------
>  lib/cpumask.c                                 |  3 ++-
>  mm/huge_memory.c                              | 13 +++++++------
>  mm/hugetlb.c                                  |  3 ++-
>  mm/ksm.c                                      |  2 +-
>  mm/memory.c                                   |  7 ++++---
>  mm/memory_hotplug.c                           | 12 ++++++------
>  mm/mempolicy.c                                |  2 +-
>  mm/page_alloc.c                               |  4 ++--
>  mm/page_ext.c                                 |  2 +-
>  net/core/pktgen.c                             |  3 ++-
>  net/qrtr/qrtr.c                               |  3 ++-
>  tools/perf/bench/numa.c                       |  6 +++---
>  48 files changed, 146 insertions(+), 108 deletions(-)


--=-w/yFab8vycJu1U8x0saQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlv8M8wACgkQ5W/vlVpL
7c7QNQ/+NU3ikW7p6wkGj8G70RbkJORkKztnANrZvZMGTngn9AOr2IYiWm5l1FX0
J1AyprX0m4BmLXBgW1BrOiReEiunq9RWtCT+2d7jQD6HxydLdRIbnQhLreHfcFv7
6pUvyapG9B8a4X/6OzQXJVkRV+iXi/NzVxJ2WvZ6PhifiPMJo9oWab/OJDu/+8Fn
w9BrPNqJhTdrSQ1E7aeMWUs/GbfQsQ+cm51Yb12KAemw5ocp45GNNeN2Y14g+YFZ
Yhf7+/ihwBaph/zDYqFRsI+uSLnKIh7vLC/weBglkzU5mNZU9ugRj6M76jDE+OI3
yqOTMp6DquBqH7qYuGA+yJfWvnsXa/KphTKzISpKXzkcGI4uyhjfWjoUN2CPbLWj
55+k1mCY0glzACh1K+SFV1EDJ157U0sEx+vGaKDfpEcUFi/SUU7xE/u+4lI12Kec
fMhcStiYmF5wvVMO8ID6+aPl9F7uNdrAJjPV6psDtLRhi6D+EkFRPG/2sxGNWNBC
2FfNwyEy9of0UsptOWI3IOt80Oz2usDEwcnC4gAQhykPe/6lNI6Yb1OjsMtUdzw1
BqoYXFKLnC2JQWxluwLMjJ/ng/Af94RzzYw901pIhtJjlTOx6nYUxO38hLp6JU6B
qKDxnSxdVo6/2QOJpMCJ2o0tX/Q1MdMWbySfxnCX9il8o/TgOck=
=I+vR
-----END PGP SIGNATURE-----

--=-w/yFab8vycJu1U8x0saQ--

