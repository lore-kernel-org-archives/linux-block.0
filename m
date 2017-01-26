Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:23594
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752436AbdAZX1d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 18:27:33 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 04/18] block: simplify blk_init_allocated_queue
Date: Thu, 26 Jan 2017 23:27:22 +0000
Message-ID: <1485473221.2540.23.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485365126-23210-5-git-send-email-hch@lst.de>
In-Reply-To: <1485365126-23210-5-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 18:25 +0100, Christoph Hellwig wrote:
> Return an errno value instead of the passed in queue so that the callers
> don't have to keep track of two queues, and move the assignment of the
> request_fn and lock to the caller as passing them as argument doesn't
> simplify anything.  While we're at it also remove two pointless NULL
> assignments, given that the request structure is zeroed on allocation.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
