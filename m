Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B5C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099EC22313
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="1y1afc8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKSBUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:20:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45340 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKSBUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 20:20:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so16365181otk.12
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 17:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LJ59oqnF6x3U59y807aLU5jRRBQycubcL7on9piFroU=;
        b=1y1afc8jcLyQ32mTCS9uQ0OmofjTL01knVVxeA8Xe/HiQhZhQO5mU5oORMEQZm//6o
         LXUtf9E66qhXQnnFefONeWehgdyMhyFE+FVMR5tGdF4ehJ6GiE+MZc3d+BtdqtZWOd34
         7x81LZQqCOP96PjtM80LQrf1ZrHNQvdX6E/Dk4R7zKB4yKSsr47bHptm0j0ppubTSjC6
         DR7AxMJ1zckCH6saiYbvUPKaeLyoX3+n1Jy1HBeEJZJDoXdXMym8quYqJw6+y6R7j4nS
         sMvMcgAsxVXU84MqR33Az8sz82QjFgkpQalfeiVNXfOxPaOpAh8qp45fN1PaX3IckWF6
         HFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJ59oqnF6x3U59y807aLU5jRRBQycubcL7on9piFroU=;
        b=K4ULAEeXxexs92LnO36dF18yOTCV/ksDpJGSLf7vUCOE0Uj+pWqkam6OoJtVCTvPKk
         vKwqNVyyEfhc9WpTyCqSJJftehaQzZREllmISmBF8sGHIzr5g/lx0NuHTAjx8adf+Wja
         cUaIUC104qY9UBesgpGaA1m3tfffrCEDON9Aet4iqP6l4CkZm4TQAr3Zb4eUt2hK52xT
         4Y7/sf7Z2mm24RbCngxZVEfK8AzL8OnN2VMIgCx30hVbniXKQOIvQItj0GR8zLht+Ytz
         JHt5lwydN07kY1zmkoZJ2HV8Tg0Q6PUezLkajn59LmtBWvnVb6stDNf7wxp3K+Sn+sDT
         ez7g==
X-Gm-Message-State: APjAAAXMNpVEXMtXoxySE7VY+jOC9NKAQD0bE6cgPMBt/HRT3RqfQGEh
        ge+DBp65uIga5IADQjvR98UNUQ==
X-Google-Smtp-Source: APXvYqxD2Gk7A0ertGhDDXxcSFbmOh/nPpTSezEjzSbKD9572h/SqZBrdpCxVwggFu8wV5X3o/CUvA==
X-Received: by 2002:a9d:1b70:: with SMTP id l103mr1781270otl.154.1574126409028;
        Mon, 18 Nov 2019 17:20:09 -0800 (PST)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:4870:71e0:c8a4:b0da:bc77:d506])
        by smtp.gmail.com with ESMTPSA id u143sm6730839oia.14.2019.11.18.17.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 17:20:08 -0800 (PST)
Subject: Re: [PATCH v2 1/4] skd: Prefer pcie_capability_read_word()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20191118002057.9596-1-fred@fredlawl.com>
 <20191118002057.9596-2-fred@fredlawl.com>
 <BYAPR04MB5816EDC3676A964C2D1D874BE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <653fa44d-7edc-8440-b778-79c127c0aa3b@fredlawl.com>
Date:   Mon, 18 Nov 2019 19:20:05 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.18
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816EDC3676A964C2D1D874BE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Damien Le Moal wrote on 11/17/19 7:45 PM:
> On 2019/11/18 9:21, Frederick Lawler wrote:
>> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
>> added accessors for the PCI Express Capability so that drivers didn't
>> need to be aware of differences between v1 and v2 of the PCI
>> Express Capability.
>>
>> Replace pci_read_config_word() and pci_write_config_word() calls with
>> pcie_capability_read_word() and pcie_capability_write_word().
>>
>> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
>> ---
>>   drivers/block/skd_main.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
>> index 51569c199a6c..f25f6ef6b4c7 100644
>> --- a/drivers/block/skd_main.c
>> +++ b/drivers/block/skd_main.c
>> @@ -3134,18 +3134,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
>>   
>>   static char *skd_pci_info(struct skd_device *skdev, char *str)
>>   {
>> -	int pcie_reg;
>> -
>>   	strcpy(str, "PCIe (");
>> -	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
>>   
>> -	if (pcie_reg) {
>> +	if (pci_is_pcie(skdev->pdev)) {
> 
> Maybe return early here ? The reason is that if pci_is_pcie() is false,
> then the string "PCIe (" is not terminated with a closing parenthesis.
> So something like:
> 
> 	if (!pci_is_pcie(skdev->pdev)) {
> 		strcat(str, ")");
> 		return str;
> 	}
> 
> May be better. Note that the "return str" is also rather pointless since
> it is not used by the caller of skd_pci_info().
> 

I agree, but it might be better to include a note that this is not a 
PCIe device. Reading "PCIe ()" seems weird to me.

>>   
>>   		char lwstr[6];
>>   		uint16_t pcie_lstat, lspeed, lwidth;
>>   
>> -		pcie_reg += 0x12;
>> -		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
>> +		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
>>   		lspeed = pcie_lstat & (0xF);
>>   		lwidth = (pcie_lstat & 0x3F0) >> 4;
>>   
>>
> 
>

Thanks,
Frederick Lawler

