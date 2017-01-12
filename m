Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52781 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750780AbdALWHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 17:07:48 -0500
Date: Thu, 12 Jan 2017 15:07:42 -0700
From: Jens Axboe <axboe@fb.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 06/10] blk-mq-tag: cleanup the normal/reserved tag
 allocation
Message-ID: <20170112220742.GC25197@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-7-git-send-email-axboe@fb.com>
 <1484256148.2720.17.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1484256148.2720.17.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 12 2017, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 14:39 -0700, Jens Axboe wrote:
> > This is in preparation for having another tag set available. Cleanup
> > the parameters, and allow passing in of tags fo blk_mq_put_tag().
> 
> It seems like an 'r' is missing from the description ("tags fo")?

Indeed, good eye. Added.

-- 
Jens Axboe

