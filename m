Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx142.netapp.com ([216.240.21.19]:5929 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934244AbeBURWR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 12:22:17 -0500
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of
 blk_rq_append_bio
To: Jiri Palecek <jpalecek@web.de>, Ming Lei <ming.lei@redhat.com>
References: <20171218074044.1369-3-ming.lei@redhat.com>
 <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
 <2c6a3916-57b8-20cb-f081-bb1b907a1a8a@web.de>
 <20180131052448.GB9985@ming.t460p>
 <87h8qbptzz.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <8be6c1f5-0359-8de4-22b3-d5e779ae7c12@electrozaur.com>
CC: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <c2e26295-0f2e-c5fd-03ce-828c68b96265@netapp.com>
Date: Wed, 21 Feb 2018 19:12:34 +0200
MIME-Version: 1.0
In-Reply-To: <8be6c1f5-0359-8de4-22b3-d5e779ae7c12@electrozaur.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21/02/18 18:20, Boaz Harrosh wrote:
<>
> again not followed closely but if it is about the free of the bounce buffers
> then I would just disable bouncing for osd all together. There are only a very
> few (2) drivers that support bidi for osd. iscsi and iser so we know those are
> totally cool and this is all not an existing problem.
> 

And also it is possible that I have at all not understood the issue
please bring me up to speed. I would like to help any way I can.

> Thanks
> Boaz
> 
