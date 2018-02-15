Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36030 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbeBOI5m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Feb 2018 03:57:42 -0500
Received: by mail-lf0-f45.google.com with SMTP id t79so33048077lfe.3
        for <linux-block@vger.kernel.org>; Thu, 15 Feb 2018 00:57:42 -0800 (PST)
Subject: Re: [PATCH V2 4/4] nvme: lightnvm: add late setup of block size and
 metadata
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20180209092719.10679-1-mb@lightnvm.io>
 <20180209092719.10679-5-mb@lightnvm.io>
 <098A1343-A9FB-47BD-A4B5-6E77A1861A4B@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e4b51c0b-35da-705e-b723-2f568fee69a7@lightnvm.io>
Date: Thu, 15 Feb 2018 09:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <098A1343-A9FB-47BD-A4B5-6E77A1861A4B@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/12/2018 09:21 PM, Javier Gonzalez wrote:
> 
>> On 9 Feb 2018, at 01.27, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> The nvme driver sets up the size of the nvme namespace in two steps.
>> First it initializes the device with standard logical block and
>> metadata sizes, and then sets the correct logical block and metadata
>> size. Due to the OCSSD 2.0 specification relies on the namespace to
>> expose these sizes for correct initialization, let it be updated
>> appropriately on the LightNVM side as well.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>>
> 
> This late initialization breaks ligthnvm's core init since the sector
> size (csecs) is used on the first init part to set the logical block size.
> 
> nvm_core_init -> blk_queue_logical_block_size(dev->q, dev_geo->c.csecs);
> 
> We can do do a nvme_nvm_revalidate and set this on the revalidation path
> instead of simply updating the info as in nvme_nvm_update_nvm_info().'

I believe that is what the patch does (nvme_nvm_update_nvm_info is 
called from the nvme_revalidate_disk context).

The nvm_core_init initialization of the block size is redundant and 
should be removed. I'll update the patch.
