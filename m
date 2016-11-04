Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933372AbcKDAOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Nov 2016 20:14:39 -0400
Date: Thu, 3 Nov 2016 17:13:54 -0700
From: Shaohua Li <shli@fb.com>
To: Christoph Hellwig <hch@infradead.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>
Subject: Re: [PATCH V2 2/2] blk-mq: immediately dispatch big size request
Message-ID: <20161104001353.GA58908@omida-mbp.local.dhcp.thefacebook.com>
References: <05e8cb8c7e09903c7db36e81a6bbd0b39b24deff.1478217670.git.shli@fb.com>
 <6297c9a39cf21c94c65d5a9b3a19e54ba5b8b573.1478217671.git.shli@fb.com>
 <20161104000954.GA10266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161104000954.GA10266@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 03, 2016 at 05:09:54PM -0700, Christoph Hellwig wrote:
> On Thu, Nov 03, 2016 at 05:03:54PM -0700, Shaohua Li wrote:
> > This is corresponding part for blk-mq. Disk with multiple hardware
> > queues doesn't need this as we only hold 1 request at most.
> 
> Any reason you only do this for the SQ and not the MQ case?

Right above:
Disk with multiple hardware queues doesn't need this as we only hold 1
request at most.

Thanks,
Shaohua
