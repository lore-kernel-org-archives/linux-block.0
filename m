Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/7] elevator: make the rqhash helpers exported
To: Jens Axboe <axboe@fb.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-4-git-send-email-axboe@fb.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <20027cf9-c8ac-f0bd-c1fd-47bfaaf97df4@suse.de>
Date: Fri, 9 Dec 2016 07:45:19 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-4-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/elevator.c         | 8 ++++----
>  include/linux/elevator.h | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
