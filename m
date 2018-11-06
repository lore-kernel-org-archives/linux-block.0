Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:59599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbeKFLmi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Nov 2018 06:42:38 -0500
Subject: Re: [PATCH blktests] fix discontiguous-io compile error on 32 bit
 systems
To: Bart Van Assche <bvanassche@acm.org>, <osandov@fb.com>
CC: <linux-block@vger.kernel.org>, <bart.vanassche@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>
References: <1541054148-144718-1-git-send-email-yuyufen@huawei.com>
 <1541083968.196084.140.camel@acm.org>
From: yuyufen <yuyufen@huawei.com>
Message-ID: <1813f3ce-e3ec-05b8-b0b0-394265ac19d0@huawei.com>
Date: Tue, 6 Nov 2018 10:19:46 +0800
MIME-Version: 1.0
In-Reply-To: <1541083968.196084.140.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2018/11/1 22:52, Bart Van Assche wrote:
> On Thu, 2018-11-01 at 14:35 +0800, Yufen Yu wrote:
>> When make discontiguous-io.cpp with -m32, g++ compiler reports
>> error for std::min(long unsigned int, size_t) has diffent
>> arguments type.
>>
>> fixes: fd21728886e7 ("Add the discontiguous-io test program")
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   src/discontiguous-io.cpp | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
>> index 5e0ee0f..855aba9 100644
>> --- a/src/discontiguous-io.cpp
>> +++ b/src/discontiguous-io.cpp
>> @@ -291,7 +291,7 @@ int main(int argc, char **argv)
>>   			unsigned char *p = &*buf.begin();
>>   			for (int i = 0; i < len / 4; i++)
>>   				iov.append(p + 4 + i * 8,
>> -					   std::min(4ul, len - i * 4));
>> +					   std::min((size_t)4, len - i * 4));
>>   		} else {
>>   			iov.append(&*buf.begin(), buf.size());
>>   		}
> Are you reading the messages posted on linux-block? An alternative that I like
> better has been discussed in this e-mail thread:
> https://www.spinics.net/lists/linux-block/msg32181.html
>
> Bart.
>
> .
>

I am sorry that I did not see the discussion before this.
And you are right. Please ignore this patch.

Yufen.
thanks
