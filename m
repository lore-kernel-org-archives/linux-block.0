Return-Path: <axboe@kernel.dk>
Subject: Re: Why the field 'depth use different data types in sbitmap and
 sbitmap_word
To: Wang Sheng-Hui <shhuiw@foxmail.com>, linux-block@vger.kernel.org
References: <dbca3ab6-c4e3-4415-7def-a056e415e036@foxmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <724ef37d-6463-0842-75af-93f43254998d@kernel.dk>
Date: Sun, 8 Jan 2017 16:08:35 -0700
MIME-Version: 1.0
In-Reply-To: <dbca3ab6-c4e3-4415-7def-a056e415e036@foxmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/07/2017 06:21 AM, Wang Sheng-Hui wrote:
> Hi,
> 
> Sorry to trouble you.
> 
> I have one question about the define of struct sbitmap & sbitmap_word:
>       In sbitmap_word, the field depth is 'unsigned long', but in sbitmap, the field depth is 'unsigned int'.
>       Why they use different data types?

No particular reason. The bit ops use unsigned long, so that is why
sbitmap_word uses it. unsigned int should be enough for sbitmap in
general.

-- 
Jens Axboe
