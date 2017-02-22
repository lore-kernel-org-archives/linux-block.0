Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932820AbdBVOfj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 09:35:39 -0500
Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
 <20170222071342.GA17472@lst.de>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <d9164183-013f-eab9-9469-9631b0f85d89@intel.com>
Date: Wed, 22 Feb 2017 07:35:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170222071342.GA17472@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/22/2017 12:13 AM, Christoph Hellwig wrote:
>> +	if (!lock_held)
>> +		mutex_lock(&dev->dev_lock);
> 
> No conditional locking, please.  I guess I causesd this by asking you
> to remove __opal_lock_unlock, but it seems we'd either need to keep it
> in the end.
> 
> Except for that the series looks fine to me.
> 
> Jens: given that 1-3 are the important fixes how about you pick those
> up ASAP?  They all also had my Reviewed-by for previous postings.
> 
Thanks

I'll respin just 4/4 shortly with __opal_lock_unlock
