Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51632C6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 01:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCUBqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 21:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUBql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 21:46:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0D2B292
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679363199; x=1710899199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=67MPh4PA74oDyONsWMMXlZyds267ChMqJ/afy8bb1jM=;
  b=caEPwasZ2kUC2PESHsCwYKjP0tHAVrDfBA8DitVRj9G8FsJotFivk2qv
   cpp+leQGyAXxEV9CUmhonkOmz86BL/EH83L2kV+UmMIoKutrsI/Ps0pmT
   5arlaCH3YZi8GAZFwlGL9kqdyP3rucx2MKZurpB09BAqfAd9gTtihwZ7D
   pYUIUYvTc+TcqaiVfa/9cfT48SQZK5hKpda7cFUIvC5/ubrq9XXf0/+dq
   dNhGQly+6+RqU3Kj+Wc6njwQoyes2fwEE7uSD7kEQZ6zSkALE3E5zSlp4
   WrOtzX7hp7tnRbe+S7hGPKPojWXuksfckXg6wfRNJLm2+C+N4cnXgUR/2
   A==;
X-IronPort-AV: E=Sophos;i="5.98,277,1673884800"; 
   d="scan'208";a="231061581"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 09:46:34 +0800
IronPort-SDR: qPihxVUvDK0DOv4NdqHxTWOFPq1JQz9nyncqCYTvS7xz/P6xlZOjaPNrl6EnOpMr09uR7cFFG/
 XoZCrhSAUNysjmwfRevb/ja2Zzspn1e83MRpAeiqhrnIW/ImtqkAzUEZnxRFXckKd7lY/RT2Fb
 CnZt8DC7veooiMkc5Wh66VMYaXK5qYg1OpLX/V1I3FEaz78z/0Y0OvUXLrAPH+jPcUfcUtSgH1
 W0T4ssoKEFX2POXJytoM/CWgcQmUflRjS7GWXCd9r39ciPruAqmnWhh21bWEeptmPVy3uY7/5F
 mVU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 18:02:53 -0700
IronPort-SDR: cHVUo//hhQkVkK7EyRKQ2lUVXHBuKpLVp0Y/wOS1j/XJ2Q801O8Frl9vadOLzzox58f4WX7OMX
 l4ihAaln19qQg1cWqFfCV8pQ2PcxQK51pE5luIREecUbPxQfWOCoUajxy/MMgx4mXnXCYzZV8I
 YVIAPMdGRgkXwO9IP1J9EDe62s6z/5Nmc0ki2Ilg8RYt8Fo0fiZsZKxOWOMPB1bOhFXNx0uoz6
 YhP6GwXkKmTvZsjy+wz7iF+/VBNKb1ReY3H8JulUi+rCsTh8pkFsCRDQ/WPY0XehmnKI6+f649
 z1Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 18:46:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PgZG15nWZz1RtVq
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 18:46:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679363193; x=1681955194; bh=67MPh4PA74oDyONsWMMXlZyds267ChMqJ/a
        fy8bb1jM=; b=oO7Eqj4JV2obV/9gu/uiVMupIKYmzq0oztiSf/6qkqcKDLkU1Ak
        qULGa/9UelQDqtFklUheoZt5daw2itILgX0OVwRHaoYe1CH1NhWmRcz2oQHyNa2E
        8PDHL/aPYZ/e3ESuRfaCu3cOxcYHogAaNr1yyxxWsqn/KIpfZ/xmu3k5hqUDuv7u
        kx1EwVrlhpEQxJjtV3KFt/wI1ylBLwJhvb8u3ZUPxFBSyAe3POsi0SrCdEopFuue
        kzsstw6PJm/OQwtepLzQ+fQJL3ROkWzQrIaSmIvKgpYpRjxjta06lmAmqJx0Bxam
        6vH4t5IDJiQSBX6bdkcnsyOTJBC8WDvLZLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8DEt3qFgFPVm for <linux-block@vger.kernel.org>;
        Mon, 20 Mar 2023 18:46:33 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PgZFz5zXdz1RtVm;
        Mon, 20 Mar 2023 18:46:31 -0700 (PDT)
Message-ID: <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
Date:   Tue, 21 Mar 2023 10:46:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/23 09:44, Ming Lei wrote:
> On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
>> On 3/20/23 16:28, Ming Lei wrote:
>>> On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
>>>> Thanks for having taken a look. This patch series is intended for
>>>> REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.
>>>
>>> But you are talking about host-managed zoned device, and the write
>>> should have to be zone append, right?
>>
>> Hi Ming,
>>
>> The use case I'm looking at is Android devices with UFS storage. UFS is
>> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a
>> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the
>> queue depth to one.
> 
> But is this UFS one host-managed zoned device? If yes, this "REQ_OP_WRITE"
> still should have been handled as REQ_OP_ZONE_APPEND? Otherwise, I don't
> think it is host-managed, and your patch isn't needed too.

Ming,

Both regular writes and zone append writes are supported by host managed
devices. For ZNS, zone append write is natively supported as a different
command. For SCSI & ATA (and UFS) devices, zone append write is emulated in the
sd driver using the regular write command because the SCSI and ATA standards do
not define a zone append write command.

For BIO splitting, splitting a regular write is fine as the resulting fragments
are sequential writes, so all fine. But zone append splitting is not allowed as
the actual written sector is returned by the device (or the sd emulation) to the
block layer through the bio iter sector. So if a zone append is split and its
fragments reordered, we can end up with a the wrong written sector and mangled
data when considering the original large bio that was split.

> 
> 
> Thanks,
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

