Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91078C6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 02:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCYCAU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYCAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 22:00:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F551043F
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 19:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679709616; x=1711245616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EO7h67tmYCEDXvXWmg+pG3kWFn9vJA7iFMTngdvUJJE=;
  b=mXZoQBUYBQCqZWL6Qf0mGg8hCIr3t8LLsDi9kyy8D8Ebk4Nf6sJPlwID
   0iYLcBlsOXBr4J7qz5pwO6Y3LPPLgT5g9ztW5LJb44ZxO4vECwNZPdbuv
   Oosato5GhjTptHeLMRQKpLwFc8m+pqfksgw8oF2Tnkaa28uWhIy2RJNqt
   H5BsvYiMF0ZHbW5qGXMIxynbJ/f0tSjbMdXWzFmGhDCrbmAe6A6O4qcYR
   P5tRo4wews7gmmH7LGut+15Jx6N8eLp6ZH3zwBg4PKetYpc4I1xNO7d4G
   vGkOC8OX1Mwo8Yv9+irqTbZqplarVTgIR7MXwPfXKSrS6FgM+/BiDK8gU
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="330888038"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 10:00:13 +0800
IronPort-SDR: TsowbVcBqNM+yVztWAaMGn12wlpvBN7zOzZPOlN+o3MyXfG3r54YKUsQZF8KnJ7mBEjF45HjRQ
 eMt/dMxYNMrSDacy4/f/mi6nUc/9fLVq4gwqlqfTfQU5F1Co0XUj+F1UmGwEGxYGF7ASSiukrD
 Z9YX6pFyz06JudtWs8m5iI0gfjjcLKIMS1u2NMYp6NvSQFJ0NXQjI5Z98DgPiS+vci/OS6Kd0t
 8+lf6bKTFnHOf2tqbMlV6ct99dhCrUgFoxJMH0hswoPTLvf/DTlnBtt+vJoTsR407LhCvcqmST
 QWs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 18:16:27 -0700
IronPort-SDR: fr9SqAIFth4XZFN60hwc30MTVOzERP1IWUG5Yo5Q6YJJ4rBuhmDNBRfX8UCczyZ6WRyIYfxZhm
 av8heQ3vyu8GlpDkiWRQQoZ4NyB0pZeSg+5F51I3F7oQ/YUmMtpUt+yV8JDNM5eYBkaDa9w2VV
 NjItgCtvySN/KQnRUPUbzmNhHzK5wQPDteWpeX3lOw7hJM8JUexJMFUiRzjRFg9/H3TeFrwKuy
 rVUsSDNJmbSgUsvD2gJKlDJGrL6r03TqQHcg5Ele70tEroq86mypADuZ3Z9B5+hxab4REEYOVf
 OFc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 19:00:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk2Mw0kYlz1RtVy
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 19:00:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679709611; x=1682301612; bh=EO7h67tmYCEDXvXWmg+pG3kWFn9vJA7iFMT
        ngdvUJJE=; b=XA//j1PJpKiCgUBjAPcCR9MQMaWiS+urTEw2u9wXmByLwcVKNIa
        XVIO+PGqRjDa0caz8wWe8dvStymijP9h+J8guwbWMDEYXgn02T20czJNrNo5ohq3
        iB+5ehvBhugvnAc0t798wZImNSWkPWf2c4jbr9gjU25cWONgEcEhv2Ra1E+RTpTA
        nG6qjYtQ1esMm/KmFhFeplZt/1A/ADDIGDmzQchVtVlsDu/5M5mlOyejJSV4d8AT
        2hy6vXPmEYq0UbANXHzUCk4fvyfG0ShkiGodlFzUvkU+lgnNfg/uVENuc97X67D0
        8bgybtIJbXS051TVEvTu2WMJnm9Cs5M5mlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3NouF0McxGW1 for <linux-block@vger.kernel.org>;
        Fri, 24 Mar 2023 19:00:11 -0700 (PDT)
Received: from [10.225.163.103] (unknown [10.225.163.103])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk2Ms6zTjz1RtVm;
        Fri, 24 Mar 2023 19:00:09 -0700 (PDT)
Message-ID: <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
Date:   Sat, 25 Mar 2023 11:00:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
 <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
 <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/23 01:55, Bart Van Assche wrote:
> On 3/23/23 15:53, Damien Le Moal wrote:
>> On 3/24/23 01:27, Bart Van Assche wrote:
>>> On 3/23/23 03:28, Damien Le Moal wrote:
>>>> For the zone append emulation, the write locking is done by sd.c and the upper
>>>> layer does not restrict to one append per zone. So we actually could envision a
>>>> UFS version of the sd write locking calls that is optimized for the device
>>>> capabilities and we can keep a common upper layer (which is preferable in my
>>>> opinion).
>>>
>>> I see a blk_req_zone_write_trylock() call in
>>> sd_zbc_prepare_zone_append() and a blk_req_zone_write_unlock() call in
>>> sd_zbc_complete() for REQ_OP_ZONE_APPEND operations. Does this mean that
>>> the sd_zbc.c code restricts the queue depth to one per zone for
>>> REQ_OP_ZONE_APPEND operations?
>>
>> Yes, since the append becomes a regular write and HBAs are often happy to
>> reorder these commands, even for SMR, we need the locking.
>>
>> But if I understand your use case correctly, given that UFS gives guarantees on
>> the command dispatching order, you could probably relax this locking for zone
>> append requests. But you cannot for regular writes as the locking is up in the
>> block layer and needed to avoid block layer level reordering.
> 
> Hi Damien,
> 
> I don't think that we can achieve QD > 1 even if we would switch to
> REQ_OP_ZONE_APPEND. A SCSI LLD is allowed to respond with 
> SCSI_MLQUEUE_HOST_BUSY if the SCSI core asks it to queue a command. This 
> may lead to reordering and hence may cause UNALIGNED WRITE COMMAND 
> errors. We want to avoid these errors.

The trick here could be to have the UFS LLD to unlock the target zone of a write
when the command is sent to the device, instead of when the command completes.
This way, the zone is still locked when there is a requeue and there is no
reordering. That could allow for write qd > 1 in the case of UFS. And this
method could actually work for regular writes too.

-- 
Damien Le Moal
Western Digital Research

