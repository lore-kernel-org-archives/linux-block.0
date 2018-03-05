Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Duplicate UUID fixes for 4.16
To: Michael Lyle <mlyle@lyle.org>, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org
References: <20180305214155.23395-1-mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c3cb84f-2d6b-f4b8-dd02-9d57b70ecdea@kernel.dk>
Date: Mon, 5 Mar 2018 14:46:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180305214155.23395-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/5/18 2:41 PM, Michael Lyle wrote:
> Jens--
> 
> Sorry for a couple of last-minute changes.  Marc Merlin noticed an issue
> with disk imaging where if multiple devices were present with the same
> bcache UUID that a kernel panic could result.  Tang Junhui fixed this.
> I found a related data corruption issue with duplicate backing devices.
> 
> Both are minimal, reviewed, and tested.  As always, thanks for your help.

Applied, thanks Mike.

-- 
Jens Axboe
