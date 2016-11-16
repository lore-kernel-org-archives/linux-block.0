Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Add notes to use LightNVM
To: Yasuaki Ishimatsu <yasu.isimatu@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <37a5a6a3-cd8b-db98-b4f3-7bd66a5bf4d8@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e36a52e5-6c30-7a0b-ee8c-51ca452e6e17@kernel.dk>
Date: Wed, 16 Nov 2016 08:27:36 -0700
MIME-Version: 1.0
In-Reply-To: <37a5a6a3-cd8b-db98-b4f3-7bd66a5bf4d8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/27/2016 09:56 AM, Yasuaki Ishimatsu wrote:
> If CONFIG_NVM is disabled, loading null_block module with use_lightnvm=1
> fails. But there are no messages and documents related to the failure.
>
> So the patch adds the notes to use LightNVM.

Added, with some slight text adjustments. Thanks.

-- 
Jens Axboe
