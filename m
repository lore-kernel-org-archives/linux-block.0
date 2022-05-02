Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE0DC433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 12:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiEBM6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385149AbiEBM6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 08:58:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A4A140BC
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651496098; x=1683032098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JUhkvda0JEwXdsLju2Qm64dHW4RVR82QZ/jIjIRhXSc=;
  b=KCyZ3l+vT77Yo1dHkfrzgWgyXAIhlO/gxXppc/zwmEmlD8vKOrjzMyv3
   83ZcaJ22RCr5bs4qAXpk8gJJtZLWl/XwQgaDvc9EuTrUkM4+1TMyJUF2+
   uzDd8LL0BVWIFvG+vA/yY9H2Cv6BiQmtDzeFgxTgs2rPPchtmaIN5TMEK
   8N6stNS1Yf26HYu1gjqdzk6MGyLKjoAKyapUIj+O5t24PoLVrisyQB6O/
   MRTU83hFbMw1Sq/tDFsMKd8r+YNbXiaja4wDOZ9M/g5Bh0ztxdre4opIc
   jHpN1jnH1y6fTJE33XJG7Qis4xglAO6QhEFEyDQF7NutEdW4paPSPmus1
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,192,1647273600"; 
   d="scan'208";a="204205550"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:54:58 +0800
IronPort-SDR: 8Je7KGf029SxZW+779CyPv/YGCz1MtTjpXPdolnTYyF4zVJVh26h/lV8aO4tRs3m/KdjMMZdDV
 Bsc3t6HTA0exrsSuBMQCjtQbbgLOJArwUvKl9IHLv+5rb6Yp7jXPUcVfltPplnWJQFjYAiiTzD
 uqqCd11cB7h0nyUA8MSQTyH5Mg/cwvBJdDhhd0/YW7lDvcVo95ggZkRYzrn9MPLO9JlleU7oHk
 W3vCtAK8Xv84uaT2EAOYevWsEh+2n6cE8X8YUW29QiReOikvJ86tCrfquJDQ2NNsnIxcpoaHQw
 0zSl5Z2PaHL+V3WBrgEHssQ4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 05:25:02 -0700
IronPort-SDR: X/mjDqfPpuofgpIpf4bo2zbOFqdjYmlyKjFST6cdH+TbHgaPMFjssBT93mltFpRb5c47qHNtZm
 YAiA9tpgsulzd5Vkfu66ILIp8nOkPttgmSlxD899UgKC5kV/f7cIivuMrwseIe0hAc6VlYGraQ
 +zpc5r/Hi1+NKGjXeIWs2poISM3Zbv2n1mgZJKF/sj7qBJf6/oVh71K/xfUzwBl9uNjG1g1UC8
 AZEABALRVBdH9l8qc2UW309TBpy6ieUH2udyJMFfdEWVeH+wQ7EmAdBSMJzkx0mMx7Jubc300+
 LGE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 05:54:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsNNL0xPWz1Rwrw
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 05:54:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651496097; x=1654088098; bh=JUhkvda0JEwXdsLju2Qm64dHW4RVR82QZ/j
        IjIRhXSc=; b=AIzuKRzwZQVGatHl1N9EZyzvTE342Ex2Xsdk8dBzDQ7YlT68E2V
        jV+TRKCrZd4GXYnfbCwGUwR95UrtQKr2UfhYl8T65OJz4IyX5umhChjtkVGNhb78
        fifJnXe4HbDMbtWoKXkttpTB62VrmW8Nx3y8woeYDf4X2F5K5ujyv36d1+FWxt7o
        sb9+KnDWiv764wZ2QpUYFR4rpzUKq6nGrx3NzsjOE6RgwxGpfrSzxy7XJaamCLU4
        cKra1DSpG8GFVPnxcIuK8yBXF6OG4IuYh9XditWd0i9eLs+PM4Hw+wMdbnKYLvAZ
        DOChJiv+tRmTFj4WmOuvf97nM+M1QTprY6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jBI20kRw0usP for <linux-block@vger.kernel.org>;
        Mon,  2 May 2022 05:54:57 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsNNJ5Mpmz1Rvlc;
        Mon,  2 May 2022 05:54:56 -0700 (PDT)
Message-ID: <46e95412-9a79-51f8-3d52-caed4875d41f@opensource.wdc.com>
Date:   Mon, 2 May 2022 21:54:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <20220502040951.GC1360180@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220502040951.GC1360180@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/02 13:09, Dave Chinner wrote:
> On Wed, Apr 27, 2022 at 06:19:51PM +0530, Nitesh Shetty wrote:
>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>> The patch series covers the points discussed in November 2021 virtua=
l call
>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>> We have covered the Initial agreed requirements in this patchset.
>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>> implementation.
>>>>
>>>> Overall series supports =E2=80=93
>>>>
>>>> 1. Driver
>>>> - NVMe Copy command (single NS), including support in nvme-target (f=
or
>>>>     block and file backend)
>>>
>>> It would also be nice to have copy offload emulation in null_blk for =
testing.
>>>
>>
>> We can plan this in next phase of copy support, once this series settl=
es down.
>=20
> Why not just hook the loopback driver up to copy_file_range() so
> that the backend filesystem can just reflink copy the ranges being
> passed? That would enable testing on btrfs, XFS and NFSv4.2 hosted
> image files without needing any special block device setup at all...

That is a very good idea ! But that will cover only the non-zoned case. F=
or copy
offload on zoned devices, adding support in null_blk is probably the simp=
lest
thing to do.

>=20
> i.e. I think you're doing this compeltely backwards by trying to
> target non-existent hardware first....
>=20
> Cheers,
>=20
> Dave.


--=20
Damien Le Moal
Western Digital Research
