Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C4EEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjF3KeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjF3Kd4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 06:33:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE3330DF
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121236; x=1719657236;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=bh+mzwZsv0sqyvr7ZUOmbGwgq8sCUfE12/5m1clQC8A=;
  b=QmFDGVCQk4m28bgh7ax1uCt94UIrm1ZKJJzGiCPNsdq1t+1brlFLf6/M
   b8Y2dkkzS5EcRLBHRKOg/Oypj5zSNtIho12I9q7X3eWd0K1IuYbWcgs1k
   PYx/l/jHaERf/gRVSM02NiQEZnxze+GRbi3gdKHUhMlYkeErfCv7xQWWV
   hYvF7m7iXnDv3d28RunkVjCyYstNGS8gtLvFr31+JHkttXy5fw9enSw4n
   LZhyuJmB+LyENV/tfx6q9aZovvBJ2BO4d3XiUqkH4d6MjxnZdQ7hGlED3
   jrVrU18DDg047QtXbnyHKucyUeGzPT0o/AhuScXWyuF70E1ymUIcmYRsd
   w==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="236618454"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:33:54 +0800
IronPort-SDR: XWCZardjlw4kwG2RtzZPaUQfxVcuAO3TGwFzDvlYEPRjMVIM0USLu5wejHt1zM87Xeogfn7OgX
 Rql9P+U6X2hjJ5k3FVJBwn/gkEEC1B4Q5vr/s8McpglOoOX9bjqoPlhPtFzDwiDwawwlLWV5/s
 z/G2CDdE0Tt3tXqN8X474QOxZ8k2dO2e5xPQ5d8rjOiBJGAts6LVw50B0rYvbelAYRBAuVWwKk
 JrKZx3nd8SOuu8siavpVmNjS+9DObyf3E3/UansssI5Myi8cuRmdd6AhJUl5V3nxb3H0nCHmeH
 bQc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:48:09 -0700
IronPort-SDR: sg5w4tlO8biEmy+h5IFYrln8Ch1vRFyX+YdW9or45+QE2Gi3rRwVZLHm6CD6YWOT5hMMjCPiVS
 5ZuxbVhe6OCC8XhuvNOzl0cDK5QjBJnweCJ91EfF6tlOu1bFjltIOgGTXvL1oK3XJgcvJceFX4
 DB0oVtns7MBwa6BFuxz07FDAZ2B0lCGTxwVwxPriN2d/8lNKJL2k/z4h9b58hKe2G2YOz/POog
 E3OPIKByHJPzpYNIi0YUN7y/J3wDh6cfisCxqBXrEqsCPrn8ET/e3KFvYtLNs6t1O6kkrFpOnX
 TyM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:33:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Qss9s43dGz1RtVt
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 03:33:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121218; x=1690713219; bh=bh+mz
        wZsv0sqyvr7ZUOmbGwgq8sCUfE12/5m1clQC8A=; b=mg/2dVzZ9mHH66e8lYah0
        kAQ/xE5I9J0LfBZZFEtHDYp7B1ujTVs1yDkT4RxqBY/bou5E9GxVHTx3RvHmGrSb
        4PMBj5sJn6o5anpuDmfXeWluUuYPF8cYfFFIDFb/ZaxJ5lpCw4dWDiGYc/lvcf0U
        gSaDLZ8oD3rwVPmxHVu3f6lYKgivQ6UKiMSHdkcBTh/Y/K/XBhYK8NZAu7toB+4N
        er28XVhB82OIENJKzIxKL37PJmdY1/xOaAKkh0Toqlh5AqIQ/I0J5jFjJt6UneS7
        ZSmJCUVUBJ7GB/31B3xGGGOxdovmnHedOdf1hBpSwge9pzEGVGUOySn+xRo6Cc/r
        Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C7sdUcAiy8sY for <linux-block@vger.kernel.org>;
        Fri, 30 Jun 2023 03:33:38 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Qss9Y6Dxwz1RtVn;
        Fri, 30 Jun 2023 03:33:37 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:03:37 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 0/4] ublk: add zoned storage support
In-Reply-To: <5F597343-EC91-4698-ACBE-9111B52FC3FC@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <5F597343-EC91-4698-ACBE-9111B52FC3FC@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <b29f01c287c7469f47fb4b689a3cba68@opensource.wdc.com>
X-Sender: aravind.ramesh@opensource.wdc.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> =EF=BB=BFOn 29/06/23, 12:37 AM, "Andreas Hindborg" <nmi@metaspace.dk
> <mailto:nmi@metaspace.dk>> wrote:
>=20
>=20
> From: Andreas Hindborg <a.hindborg@samsung.com=20
> <mailto:a.hindborg@samsung.com>>
>=20
>=20
> Hi All,
>=20
>=20
> This patch set adds zoned storage support to `ublk`. The first two=20
> patches does
> some house cleaning in preparation for the last two patches. The third=20
> patch
> adds support for report_zones and the following operations:
>=20

Just to clarify, we do need you ublk user space patches
to create a ublk device node (with these patches in kernel), right ?

>=20
> - REQ_OP_ZONE_OPEN
> - REQ_OP_ZONE_CLOSE
> - REQ_OP_ZONE_FINISH
> - REQ_OP_ZONE_RES

REQ_OP_ZONE_RESET

>=20
>=20
> The last patch adds support for REQ_OP_ZONE_APPEND.
>=20
>=20
> v3 [2] -> v4 changes:
> - Split up v3 patches
> - Add zone append support
> - Change order of variables in `ublk_report_zones`
>=20
>=20
> Read/write and zone operations are tested with zenfs [3].
>=20
>=20
> The zone append path is tested with fio -> zonefs -> ublk -> null_blk.
>=20
>=20
> The implementation of zone append requires ublk user copy feature, and=20
> therefore
> the series is based on branch for-next (6afa337a3789) of [4].
>=20
>=20
> [1]
> https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952=
dd88bf5e668b
> <https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e99895=
2dd88bf5e668b>
> [2]
> https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspa=
ce.dk
> <mailto:20230316145539.300523-1-nmi@metaspace.dk>/
> [3] https://github.com/westerndigitalcorporation/zenfs
> <https://github.com/westerndigitalcorporation/zenfs>
> [4] https://git.kernel.dk/linux.git <https://git.kernel.dk/linux.git>
>=20
>=20
> Andreas Hindborg (4):
> ublk: change ublk IO command defines to enum
> ublk: move types to shared header file
> ublk: enable zoned storage support
> ublk: add zone append
>=20
>=20
> MAINTAINERS | 2 +
> drivers/block/Kconfig | 4 +
> drivers/block/Makefile | 4 +-
> drivers/block/ublk_drv-zoned.c | 155 +++++++++++++++++++++++++++++++++
> drivers/block/ublk_drv.c | 150 +++++++++++++++++++------------
> drivers/block/ublk_drv.h | 71 +++++++++++++++
> include/uapi/linux/ublk_cmd.h | 38 ++++++--
> 7 files changed, 363 insertions(+), 61 deletions(-)
> create mode 100644 drivers/block/ublk_drv-zoned.c
> create mode 100644 drivers/block/ublk_drv.h
>=20
>=20
>=20
>=20
> base-commit: 3261ea42710e9665c9151006049411bd23b5411f

Regards,
Aravind
