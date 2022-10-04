Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D1C433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 22:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJDWko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJDWkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 18:40:39 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309F3248D4
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664923233; x=1696459233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xo6PXsrm963aNNXHkP/RkFctw/Yh7d0/8hzr/zck+Lo=;
  b=QX3/HJV0O/WeY0prdpOx7hzT9s1x2WO5UvYM8/dk8xffpojaP73aA5dJ
   bZMx+oWEIB7c7ER78R1fO7JxnLqo1PhCBNmlkTEBcrcgY22RJthFD/+JD
   yyluV70lxFkO9SAO46sEMdLsfFCfTS5J/yer1mXByGaoxKfvzpaJJ829X
   xsRntq/ulHZ9gp6EUqhYVjywX/Bqn8ALZfMVduzmbaqPAACjAW62/5dVI
   uBD5jAP2p1oT7dyKaQRkswIaZA3SLjd8MfootBaKaJMez6Fx5rf/gwy/B
   sQiWT1ATVj03R/IS/CY+6LDHVMn0UNBKBcLcA/6x2ZQmyzoZ2KyeANH2m
   w==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="212994335"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 06:40:28 +0800
IronPort-SDR: dx8w8oMxm04wohnHDmO3zlVUJ12CSYsNDdi8m5ndUM4WxDIHqgi+F4quhOuliyA40sqNg7wkbJ
 OVAmwO9mOiQBtF43bsIjzAJNnUZE7F3MyInOWxMGYTKfEZwIDpibvVtwh65HKjfnKNKRy82B91
 g/yAnQL87qffRs/MsspON/0cOz9DpVLKOCVGuZCraLEEkWXDqLB2r1K0JxDR0llOqLJJuHXMnG
 eNoS6GIPpJn+5g5Y7oGtzSVxuSx4mOzlWEkAdOOYlFcQZV+qIY1qkXn0SrEre0Q8BroOQxr678
 IB6hFLODqKAO4Mbz2XNlsI2r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 14:54:42 -0700
IronPort-SDR: PgQNK+oNHzqWM6a9tIpHoKFQkd3nttegaVWzPEPawe4er0pFoCnesJkD8JVXqrMFgkfCQ9visw
 Fly9X/dz8Yzt52yf6cVmAlhx98lG5GA3g5lV71cDvfjwu+Qfk4C4UCedlWP22BDPQrmMKN7vLu
 1Ib1d0awJ8GaXxCs2OYgSk/pcRz9Z3HtX38Y1HgksIR7KWpWqySsuh6/Zt2TVRHXfKsGszDxGQ
 yi8SCndq62fHkQoWq6bL5QdKDz5kTJoIZRRdtq8J9GHp1IOSwLhHf6GN07iwazqAYe4MUAAxbr
 9CQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:40:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mht2N5jDSz1RvTp
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 15:40:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664923228; x=1667515229; bh=xo6PXsrm963aNNXHkP/RkFctw/Yh7d0/8hz
        r/zck+Lo=; b=mo51zzHaiGoIODP83ULRJiipIc8J8krv/YhF2eKwOnd6VZFcxAU
        NBsrHzBF6myQDWPVNv+0yWde9qfYF5tFsCP+AJPSerNE4NRbPx7i26835CiV4ju4
        X2XvhkIlzBdjVz+kXdPEa7ngN+EhCMSPi/zGupJimah1C8E0S43ZpX6zp9dlX74y
        dj3XQq4TunTKhxWZ1WDpStZzBh8Iid1UjVNknpZHpdHcBttZw2myLdKe4nQskz8C
        kpUppfXwJMhsemjsyJvk9UgtUC3YuLxbYHtm6Q86rXIpFXo29fhFnOuRtm7WphFv
        VkxHA1V5s+GdcsZelq2M566BTMo7clOez5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 89x7RS9dUkbQ for <linux-block@vger.kernel.org>;
        Tue,  4 Oct 2022 15:40:28 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mht2M5VC4z1RvLy;
        Tue,  4 Oct 2022 15:40:27 -0700 (PDT)
Message-ID: <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 07:40:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: allow specifying default iosched in config
Content-Language: en-US
To:     Khazhy Kumykov <khazhy@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220926220134.2633692-1-khazhy@google.com>
 <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 03:33, Khazhy Kumykov wrote:
> On Mon, Oct 3, 2022 at 11:12 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> This will allow a configuration to specify bfq or kyber for all single queue
>> devices
> That's the idea
>> , which include SMR HDDs. Since these can only use mq-deadline (or none
>> if the user like living dangerously), this default config-based solution is not
>> OK in my opinion.
> I don't think this is true - elevator_init_mq will call
> elevator_get_by_features, not elevator_get_default for SMR hdds (and
> other zoned devices), as it sets required_elevator_features.

OK, but my point remains: why not use a udev rule ? Why add a config
option to hardcode the default scheduler ? Most average users will have no
idea which one to choose...

>>
>> What is wrong with using a udev rule to set the default disk scheduler ? Most
>> distros do that already anyway, so this config may not even be that useful in
>> practice. What is the use case here ?
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>

-- 
Damien Le Moal
Western Digital Research

