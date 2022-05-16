Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF772C433FE
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 14:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiEPOPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiEPOPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 10:15:47 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB7EE3E
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652710544; x=1684246544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZIVl0tMHMU=;
  b=Jtw68JZ804SXa/8zmg9rJaKxZbmzm2kH9/YW8cLkeeHDUwGdiSDdfKXX
   bUZmLNt8nKZvBs/T+8oRWNJsylYb9f69xs91AOb+TnbR3h0vziGj2Kyrp
   o2ng6uLujOEDCaISIAqNcs3E/738vC3dDGdUWBkMPOT6N8XzpooUrbuyX
   RrXW91y3uQLxGiudM63UaUdKJ9oOX6MDrvtmpSi84Mwmn5YyGrtIHhVFp
   aYHFlSRnq4ngVa+L4JekJtzr1DeH6wHALttsGXWdRdBbEuBNYTrS9A73c
   N2SZVGm4e4FXDVzWn+mDk0azdfdaVqQxM+eivsCXmux/4LbQJgMvI/wdr
   w==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205308054"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:15:43 +0800
IronPort-SDR: ul4f/qKvrajT4fwd3tD7UHlm87/V2owkdpzazyZU09VInGQvfTjZGcblN5uAXpwwAOCkl0j78B
 nfrDlrL43lY/pEJu3leqHhPA2yaUXzRDsU4HgZTuZ/yx4/EDIla4Xi9HNDBSdbFOwJpMEgdais
 qw8rhCRd/vYvzCwDyJzO7zknAqEt3C/X9YEbTap1ruPGCVK+/fDDoaCubb2z9FH/WpPtBwtfxe
 37V9A9rWSRclM/i9s27sk889yKPRVL8xEbGvydXo1lIcom/F7bioBLuV6meFMQtfJeM29z4rkM
 2TREExd+lGOqypAMb1dDtYb0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:41:26 -0700
IronPort-SDR: /83lcec9Wmo95uvQkKViKLyfYiuyyyeoBKVztjhzqeIrvj3pRQ+g0Sjpv8Ag7X7NfRhW6A40Jk
 O2nBfrqEwlxtX9hCOjgy6uK0y60H5LVaPXF076akz/GwFwR/DctwAeIEczdInkJo6GG6KT/iNT
 k+XfI2wHM+9WdbUrfiRzuw7tqdfx3v7j+qwHbb51wRhpygFFD1KMaXYTMNEas5DRBm304kJa/Z
 E5enwPezs9h6j7wfeVWKvYJQaLmI/8V2cShJGsAXASswlw7tByV9C1ShcncrI2ukefptWaHPPq
 9Dw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:15:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21W324ZPz1SVpD
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:15:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652710542; x=1655302543; bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZI
        Vl0tMHMU=; b=i4y52IglqHa1njsCmAT+LslWANsFjmGWNuC+BQusYwJboYbqlpx
        1K5trb7R/DS0LQM7zIGMW36j5tKV1MkXjwyqWyIuVDc9mYbpFnl/PFabswil526a
        8PiySSAYXnoSsIriKA/fIQIfIzGNus805nNa9Qt91pNUX3WFWNouE47CHlBB9rel
        maqyn8618u1OIr5FZQpjtBkmCq16SVwivVnZFernknGS9rgAJn+4/1wc9xKfDMsc
        KdcjDRBgvTZk1H8sIVIYRnv8T+1SqXKjglgem7sY9T2qTTW/b7gkVCrv7G4sfF23
        zShZbGhGxHLSBwjGLH9SpFHHDxkqgHQgncw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oMMbhY1-2iTl for <linux-block@vger.kernel.org>;
        Mon, 16 May 2022 07:15:42 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Vw31VPz1Rvlc;
        Mon, 16 May 2022 07:15:36 -0700 (PDT)
Message-ID: <31e03f27-6610-c4e4-58b9-6b9db000a753@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
        Chris Mason <clm@fb.com>, matias.bjorling@wdc.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <CGME20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444@eucas1p1.samsung.com>
 <20220516133921.126925-1-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
[...]
> - Patchset description:
> This patchset aims at adding support to non power of 2 zoned devices in
> the block layer, nvme layer, null blk and adds support to btrfs and
> zonefs.
> 
> This round of patches **will not** support DM layer for non
> power of 2 zoned devices. More about this in the future work section.
> 
> Patches 1-2 deals with removing the po2 constraint from the
> block layer.
> 
> Patches 3-4 deals with removing the constraint from nvme zns.
> 
> Patches 5-9 adds support to btrfs for non po2 zoned devices.
> 
> Patch 10 removes the po2 constraint in ZoneFS
> 
> Patch 11-12 removes the po2 contraint in null blk
> 
> Patches 13 adds conditions to not allow non power of 2 devices in
> DM.


Not sure what is going on but I only got the first 4 patches and I do not see
the remaining patches on the lists anywhere.


-- 
Damien Le Moal
Western Digital Research
