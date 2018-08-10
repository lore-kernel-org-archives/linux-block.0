Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbeHJLka (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 07:40:30 -0400
Subject: Re: [PATCH v2 03/17] bcache: add identifier names to arguments of
 function definitions
To: shenghui <shhuiw@foxmail.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180810072357.19823-1-colyli@suse.de>
 <20180810072357.19823-4-colyli@suse.de>
 <ba280eaf-9391-25bf-24d6-a513e180f9b4@foxmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <31fd4322-abf4-ecee-86f6-effd7f2729d5@suse.de>
Date: Fri, 10 Aug 2018 17:11:18 +0800
MIME-Version: 1.0
In-Reply-To: <ba280eaf-9391-25bf-24d6-a513e180f9b4@foxmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/8/10 4:26 PM, shenghui wrote:
> 
> 
> On 08/10/2018 03:23 PM, Coly Li wrote:
>> There are many function definitions do not have identifier argument names,
>> scripts/checkpatch.pl complains warnings like this,
>>
>>  WARNING: function definition argument 'struct bcache_device *' should
>>   also have an identifier name
>>   #16735: FILE: writeback.h:120:
>>   +void bch_sectors_dirty_init(struct bcache_device *);
>>
>> This patch adds identifier argument names to all bcache function
>> definitions to fix such warnings.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Shenghui Wang <shhuiw@foxmail.com>
>> ---
>>  drivers/md/bcache/bcache.h    | 112 +++++++++++++++---------------
>>  drivers/md/bcache/bset.h      | 126 +++++++++++++++++++---------------
>>  drivers/md/bcache/btree.c     |   6 +-
>>  drivers/md/bcache/btree.h     |  80 ++++++++++-----------
>>  drivers/md/bcache/debug.h     |   6 +-
>>  drivers/md/bcache/extents.h   |   6 +-
>>  drivers/md/bcache/journal.h   |  20 +++---
> 
> In journal.c, there is:
> 585 static void journal_write(struct closure *);
> 
> In super.c, there is:
> 2150 static ssize_t register_bcache(struct kobject *, struct kobj_attribute *,
> 2151                    const char *, size_t);
> 
> 

Nice catch, it will be fixed in v3 series.

Thanks.

Coly Li
