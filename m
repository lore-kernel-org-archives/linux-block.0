Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCAEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 07:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiFTHHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiFTHHN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 03:07:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE04DF1F
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655708828; x=1687244828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ayM3BKn18ekGhnziKOAoSX4/0dgNEI8Qt8iqbI2GS/I=;
  b=ZXCZ8Pfwb6ryuLs1lMcRexvSfFxvMsyuWMOP/dXb3mczsHpzrTqHdiI8
   ZA2f6FmcbkmMnSk6dHmUkmWDp4HGs2Lx9QZ8+O2GF1Q/gE0TlDg07as0n
   PynYqxCacW3e+N9Dh77yrQPIB9xqC019QjBI56x9AykacCnEET4ffVzMT
   mkXD5QQirNuxmLZa1zoFIyuHhp7XlalKyCMiJjN4Y6lVNAIbRvGb4BDZ6
   Z1MGfE1/A1D47MGtO+E/SNGVgdgEAdFFiuC7/xZQjldR/GVaRbA6Rip4d
   eXe6K7tzCecTom1K8vf6IGJ0vg35vek2g0t/Feuzeb8Sl78YYfOSriPMl
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208461430"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 15:07:07 +0800
IronPort-SDR: peaZMBS7CvawhDGiAAgeFVaQR2m8Czsj8SeTE0v7D0IMQzUWWR1ij8xEHauBXBMhhf2oEqXd3D
 oKmryLdhEjQrunf1Yj0vD+L/xINjUx4VPsZl+IyTSx1edDKLU3U2TvUg5DzQiQDILZK0rj6dLI
 Oda8uNR7kUlxJOg8HcV2wLN3bqsSrzxrHX3GrVtoremMnYbrpPcw/ioX+FGS6IM/VfTwd8kcno
 9DHJmVwLIM9nWFQLrOYv5L/kuDw3AmxpepsRKta1FilUhBKnbJIpcki+ckwU9qVqKEldOVLEgA
 Ne8twA/8bdqTKrgoMMuzIWh0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 23:29:40 -0700
IronPort-SDR: 8LWHRMWXgqrZAXhyvucDhrooUke6BzmeqGfTP8dA4cSxC6kGV6XFP2XTMdnbHX26nUZtsfeeOo
 +jtj5Siom+H4xeSpoyBzto7GwiI7tm1EPKiKXatn8yuU2UhzkeMJx3hjBvSbgv4f+9tCeFO4iy
 pcA25Nvx8NRJTrr1xl6xp4sUme33bzocYrlvpCCfNFy3trobPcHg1NIxVJZ9LRd4uZg6CUVSvS
 66+Wg4HwksS/hjFjBI3pRYIaC22sFSzg91nMZiig8rJLbCD2zzvTR3v0KLggtfG0dvCX9P4eC5
 a+0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 00:07:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRLLM17wVz1SVp1
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 00:07:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655708826; x=1658300827; bh=ayM3BKn18ekGhnziKOAoSX4/0dgNEI8Qt8i
        qbI2GS/I=; b=W9chRna9g2XZTtycfGkCBD3Z7dfQ5SvujksisB5b8P5rr5XJT7Q
        yWQw39YalqO70033in0deDny1vKdbzlN7XBCtSeM2jfvfLgOtzUiYpLdp9pFIAxx
        5lyGReIFGNn/VCP1cx+E6axQi7MG2bODSSoi9VSP834RJB+HjZomE9d6pg3+nb9X
        7hZK0NiEQxx5jn1esfkKF6AhRGIc57UpkTtwZMwUOPeBWsRY99xJm8MAHktRDXWq
        9UW4N7S4tZnjBoT5Xr+46khOBqo4kcZpSIVorp6yTfBEJqWrbxTrpmSEX83FRbTK
        PHVvcq3P8qnGPCzFW0mE+sfysRF57eBBeSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cXa0pCiXF2-W for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 00:07:06 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRLLH4vpLz1Rvlc;
        Mon, 20 Jun 2022 00:07:03 -0700 (PDT)
Message-ID: <74db73c0-3739-daa1-3af2-c7c4a8acb263@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 16:06:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        brking@us.ibm.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <7f80f3b6-84f6-de48-4e69-4562c96e62c5@huawei.com>
 <e4b108ba-cbc9-5237-f873-2fcea94f2b85@opensource.wdc.com>
 <543fcfb2-6baf-1b19-d0f5-83979090db31@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <543fcfb2-6baf-1b19-d0f5-83979090db31@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/22 15:45, Hannes Reinecke wrote:
> On 6/13/22 11:06, Damien Le Moal wrote:
>> On 6/13/22 17:25, John Garry wrote:
> [ .. ]
>>>
>>> We may have 32 regular tags and 1 reserved tag for SATA.
>>
>> Right. But that is the messy part though. That extra 1 tag is actually not
>> a tag since all internal commands are non-NCQ commands that do not need a
>> tag...
>>
>> I am working on command duration limits support currently. This feature
>> set has a new horrendous "improvement": a command can be aborted by the
>> device if it fails its duration limit, but the abort is done with a good
>> status + sense data available bit set so that the device queue is not
>> aborted entirely like with a regular NCQ command error.
>>
>> For such aborted commands, the command sense data is set to
>> "COMPLETED/DATA UNAVAILABLE". In this case, the host needs to go read the
>> new "successful NCQ sense data log" to check that the command sense is
>> indeed "COMPLETED/DATA UNAVAILABLE". And to go read that log page without
>> stalling the device queue, we would need an internal NCQ (queuable) command.
>>
>> Currently, that is not possible to do cleanly as there are no guarantees
>> we can get a free tag (there is a race between block layer tag allocation
>> and libata internal tag counting). So a reserved tag for that would be
>> nice. We would end up with 31 IO tags at most + 1 reserved tag for NCQ
>> commands + ATA_TAG_INTERNAL for non-NCQ. That last one would be rendered
>> rather useless. But that also means that we kind-of go back to the days
>> when Linux showed ATA drives max QD of 31...
>>
>> I am still struggling with this particular use case and trying to make it
>> fit with your series. Trying out different things right now.
>>
> Hmm. Struggling on how that is supposed to work in general.

The standard monks defined it as conceptually easy: if a command completes
with success and sense data available bit set, then just read that log
page that has the sense data to check what happened. Very trivial in
principle.
But of course, this is ATA, so a mess in practice because we want to do
that read log with an NCQ command to less impact on the drive performance
than a regular error. Otherwise, if we simply do a regular eh, we end up
with the same impact as a hard command failure. And then we end up with
all these problems with tag reusing and nothing in libata allowing to do
internal ncq commands.

> As we're reading from a log to get the sense information I guess that 
> log is organized by tag index. Meaning we have to keep hold of the tag 
> which generated that error.

Yep. This is a 1024B log which has all the sense information of for all
completed NCQ commands, organized per tag.

> Q1: Can we (re-) use that tag to read the log information?

I thought of that. BUT: if a revalidate or regular eh is ongoing, we need
to delay issuing of the NCQ read log command since eh will prevent issuing
anything (there will be non-ncq commands on-going). Problem here is that
delaying ncq commands means essentially doing a requeue so we need a real
req/scsi req for that. Reusing the tag for a new temporary internal qc is
not enough.

> Q2: What do you do if all 32 command generate such an error?

For that case, I can simply use the internal tag and do a non-ncq read
log. That is actually the easy case !

> But really, this sounds no different from the 'classical' request sense 
> handling in SCSI ML. Have you considered just run with that an map 
> 'REQUEST SENSE' on your new NCQ Get Log page command?

I am exploring the reuse of the scsi EH now. But very messy on libata
side. Still no good solution.

While doing that, I did discover that libata eh is very messy because of
one driver only: scsi ipr. That is the only one that does not have a
->error_handler port operation. And because of that, we are stuck with
lots of "old EH" ata code. So there are always 2 different eh path.
Complete mess. I am trying to see if I can't convert scsi ipr to have a
error_handler port operation, but I cannot test anything as I do not have
the hardware.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
