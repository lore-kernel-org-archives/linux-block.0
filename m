Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C6CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiF2Gco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiF2Gcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:32:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3857F2AC7A
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656484360; x=1688020360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o1/EY/w5mHD9gm+yafv5BzL2x65fugoUcJKTVZbpyVc=;
  b=eGQ8EuM3Lo0atZYUg6u0WHGFqO/iTOZxpqRPJ+xp3KvMncVUMORs85RU
   YvSOv0kgQeKHvKtohJz/kzqQxNMdThMrwT6UEYKlJ8RkRAC6Y6gao4SI5
   nEZ4E9/t9VA+zm5Xj7+NiVSgvXDs7CTzZaIUfsvXvlco1JiHaE5nB9EDa
   Wt0GokXmxSQ+AG08z5SpPOEMFYvoHuSo/lUjvfSG2qqJw3ANRzvB0HP0S
   6uoeXwaLHRT+UOkC5EjBWf6pfFRrQz/Vh/pYmwaEUjVVItwu1M3WvLPwj
   ioCIDTRlTbw3PNtCo/IVcY+PtO0bFqEF6z0YxUVNpGKLh+62W/t8+pZi5
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="205089151"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 14:32:39 +0800
IronPort-SDR: ftcpOa9ZooAG6xlItSH4W3bdWei8shckbzCYaIyyoFu6+5Ccr73W8ECWAcvn1giNKQ/X7zzqht
 O04PyQb4wWJmdUCkLpp+FytSG7RizJ5X1ZkVEK/f4B7sdsc1xCTcbiEt8iOwne9+FiVhpxxgtk
 UjDtvXPFZrpMCZHp9d53sHTrLGBr82eiBI9i70mFILdGLO90TUfg5i3wgACm/WfvhM/r0bq8Ii
 1SLiLkHajlFxGCZrT9sJFY/zl8brxrG9w9mpF/QZjMdUzUFwHZ3UE4k9Lbzgfl6JZHgajqeyU8
 0ckdNAwZyqNlhraJp+EmHQLx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 22:55:00 -0700
IronPort-SDR: v6uj/87R5L8I/XY2RzHnaaLeO8zb0upOYRPeS2WMbEWV/aZ7He+RQdshANVkJA3wzZbKE5mWO3
 jyN9KHIudvDe9Sxc8ZpdIGC4zqpWkKG7XGbKynP8pxPblY1Tporke1+260T7VSXi51IcGGFC1o
 4RTs2XapljFFZIlGT3JKZQyqZYG6q/dNxUuhU/VdMd0gfMn7tA4kBIu44iaPT4H//poKlFO2wr
 dtEk/BJsVVx89Z7SuhMbiJ/nxJkXIQHmy5DnKhuU8cf2RMzjWLJvHIuR1NDCn+dgElaz7Padhw
 Pns=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 23:32:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXs8R1dsJz1Rw4L
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:32:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656484358; x=1659076359; bh=o1/EY/w5mHD9gm+yafv5BzL2x65fugoUcJK
        TVZbpyVc=; b=MHzimPOFWY9/L40B61Pr3hyzlirMuhQ7E+QD8XyuxjbIbBfYI1H
        7OzRKF/NFCSOW6oiU3tnJfcxoUMqA4IQ5fg/ks0MRMJ5SrxFglJs8BrQY0O+dlc6
        hJdDU7fcZ3hAar2DaTnGeNWRjcZtHBmdrKVlUEF3geQfTnCdFE3Em11jIOE/4o5D
        ndS49NyHHrb3EZvFbEZBE6RV5yOJTMhjJ1NKe69N0s60GWiyzcKwMAgbec0ltstS
        sONRvvWtDJQzqPPE+I1rAdTQLtB3r9m4JT7c/DrtqN5MqDBONvU+x0xJE6VMkD7W
        GPIaJKL0Ae1jmnmOJHmrA+CecxiKnIjc9Hg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SNupj0MN4fpY for <linux-block@vger.kernel.org>;
        Tue, 28 Jun 2022 23:32:38 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXs8Q0WfLz1RtVk;
        Tue, 28 Jun 2022 23:32:37 -0700 (PDT)
Message-ID: <7cc69dfd-0078-dd2a-794c-a5c5a9073f0d@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 15:32:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: clean up the blk-ia-ranges.c code a bit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org
References: <20220629062013.1331068-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629062013.1331068-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 15:20, Christoph Hellwig wrote:
> Hi Jens, hi Damien,
> 
> this is a little drive by cleanup for the ia-ranges code, including
> moving the data structure to the gendisk as it is only used for
> non-passthrough access.
> 
> I don't have hardware to test this on, so it would be good to make this
> go through Damien's rig.

What branch is this based on ?

> 
> Diffstat:
>  block/blk-ia-ranges.c  |   65 +++++++++++++++----------------------------------
>  block/blk-sysfs.c      |    2 -
>  block/blk.h            |    3 --
>  include/linux/blkdev.h |   12 ++++-----
>  4 files changed, 28 insertions(+), 54 deletions(-)


-- 
Damien Le Moal
Western Digital Research
