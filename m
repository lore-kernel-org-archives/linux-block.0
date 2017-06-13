Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] add support for an inode to carry stream related
 data
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-5-git-send-email-axboe@kernel.dk>
 <C0001DC5-23C6-4B1E-B369-B72D1B631D5C@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6a1f3fc8-749b-fa55-b19f-e70ded630c92@kernel.dk>
Date: Tue, 13 Jun 2017 14:14:57 -0600
MIME-Version: 1.0
In-Reply-To: <C0001DC5-23C6-4B1E-B369-B72D1B631D5C@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 01:24 PM, Andreas Dilger wrote:
> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> No functional changes in this patch, just in preparation for
>> allowing applications to pass in hints about data life times
>> for writes.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> This is fine from the POV of passing the stream ID unchanged down the stack.
> If we really wanted to limit the ID to a 16-bit value, the i_stream could fit
> into a few 16-bit holes in struct inode, to avoid increasing its size.

Thanks, I'll change it to a short and pack the hole instead. Even with
everything else in there, having 64k streams is more than we need, might
as well do that.

-- 
Jens Axboe
