Return-Path: <axboe@kernel.dk>
Subject: Re: confusion about bio_split
To: NeilBrown <neilb@suse.com>, Wang Sheng-Hui <shhuiw@foxmail.com>,
 linux-block <linux-block@vger.kernel.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <tencent_2CB1180FF26CF53DED88D66CCA27AA87DC0A@qq.com>
 <87o9ll83gr.fsf@notabene.neil.brown.name>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0d6cd230-42e6-cef7-d660-eac84d71ecdf@kernel.dk>
Date: Tue, 23 Jan 2018 09:12:19 -0700
MIME-Version: 1.0
In-Reply-To: <87o9ll83gr.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/23/18 12:00 AM, NeilBrown wrote:
> On Mon, Jan 15 2018, Wang Sheng-Hui wrote:
> 
>> Dear,
>>
>> Sorry to trouble you.
>>
>> I'm confused by the following code in bio.c/bio_split:
>> -------------------------------------
>> struct bio *bio_split(struct bio *bio, int sectors,
>> ...
>> 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>> 		bio_set_flag(bio, BIO_TRACE_COMPLETION);         
>> ...
>> }
>> EXPORT_SYMBOL(bio_split);
>> ------------------------------------
>>
>> I think it maybe flag on the new split set, right?
> 
> Goldwyn Rodrigues posted a patch to fix this a couple of
> months ago.
> Jens - can you apply that?  Do you need it resent?
> 
> https://www.mail-archive.com/linux-block@vger.kernel.org/msg16039.html

I got it now, applied. Thanks.

-- 
Jens Axboe
