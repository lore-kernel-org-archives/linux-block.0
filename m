Return-Path: <rgoldwyn@suse.de>
Subject: Re: [PATCH 0/10 v13] merge request: No wait AIO
To: Jens Axboe <axboe@kernel.dk>
Cc: viro@ZenIV.linux.org.uk, hch@lst.de, jack@suse.cz,
 akpm@linux-foundation.org, linux-block@vger.kernel.org
References: <20170619163348.15542-1-rgoldwyn@suse.de>
 <a3c9ac14-d04d-2dc5-c656-879c6262aa96@kernel.dk>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <16569216-f35a-8ed3-9fe5-2323d587f24f@suse.de>
Date: Mon, 19 Jun 2017 18:20:33 -0500
MIME-Version: 1.0
In-Reply-To: <a3c9ac14-d04d-2dc5-c656-879c6262aa96@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 06/19/2017 06:15 PM, Jens Axboe wrote:
> On 06/19/2017 10:33 AM, Goldwyn Rodrigues wrote:
>> Jens,
>>
>> As Christoph suggested, I am sending the patches against the block
>> tree for merge since the block layer changes had the most conflicts.
>> My tree is at https://github.com/goldwynr/linux/tree/nowait-block
> 
> I can merge it for 4.13, but I need Al to be happy with it first.
> 

I understand. I am working on another version to include support for dax
files. I will post the updated patches shortly.

-- 
Goldwyn
