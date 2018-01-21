Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55245 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeAUCYC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jan 2018 21:24:02 -0500
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
Date: Sat, 20 Jan 2018 20:23:56 -0600
MIME-Version: 1.0
In-Reply-To: <87zi58rmf7.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 01/20/2018 08:11 PM, Andi Kleen wrote:
> Goldwyn Rodrigues <rgoldwyn@suse.de> writes:
> 
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> In case direct I/O encounters an error midway, it returns the error.
>> Instead it should be returning the number of bytes transferred so far.
> 
> It's likely there's a lot of code in user space that does
> 
>      if (write(..., N) < 0) handle error
> 
> With your change it would need to be
> 
>      if (write(..., N) != N) handle error
> 
> How much code is actually doing that?
> 
> I can understand it fixes your artifical test suite, but it seems to me your
> change has a high potential to break a lot of existing user code
> in subtle ways. So it seems to be a bad idea.
> 
> -Andi
> 


Quoting 'man 2 write':

RETURN VALUE
 On  success,  the  number  of bytes written is returned (zero indicates
 nothing was written).  It is not an error if  this  number  is  smaller
 than the number of bytes requested; this may happen for example because
 the disk device was filled.  See also NOTES.

-- 
Goldwyn
