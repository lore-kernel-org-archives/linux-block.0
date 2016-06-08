Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] ext4: use bio op helprs in ext4 crypto code
To: mchristi@redhat.com, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org
References: <1465418981-7360-1-git-send-email-mchristi@redhat.com>
 <1465418981-7360-2-git-send-email-mchristi@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57588771.4050905@kernel.dk>
Date: Wed, 8 Jun 2016 15:00:33 -0600
MIME-Version: 1.0
In-Reply-To: <1465418981-7360-2-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/08/2016 02:49 PM, mchristi@redhat.com wrote:
> From: Mike Christie <mchristi@redhat.com>
>
> This was missed from my last patchset.
>
> This patch has ext4 crypto code use the bio op helper
> to set the operation. The operation (discard, write, writesame,
> etc) is now defined seperately from the other REQ bits. They
> still share the bi_rw field to save space, so we use these
> helpers so modules do not have to worry about setting/overwriting
> info.
>
> Jens, I am not sure how you handle patches on top of patches
> in the next branches. If you merge patches that fix issues
> in previous patches in next, then this patch could be part
> of

Since it's all merged, there's only one way to handle it - and that's to 
apply this on top. I can't fold patches at this point.

-- 
Jens Axboe
