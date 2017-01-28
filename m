Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Sat, 28 Jan 2017 09:25:13 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 15/18] scsi: allocate scsi_cmnd structures as part of
        struct request
Message-ID: <20170128082513.GB4728@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de> <1485365126-23210-16-git-send-email-hch@lst.de> <1485542367.4267.19.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1485542367.4267.19.camel@sandisk.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 27, 2017 at 06:39:46PM +0000, Bart Van Assche wrote:
> Why�have the�scsi_release_buffers() and scsi_put_command(cmd) calls been
> moved up? I haven't found an explanation for this change in the patch
> description.

Because they reference the scsi_cmnd, which are now part of the request
and thus freed by blk_finish_request.  And yes, I should have mentioned
it in the changelog, sorry.

> Please also consider to remove the cmd->request->special = NULL assignments
> via this patch. Since this patch makes the lifetime of struct scsi_cmnd and
> struct request identical these assignments are no longer needed.

True.  If I had to resend again I would have fixed it up, but it's probably
not worth the churn now.

> This patch introduces the function scsi_exit_rq(). Having two functions
> for the single-queue path that release resources (scsi_release_buffers()
> and scsi_exit_rq()) is confusing. Since every scsi_release_buffers() call
> is followed by a blk_unprep_request() call, have you considered to move
> the scsi_release_buffers() call into scsi_unprep_fn() via an additional
> patch?

We could have done that.  But it's just more change for a code path
that I hope won't survive this calendar year.
