Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1DDC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 03:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCUDZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 23:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 23:24:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0E212592
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679369097; x=1710905097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gcqxc0l/1uaXqv/zuhql/n8qhOG0iOornA0vd4q/vu4=;
  b=cgG8FH6lXcunjJwk7g+AEfhdkGHYW8/iQf5+XzcgouBlUm1qbcDFxR3a
   MuExLQtKH4Cqd9C+ZBGM0qhSpHBCmJtnnaWpWAhWBHCExgrIOxW3/LWLB
   QgXFVPsYKa5nzReiU4vcccbv2BpLVfKQietdZdjyvjK/Kl/12lWTfLjBY
   gFmg/7ZKwfZr/5J0hYVyBjmm6VUydlzwocBgBpKlUZqQu19K8U4VL6Z38
   yjrpJ76VLj80M21XeTwdw/YojWRCkiopDt0xJJCQif79yYEdOARqtN1md
   bbseEDyV3FKRdxvfEMKd47fHsy8+qE0yeuWR9FkMc0NndQek94qNo3qZ/
   A==;
X-IronPort-AV: E=Sophos;i="5.98,277,1673884800"; 
   d="scan'208";a="330510906"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 11:24:55 +0800
IronPort-SDR: BKJ2v58RJcJ+/3wTcHAdTsSiWy/8pbkiz5VhFXxXOcRR5pmSPgaIvN7RdaA+tZh+ejuDwwnu8r
 yifJy8KLz5/obLr0So3PBJ8eDVX96MlBEcVBRn/y3bD1KXE2pKgCb4OkFeu/fEdjzTknDP7Vbl
 M22A3A4S17nAXjd7+KpuHpMNMsRwkiXRh7YidX28DZ1w1TA3Yu5zOUqS6pHmkzBM2+6bGqw4Wv
 hStCdRbmXFG3DqkJ3qU7CM1Lkjex/8VAjT8JfQqaeGIylDZY2dmTnTXBJw6zlrNLPlz3kVt/gm
 voo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 19:35:35 -0700
IronPort-SDR: XBw1GkO0t9D8R9r3IfaSjGtwtqp7oDnqwHmGUcYxgWJxZuG9699TtrmKDCG6rFP+ZtLdZ13Y5s
 oE3hLEicTeCzJCcemW7REvtokwtg47x+5jXr4iLV9oF532WZevqN8ECCOSoyzw0Jk8XrOKVdlH
 tA24vwjp7yEIo5XNZnr9y0haLaBVBlve+sz3dDqQv2OiJ+A7XKwbgrFHXaH/kUnMISFmN7nQBU
 N0RzjMvFwOsdirD0W44T47baq1SXpXUVLxd+YYvZ36CwuiZKfALTDTAc4dFDpeiParcU9v/UWG
 AHk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 20:24:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PgcRW316Mz1RtVv
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 20:24:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679369094; x=1681961095; bh=Gcqxc0l/1uaXqv/zuhql/n8qhOG0iOornA0
        vd4q/vu4=; b=VhqlfIfBChMu2nKFIEZrSHPwWEq3j3m7JMi88rg5ip5DWWNq4gp
        lR0ryBcUGTHUWVDIGzqCpy+IllTa4J9pIIKKOUUxdxm4PaudgXwWZZSqjNrlhkNE
        8G/QluRwhKtLGR5lvF9gQg0AgRQBLdWSqoPIOLrriiTBj2gl+aPiUp9Nv+bwvgik
        mxI8hcFcVRp69phLPgoaCzRlFMMo8viUclb/QnitbnMTmPh73mMuRCOVc8PSz4R+
        MOnc76WhNlAyvgyd4X6u62YgRIB2Nuyf96G7ZShY/+yXsHSmFZC3sBgD5x1yhzDZ
        52VvKXauz8c5L214nu5szdGl130t/bhhR+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ocARq_cmh6eI for <linux-block@vger.kernel.org>;
        Mon, 20 Mar 2023 20:24:54 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PgcRT0kptz1RtVm;
        Mon, 20 Mar 2023 20:24:52 -0700 (PDT)
Message-ID: <9c74df25-aa99-afc2-4f40-3201dd67368e@opensource.wdc.com>
Date:   Tue, 21 Mar 2023 12:24:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
 <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
 <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/23 11:17, Ming Lei wrote:
> On Tue, Mar 21, 2023 at 10:46:30AM +0900, Damien Le Moal wrote:
>> On 3/21/23 09:44, Ming Lei wrote:
>>> On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
>>>> On 3/20/23 16:28, Ming Lei wrote:
>>>>> On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
>>>>>> Thanks for having taken a look. This patch series is intended for
>>>>>> REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.
>>>>>
>>>>> But you are talking about host-managed zoned device, and the write
>>>>> should have to be zone append, right?
>>>>
>>>> Hi Ming,
>>>>
>>>> The use case I'm looking at is Android devices with UFS storage. UFS is
>>>> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a
>>>> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the
>>>> queue depth to one.
>>>
>>> But is this UFS one host-managed zoned device? If yes, this "REQ_OP_WRITE"
>>> still should have been handled as REQ_OP_ZONE_APPEND? Otherwise, I don't
>>> think it is host-managed, and your patch isn't needed too.
>>
>> Ming,
>>
>> Both regular writes and zone append writes are supported by host managed
>> devices. For ZNS, zone append write is natively supported as a different
>> command. For SCSI & ATA (and UFS) devices, zone append write is emulated in the
>> sd driver using the regular write command because the SCSI and ATA standards do
>> not define a zone append write command.
> 
> Thanks for the clarification.
> 
>>
>> For BIO splitting, splitting a regular write is fine as the resulting fragments
>> are sequential writes, so all fine. But zone append splitting is not allowed as
> 
> The current bio split code may not make sequential write requests, and
> looks Bart is trying to address it. Then looks scsi zdc emulation still
> requires sequential writes aiming to same zone.

Split does create sequential writes, always, but the processing order may not be
sequential in case of plugging. However, writes to sequential zones are never
plugs so reordering due to plugging does not affect zoned devices.

> 
> But I guess it is hard to maintain bio order, especially md/dm is
> involved.

It is not that hard once you get rid of plugging, which we did. So far, with
everything we support, we are not detecting any issues and we test weekly, every rc.

> 
> Thanks, 
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

