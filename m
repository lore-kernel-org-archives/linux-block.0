Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: don't check position contiguity for DISCARD in
 attempt_merge
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
 <yq15zxyj5ep.fsf@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <09103f89-35af-e4e5-fd7c-e3f48e6fda75@oracle.com>
Date: Sat, 20 Oct 2018 21:57:44 +0800
MIME-Version: 1.0
In-Reply-To: <yq15zxyj5ep.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Martin

On 10/19/18 11:57 PM, Martin K. Petersen wrote:
> 
> Jianchao,
> 
>> Discard command supports multiple ranges of blocks, so needn't
>> checking position contiguity when merging. Let's do the same thing
>> in attempt_merge as the blk_try_merge.
> 
> Discards need to be contiguous unless queue->limits.max_discard_segments
> is bigger than 1. So if you remove this I think you need to add a
> contiguity check in req_attempt_discard_merge().
> 
Yes.

I will send the V2 version next.

Thanks
Jianchao
