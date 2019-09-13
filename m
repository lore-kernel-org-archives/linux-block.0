Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE09FC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 14:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A405E20830
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 14:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbfIMO6Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:58:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388211AbfIMO6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 10:58:25 -0400
Received: from [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3] (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C715C28F078;
        Fri, 13 Sep 2019 15:58:21 +0100 (BST)
Subject: Re: [PATCH 3/3] null_blk: validated the number of devices
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "m@bjorling.me" <m@bjorling.me>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
 <20190911144636.226945-3-andrealmeid@collabora.com>
 <20190912161937.GK29434@bombadil.infradead.org>
 <dbdb0415-8762-f9c1-a65a-3531d9cca109@collabora.com>
 <DM6PR04MB5754177B405819C802549AE686B00@DM6PR04MB5754.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <d55554f5-7212-c5fc-dbb0-4269be913aaa@collabora.com>
Date:   Fri, 13 Sep 2019 11:57:17 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB5754177B405819C802549AE686B00@DM6PR04MB5754.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/19 7:20 PM, Chaitanya Kulkarni wrote:
> On 09/12/2019 03:09 PM, André Almeida wrote:
>> Hello Matthew,
>>
>> On 9/12/19 1:19 PM, Matthew Wilcox wrote:
>>> On Wed, Sep 11, 2019 at 11:46:36AM -0300, André Almeida wrote:
>>>>
>>>> -static int nr_devices = 1;
>>>> +static unsigned int nr_devices = 1;
>>>>   module_param(nr_devices, int, 0444);
>>>
>>> ^^^ you forgot to change the module_param to match
>>>
>>>> +	if (!nr_devices) {
>>>> +		pr_err("null_blk: invalid number of devices\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>> I don't think this is necessary.
>>>
>>
>> Could you explain why you don't think is necessary? As I see, the module
>> can't be used without any /dev/nullb* device, so why we should load it?
>>
>> Thanks,
>> 	André
>>
> 
> I think Matthew is right here. I think module can be loaded with 
> nr_devices=0.
> 
> Did you get a chance to test nr_device=0 condition ?
> 

Yes. It says "module loaded" and lsmod shows that it is loaded indeed.
But you don't have any /dev/nullb*, so you can't do much with the module.

With this patch, it refuses to load the module.

> Also, did you get a chance to test this patch with all the
> possible conditions ?
>

I did not tested with all possible conditions, but I tested with the
following ones:

* Using a negative number of devices:
	- Previously, it would alloc and add a huge number of devices until the
system gets out of memory
	- With module_param as uint, it will throw a "invalid for parameter
`nr_devices'" and refuse to load

* Using a range of values (1, 10, 100, 1000):
	- It will works as expect, creating some /dev/nullbX accordingly with
your parameter. Works fine with and without this patch.
