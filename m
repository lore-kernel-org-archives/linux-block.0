Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bvec: avoid variable shadowing warning
To: Johannes Berg <johannes@sipsolutions.net>, linux-block@vger.kernel.org
References: <1470903356-22381-1-git-send-email-johannes@sipsolutions.net>
Cc: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
 Johannes Berg <johannes.berg@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ebaa14b-f54a-3f58-410c-bc308dc91a24@kernel.dk>
Date: Thu, 11 Aug 2016 09:41:57 -0600
MIME-Version: 1.0
In-Reply-To: <1470903356-22381-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/11/2016 02:15 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Due to the (indirect) nesting of min(..., min(...)), sparse will
> show a variable shadowing warning whenever bvec.h is included.
>
> Avoid that by assigning the inner min() to a temporary variable first.

Grumble, reluctantly applied :-)

-- 
Jens Axboe
