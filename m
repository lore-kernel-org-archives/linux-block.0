Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5FECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 22:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiJ0Wfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiJ0Wf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 18:35:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632034F64D
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666910127; x=1698446127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H+7M2UuZtjw+FCc+KMjrmjoeHRhHt0w0ZWFxTeOO8oM=;
  b=jMq3qT0HoZAldO+PMM+z+Zjp0Sg2Z8XbyD7+udMuPch6qk4TP0abeHbF
   tR/rgAC5YhT9vNLcuXYbZwmQEbrh8sZ98FflVsuUjKmTmtDbgfNFyCZv3
   /osyZZBKuLFytwHR15sFcgwRdiCAEaAMewy0VgYoB6oM+D3Ia2R4tBS4n
   9qgLwGvLup7MAgD2kVsKCm1t8zjA9tGSV6W0UchANzdSK0fqvvdZIoFg5
   Cll5+Hnt++74k4flaZaHl7bmXBfYBtMNM+E4Pl8mPMHORAi7KxfFzfYlp
   P2s4dOPN3WG6KOiqa8pBhx1KIeKz2VyK8z6yTZ0gBZNhh+acE0Rr8pr5g
   g==;
X-IronPort-AV: E=Sophos;i="5.95,219,1661788800"; 
   d="scan'208";a="220083967"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 06:35:22 +0800
IronPort-SDR: FSd38QKR6+fpUOOaWoLxW2uFTDDjBMNbsy6irur7c0gwv9rIcOPGr7knpEK9GQAmDm4yqEoChB
 5E3d87U+PWQ+2kbS6Wfghnmoeq/dX2osK63Zcy1lBBPR5OvSqTeFlEeWvIyRUcAB8nNekBgXGA
 UDKPGqusXNKerh0HSSBi7UjDBYQlouafnnhDc4f+6IGWrBIogIHlCyXUkx+3r3hDOU4zN3yUql
 F5MKuo8MhO4xrfdXXPrUZMZroLJw1eiWospc9EihvPz3Ho/F5vS6q5ux0Mm7YBxrGJ6LKHYvAl
 2GvXlgS0321zo3uvsCT0oF5M
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 14:49:00 -0700
IronPort-SDR: yvJRr3U6+HHO2zzQArH0r8/66qBIWYyae+RtSxkdsnKueKMpZQ1D/k7m7EcMN+8yCSk/icTlg3
 l3WBpycy3zr1D9WZAfLut2XR7T5OYkHfURv9y63qdiTNJDLOUMhg7B9t/t1bR5NznuwsHQsi9b
 X/RFnrblEvOuN8qJMAShPPBma1pDWFw0OLCZx4uqXQNsuPrEONmGJHrc6YuSVPd4RDZRLOADFD
 uRoTxyEvz3SzYSCGx12IFupmtdXKrSrLzfN0fpo0ozuLcA5BbZpDMsHP4EcYLyihjMn0pkOUsa
 dv4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 15:35:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mz0qt2DQMz1RwvT
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:35:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666910120; x=1669502121; bh=H+7M2UuZtjw+FCc+KMjrmjoeHRhHt0w0ZWF
        xTeOO8oM=; b=Du8cJe38qXZtFU2pgZ1EY48VMPrJAxsY4dGwqHb1AAg2hjV2hUY
        SL6H6ZzVOtVSS6Ux/93oSLRwL0BHGQ7NRiaaRuW0l2WFwj94G1yi96nxaFacKZqc
        RACVX9N2txxHPfiLTX6d45407tXfaXvdVqIYSX/+EwH2+P5uikWa0SUEYcTdvGYv
        JFmlcmrDEQNaY2yPbBGppu5n1E1FMu/PmDO4tyaFE/b3RQOm/QLNK3TXZjLDdVu6
        yVDeeb36H1CzveBC/PVr9U6+Dta0TBiKIuouXgC3gInVgNjbwEEOw7695XYvPbfz
        +xkDb2cqa1GrztknrVZQDb5tNx/1MH2XmxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rgIYcvyjg8zg for <linux-block@vger.kernel.org>;
        Thu, 27 Oct 2022 15:35:20 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mz0qp2LJDz1RvLy;
        Thu, 27 Oct 2022 15:35:18 -0700 (PDT)
Message-ID: <07028dac-d6cc-d707-db08-b92c365a6220@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 07:35:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
 <ea0be367-a4e0-3cc2-c4c7-04d8db1714cd@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ea0be367-a4e0-3cc2-c4c7-04d8db1714cd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 02:23, John Garry wrote:
> On 27/10/2022 14:02, Hannes Reinecke wrote:
>>>>> =C2=A0 /**
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 ata_scsi_slave_config - Set SCSI d=
evice attributes
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 @sdev: SCSI device to examine
>>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>>> index 8938b584520f..f09c5dca16ce 100644
>>>>> --- a/include/linux/libata.h
>>>>> +++ b/include/linux/libata.h
>>>>> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct=20
>>>>> scsi_device *sdev,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sector_t capacity, int geom=
[]);
>>>>> =C2=A0 extern void ata_scsi_unlock_native_capacity(struct scsi_devi=
ce=20
>>>>> *sdev);
>>>>> =C2=A0 extern int ata_scsi_slave_config(struct scsi_device *sdev);
>>>>> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct scsi_cmnd *scmd);
>>>>> =C2=A0 extern void ata_scsi_slave_destroy(struct scsi_device *sdev)=
;
>>>>> =C2=A0 extern int ata_scsi_change_queue_depth(struct scsi_device *s=
dev,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int queue_depth);
>>>>> @@ -1391,7 +1393,8 @@ extern const struct attribute_group=20
>>>>> *ata_common_sdev_groups[];
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .slave_destroy=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D ata_scsi_slave_destroy,=C2=A0=C2=A0=C2=A0 \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bios_param=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D ata_std_bios_param,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlock_native_capacity=C2=A0=C2=A0=C2=
=A0 =3D ata_scsi_unlock_native_capacity,\
>>>>> -=C2=A0=C2=A0=C2=A0 .max_sectors=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D ATA_MAX_SECTORS_LBA48
>>>>> +=C2=A0=C2=A0=C2=A0 .max_sectors=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D ATA_MAX_SECTORS_LBA48,\
>>>>> +=C2=A0=C2=A0=C2=A0 .reserved_queuecommand =3D ata_internal_queueco=
mmand
>>>>> =C2=A0 #define ATA_SUBBASE_SHT(drv_name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ATA_BASE_SHT(drv_name),=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>>>>
>>>
>>
>> But that means we can't use it before the SCSI host is initialized; so=
me=20
>> HBAs require to send commands before the host can be initialized prope=
rly.
>=20
> At what stage do you want to send these commands? The tags for the shos=
t=20
> are not setup until scsi_add_host() -> scsi_mq_setup_tags() is called,=20
> so can't expect blk-mq to manage reserved tags before then.
>=20
> If you are required to send commands prior to scsi_add_host(), then I=20
> suppose the low-level driver still needs to manage tags until the shost=
=20
> is ready. I guess that some very simple scheme can be used, like always=
=20
> use tag 0, since most probe is done serially per-host. But that's not a=
=20
> case which I have had to deal with yet.

In libata case, ata_dev_configure() will cause a lot of
ata_exec_internal_sg() calls for IDENTIFY and various READ LOG commands.
That is all done with non-ncq commands, which means that we do not requir=
e
a hw tag. But given that you are changing ata_exec_internal_sg() to call
alloc_request + blk_execute_rq_nowait(), how would these work without a
tag, at least a soft one ? Or we would need to keep the current code to
use ata_qc_issue() directly for probe time ? That will look very ugly...

>=20
> Thanks,
> John

--=20
Damien Le Moal
Western Digital Research

