Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Follow up block changes for this merge window
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block <linux-block@vger.kernel.org>
References: <5ba8d7db-03fe-4983-5636-78f0ff6881bb@kernel.dk>
 <CA+55aFyHYPATi0wTbKBBTEQvtoh4=rdFRz5zBQOnEzfT4h67og@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0180fdfe-ac2f-5388-dc0d-e33a173bb85b@kernel.dk>
Date: Wed, 22 Aug 2018 15:05:36 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFyHYPATi0wTbKBBTEQvtoh4=rdFRz5zBQOnEzfT4h67og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/22/18 2:39 PM, Linus Torvalds wrote:
> On Wed, Aug 22, 2018 at 10:54 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> - Set of bcache fixes and changes (Coly)
> 
> Some of those bcache style fixes look questionable.
> 
> Maybe we should push back on some of the checkpatch rules instead?
> 
> Like having argument names in declarations - sometimes descriptive
> names can be good documentation. And sometimes they are just noise,
> because the type is what describes it.
> 
> Oh well. Taken.

Thanks - fwiw, I don't disagree, and I tend to push back harder on
this in core code than drivers. Especially for newer maintainers,
as it can sometimes be a way to dabble around in the code and
find "real" issues.

-- 
Jens Axboe
