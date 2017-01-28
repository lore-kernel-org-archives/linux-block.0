Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35913 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbdA1I1T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 03:27:19 -0500
Date: Sat, 28 Jan 2017 09:26:24 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: split scsi passthrough fields out of struct request V3
Message-ID: <20170128082624.GC4728@lst.de>
References: <1485534918-18239-1-git-send-email-hch@lst.de> <1485543514.4267.23.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485543514.4267.23.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 27, 2017 at 06:58:53PM +0000, Bart Van Assche wrote:
> Version 3 of the patch with title "block: split scsi_request out of
> struct request" (commit 3c30af6ebe12) differs significantly from v2
> of that patch that has been posted on several mailing lists. E.g. v2
> moves __cmd[], cmd and cmd_len from struct request into struct
> scsi_request but v3 not. Which version do you want us to review?

Hi Bart,

I tried to resend the whole updated v3 series, but the mail server
stopped accepting mails due to overload.  Otherwise it would have
included all the patches.  Jens instead took the updated version
straight from this git branch:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-pc-refactor
