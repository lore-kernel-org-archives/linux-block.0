Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 martin.petersen@oracle.com
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-2-git-send-email-axboe@kernel.dk>
 <20170627144255.GB2541@infradead.org>
 <ec6ab0fa-60d7-3aa5-aa7c-81c105bdd488@kernel.dk>
 <20170627151621.GA27962@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9df1d7ae-eba7-2bc5-f89f-15b8f97173bd@kernel.dk>
Date: Tue, 27 Jun 2017 09:18:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170627151621.GA27962@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 09:16 AM, Christoph Hellwig wrote:
> On Tue, Jun 27, 2017 at 09:09:48AM -0600, Jens Axboe wrote:
>> On 06/27/2017 08:42 AM, Christoph Hellwig wrote:
>>> The API looks ok, but the code could use some cleanups.  What do
>>> you think about the incremental patch below:
>>>
>>> It refactors various manipulations, and stores the write hint right
>>> in the iocb as there is a 4 byte hole (this will need some minor
>>> adjustments in the next patches):
>>
>> How's this? Fixes for compile, and also squeeze an enum rw_hint into
>> a hole in the inode structure.
>>
>> I'll refactor around this and squeeze into bio/rq holes as well, then
>> re-test it.
> 
> Looks good, minor nitpick below:
> 
>> index 4574121f4746..4587a181162e 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -265,6 +265,20 @@ struct page;
>>  struct address_space;
>>  struct writeback_control;
>>  
>> +#include <linux/fcntl.h>
> 
> I didn't seem to need the move.  But if you want to move it can
> we keep all the includes together at the very top?

It did here, we need it for the RWH_ defines or my compile blows up.
But yeah, let's just move it to the top, not sure why it's in the
middle.

>> +static inline enum rw_hint __inode_write_hint(struct inode *inode)
>> +{
>> +	return inode->i_write_hint;
>> +}
>> +
>> +static inline enum rw_hint inode_write_hint(struct inode *inode)
>> +{
>> +	enum rw_hint ret = __inode_write_hint(inode);
>> +	if (ret != WRITE_LIFE_NOT_SET)
>> +		return ret;
>> +	return WRITE_LIFE_NONE;
>> +}
>> +
>> +static inline enum rw_hint __file_write_hint(struct file *file)
>> +{
>> +	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
>> +		return file->f_write_hint;
>> +
>> +	return __inode_write_hint(file_inode(file));
>> +}
>> +
>> +static inline enum rw_hint file_write_hint(struct file *file)
>> +{
>> +	enum rw_hint ret = __file_write_hint(file);
>> +	if (ret != WRITE_LIFE_NOT_SET)
>> +		return ret;
>> +	return WRITE_LIFE_NONE;
>> +}
> 
> I'd say kill all these helpers and just treat both WRITE_LIFE_NONE
> and WRITE_LIFE_NOT_SET special all the way down in NVMe.

Sure, we can do that.

-- 
Jens Axboe
