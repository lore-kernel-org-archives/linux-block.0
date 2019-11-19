Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB6C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E40522310
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="zTeOhlOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKSBVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:21:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33894 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSBVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 20:21:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id l202so17342278oig.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 17:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bU9yatWUATDadtyUGjLu2bxv54BFgg0wz4MPxKlXIOs=;
        b=zTeOhlOhY7SzoVwDvHQZNQR1o/r1BerSB+zKMZ5D+hlOH1KxEHActHws1wYP8RAg2H
         MCR5BxI5Q1+cOZIdzypDxS7RIz/dpCCer1jq/olgGO8wG9PQiwZqJRxd0uCBxVe5RbI9
         p+4505BHgu3+pYlcuEvB5VKArubyJabfEj2A6dRfmu8a/6rZZARqwrR5p49NFsgdJI/I
         zPzHz8o042ad4XVXcxqocgddFCBwcYy8s5ao/3pOIVJAI4mDC6HLjFHvZn4Y+K4ZfJ+M
         8PMkdqTN05K2eHBkDqdSxATRry1+fhFTN+vSEpFv7QXQtSO2FSm/amDOJw2JDOMHL8Jw
         54Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bU9yatWUATDadtyUGjLu2bxv54BFgg0wz4MPxKlXIOs=;
        b=IrozL97GqbXzXbppaCJtEbFCcaJ3D2DzGWvxbHDf0Eekz/tbNkZrxQL3943uz1uzMF
         hKCL/gkGhOCzazzmGnlA99d3rDW4Tl9jXJGYakygDL5HaUTubrpFv6wREReCQMANuyOQ
         i6ceG4nDI6JHck0PvxkU72uqZxNnqvE5re1NkgjGeJd6QjlmJaKAKh1zB2PEXPQ9D3Pc
         Gp7sq5Axr6Nyoc5Qc5fCguOvPPI3v841dVpYHfjQ9qBzam4F0C9KijBjl6sIPUb+zgtD
         xrJABKHWRh9456kZUo2ymta4DZv2qO/+aW3NCKrY1Sofz10H06lsJuHCblSWn+Fv1B0G
         TGDg==
X-Gm-Message-State: APjAAAUdJK0HXlIDEC+AqyfVDS4HI4Dn3q6TZwhqyUtBGBDdM+npqy5H
        /iZKO5QW+F6kNCzT5I8P/LkZpQ==
X-Google-Smtp-Source: APXvYqz9bHbxBf7mwUCUBa4jCc1enfY2KcIv7maD6VbCwjP26gmFlWsYsAUbM+9fh5TNy/IVQhCZyQ==
X-Received: by 2002:a05:6808:b17:: with SMTP id s23mr1749904oij.102.1574126487415;
        Mon, 18 Nov 2019 17:21:27 -0800 (PST)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:4870:71e0:c8a4:b0da:bc77:d506])
        by smtp.gmail.com with ESMTPSA id b12sm6785523otl.34.2019.11.18.17.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 17:21:26 -0800 (PST)
Subject: Re: [PATCH v2 2/4] skd: Replace magic numbers with PCI constants
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20191118002057.9596-1-fred@fredlawl.com>
 <20191118002057.9596-3-fred@fredlawl.com>
 <BYAPR04MB58162980CA2A2244626C999DE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <a01d4103-b756-afd5-2cc0-e40115a41343@fredlawl.com>
Date:   Mon, 18 Nov 2019 19:21:24 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.18
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB58162980CA2A2244626C999DE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Damien Le Moal wrote on 11/17/19 7:45 PM:
> On 2019/11/18 9:21, Frederick Lawler wrote:
>> Readability was improved by replacing pci_read_config_word() with
>> pcie_capability_read_word(). Take that a step further by replacing magic
>> numbers with PCI reg constants.
>>
>> No functional change intended.
>>
>> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
>> ---
>> v2
>> - Added this patch
>> ---
>>   drivers/block/skd_main.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
>> index f25f6ef6b4c7..7f8243573ad9 100644
>> --- a/drivers/block/skd_main.c
>> +++ b/drivers/block/skd_main.c
>> @@ -3141,9 +3141,11 @@ static char *skd_pci_info(struct skd_device *skdev, char *str)
>>   		char lwstr[6];
>>   		uint16_t pcie_lstat, lspeed, lwidth;
>>   
>> -		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
>> -		lspeed = pcie_lstat & (0xF);
>> -		lwidth = (pcie_lstat & 0x3F0) >> 4;
>> +		pcie_capability_read_word(skdev->pdev, PCI_EXP_LNKSTA,
>> +					  &pcie_lstat);
>> +		lspeed = pcie_lstat & PCI_EXP_LNKSTA_CLS;
>> +		lwidth = (pcie_lstat & PCI_EXP_LNKSTA_NLW) >>
>> +			 PCI_EXP_LNKSTA_NLW_SHIFT;
>>   
>>   		if (lspeed == 1)
>>   			strcat(str, "2.5GT/s ");
>>
> 
> Looks OK to me. But since this is changing again one line that is added
> by patch 1/4, why not make patch 1 and this patch changes a single patch ?
> 

Works for me.

Thanks,
Frederick Lawler

