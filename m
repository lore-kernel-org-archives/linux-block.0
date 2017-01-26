Subject: Re: [dm-devel] split scsi passthrough fields out of struct request V2
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hch@lst.de" <hch@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <1485455329.2540.7.camel@sandisk.com>
 <e8f4b084-be66-d5b3-5785-13b80642040f@fb.com>
 <1485456745.2540.9.camel@sandisk.com>
 <db7f9165-19db-d1f2-a2fa-7546da57741b@fb.com> <20170126185924.GA25289@lst.de>
 <ee95c6dd-cdb4-7da5-2d4a-ec14034eac7a@fb.com>
 <71e22257-0592-fdd3-25e5-a78ceced2ab9@sandisk.com>
 <4054e944-b28d-1cd6-574f-6cd90e28c301@fb.com>
 <1485464486.2540.12.camel@sandisk.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <6995c991-65a4-8dca-c36e-fb2eff277ca9@fb.com>
Date: Thu, 26 Jan 2017 14:12:25 -0700
MIME-Version: 1.0
In-Reply-To: <1485464486.2540.12.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/26/2017 02:01 PM, Bart Van Assche wrote:
> On Thu, 2017-01-26 at 13:54 -0700, Jens Axboe wrote:
>> Your call path has blk_get_request() in it, I don't have
>> that in my tree. Is it passing in the right mask?
> 
> Hello Jens,
> 
> There is only one blk_get_request() call in drivers/md/dm-mpath.c
> and it looks as follows:
> 
>  	clone = blk_get_request(bdev_get_queue(bdev),
> 			rq->cmd_flags | REQ_NOMERGE,
> 			GFP_ATOMIC);

Yeah, I found it in the dm patch. Looks fine to me, since
blk_mq_alloc_request() checks for __GFP_DIRECT_RECLAIM. Weird, it all
looks fine to me. Are you sure you tested with the patch? Either that,
or I'm smoking crack.

-- 
Jens Axboe
