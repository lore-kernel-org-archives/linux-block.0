Return-Path: <axboe@kernel.dk>
Subject: Re: Oops on the system startup in the function part_in_flight()
To: Krzysztof Kolasa <kkolasa@winsoft.pl>, linux-block@vger.kernel.org
References: <964a2654-3b86-c9f6-1522-0854d1e4ab0d@winsoft.pl>
 <89aa304b-9ebe-3d2f-3898-edfb4e0e4b87@winsoft.pl>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <32beb9f5-f818-338c-bf41-4eb720fe8409@kernel.dk>
Date: Sun, 24 Sep 2017 20:07:11 -0600
MIME-Version: 1.0
In-Reply-To: <89aa304b-9ebe-3d2f-3898-edfb4e0e4b87@winsoft.pl>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/23/2017 12:36 PM, Krzysztof Kolasa wrote:
> bisected bad commit:
> 
> # first bad commit: [f299b7c7a9dee64425e5965bd4f56dc024c1befc] blk-mq: provide internal in-flight variant

Can you see if this patch fixes it:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=cd9e0a08e4f6173f9d7a469cabd09938fc4f0e25

-- 
Jens Axboe
