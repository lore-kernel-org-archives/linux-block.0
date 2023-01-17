Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F7C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAQHKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 02:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjAQHKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 02:10:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54323330
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673939419; x=1705475419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2V3NWgG/L/DSDCbEmm1VVQTHZwJxPmbKdUQ/aAJDqU=;
  b=Zz3RQDwSGHIe+90Pz9R6DzusF+wYS/q8qVAFHQexuQHizeMv92cVcjdN
   e9aFkrM6VjkqGkZZBNS9IXa8Jdiw4ChQk6N1nDy7Z+LrsvBL0frIxXAFI
   8hfuah8nLEN9chHn2c1VoKKWqHzptySAX3F5GrqMM3Y9QWOyfmv39X3T7
   mTXtFHWuKnMw5xb5k02/F/q/nTun7KDrOiNxOceei0qlXmKULgVC6usBt
   ZQrSaXTLzJynlGM7Ui4am9FodxjzNRM/RtC+USi1IZelIAAKId1OJJw5W
   ZEvbf2Evt1Xcf/+pVP3Oq085d24iYFPKiwVRFN2AsB1QrAspevAFepAjA
   A==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="221066032"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 15:10:18 +0800
IronPort-SDR: CyD6mH8b2Qhyk0R2XTb5pgs+/nIu3p6btKQpiFQbvplfkkABUFEnS/wtH4lHnh6mgCQaQmC2TQ
 M7EqA41Ig10Pf3/uPFgJ8L6UIlQBkqpx8oH1vLftoT0WamPAON/Zi7uRocfCruNn5uKSZ33gKR
 pywfdGtTb/1qBxc0FxQbnABu1IjTOrN7+C+6JMwMrx4Hpsti6oGtOTXLzddfi4WaVHHL78MfJv
 R+d4pDSKXBQkyE6ov8Sflj6udrFAl2qxcgz6598AG9dk6Q7d8jwpys2b2MMsS0YIsK7JtFAOKI
 TqI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 22:28:00 -0800
IronPort-SDR: Hh4d6bDr1bMK09NZCC5odEPWITUEI1visK7Xww3u7XGeFxo4TruNL0ua/oB4Zq6DU5mJ292Ws4
 r//jIpV/cQ5dDsuSMecLxR6vHEMYtf7WHa233OeRgKR/K94XkDj9H7mVWRrQEUebnjeOsZJQ14
 s0Z9Mj67OMU560ZHlM32Uv1snto4n2YUIOWwD4XiYNnhRSTdaO6hrlFCVm6cYS6BKZYSVlzbz4
 dkIA60ww8HHhR+M5KWVr+EAjcOLNqnv9bAu/sYjbNyBeWR7q8eqKjBMiUu04CNmdzNH2Ioksff
 /gE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 23:10:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nx0Qf0gM4z1RvTr
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 23:10:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673939417; x=1676531418; bh=q2V3NWgG/L/DSDCbEmm1VVQTHZwJxPmbKdU
        Q/aAJDqU=; b=W4w/NhrRr35fGiw++8g0VuA85AvFEl8y56V1TXQuFhJKoOgFt+v
        uAG7jb0/jULdOZE8fm+vCJjlIcccVxfvuChA1kYk6H3iDoZu9SeMaiwkS3Uw0xZ+
        wt+GDLCWWbvLuSxLDE2zP96MMAQCl2X7znS2/FdyQqMYwyO5/yQOh1DvQ22UyAcY
        I75VPwFvXx0jN4aDwxS5DRzifkH1KAW3STgMQ9mzMay1+5J0ByoSFDuM6VyI9QSL
        XAg11N0m2G4GjGobKICLRG/ggudsCMRP8rgF5b1kbZ7Mw5UvrKTlWRsHAybTgws+
        +JNBR8wfuWBf2Nx3mPaWANWusFDHo0gwbsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nqJZsZ9Sk6SR for <linux-block@vger.kernel.org>;
        Mon, 16 Jan 2023 23:10:17 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nx0Qc58DWz1RvLy;
        Mon, 16 Jan 2023 23:10:16 -0800 (PST)
Message-ID: <04ab7f5a-9ba2-09f3-7aff-61cde2696d25@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 16:10:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 01/18] ata: libata: allow ata_scsi_set_sense() to not
 set CHECK_CONDITION
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-2-niklas.cassel@wdc.com>
 <Y8Y6/xa3thf4/UNy@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8Y6/xa3thf4/UNy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 15:06, Christoph Hellwig wrote:
>>  void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
>> -			u8 sk, u8 asc, u8 ascq)
>> +			bool check_condition, u8 sk, u8 asc, u8 ascq)
>>  {
>>  	bool d_sense = (dev->flags & ATA_DFLAG_D_SENSE);
>>  
>>  	if (!cmd)
>>  		return;
>>  
>> -	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
>> +	scsi_build_sense_buffer(d_sense, cmd->sense_buffer, sk, asc, ascq);
>> +	if (check_condition)
>> +		set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
>>  }
> 
> Adding a bool parameter do do something conditional at the end
> of a function is always a bad idea.  Just split out a
> __ata_scsi_set_sense helper that doesn't set the flag.

What about passing the SAM_STAT_XXX status to set as an argument ?
Most current call site will be modified to pass SAM_STAT_CHECK_CONDITION,
and we could add a wrapper ata_scsi_set_check_condition_sense() to
simplify this most common case.

-- 
Damien Le Moal
Western Digital Research

