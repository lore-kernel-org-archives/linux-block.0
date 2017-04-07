Return-Path: <ming.lei@redhat.com>
Date: Fri, 7 Apr 2017 17:41:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Avoid that scsi-mq queue processing stalls
Message-ID: <20170407094107.GC27631@ming.t460p>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406181050.12137-1-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 11:10:45AM -0700, Bart Van Assche wrote:
> Hello Jens,
> 
> The five patches in this patch series fix the queue lockup I reported
> recently on the linux-block mailing list. Please consider these patches
> for inclusion in the upstream kernel.

I read the commit log of the 5 patches, looks not found descriptions
about root cause of the queue lockup, so could you explain a bit about
the reason behind?

Thanks,
Ming
