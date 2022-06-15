Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78685CCA47D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiFOLDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347222AbiFOLBr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 07:01:47 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB453C42
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655290904; x=1686826904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NX4SXzXOcEm6Wa/wGxya5bBYUkYI+YwahbjUCLImppA=;
  b=GSsF1q3+8agKyRbYhnOYE9GXNV9BUMyo/VlZKdjP9Hi9Ac9+QuYzNCkO
   GZHb05uf3IDmu4x5h+XGC0DBc+ZExq5y5n7D5lGW0XbcG29xI8fT+uWc2
   ojlw5tqH0kSNeGvKoagPp/722sTubvIliFso7Uyr4wIuFeyNd3ZjsIR2r
   riYnGiFyjvI5IY3gZnYZsdWgSXaK9OAV2skxbpx6D3p0ZYjZdWs1PVV+l
   wdN0ynlWf9nUKW3pbuEs4m0i5F3VbtDlH3EpiNKZIVOc0qLull3CXg5E6
   Sito3jJug/Me4ROpnh0DWFwfJGiTHIaJjpDmnVUtiZpiDyb/VNjZcb3Em
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="208069844"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:01:42 +0800
IronPort-SDR: QrEeKQ1vReCWgyH18IobbTfBfKQ9WkHte3YrHv3MKSE7nNViQuxXgAh6jm36RTqrgiHEEisAic
 vikV9XMYWTfZTNdEuHJpbrSz0P4pyJkyrKDrVq16DB4uxtA1e1hlgZBPr4ZLU62CsQn1O2wvsp
 IjEWZh7ZYgFE3ivmdB+YXH9YK1RjvF6NHdgyabEDAH4PvcwURMp9mp8TJRY0CLgMb8SFon9H/n
 B27cOlp5p9qphOpvI2tihS3QiwXSaOEFKOI18gfiijzatyILPBMm2ElV+ujtcqjte4+cPUA70T
 B5fslkJDtz/x8oeea1OPvqdB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 03:20:07 -0700
IronPort-SDR: JlbJjlv50Q2Ag4WtYxxO7OgjIRNEPeVGh68ka0/PCUSTeLqczkphgowqn1b6itONlJaPYicV9J
 MUaAnK5dwDbX+Yeo4gCexRcNU7/P7+bs5lVeNc2IC1LLDoBNhorTCSBLYmstqatDiTXhoXWdXi
 b5KAKXsUJnqBwzU8UNSCpseSiU6GrFLjv9nShi51oA/5Z+t3rdemM+NWwkAXK/CwrtKgL0qP4+
 BMc0j5sb6hEvh1QubIrF76+n2y5tDNPr50eq3Df3bhNz+glDDEtDPqoYF9hP0y4UmPuyi9Rfdc
 tLA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:01:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNMnL1Qljz1SVp4
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 04:01:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655290901; x=1657882902; bh=NX4SXzXOcEm6Wa/wGxya5bBYUkYI+Ywahbj
        UCLImppA=; b=T6O853cQSCc1Q4cmoll53tWhQlua3CRnPGD/JHULr+pEpWjg8h7
        0Xgdl1p1eKFllYxujnUn3MuRx05W5yg4eH94W33801uIFWBS8B9RszzJp2zORP9p
        HVZSGFXj5JVVwR10o2jqDeBJ5IvVQgbePcZUasIHK8IWm6QmBkd4ZdVkji1cMrkl
        ydZnuHIvZc3PW48cZj3PH/YYcej3sIF68hcr6jxIE1o8HHqMzHXNmreRtF4+ubtW
        VpLV2MkpVYtuubSm3kEQhuLMCm+BwvB4svyqyRNH9MUWiG5kh8MJfbVqki9g9R0O
        4fondWDP/36O5pyKLGIwjOL7J83eecHT3LA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5obxbOj-Oedu for <linux-block@vger.kernel.org>;
        Wed, 15 Jun 2022 04:01:41 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNMnG1fD0z1Rvlc;
        Wed, 15 Jun 2022 04:01:38 -0700 (PDT)
Message-ID: <f7b586a3-5370-f3b9-72dc-f9bea0b63f1f@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 20:01:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 12/13] dm: call dm_zone_endio after the
 target endio callback for zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b@eucas1p1.samsung.com>
 <20220615101920.329421-13-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 19:19, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore. Call dm_zone_endio for zoned devices
> after calling the target's endio function
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> @Damien and @Hannes: I couldn't come up with a testcase that uses endio callback and
> zone append or append emulation for zoned devices to test for
> regression in this change. It would be great if you can suggest
> something. This change is required for the npo2 target as we update the
> clone bio sector in the endio callback function and the orig bio should
> be updated only after the endio callback for zone appends.

Running zonefs tests on top of dm-crypt will exercise DM zone append
emulation.

> 
>  drivers/md/dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3f17fe1de..3a74e1038 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1025,10 +1025,6 @@ static void clone_endio(struct bio *bio)
>  			disable_write_zeroes(md);
>  	}
>  
> -	if (static_branch_unlikely(&zoned_enabled) &&
> -	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
> -		dm_zone_endio(io, bio);
> -
>  	if (endio) {
>  		int r = endio(ti, bio, &error);
>  		switch (r) {
> @@ -1057,6 +1053,10 @@ static void clone_endio(struct bio *bio)
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&zoned_enabled) &&
> +	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))

blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))) ->
bdev_is_zoned(bio->bi_bdev)

> +		dm_zone_endio(io, bio);
> +
>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>  	    unlikely(swap_bios_limit(ti, bio)))
>  		up(&md->swap_bios_semaphore);


-- 
Damien Le Moal
Western Digital Research
