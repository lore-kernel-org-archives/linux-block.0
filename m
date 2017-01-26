Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:42144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753423AbdAZVB7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 16:01:59 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request
 V2
Date: Thu, 26 Jan 2017 21:01:47 +0000
Message-ID: <1485464486.2540.12.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485455329.2540.7.camel@sandisk.com>
         <e8f4b084-be66-d5b3-5785-13b80642040f@fb.com>
         <1485456745.2540.9.camel@sandisk.com>
         <db7f9165-19db-d1f2-a2fa-7546da57741b@fb.com>
         <20170126185924.GA25289@lst.de>
         <ee95c6dd-cdb4-7da5-2d4a-ec14034eac7a@fb.com>
         <71e22257-0592-fdd3-25e5-a78ceced2ab9@sandisk.com>
         <4054e944-b28d-1cd6-574f-6cd90e28c301@fb.com>
In-Reply-To: <4054e944-b28d-1cd6-574f-6cd90e28c301@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-01-26 at 13:54 -0700, Jens Axboe wrote:
> Your call path has blk_get_request() in it, I don't have
> that in my tree. Is it passing in the right mask?

Hello Jens,

There is only one blk_get_request() call in drivers/md/dm-mpath.c
and it looks as follows:

 	clone =3D blk_get_request(bdev_get_queue(bdev),
			rq->cmd_flags | REQ_NOMERGE,
			GFP_ATOMIC);

Bart.=
