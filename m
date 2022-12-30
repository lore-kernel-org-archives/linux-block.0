Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35714C3DA7C
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiL3Mz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3Mz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 07:55:26 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A54140C3
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 04:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672404925; x=1703940925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JcVUA1+VAUjkfEBJBe0KTipXfb249HRYaSoxS210Kk4=;
  b=DcfJxsrceG9L1Oc023/E+zGRE7NLs4h5UKJ6MAmXWgeMsEIPx9xoyCTX
   veNHl7aBrGzlRi/RA9RU0PBrsm7FpoxCjZTdRVPNtpJi6M5GFQ6OtVLc2
   Yp7GOj33TkhtYnBF+4Lq8KHwn+fluIgyK8PzUsG8+M6co7vZKiVvLMeTq
   9Zo5oLIzN/GbgIcSdqon8uSUGIMkrdbFKz+66tE2ja8Uq9jpkQCXom4SF
   a8/Dw1AzwnQvcXWi6+/7vyDP5W7PL7Tqf6Gx+Xs608pWjpDF6uWxIAIXM
   mPqq+ld8NXTD7AUSfQoBn5nAeEjCK3LVa/AJSVO3+kds4qcXxGH7HovUW
   g==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="224814264"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 20:55:24 +0800
IronPort-SDR: L3IHrCCq3nMZsfIBwVl1hVkgbpqc/X75NYV4ymOUGPa0NpCv5AQzRJq9WiMRQ7Y3UQar03CWRF
 /x1390RgLzyujP8d18dy/6udgCaUfde78GhwjQW2yLvhGx9yTsstVo6AA2nDwNtoxn5f1oWOxZ
 2/DWAuOnww+RqiZKS+/zZYuoKVAMPjDnreQjkI9WT/iBuRWmQ7wjPARWG1Jhb7knFJ3yxyRPsK
 8nv8vGrWwQYUxokl3d3py/nM6EAZySuYh68TJ1Bwa/pJg2EzBMkeBAhlZxoS7vyKM669PAH0j1
 PTI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 04:07:43 -0800
IronPort-SDR: E2EvZklTuANFr94SUMZ3FCNyoFcQDiRJRmJKALz2pme85JxG86sbNWy6aVCzhZ4dn9rPxNWb+r
 qOXDnMdyINN6JEBSMUODjbk4+tIQdKe130wrumLLCEQ0iOCd4gGllBXMob9zj8KhAWNfCjp72E
 pQgdZrMIeNPAzs6agf9Li9DXHPBXrL7dd8Esbpstose3eJuqwbgKbIknBfoE+vAsKK3b9PBj5y
 76IZAhUNolRbLRxMSA2XJ2DCC2ToCZcaxOhESQ9eh9IUbwXDuWapvUY6pqNKKCxWfZ4RsWUu6Z
 kUc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 04:55:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nk4x82y81z1Rwt8
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 04:55:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672404923; x=1674996924; bh=JcVUA1+VAUjkfEBJBe0KTipXfb249HRYaSo
        xS210Kk4=; b=Fd1FBPzYWV6sjnure7UCz1wFf17a8XII/nRfrQ2CyJEbt/+qh/n
        nUgMjstO0M0CWvNJLEgLkq7i8Wa77Arng+j+xxtiWUWOignslnZ0gcS7CSBQhr8o
        eRh7uXalsf58TYHrla+LgiKGJXFaco2gbKIPucoHS9KIrwLGoHPjNrN0IFnqi7ko
        zJV8HpI3tXuQgHfLSsU1axtpYfMxJ37mChDhM5H9xo2kugqAIHKihr68vHyjQwIb
        vX0L2KZEVx+2zpWsoQVCD2QHnKQvcUbdRV7cH7Zt/mR82TF3nBtxurr1tSmSa515
        fHjd0m0Ze29lgJ/fyENbRVgB71d/rrKD7Ww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r9hEcvQ3B9TR for <linux-block@vger.kernel.org>;
        Fri, 30 Dec 2022 04:55:23 -0800 (PST)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nk4x63lLwz1RvLy;
        Fri, 30 Dec 2022 04:55:22 -0800 (PST)
Message-ID: <a6bf8748-a47a-41d7-2c61-43a333df863d@opensource.wdc.com>
Date:   Fri, 30 Dec 2022 21:55:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 7/7] ata: libata: Enable fua support by default
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
 <Y67DaUBSFBU9xoIU@x1-carbon>
 <602e37be-38fa-0143-a6fe-010aa74197d8@opensource.wdc.com>
 <Y67cdx1h0QMb0brO@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y67cdx1h0QMb0brO@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/22 21:41, Niklas Cassel wrote:
> On Fri, Dec 30, 2022 at 08:21:59PM +0900, Damien Le Moal wrote:
>> On 12/30/22 19:54, Niklas Cassel wrote:
>>>
>>> Perhaps this commit should more clearly say that this commit only affects
>>> the simulated output for a SCSI mode sense command?
>>>
>>> Currently, the commit message is a bit misleading, since it makes the
>>> reader think that a SCSI write command with the FUA bit was not propagated
>>> to the device before this commit, which AFAICT, is not true.
>>
>> It was not with the default libata.fua = 0, since the drive would never be
>> exposed as having FUA support. See ata_dev_supports_fua() and its test for
>> "!libata_fua" and how that function was used in ata_scsiop_mode_sense().
> 
> I see, drivers/scsi/sd.c does a SCSI mode sense to check if FUA is reported
> as being supported, and then calls the block layer setter for this.
> 
> So changing the simulated SCSI cmd output is sufficient to tell the block
> layer that it can send FUA requests to us.
> 
>>
>> The confusing thing here is that indeed there is no code preventing
>> propagating FUA bit to the device in libata-core/libata-scsi for any
>> REQ_FUA request. But the fact that devices would never report FUA support
>> means that the block layer would never issue a request with REQ_FUA set.
> 
> Well, ata_scsi_rw_xlat() is used both for passthrough commands and commands
> issued by the block layer.
> 
> Just like how ata_scsiop_mode_sense() will be called regardless if it was a
> passthrough command or a command issued by the block layer.
> 
> ata_scsiop_mode_sense() will not behave differently if it was a command
> issued by the block layer or if it was e.g. a SG command.
> 
> I would argue that it makes sense (pun intended) for ata_scsi_rw_xlat() to
> also behave the same, regardless if it was a command issued by the block
> layer of if it was e.g. a SG command, but I will leave that to you to decide.

Yes, we can improve that. The current series does not change the
relatively (and really old) bad handling of passthrough FUA commands. So
this is something we can do on top of the fua series.

> 
> 
>> That would be possible for passthrough commands only. What is going to
>> happen is that we'll now get an error for that write if the drive does not
>> support NCQ or has NCQ disabled.
> 
> Why would it give an error on a drive that has NCQ disabled?

My bad. It will not. In that case, WRITE FUA EXT will be used for an FUA
write.

> 
> Your new code looks like this:
> 
> static void ata_dev_config_fua(struct ata_device *dev)
> {
> 	/* Ignore FUA support if its use is disabled globally */
> 	if (!libata_fua)
> 		goto nofua;
> 
> 	/* Ignore devices without support for WRITE DMA FUA EXT */
> 	if (!(dev->flags & ATA_DFLAG_LBA48) || !ata_id_has_fua(dev->id))
> 		goto nofua;
> 
> 	/* Ignore known bad devices and devices that lack NCQ support */
> 	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
> 		goto nofua;
> 
> 	dev->flags |= ATA_DFLAG_FUA;
> 
> 	return;
> 
> nofua:
> 	dev->flags &= ~ATA_DFLAG_FUA;
> }
> 
> So it should only give an error for a drive where NCQ is not supported.
> If NCQ is supported, but disabled, you will still send a ATA_CMD_WRITE_FUA_EXT
> command.

Yes.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

