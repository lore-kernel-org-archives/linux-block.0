Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C08C77B62
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC2Xee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2Xee (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:34:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00D12D
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132873; x=1711668873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ma+GEPR39SMifngZ8BJHd5lgwaD86YsRlpp+x2qXieU=;
  b=lwdid+FiNYyqZTBUUcKMs08bK/2Mk8EyPErScaNSbSjbS++QrrEfotk3
   8+j+yfehgqXd18fEw437dxEfrvWOKXrbn5IscTOBIBjyBnFSnLg2DEYeQ
   9NZ8ABAscBHInvGCcrFxr6OJivTwC7BkL7rofM4yqr9AvtfI3PwV4m5/H
   OQvy/KMGz5iRy1uDt3oLqj4PlyALLyRqL8oDGQd4oY6y+GkRy8YlZcOgK
   eNbBPvWRGPvx5iE9JEH0w7kU3CemNuibXSbtvlgdd5gS26KBZcd5b1qyP
   omHTK7MAL+6r4FTSiN4HNx2e2yBjScyPJN4Dr+oS6MQVMI+boc9GJIN2J
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648288"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:32 +0800
IronPort-SDR: 39Z1eiwY87opWtWM3KHisR+NsrU4tECjgZHKyizej4uyTrDDCkvjyVT4MzTzFjziiFI96ofVM9
 pbudv1/HMQyu8MnD12HUy7Nz6pqolivkuPwD5Ah7za/oL+6HDG8UqtISE6Tqd9PG/Tx8O/K7mG
 /UI58L1lC/ljNXx+p2S/6S/TWGnh7n04XaPhtM7l9IRPGXe+fSNrKtxWY5LBZ8xkU3wB4PuqE1
 Et7AZ6oDg8lWShgZEi5k5K/n4JrUS0kRpA1jGMqCRc2E397Et1ANKUtk/S1OuR9ig0uOeReSSM
 F1o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:50:40 -0700
IronPort-SDR: mWw/XC3CSYwYhK5os7Gq7fE0ZtxzcRlgXnY1Zer6WWUmqB+QcIM8geNcraOBZ6xdf5R9JHqTSc
 X3lYpb7tsS2gzvDJfjIepvdC6SSnrOA0qxb8IseRAH6qLtMQ5EaXd+5FsxgXcQ9VUk4tkhPz/a
 dYii54Rp3eFcefKNUZvbwyVBXf5aDUUTs8WxOGNVmOKB1ccQw02x8ofE/JxplQz9Vghzi8SkKo
 vvi1FBMFjMS0q/tUzF1FVlRaQI4YxpBYS8jg8sZ57uOGKzCTpIp+4xdZjnbN+fjaoZjVxicmtl
 zqA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2vW6Rg3z1RtW4
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:34:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132870; x=1682724871; bh=Ma+GEPR39SMifngZ8BJHd5lgwaD86YsRlpp
        +x2qXieU=; b=fltjWhcTro3tBLErFz/FZKkzG2DRnrFpnpGJoq06RhvP/J7AK4O
        7Y13aBEddFYPLh9qRwO0kXfog8r+uI+ZEpj3mepNN45RU6pAx2fur9TCfUY6gJI1
        6dh+CAboV3J8Z+TMCQcResD4WNAFsgSD75rA+uDcCBgSl2pXfdspEqVu2G3lBX+d
        yOF3uiVoBgS9RXQiGvI0lrLCKxFf7VBP4RZM/qK3Hpc10swa4bYr8meiIO5g+tR2
        jNxUg/dF7XPNmm0sq2Anptg6+bujSCGgAr6I2EsRid+qpoqMwnWUw/TZET6FvW7R
        EFsv1nA6Q5z1Oldh2VB7ChRoWKk1ezNKX7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ekPHuCZdoqK7 for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:30 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2vS0ZGvz1RtVm;
        Wed, 29 Mar 2023 16:34:27 -0700 (PDT)
Message-ID: <d07c2d82-0edb-6bf1-b97e-07cd66a33bbb@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:34:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/19] jfs: logmgr: use __bio_add_page to add single page
 to bio
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
 <902f83de56c67b333959d8b8b4cf37a25414e927.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <902f83de56c67b333959d8b8b4cf37a25414e927.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The JFS IO code uses bio_add_page() to add a page to a newly created bio.
> bio_add_page() can fail, but the return value is never checked.
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

