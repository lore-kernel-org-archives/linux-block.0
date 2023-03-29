Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F30C77B60
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 23:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC2XaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjC2XaE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:30:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC11FFF
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132603; x=1711668603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Y/8nFwSzVjprTaZ9/Wyk96kEMW0qhqMfVVhpdupNbM=;
  b=f5nJq44j3PfCMj9yotos2QGi7WY4mEAZDRCwkJPRToRfFiDNiG4FvMbQ
   jPBpmJoSSTsgC565gAHt8bxRS78Eq/exgk2Z6HTV0oIjr6mUxmze67QVC
   qF0QLzAWW8x2eb1z2uOUWbJ435DjL/g2O1mlT5X5IjZlz7rw/zL3ldnnb
   1joJ2jTaeWa3EwSkSoRPzh3s2RWXsIJ8YtZXjur67msA1G49cxT630jCP
   4hln0L06jiRIjhhdz4RbLReKjfwA6yWcJvaOzogRMBK1oSBFVMEBjMDYo
   FGAzfXszy/6v8YxxsQIvu4TbJ5L79hHJugdJdsixejSjRmMLJpND/v0qg
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113380"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:30:00 +0800
IronPort-SDR: 0w3wYxwjsm4c+HJsZwRQbe/AZ7fH9oPWVjRQbz0B2H1hiLnL3C0Lzf+iZy6m6AgBNmWwjGL+Fw
 Ri4OchFkQ8BngWqH+rAs/leRzV3PqVGliXH6T9nptTLzi7z9Z54kPIyD0FCXg2PUEYASN2+eoz
 PiW+AP6DCOfDOi7RTvqB1Fuh1R7e0JIUb9irFRkj6VXfxlB1z6qrewrbIJkm4FQrLpiG8LNpTK
 7Jn5Q0OD7mMNKe3ckB8T2XocacoBafLP3y/zqdFI72/tgMYTLaw0evPjEkAHzCG2NY0lRkoE1u
 Ia4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:40:29 -0700
IronPort-SDR: YUgXtvQj8vBkfXZT0tBtARZiGsXHHMX4sKg30+Ngoe/Xr0Edlk9WJu6Tf4lf7wlmYOOJsqMIt/
 byIXP62FmlAz8s9TP5bFFgEzp8M7Tv6Rezbnsjp5i5CfroRgjJFpgXOwMpYzIsw+egSUo7cuu9
 nbExZdmfTnqOBzaeXxJypcVX1bNWVCnup/3sdDx9/9pOOn/zbgfx9sFB6su844qXB2ttr5Ohbd
 WNirxODz7VPDfP0f19pKFrhSdp9Yllg2gmQkPojo47WwUDcEkgGBZ1/kNGlPn28sTG+UNFSHEV
 FaU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:30:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2pJ39BBz1RtW6
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:30:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132599; x=1682724600; bh=/Y/8nFwSzVjprTaZ9/Wyk96kEMW0qhqMfVV
        hpdupNbM=; b=attI7Cb1FiJUfGooWKuUBF69nVtx8C0v6ZnYPU/aallwnH131e8
        koFS+onmiGvEVL5Rsy8MD8W84BqTFny7oW+UX3Q0EgmJyd7MjsjVGq5Fag+o00/p
        kBXyOu8rVI1MppDWnwv1nSsJjZgW3+f/JtpOKGfbDSqhjxMshlz8soCSdqYWdxyR
        mZbB9MxATuHT290hQKyTcBQsnd1Zs0bx71V0NrVJwmHkHSmV/TllIeaQKFtE+uS6
        +2zu64x2THYHjMlElnTspmwc+eMYbDW16URD8fpUN8smUWhlgc3H2/33t07voR+F
        ONOgbvSndu0231MHqn3BP6ebhDrfi+c2eNQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zb1CqHXLP6BG for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:29:59 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2pD1Xt9z1RtVm;
        Wed, 29 Mar 2023 16:29:56 -0700 (PDT)
Message-ID: <ec7a0c67-a0b6-64d7-0f3e-dee9744daffc@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:29:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/19] drbd: use __bio_add_page to add page to bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
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
 <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The drbd code only adds a single page to a newly created bio. So use
> __bio_add_page() to add the page which is guaranteed to succeed in this
> case.
> 
> This brings us closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

With Matthew comment addressed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

