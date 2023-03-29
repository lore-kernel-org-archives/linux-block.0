Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E8C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC2XfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2XfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:35:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB955251
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132899; x=1711668899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eeHaifFAhmRPPQjhcQgNdDiqHkPhvUoOQEh9qZdcZBI=;
  b=Q7H1CagV1Zx06BgBz2m8mj7RHo33QB2yEIn20+8oPwzhU/+Z2ewikvSX
   ZAhSMBygJL5YnyAVqTv0XHQJviwg09ZkfEGOSrqV3E1pF6Hv91BbKzEEm
   fsGgeYbTdtqxaKKVo9V46tAOebxw0itObRODsBWJmQAfPEJPUFfHe8xzJ
   PrI4jx3bcRbq94rwJyYtqWirbrusNQD6m1aNGsgFSVZkNjZ/YuQKgo+pI
   sIq6NcTJVv8yc+4Ww8p3B2fa4T+hbU+AbpVl26OLcDNE1rEOYlxRUy7Ts
   82gSzM0uaFR4Ve9BlPGTTdx382SFqyxX9z1Ji+LHNwT4TFSirj7vpPEbe
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113717"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:58 +0800
IronPort-SDR: 1nG8qMw9qlohfDpgsUr3kQNgp3FgcxQEIb7YXv4PNKT7eE1A1Pc+KRrRJu53vGDX/pqHkYWYGl
 /hYVHIpFvhuIdorTQvAscdgBy9CYzhd4bjMoJ04Ptvsx8QUdLzFhnKDlEsllXha5TVPrqwi5no
 zOuvTj3snr9BJstJHGzhCuGdMhnhob3Klij3G6EHIefhBYInt3+4cxRkia+p6y9lXx0tVHywUr
 FhKLRHd816s2UklTOt3RgrnogeP8cB0rBL/WyEyjJnurJHRk2htWdPUBC7oFvhRIwfERM5VL1N
 neM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:51:07 -0700
IronPort-SDR: j4hwDjMn1/n8yShOVR+jSQZy+Nen8IoQdFxW8+KuUVBHonczY5F7gDb5IAAgVkpU/tyhDfVJ2+
 4fLoQFRFVY0xa2PFTNCvLorDGCAIMhCOgBTTP/NAo+9X3H0lWXVAHdLY6kVX26ZLafsHPCqrUQ
 Yeko40At6BtIrBeQHh5PlTd7+58DII/Wz+jWfiKRAbaD3Xab/74c3zM0P85cNrgNvPnVGQsHkB
 Xx0ilD8asiqsxUsLD26gQjluVySaEqbv85T61sInx4ItxHflBSc4z7+SLM0b4RfWjPykItBEA6
 XYI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2w2348yz1RtVx
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:34:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132897; x=1682724898; bh=eeHaifFAhmRPPQjhcQgNdDiqHkPhvUoOQEh
        9qZdcZBI=; b=BXNDcLcmPPrVqL0uFQjErIzucxTlO2TIjyuUMny2mRGUWmQis2+
        Kp33jWSJF1g147Opo3rTneP3H7gwmNnEY+Up30cZQPxCibvRicdthlRAp7HwfA3s
        yZ2CR0pSt1DWieL+O+5noiTVyC18th0YJN7NxnEc9WA69UT3Aek5Gf1Ykc8KUD/E
        fCMhYTIDSrIhJoUmE5A9NvofEQI3CB/096YNkJxWerVVLA5+j1USgnk3t3REY1DB
        4txAUQ8raXYpQ2EQFHL2FPvKU/3Tn62ZAbsAG7vjHNq3VUhum4TuE7DV08/TeyBl
        eQW/1XF2djdTME7GQEAjbOj7c59rU1TGj7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N2wYjmdRpe5I for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:57 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2vy4wThz1RtVm;
        Wed, 29 Mar 2023 16:34:54 -0700 (PDT)
Message-ID: <14a2f204-32a4-5108-560b-98c3dac2abfb@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:34:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/19] gfs: use __bio_add_page for adding single page to
 bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The GFS superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

