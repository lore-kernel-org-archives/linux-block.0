Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:19240 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeBBIJj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Feb 2018 03:09:39 -0500
Subject: Re: [PATCH v2] buffer: Avoid setting buffer bits that are already set
From: kemi <kemi.wang@intel.com>
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@fb.com>,
        Darrick J Wong <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
Cc: Dave <dave.hansen@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <1508807802-9691-1-git-send-email-kemi.wang@intel.com>
 <f18ba82a-e715-a71c-4904-3adc9b8ea149@intel.com>
Message-ID: <6e946728-23f5-d5df-c8d0-c9ec4251557c@intel.com>
Date: Fri, 2 Feb 2018 16:07:28 +0800
MIME-Version: 1.0
In-Reply-To: <f18ba82a-e715-a71c-4904-3adc9b8ea149@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, Jens
  Could you help to merge this patch to your tree? Thanks

On 2017年11月03日 10:29, kemi wrote:
> 
> 
> On 2017年10月24日 09:16, Kemi Wang wrote:
>> It's expensive to set buffer flags that are already set, because that
>> causes a costly cache line transition.
>>
>> A common case is setting the "verified" flag during ext4 writes.
>> This patch checks for the flag being set first.
>>
>> With the AIM7/creat-clo benchmark testing on a 48G ramdisk based-on ext4
>> file system, we see 3.3%(15431->15936) improvement of aim7.jobs-per-min on
>> a 2-sockets broadwell platform.
>>
>> What the benchmark does is: it forks 3000 processes, and each  process do
>> the following:
>> a) open a new file
>> b) close the file
>> c) delete the file
>> until loop=100*1000 times.
>>
>> The original patch is contributed by Andi Kleen.
>>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kemi Wang <kemi.wang@intel.com>
>> Tested-by: Kemi Wang <kemi.wang@intel.com>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>> ---
> 
> Seems that this patch is still not merged. Anything wrong with that? thanks
> 
>>  include/linux/buffer_head.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> index c8dae55..211d8f5 100644
>> --- a/include/linux/buffer_head.h
>> +++ b/include/linux/buffer_head.h
>> @@ -80,11 +80,14 @@ struct buffer_head {
>>  /*
>>   * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
>>   * and buffer_foo() functions.
>> + * To avoid reset buffer flags that are already set, because that causes
>> + * a costly cache line transition, check the flag first.
>>   */
>>  #define BUFFER_FNS(bit, name)						\
>>  static __always_inline void set_buffer_##name(struct buffer_head *bh)	\
>>  {									\
>> -	set_bit(BH_##bit, &(bh)->b_state);				\
>> +	if (!test_bit(BH_##bit, &(bh)->b_state))			\
>> +		set_bit(BH_##bit, &(bh)->b_state);              \
>>  }									\
>>  static __always_inline void clear_buffer_##name(struct buffer_head *bh)	\
>>  {									\
>>
