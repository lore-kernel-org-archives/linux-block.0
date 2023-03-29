Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C429C761A6
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjC2XdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjC2XdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:33:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E725251
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132781; x=1711668781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=APb6MZhJtx+BKA0st8ClsB22pp0y9Pqig7XgT6sLxmI=;
  b=lmn3c9uaNN+nkifD2s7Cowy/oo7RJtV5vQ5OZMPI/tI0E421jZh1q1LI
   2WmqkErMD4o7Q04QxDZiu+172f2pRCPoO0CHYHhc60m0ch8PTgLUSVFJG
   DGVOhtt1ahoESK9o30gx1HlLY8OKxCqrzC0dblu3Ixgr67SFxhQUfZ8g9
   x7cQvgLd7WjmTCzPs2b7tAI9CIJ2wIS/1Gg5a4mbJV0cl3z90QboSnHi9
   r5UNZ1pWv6ZS5HsaDRlvKYnsl7gMQgrnGE2Gd7wIMF5PE6WXpoxZzcrB3
   kfqu01SUGGrCrryZ0QOpw323KSX4JBnx2jzDZ6Yx8ld6k6BAV3pfMT5Fs
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="331273894"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:33:00 +0800
IronPort-SDR: m+jHHUscoTmiifQkjCdc0FIundMkkAtWTDrtvQh6TMaA55T1ETQvaSESYj79Pthh0AXgbhhSn0
 6ITmoeOgMovdvSK1BS/zWY2mHIwnE3+LZ+fvsO4rUUjeSqVDF8uPREsXOswUN2z4jEfFFF5pvR
 QcJVu8VlhugiihHjMHZNd2V+cuqH/BIBFBwx1t8YM/TkTgcPDM3+0nD6qZNkM+MWCwgg+gso8G
 VQXx/LN64eD14Sqw1XZpu514Bl8fizIPqYOu+/W7cMwFh/dHOHwXFKw4ePPhJiDcws/6IvO+G8
 eVo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:43:27 -0700
IronPort-SDR: Dh1UL1NszLLbhQGWbWu6hpQ+g+ALLmqvP34TywGPwGTeB8Voo+3Pv6yjR/NPOeAdLJcEVA6E2J
 m+y16IDAExR0tq9rZk2Efw3+hWfhBDKv/ZRAyKv56VGK8fFSiyx2exe+ImYtyrJ6qbifOlLqQO
 7puJ2uy/HhWgY38Eiobsn5NZRgucHb46Nh7ymjL3pYSx2zi59umfFB1hWznom/3+0LAuyH3MfK
 fJVX29KaABJSffjD3fKNXsp7KEVl2u8MbVrdvPbUdPovh0smHkfGeKOaR2IQiNTe8W8Vx3DbGh
 UO4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:33:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2sl5bBhz1RtVt
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:32:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132779; x=1682724780; bh=APb6MZhJtx+BKA0st8ClsB22pp0y9Pqig7X
        gT6sLxmI=; b=EYPDnYeYBXvIPZU4yIKMtwumuioUV+FfuJ8fPXn7WoGbUKa7gK8
        7zyK1PX1ztxSUnflTcanHerZGll9o1DObBU+bLHw03SR356wtqMJKa09n0qcvgMS
        vZWj5aB/mrLRcKD+ZLaMWZavI1BMEp4d64WqsbKtIuhCcLZQRoyst2pdWD8Q3ya+
        ByQ8/RWystsxIVYmNeYNkH7soMStSvU7GBy5Z6O0BckSLdQn+7R88KD6YesLFa8q
        MYecYOCLxyWkIdz2hhL6x1SyTg5ktN5Fm733y5g6M9KOTaT0AtP36cbIMuLZhZ81
        iYFb15wzt+oKQjUeF0cNSTKYAFDWutLqRVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AbcmzRhqVTZw for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:32:59 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2sh28h9z1RtVm;
        Wed, 29 Mar 2023 16:32:56 -0700 (PDT)
Message-ID: <93331778-cc12-5d26-34a5-7cd8834a0309@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:32:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/19] md: raid5: use __bio_add_page to add single page to
 new bio
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
 <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The raid5-ppl submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked. For adding consecutive pages, the return is actually checked and
> a new bio is allocated if adding the page fails.
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

