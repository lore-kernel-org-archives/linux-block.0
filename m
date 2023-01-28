Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD50FC54EAA
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 00:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjA1AD3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjA1AD2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 19:03:28 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A983481
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 16:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674864206; x=1706400206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9eDZ40FOyq9+O3AUOqcTczjT8ELVvM/ktI06hfIYnP8=;
  b=EpQAaDdOOlbK3d81+yuqnkQIm6gAF1g7nRalfYaPgUx5mB9BiXkPmvW6
   d/FQNVillM9XUZ9uqLNbZ5JiGqh07xZibMUFRHjUUXn/lXEPpdQQ5B+J2
   T7YJ6NwpHAxkAGIF8gdLeykcci2vdCQUGdTcd15j5gAfblxoxDdzHKBYf
   2efx/Hn+KA2at6n1sT3TYoIt/sZ4ZP10l5AyLYCHq+F2SUCxgsrFIEGwN
   CHCNep8YvaY58oXz8ZoiKV6Vw96i0d/IHkLUpfuCidrZahLKUH0BePEDp
   Cc7+XOUTY9dWHoh+fLCEYbz7YfsPGk+AUqxsLEjSDRq08ZPG56GuhNDrD
   A==;
X-IronPort-AV: E=Sophos;i="5.97,252,1669046400"; 
   d="scan'208";a="326234915"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2023 08:03:26 +0800
IronPort-SDR: xJ0nZkYF1rp+6AI8lCJRpVeg3btMiz8Cl9pRT/8cYaM+N/yscxGRxfWMlqX9+XfB7b7yHTEym3
 BhN4isFrEQt53aZhygop7zyjbqJf4/+m0nDhw/5t+Z+BrLlgCv6IRroLWO/GV1UuztmGkb9Nkw
 X+Q2n/gb631TM9+btx2qS5OrJpEfF6tNgcSliNj5PQN91HcsgiBp7i+cMzNjueMbrTjCHEEkOr
 jozlmkebCZ7rPshwLydX7x+JJOCPpld/ieV6TN4+Ymg2EMl2JmeGxlMXwGMfFgA1NFsl3uIkEn
 m4E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 15:15:10 -0800
IronPort-SDR: yPgsE6iqnTthPvxTR4O7Msi3VHrOgVvzpFI9xjwkyesbz83DwseU8qqjieYorscfJFtCkZpjRm
 BcI3Q3x7l5vFbV8evtmmpqB08fNaoR5qSviYe2K2n2OzomErk4hbNzI0FEW9YFF4BSseebOH0m
 Cpkg6yGmzM5DNg28xp2ofmRiFOd2QxInPe24V1Fas/0hUUVPeXRElHzys9XLnaW/D/wa4ZKM9s
 Sf/jkcYwnNlZ65JjFHnBduPokz0MU2H88zI7iAmqEij8H7xi00918NSSGTiRTH+3V/MUnYjvUA
 sSI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:03:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P3ZQz4MtTz1RwqL
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 16:03:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674864202; x=1677456203; bh=9eDZ40FOyq9+O3AUOqcTczjT8ELVvM/ktI0
        6hfIYnP8=; b=B0p6HvFsu5QWTI0mzodhIWy9yoitQlDFdYziIPXgNxUw/jdlg3Y
        nCQ/QeoKDkl2f4N3sd2L98hv9q1chkEQ/AFCx8aVA46+euohwDW/K65i79Acjf+M
        MddjbMv2r3sihhvdC0dQ4QM2ffRNc/ki269Pu4ZLJWZCsof0vhB7iX4084kVuAir
        MhuaJgTECn4JEJFMt4c98ChSsiEW+8AvnrExywaLvscfvE/aEy/oytIkqYYiPUiK
        KzXp1tWu5+uORIdSTPcaxD+sE3W27n98nHhvfGxFWUD/O7KpBDrHNCBNe/CUmGHp
        b7vC46vRK75miq/zXZhdJDZ0C5DNuDwZ6RQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HvKJW4h2vm28 for <linux-block@vger.kernel.org>;
        Fri, 27 Jan 2023 16:03:22 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P3ZQx145yz1RvLy;
        Fri, 27 Jan 2023 16:03:20 -0800 (PST)
Message-ID: <416d42f5-d2a3-1f6e-122a-10771dc44e55@opensource.wdc.com>
Date:   Sat, 28 Jan 2023 09:03:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 08/18] scsi: sd: set read/write commands CDL index
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-9-niklas.cassel@wdc.com>
 <e257cab1-7eed-d1d5-4129-f2bedb50953e@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e257cab1-7eed-d1d5-4129-f2bedb50953e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/23 00:30, Hannes Reinecke wrote:
> On 1/24/23 20:02, Niklas Cassel wrote:
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>
>> Introduce the command duration limits helper function
>> sd_cdl_cmd_limit() to retrieve and set the DLD bits of the
>> READ/WRITE 16 and READ/WRITE 32 commands to indicate to the device
>> the command duration limit descriptor to apply to the command.
>>
>> When command duration limits are enabled, sd_cdl_cmd_limit() obtains the
>> index of the descriptor to apply to the command for requests that have
>> the IOPRIO_CLASS_DL priority class with a priority data sepcifying a
>> valid descriptor index (1 to 7).
>>
>> The read-write sysfs attribute "enable" is introduced to control
>> setting the command duration limits indexes. If this attribute is set
>> to 0 (default), command duration limits specified by the user are
>> ignored. The user must set this attribute to 1 for command duration
>> limits to be set. Enabling and disabling the command duration limits
>> feature for ATA devices must be done using the ATA feature sub-page of
>> the control mode page. The sd_cdl_enable() function is introduced to
>> check if this mode page is supported by the device and if it is, use
>> it to enable/disable CDL.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Co-developed-by: Niklas Cassel <niklas.cassel@wdc.com>
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> ---
>>   drivers/scsi/sd.c     |  16 +++--
>>   drivers/scsi/sd.h     |  10 ++++
>>   drivers/scsi/sd_cdl.c | 134 +++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 152 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index 7879a5470773..d2eb01337943 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -1045,13 +1045,14 @@ static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
>>   
>>   static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write,
>>   				       sector_t lba, unsigned int nr_blocks,
>> -				       unsigned char flags)
>> +				       unsigned char flags, unsigned int dld)
>>   {
>>   	cmd->cmd_len = SD_EXT_CDB_SIZE;
>>   	cmd->cmnd[0]  = VARIABLE_LENGTH_CMD;
>>   	cmd->cmnd[7]  = 0x18; /* Additional CDB len */
>>   	cmd->cmnd[9]  = write ? WRITE_32 : READ_32;
>>   	cmd->cmnd[10] = flags;
>> +	cmd->cmnd[11] = dld & 0x07;
>>   	put_unaligned_be64(lba, &cmd->cmnd[12]);
>>   	put_unaligned_be32(lba, &cmd->cmnd[20]); /* Expected Indirect LBA */
>>   	put_unaligned_be32(nr_blocks, &cmd->cmnd[28]);
>> @@ -1061,12 +1062,12 @@ static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write,
>>   
>>   static blk_status_t sd_setup_rw16_cmnd(struct scsi_cmnd *cmd, bool write,
>>   				       sector_t lba, unsigned int nr_blocks,
>> -				       unsigned char flags)
>> +				       unsigned char flags, unsigned int dld)
>>   {
>>   	cmd->cmd_len  = 16;
>>   	cmd->cmnd[0]  = write ? WRITE_16 : READ_16;
>> -	cmd->cmnd[1]  = flags;
>> -	cmd->cmnd[14] = 0;
>> +	cmd->cmnd[1]  = flags | ((dld >> 2) & 0x01);
>> +	cmd->cmnd[14] = (dld & 0x03) << 6;
>>   	cmd->cmnd[15] = 0;
>>   	put_unaligned_be64(lba, &cmd->cmnd[2]);
>>   	put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
>> @@ -1129,6 +1130,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>>   	bool write = rq_data_dir(rq) == WRITE;
>>   	unsigned char protect, fua;
>> +	unsigned int dld = 0;
>>   	blk_status_t ret;
>>   	unsigned int dif;
>>   	bool dix;
>> @@ -1178,6 +1180,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   	fua = rq->cmd_flags & REQ_FUA ? 0x8 : 0;
>>   	dix = scsi_prot_sg_count(cmd);
>>   	dif = scsi_host_dif_capable(cmd->device->host, sdkp->protection_type);
>> +	if (sd_cdl_enabled(sdkp))
>> +		dld = sd_cdl_dld(sdkp, cmd);
>>   
>>   	if (dif || dix)
>>   		protect = sd_setup_protect_cmnd(cmd, dix, dif);
>> @@ -1186,10 +1190,10 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   
>>   	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
>>   		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
>> -					 protect | fua);
>> +					 protect | fua, dld);
>>   	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
>>   		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>> -					 protect | fua);
>> +					 protect | fua, dld);
>>   	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
>>   		   sdp->use_10_for_rw || protect) {
>>   		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
>> index e60d33bd222a..5b6b6dc4b92d 100644
>> --- a/drivers/scsi/sd.h
>> +++ b/drivers/scsi/sd.h
>> @@ -130,8 +130,11 @@ struct sd_cdl_page {
>>   	struct sd_cdl_desc      descs[SD_CDL_MAX_DESC];
>>   };
>>   
>> +struct scsi_disk;
>> +
>>   struct sd_cdl {
>>   	struct kobject		kobj;
>> +	struct scsi_disk	*sdkp;
>>   	bool			sysfs_registered;
>>   	u8			perf_vs_duration_guideline;
>>   	struct sd_cdl_page	pages[SD_CDL_RW];
>> @@ -188,6 +191,7 @@ struct scsi_disk {
>>   	u8		zeroing_mode;
>>   	u8		nr_actuators;		/* Number of actuators */
>>   	struct sd_cdl	*cdl;
>> +	unsigned	cdl_enabled : 1;
>>   	unsigned	ATO : 1;	/* state of disk ATO bit */
>>   	unsigned	cache_override : 1; /* temp override of WCE,RCD */
>>   	unsigned	WCE : 1;	/* state of disk WCE bit */
>> @@ -355,5 +359,11 @@ void sd_print_result(const struct scsi_disk *sdkp, const char *msg, int result);
>>   /* Command duration limits support (in sd_cdl.c) */
>>   void sd_read_cdl(struct scsi_disk *sdkp, unsigned char *buf);
>>   void sd_cdl_release(struct scsi_disk *sdkp);
>> +int sd_cdl_dld(struct scsi_disk *sdkp, struct scsi_cmnd *scmd);
>> +
>> +static inline bool sd_cdl_enabled(struct scsi_disk *sdkp)
>> +{
>> +	return sdkp->cdl && sdkp->cdl_enabled;
>> +}
>>   
>>   #endif /* _SCSI_DISK_H */
>> diff --git a/drivers/scsi/sd_cdl.c b/drivers/scsi/sd_cdl.c
>> index 513cd989f19a..59d02dbb5ea1 100644
>> --- a/drivers/scsi/sd_cdl.c
>> +++ b/drivers/scsi/sd_cdl.c
>> @@ -93,6 +93,63 @@ static const char *sd_cdl_policy_name(u8 policy)
>>   	}
>>   }
>>   
>> +/*
>> + * Enable/disable CDL.
>> + */
>> +static int sd_cdl_enable(struct scsi_disk *sdkp, bool enable)
>> +{
>> +	struct scsi_device *sdp = sdkp->device;
>> +	struct scsi_mode_data data;
>> +	struct scsi_sense_hdr sshdr;
>> +	struct scsi_vpd *vpd;
>> +	bool is_ata = false;
>> +	char buf[64];
>> +	int ret;
>> +
>> +	rcu_read_lock();
>> +	vpd = rcu_dereference(sdp->vpd_pg89);
>> +	if (vpd)
>> +		is_ata = true;
>> +	rcu_read_unlock();
>> +
>> +	/*
>> +	 * For ATA devices, CDL needs to be enabled with a SET FEATURES command.
>> +	 */
>> +	if (is_ata) {
>> +		char *buf_data;
>> +		int len;
>> +
>> +		ret = scsi_mode_sense(sdp, 0x08, 0x0a, 0xf2, buf, sizeof(buf),
>> +				      SD_TIMEOUT, sdkp->max_retries, &data,
>> +				      NULL);
>> +		if (ret)
>> +			return -EINVAL;
>> +
> That is a tad odd.
> Is CDL always enabled for 'normal' SCSI?

Yes it is on the device side. There is no mode sense to turn it on/off. Not sure
why it was designed like that in the specs... The sysfs duration_limits/enable
attribute is a "soft" on/off switch and it is off by default, even for drives
reporting supporting CDL.
Hence the "if (is_ata)" to do the mode sense to enable the feature on the device
side only for ATA devices. We need this to avoid having 2 different enable
pathes with 2 different sysfs "enable" attributes. Doing it like this is a lot
less code.

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

