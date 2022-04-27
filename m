Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF55C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 02:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356990AbiD0CEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Apr 2022 22:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbiD0CEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Apr 2022 22:04:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD72F101CF
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651024866; x=1682560866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aVEYVQf35+Uh7XzM6a1kJevWBsv5Uf3EWaUSl6Zi8N0=;
  b=A+yHnmRvrnJH0i/BGBq/JigLSIBTIMtmxq7muN8ic+U+vQln7Suq1ip3
   Fh6x+dfcjtEm99VabViuXNFz4Zxmj8AaokZc9yUZS91pvBZRcc2QWVtDA
   wgdmwxeWJq76Be1om3VUSjFXj4IGttH0z6F1mCQ1ZdKL/XNMomI9XmgYq
   3VgHgnv16OX9OzORvyDGOQ9bD3rtPnwdbyxvGMWWJ8cpP3tIBWk7p8//2
   gN7Axs3UAawqOjfHZsu5K/rifavIu05rGRaptcOg8CKBIhVVnYFAxx3QK
   5Eec/X9k8zbtZe8xQFD5t9/ylTwagUD14nCxt0pPrmrAm5SKsxvw32Cgv
   A==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="197753707"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 10:01:05 +0800
IronPort-SDR: frtsbZoW68Y6cyB+tJgNeDSwhHMuW1m3zRxwv5mtiREl0V5Z/IvvMpxhZbkU0cJ3ftBD5DgbIe
 nPz75b7+vNgE/w6YWEj2RR+jdYQ9C+sP7qTq6T1sJe6CZcTcdr3M/4RZ9gR3FLmNlgREDI1oYX
 FrpOC5iPmOr1kmTqGniFH78VKRJvD821zTnEyQMGGMIm79ye+p9QDcN5LwOUrNZ4ONKEIPpvDD
 d+VdLTyw+m5LNsH0J2bvGsnm2n1UIVL2CpoCzwztg6Rvlp7R87KYT6b3e5bBi/VG2KRN5Ei4WB
 mfhmDtUU7oepQYvln6vu98qV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:31:59 -0700
IronPort-SDR: 0daETn2dlRpR5Sml5Nv9fVqZUC0vA+JGJbR9qmbBwZb3GF7MhoQ5jsZFCu+TLOzkFCE7NxOlJh
 Guk6WY+Y6Y+W8wTAjE5vPViSk/ztp7NEtWZvCdn+E++UtkaKlAV16nZgsn9rSoutYMIL74LmL8
 rQ4YXcL0CrDgVHlOF4gc/539CYsn0MKg/WHxsAKdKyHSzFdYUXeoEZFCYRQNxYH2yICHPyd7lW
 ufVsM9icQ+SfB2Tye4aDHSP2aG1tUpl2qzBoecNKHydbRT4d1lX3z95C7/eGCgGub2rC4qtqUl
 VJI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 19:01:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp2693ktfz1Rwrw
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 19:01:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651024863; x=1653616864; bh=aVEYVQf35+Uh7XzM6a1kJevWBsv5Uf3EWaU
        Sl6Zi8N0=; b=KfX3t52RHjy82z2TJzUhoVlJ0/BxFzUJLFKPzHSozkhHJJmCA2P
        nweuPL+ydqBMCKQEK2VHh35Y/SPhWrUHSvx9x7hn0VwCddnnjN9XqHGV8T+TR+RY
        aKeV2RSsxx1DxTEJxJeTvRr3oFCucN5CLVD2xVdrUgsoJTLNmlkJJNPBnjOu8xh1
        ChIzLsgudSmkQoeSFyEiaMjAm71wKa4uYjsEYZ0pKmTZDDD6frJfWMF7mEmwuXgW
        0X4RpDdKxB4i1yrkm5y0mIWo8WBIMJsp0WeTsmtrh2XcJOR7GVoyk1lQPHQ1IXqb
        kKDvjaQQ+59quwxyWYKAYS90TOq0fi3lUyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X72Ma1yBFfmJ for <linux-block@vger.kernel.org>;
        Tue, 26 Apr 2022 19:01:03 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp25z67Pcz1Rvlc;
        Tue, 26 Apr 2022 19:00:55 -0700 (PDT)
Message-ID: <76a89205-f4f1-1e51-aa23-c8082bfefd3c@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 11:00:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> The patch series covers the points discussed in November 2021 virtual c=
all
> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> We have covered the Initial agreed requirements in this patchset.
> Patchset borrows Mikulas's token based approach for 2 bdev
> implementation.

Please reduce the distribution list. List servers (and email clients) are
complaining about it being too large.

>=20
> Overall series supports =E2=80=93
>=20
> 1. Driver
> - NVMe Copy command (single NS), including support in nvme-target (for
>     block and file backend)
>=20
> 2. Block layer
> - Block-generic copy (REQ_COPY flag), with interface accommodating
>     two block-devs, and multi-source/destination interface
> - Emulation, when offload is natively absent
> - dm-linear support (for cases not requiring split)
>=20
> 3. User-interface
> - new ioctl
> - copy_file_range for zonefs
>=20
> 4. In-kernel user
> - dm-kcopyd
> - copy_file_range in zonefs
>=20
> For zonefs copy_file_range - Seems we cannot levearge fstest here. Limi=
ted
> testing is done at this point using a custom application for unit testi=
ng.
>=20
> Appreciate the inputs on plumbing and how to test this further?
> Perhaps some of it can be discussed during LSF/MM too.
>=20
> [0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=3DzT1=
4mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
>=20
> Changes in v4:
> - added copy_file_range support for zonefs
> - added documentaion about new sysfs entries
> - incorporated review comments on v3
> - minor fixes
>=20
>=20
> Arnav Dawn (2):
>   nvmet: add copy command support for bdev and file ns
>   fs: add support for copy file range in zonefs
>=20
> Nitesh Shetty (7):
>   block: Introduce queue limits for copy-offload support
>   block: Add copy offload support infrastructure
>   block: Introduce a new ioctl for copy
>   block: add emulation for copy
>   nvme: add copy offload support
>   dm: Add support for copy offload.
>   dm: Enable copy offload for dm-linear target
>=20
> SelvaKumar S (1):
>   dm kcopyd: use copy offload support
>=20
>  Documentation/ABI/stable/sysfs-block |  83 +++++++
>  block/blk-lib.c                      | 358 +++++++++++++++++++++++++++
>  block/blk-map.c                      |   2 +-
>  block/blk-settings.c                 |  59 +++++
>  block/blk-sysfs.c                    | 138 +++++++++++
>  block/blk.h                          |   2 +
>  block/ioctl.c                        |  32 +++
>  drivers/md/dm-kcopyd.c               |  55 +++-
>  drivers/md/dm-linear.c               |   1 +
>  drivers/md/dm-table.c                |  45 ++++
>  drivers/md/dm.c                      |   6 +
>  drivers/nvme/host/core.c             | 116 ++++++++-
>  drivers/nvme/host/fc.c               |   4 +
>  drivers/nvme/host/nvme.h             |   7 +
>  drivers/nvme/host/pci.c              |  25 ++
>  drivers/nvme/host/rdma.c             |   6 +
>  drivers/nvme/host/tcp.c              |  14 ++
>  drivers/nvme/host/trace.c            |  19 ++
>  drivers/nvme/target/admin-cmd.c      |   8 +-
>  drivers/nvme/target/io-cmd-bdev.c    |  65 +++++
>  drivers/nvme/target/io-cmd-file.c    |  49 ++++
>  fs/zonefs/super.c                    | 178 ++++++++++++-
>  fs/zonefs/zonefs.h                   |   1 +
>  include/linux/blk_types.h            |  21 ++
>  include/linux/blkdev.h               |  17 ++
>  include/linux/device-mapper.h        |   5 +
>  include/linux/nvme.h                 |  43 +++-
>  include/uapi/linux/fs.h              |  23 ++
>  28 files changed, 1367 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: e7d6987e09a328d4a949701db40ef63fbb970670


--=20
Damien Le Moal
Western Digital Research
