Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15019C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2Xdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjC2Xdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:33:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9C4C13
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132820; x=1711668820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2XfkCsgwrNyUw6t3bN5epvi5ctQPl/PkBM51tAE2KI4=;
  b=LZMxkIFhvmE3CGmJctROf8J7EaYwhR6L5ejzcEq2xa1zXp50iy4QiSXr
   g4AlpLK7xs0iLQQ4bn26riQ0BfTqcdlQWBFrGTQ+VoThO8AcdMYzMKDO/
   bcgflrGfA5jtUWhR6ysGA5ayQDMJAz19ElRPBQMIP2QULOWRXO7Ik0SYC
   DrXrMfWdqK8XJww1rTN1//vpiwVevKEnSMOIHwaUnqvQdOctG0t/uAEvn
   lFxY+yLiDr/o6jM2uaue288Xf3MI9UO2KQGyr3+5MwnFUHKMqTvb1bgxm
   xFZ3qq/8EJKXM0Kob8pSsl1QK7hs2ofkE5EbPucA1A69coEl98LGTc1fr
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648228"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:33:39 +0800
IronPort-SDR: sIM9Nebt11knxVPOFzwODbiQl62W8r8KOJdGXN7+3+Ib+dffDY9cstsuYOuARLdGaTiuc8cAcm
 bXDKQ9pIOMGovaxccTY5/807jCWE3qcaAKEAHpTUEKTTojy8188jGOMONiCbeQFouAZIPLNRIv
 JRafYyBIA/0ivQccycSu9/LBmklnd2rZZxFZdKL1MX8PGYci6U+stkUEkQmVOnCpjhhWGQEf9N
 /fDrj31UZ3bYyTlAoSzXHE5fkShjHgiiR/jLBbafvqaxDmYDxaHRaRmS8ASpQH4wSyKxftKuyT
 w00=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:44:07 -0700
IronPort-SDR: VvewSW1M5KG/6b1begqedpSzDaN1RqD1bTXWuRQdy2sh8v2NCgADKwgv9OzJFCyr/gI/q+BYmR
 HaHYKKf+CDj2WPLeB9+ix5btbWszxdhswDU04DuiBXtZyEJi/+U3ccOiFN4ixrQjDT0hjZtl21
 u5Wqqn8PrNAJqSrkUz/nhz1toTmHbHLQOHMUb/0Bq6xFK5aosfYXsaPIPlAnzkM9xrL90YzloX
 mPfOsFBtlPPiMAy3F3mv+/VdAFRjxkM6PeXHFrfKoI6FLUWH7pBb6hNVJmj928zjV7kiJMKL71
 Zqc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:33:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2tW1LKqz1RtW2
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:33:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132818; x=1682724819; bh=2XfkCsgwrNyUw6t3bN5epvi5ctQPl/PkBM5
        1tAE2KI4=; b=iL0pOV79abCn58O3GsYB3incxhwrPGLAZGI7X+0lqN4SQQeDOnB
        qJb7+62q5R7L5egPIr3c45AiogLxHvyE6Lwb4X+ABQD60bWF9q9d86DXH9mxAomK
        Qu2grIxrBMnxXiUCC9/WpTKWZywUMM3/M8INQgOE8mZwBHEVU6DB5WsHrjzo+Sn/
        1V6s1+NZHPGuYuWBRZO8OSKChosO5Hy1NGf3W1IvjZty3XmVtff6p8XfHJ30Gaoh
        4l9C78DP+cf3gRR2ZbpYL8pkpDSGf79rjnBmncsC+8xVR7xVsQk0BA1KeF40WXti
        HbeBREtOM52B3AwqaTea8N47bzscm0SsNKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m9i47E6dTUqN for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:33:38 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2tR3Vpwz1RtVm;
        Wed, 29 Mar 2023 16:33:35 -0700 (PDT)
Message-ID: <922e7921-c70c-cda6-aa5a-07ed44596d4b@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:33:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/19] btrfs: repair: use __bio_add_page for adding single
 page
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
 <faae16612c163bd6e65cf3d629b0a3c65666821b.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <faae16612c163bd6e65cf3d629b0a3c65666821b.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The btrfs repair bio submission code uses bio_add_page() to add a page to
> a newly created bio. bio_add_page() can fail, but the return value is
> never checked.
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

