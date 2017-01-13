Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751524AbdAMPGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 10:06:46 -0500
Date: Fri, 13 Jan 2017 08:06:02 -0700
From: Jens Axboe <axboe@fb.com>
To: Christoph Hellwig <hch@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <osandov@osandov.com>, <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 06/10] blk-mq-tag: cleanup the normal/reserved tag
 allocation
Message-ID: <20170113150602.GE23338@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-7-git-send-email-axboe@fb.com>
 <20170113083051.GD637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170113083051.GD637@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 13 2017, Christoph Hellwig wrote:
> On Wed, Jan 11, 2017 at 02:39:59PM -0700, Jens Axboe wrote:
> > This is in preparation for having another tag set available. Cleanup
> > the parameters, and allow passing in of tags fo blk_mq_put_tag().
> 
> I've been playing around with this are a bit but never submitted
> anything.  Below is an untested merge of my previous bits with your
> patch, let me know what you think about it:

Looks good to me. I'll test it and merge it with the other patch, if
successful.

-- 
Jens Axboe

