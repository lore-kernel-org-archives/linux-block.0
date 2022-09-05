Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D023ECAAD5
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 06:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiIEG6F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbiIEG5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 02:57:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A0255A5
        for <linux-block@vger.kernel.org>; Sun,  4 Sep 2022 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662361044; x=1693897044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KVFa7AvEJ4KW0XYV0S8jEkuBJmlf3QhccAyRTJ68zsY=;
  b=a1+Qsh7mDLoZXETuir00jNxXVzcwxDka0vyoMjvJqq7OunJgiYAJ7wgo
   cO3OPeHJoAClEidbXkl0zfCM8K+88K37PaLbCB2pn3fVQaCvOz+rodIhd
   9yWIrn8qJUrVuwoh07A+qGROzT7aOqhOLMoPRY42mR92lW2XXteBdd0UY
   ynEzj1DrCFjKfxDkZS97wwwQe/Eq/2QWeUbYneLqHlLu9Q3YPL4cje0QH
   Rl1arClTD8eZcE/Cp6Qn2/3Un7ID+LChmDZqDubhifyyczV21GETf5OT3
   kAVhYrLnH5q4dBCoiCmp8ffKPEnxK7GbsFhIoVCvyS+wZH8tyApRKO6cY
   w==;
X-IronPort-AV: E=Sophos;i="5.93,290,1654531200"; 
   d="scan'208";a="210505362"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 14:57:04 +0800
IronPort-SDR: ZMEqrYCubEspgk0ts2Gaf0Mq4ZGUDB+AqXeJ4RcOsYVtgFifS8BT+z94UBn4uL3pOvcykFtsHC
 J7Mmd6nhbWEf+AFMqTSVJy+kY7aqllan5F+L5KWIbWVWM8Z2kWtjzROtqgEQtkvSVFF3tHW0R5
 HAWcIc5wNPRO/6fZUAKnDseF2PiSKzt/JIhwwENsXmMpIZCULzApIuWaH4dpxzFhdmTK16dAk3
 82f1kfytOHqjH6hbXerR7jQse4YD8lr2BGGcR9aoGGhLqWJ6pj+3i7nddqeyO9cfk7OGnq3tjv
 5Wfuf+YG58YLj+hYKls6x1h/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2022 23:17:30 -0700
IronPort-SDR: Jsm0P0Pgo2WMtOqANTUQ5aBsvYxtMmOlqm/tPlsa9Arzo6Ml+Kd7LQABPr4XO++lNJQQSqqqar
 s+JVTApxVsmVf0Ko+UwHgelxMkLIhXaXTYYPsxymGsZATHUVsuUk4Cb4qYklVXhX16gc271bXS
 6pGdpHl5AV2vv1d/fahbD0bisLKXpOIKQIo/ZpnSIVoY/vgdNehnOlltyTPsyoJB1kk8C3G8TE
 6y71LLqPu+jNf4lRymoK/VOvLPyuTJs2XB+4OcbZwnEYir/ZHF8EsSW+k+j4dq+KM3cXh6XZoT
 hGE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2022 23:57:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MLfTF6XZZz1RwvL
        for <linux-block@vger.kernel.org>; Sun,  4 Sep 2022 23:57:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662361025; x=1664953026; bh=KVFa7AvEJ4KW0XYV0S8jEkuBJmlf3QhccAy
        RTJ68zsY=; b=DCl1fMhkIOYiScICM3/wtd4aoEzjS2ALfcSQ4Pq2g1w6pybNxI0
        tqOgmzqksF3ug6dP3mdX47MNRVaIwjVCq4TazUFUUMV148BCRxj6VyvQHJaYz3to
        yHCvBhxWdXiWYgRkTw9WdF+LEs95gytNqGbnzvtw78D0LYnRYFzm3lcr2gtv2FJM
        8XAPyKCj2q9sAlv72HNFtZYlRecB9gpqE/7v9n77P1O3/sWShPA7zz+ALC1cyOD9
        93vp5itn8kDXCq+m1nCA8OCofnTGUbCZbsMW9zC0x/nGx5xoRhVl1bw9BbAQW9C3
        sjn02U1lu6Ni1/ynM6DS+4V+bpYqoSCsvFw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M4bst5t_zfBB for <linux-block@vger.kernel.org>;
        Sun,  4 Sep 2022 23:57:05 -0700 (PDT)
Received: from [10.225.163.60] (unknown [10.225.163.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MLfTC1mFSz1RvLy;
        Sun,  4 Sep 2022 23:57:03 -0700 (PDT)
Message-ID: <960a4b35-347f-1f5c-74ae-8f7c9efb7d36@opensource.wdc.com>
Date:   Mon, 5 Sep 2022 15:57:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-18-hch@lst.de>
 <c2e15bee-cd4d-9699-621d-986029f337b6@opensource.wdc.com>
 <20220905065008.GF2092@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220905065008.GF2092@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/22 15:50, Christoph Hellwig wrote:
> On Fri, Sep 02, 2022 at 10:38:50AM +0900, Damien Le Moal wrote:
>> On 9/1/22 16:42, Christoph Hellwig wrote:
>>> No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
>>> splits and converts them to REQ_OP_ZONE_APPEND internally.
>>
>> Hu... I wanted to use that for zonefs for doing ZONE APPEND with AIOs...
>> Need to revisit that code anyway, so fine for now.
> 
> We could resurrect it.  But I suspect that you're better off doing
> what btrfs does here - let iomap submit a write bio and then split
> it in the submit_bio hook.

Nope, we cannot do that for zonefs as the data mapping is implied directly
from the written offset (no metadata) so we cannot split an async write
into multiple zone append BIOs, since the single aio write data may end up
all mingled due to possible reordering of the fragment BIOs.

But the need for a split can be checked before submission and an error
returned if the aio write is too large. So this method of using the
submit_bio hook still works and will simply turn a write into a zone
append if the file was open with O_APPEND.

-- 
Damien Le Moal
Western Digital Research

