Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38353 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932464AbeB1RuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 12:50:10 -0500
Received: by mail-wr0-f195.google.com with SMTP id n7so3341873wrn.5
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2018 09:50:10 -0800 (PST)
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
 <058e8999-3f89-ae20-ee38-229c78d6d1c8@web.de>
 <24729d65-c531-dcc5-3eca-900d65961092@electrozaur.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>
From: Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <269e0999-599f-cdb6-8dc8-0a5cdc521eae@electrozaur.com>
Date: Wed, 28 Feb 2018 19:50:07 +0200
MIME-Version: 1.0
In-Reply-To: <24729d65-c531-dcc5-3eca-900d65961092@electrozaur.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 28/02/18 19:38, Boaz Harrosh wrote:
<>
> Based on v4.15 code feel free to add to your patchset
> where needed
> 

Sorry is what happens when you work on so many Linux versions at
the same time. This one is based on v4.15

> ----
> Don't leak the request if blk_rq_append_bio fails
> 
> Sign-of-by: Boaz Harrosh <ooo@electrozaur.com>
> ----
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index e188771..58782dc 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1579,8 +1579,10 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
 		struct bio *bounce_bio = bio;
 
 		ret = blk_rq_append_bio(req, &bounce_bio);
-		if (ret)
+		if (ret) {
+			_put_request(req);
 			return ERR_PTR(ret);
+		}
 	}
 
 	return req;
