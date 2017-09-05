Return-Path: <i@coly.li>
Subject: Re: [PATCH 01/19] bcache: Fix leak of bdev reference
To: Christoph Hellwig <hch@infradead.org>
Cc: bcache@lists.ewheeler.net, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org, axboe@kernel.dk, Jan Kara <jack@suse.cz>
References: <20170629134510.GA32385@infradead.org>
 <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
 <20170705182447.GA10673@infradead.org>
 <e9019647-62b5-1c14-8b2f-66528b972b5c@coly.li>
 <20170905064348.GA23716@infradead.org>
From: Coly Li <i@coly.li>
Message-ID: <164b1a85-1753-cff4-9571-bb1cf085d4ac@coly.li>
Date: Tue, 5 Sep 2017 14:55:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170905064348.GA23716@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2017/9/5 下午2:43, Christoph Hellwig wrote:
> On Tue, Sep 05, 2017 at 01:30:04AM +0800, Coly Li wrote:
>>
>> When you mentioned "whole chunk of code", do you mean the following
>> block of code ?
>>
>>
>> 1960         if (IS_ERR(bdev)) {
>> ========= start of whole chunk of code ============
>> 1961                 if (bdev == ERR_PTR(-EBUSY)) {
>> 1962                         bdev = lookup_bdev(strim(path));
>> 1963                         mutex_lock(&bch_register_lock);
>> 1964                         if (!IS_ERR(bdev) && bch_is_open(bdev))
>> 1965                                 err = "device already registered";
>> 1966                         else
>> 1967                                 err = "device busy";
>> 1968                         mutex_unlock(&bch_register_lock);
>> 1969                         if (!IS_ERR(bdev))
>> 1970                                 bdput(bdev);
>> 1971                         if (attr == &ksysfs_register_quiet)
>> 1972                                 goto out;
>> 1973                 }
>> ========= end of whole chunk of code ============
>> 1974                 goto err;
>> 1975         }
>>
>> I don't mind to remove it, just double check I don't misunderstand what
>> you meant.
> 
> Yes, that's the problematic block.
> 
Understand, I will send out a patch, hopefully it can catch up 4.14
merge window.

Thanks for the hint.

-- 
Coly Li
