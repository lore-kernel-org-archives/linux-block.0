Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC7EFA3745
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 08:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJ1IHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJ1IHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 04:07:35 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4632A14D1DE
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666944455; x=1698480455;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BhLvfHx2bYTYF8JSCc4dtFpE9sunuk39pQhitXjwVlM=;
  b=PWx5zcFhgIvo/k7DsIV7lSu4gWSowQD61ZlZtJbA42i8iyvkEiR/heay
   5Ori+TzS3SLsUo0uWi1x4e6BAURkwFKv1mV8qHZJSwUAVsYUxD8+5aLIX
   O76qXModcDPrOyQgNP/M4BlbozR9eC7cGvLeWS8f8m7M8DF3OH1uPTocY
   Sh/0T/m+4cmwhYbwdqDTs0EszusRst07GqDgiXxPe8Q6PT6pZOWY1ORMP
   Oo72eLQCnAQXwu0DBen5d7hf71CQ4kRMF/cXncJkAagjW/0zdD3fpcB77
   MnceywoVZXTbqa5MOCnIeQ0zdVH+poxNxdqO2FUl+6t2ZYfJ0omz24h6j
   A==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="220104564"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 16:07:33 +0800
IronPort-SDR: hqmdOtL+Ai/50c2SLRzB86gDFE3xi3ohe6VC8PQ+DylzRl2zmfbfN1hjAB15RT8XRgRaIWBt/7
 AfNwYA0ZZ5YMsHv2F7JwuDoKEhxFMcZteV3LwhCf6SdYj4h5vDOe1PpZEUn0MUZXAlcFVeBMz2
 cFQxKjOtH2GkOYhREBctTrh5ose2fB7aeTToTsl92mFJqQ3ZnpMako19gM9HgbKQTIQ3DbWX1+
 Y1gmG4e0wDelJ+gIfguyj8PmSmRDMYL6+OlCxwey0R9YNandBByguUfXtAFky+ACoZebJp5gjX
 /PFXqZeAseAw+mlGkDjex5RS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 00:26:53 -0700
IronPort-SDR: U5EtW/QZgguVqKMYpUTxSCXsTU5AZDArauFCxjmSUcUx7MjxQCHyVeiWUBwrFJ0Slbg1P2oadP
 9WyDoKB8EBX3og0BYCIrRzrAElot0BkCfcXnpLi7OHV8GIdvmqfuciYYJhDKH9EwznUDdaI9Er
 zdpFiMDgk9ynAaLzwgvxU6WxO7qoOe5ZuEsTdDG3eUfycnDlmKByiwfzArDtKlRVxcjwD2K0yX
 mdXRwuEtDxHwkIh9S9mvhrwI5sa8uvZ7fLSaYWhEa59bBFGa6UmPPhe/Xx3Dk1UZ1iwQ1Dz45v
 bg4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 01:07:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzFX36N09z1Rwtm
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:07:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666944450; x=1669536451; bh=BhLvfHx2bYTYF8JSCc4dtFpE9sunuk39pQh
        itXjwVlM=; b=KxefP19qgUN4wNOceIOqEus03yHsZnkg6PYKdOKPs1Wb/5pIxf/
        msokWX2Y5zFXySostoRVnvaL6ro5NBDm7UbnFfU0W3GSB6hB4QRhlEIB1KMTZa1x
        n2KXekFQW3yjydfyTZZJLMkoDEXjKV0SOPtLmys+R+kp3PHeudiqae2NaYFD5EIC
        0ccznLPEMmQddQVMEDGBsEjzgdVixJs90iGFXH9f8vYt0jHad/uBqSIoahBseKiI
        STsYxFjq4E1IuACwB+82VXDpc8Ht6ayKQDrnZp97MVBqhhy3hEKE2Ny0l8xv50wZ
        f5BFYQNx/DexxldFY5i5rGuZwVopAxs9mvw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fVCjqbuLzPLF for <linux-block@vger.kernel.org>;
        Fri, 28 Oct 2022 01:07:30 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzFX00SKwz1RvLy;
        Fri, 28 Oct 2022 01:07:27 -0700 (PDT)
Message-ID: <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 17:07:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 17:01, John Garry wrote:
> On 27/10/2022 23:25, Damien Le Moal wrote:
>>> So we have this overall flow:
>>>
>>> ata_exec_internal_sg():
>>>    -> alloc request
>>>    -> blk_execute_rq_nowait()
>>>        ... -> scsi_queue_rq()
>>> 		-> sht->reserved_queuecommd()
>>> 			-> ata_internal_queuecommand()
>>>
>>> And then we have ata_internal_queuecommand() -> ata_sas_queuecmd() ->
>>> ata_scsi_queue_internal() -> ata_qc_issue().
>>>
>>> Hope it makes sense.
>> OK. Got it.
>> However, ata_exec_internal_sg() being used only from EH context with the
>> queue quiesced, will blk_execute_rq_nowait() work ? Is there an exception
>> for internal reserved tags ?
>>
> 
> Well, yeah. So if some error happens and EH kicks in, then full queue 
> depth of requests may be allocated. I have seen this for NCQ error. So 
> this is why I make in very first patch change allow us to allocate 
> reserved request from sdev request queue even when budget is fully 
> allocated.
> 
> Please also note that for AHCI, I make reserved depth =1, while for SAS 
> controllers it is greater. This means that in theory we could alloc > 1x 
> reserved command for SATA disk, but I don't think it matters.

Yes, 1 is enough. However, is 1 reserved out of 32 total, meaning that the
user can only use 31 tags ? or is it 32+1 reserved ? which we can do since
when using the reserved request, we will not use a hw tag (all reserved
requests will be non-ncq).

The 32 + 1 scheme will work. But for CDL command completion handling, we
will need a NCQ command to do a read log, to avoid forcing a queue drain.
For that to reliably work, we'll need a 31+1+1 setup...

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

