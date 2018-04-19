Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35020 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeDSTNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 15:13:22 -0400
Received: by mail-pf0-f172.google.com with SMTP id j5so3096416pfh.2
        for <linux-block@vger.kernel.org>; Thu, 19 Apr 2018 12:13:22 -0700 (PDT)
Date: Thu, 19 Apr 2018 12:13:20 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH blktests] scsi/004: add regression test for false
 BLK_STS_OK with non good SAM status
Message-ID: <20180419191320.GB20941@vader>
References: <1523955817-15790-1-git-send-email-maier@linux.ibm.com>
 <20180419185330.GA20941@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419185330.GA20941@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 19, 2018 at 11:53:30AM -0700, Omar Sandoval wrote:
> Thanks for the test! Applied.

Side note, it's unfortunate that this test takes 180 seconds to run only
because we have to wait for the command timeout. We should be able to
export request_queue->rq_timeout writeable in sysfs. Would you be
interested in doing that?
