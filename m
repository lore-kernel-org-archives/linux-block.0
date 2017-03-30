Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Minchan Kim <minchan@kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox> <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
 <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de> <20170307085545.GA538@bbox>
 <10a2335c-0ed0-43de-1cbd-625845301aef@suse.de> <20170308051118.GA11206@bbox>
 <1073055f-e71b-bb07-389a-53b60ccdee20@suse.de> <20170309052829.GA854@bbox>
 <CAEwNFnBnEObVdjqNdvh_-Dc0ryDjeW3c1qVdfOCbbyQREaDdqA@mail.gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Nitin Gupta <ngupta@vflare.org>,
 Christoph Hellwig <hch@lst.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, yizhan@redhat.com,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <d5ad0aeb-0a8f-5ebd-f788-c6f6d92b76cf@fb.com>
Date: Thu, 30 Mar 2017 09:35:56 -0600
MIME-Version: 1.0
In-Reply-To: <CAEwNFnBnEObVdjqNdvh_-Dc0ryDjeW3c1qVdfOCbbyQREaDdqA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/30/2017 09:08 AM, Minchan Kim wrote:
> Hi Jens,
> 
> It seems you miss this.
> Could you handle this?

I can, but I'm a little confused. The comment talks about replacing
the one I merged with this one, I can't do that. I'm assuming you
are talking about this commit:

commit 0bc315381fe9ed9fb91db8b0e82171b645ac008f
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Mon Mar 6 11:23:35 2017 +0100

    zram: set physical queue limits to avoid array out of bounds accesses

which is in mainline. The patch still applies, though.

Do we really REALLY need this for 4.11, or can we queue for 4.12 and
mark it stable?

-- 
Jens Axboe
