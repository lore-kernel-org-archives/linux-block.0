Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8864FC04E69
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 15:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjGZPDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjGZPDG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 11:03:06 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D32688
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 08:02:58 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666e6541c98so6376556b3a.2
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 08:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383778; x=1690988578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzom1BMlrJ48cQurHlgiCWfwm/e5GGsUChmkHVBXMcA=;
        b=JnnX0/O2+/LEPaZ4Wa2m0vH7hRo+2BYcAMrKii4gI4GguPDWcC1z8LqCjApToUtGb7
         Q86GDvex8lWVWBq6QthgzswmnA/G3UbED2cfrTSXF4S4nN8QJz7DAuOW1vRzennCYBCT
         D2yxsW4lYmirUwP4yXCEXFfOggkpEkFHQ6nnjZkv2CHXF9QXywKJthGrhkkaVvEM41Ni
         FxMYL3LM6KkvgETYPISrkzuz+UOMb1Aol1kVlsXpfzNEVRd5F0E/hxB8QYXO0vA61UUV
         sp3r6gwV13KH3ToW5YoQtIBz7NtCos32abK1/HFIHiiIANaRcqtW4ZVwu/MeHgPwwFM1
         yBwg==
X-Gm-Message-State: ABy/qLbgEtg2YQEn9gpSo4NHcF3MOMENTJWCtzt/ZaHRfYwTexe5sC51
        yvINQ26zKuQwKgNZ3sQyBmg=
X-Google-Smtp-Source: APBJJlE3tABXKvGJTCEnCtChEp3SsVkF/rykkHCFUzw1Syx945vhSGXLEIKXHrKkYBg5DVdEcLSoVQ==
X-Received: by 2002:a05:6a20:a122:b0:132:bdba:5500 with SMTP id q34-20020a056a20a12200b00132bdba5500mr2720322pzk.39.1690383777936;
        Wed, 26 Jul 2023 08:02:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7ecb:b0e6:dc38:b05f? ([2620:15c:211:201:7ecb:b0e6:dc38:b05f])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78d14000000b006866a293e58sm9474605pfe.176.2023.07.26.08.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:02:56 -0700 (PDT)
Message-ID: <15c27150-a4fb-9c93-377a-6a462f3565c1@acm.org>
Date:   Wed, 26 Jul 2023 08:02:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/6] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-5-bvanassche@acm.org>
 <e9cfd243-4b2d-a2f5-2d34-b0012470117a@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e9cfd243-4b2d-a2f5-2d34-b0012470117a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 01:47, Damien Le Moal wrote:
> On 7/26/23 09:57, Bart Van Assche wrote:
>> +/*
>> + * Returns a negative value if @_a has a lower LBA than @_b, zero if
>> + * both have the same LBA and a positive value otherwise.
>> + */
>> +static int scsi_cmp_lba(void *priv, const struct list_head *_a,
>> +			const struct list_head *_b)
> 
> The argument priv is unused.

I cannot remove the 'priv' argument. From include/linux/list_sort.h:

typedef int __attribute__((nonnull(2,3))) (*list_cmp_func_t)(void *,
		const struct list_head *, const struct list_head *);

__attribute__((nonnull(2,3)))
void list_sort(void *priv, struct list_head *head, list_cmp_func_t cmp);

>>   /**
>>    * scsi_unjam_host - Attempt to fix a host which has a cmd that failed.
>>    * @shost:	Host to unjam.
>> @@ -2258,6 +2289,12 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
>>   
>>   	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
>>   
>> +	/*
>> +	 * Sort pending SCSI commands in LBA order. This is important if zone
>> +	 * write locking is disabled for a zoned SCSI device.
>> +	 */
>> +	list_sort(NULL, &eh_work_q, scsi_cmp_lba);
> 
> Should we do this only for zoned devices ?

I'm not sure this is possible. Error handling happens per SCSI host. 
Some of the logical units associated with a host may be zoned while 
others may represent conventional storage or have no storage associated 
with them (WLUN).

Thanks,

Bart.
