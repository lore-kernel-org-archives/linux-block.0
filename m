Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E102C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 20:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D120850
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 20:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6D120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLCU6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:58:48 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35081 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLCU6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 15:58:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so8276089qka.2;
        Mon, 03 Dec 2018 12:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g9C1/r4c63to+g32lsRVecYhxr1QWtG5M1qbNkaLgcA=;
        b=J2Uq+VCxmsOZTsF+k+gwya/bQR4hPdNOg2v4S7Z8R5Giv3HEdIwx9k03XznESMVicg
         /OjH7mZNcBi31waf8XttkyK2eogeRdNzfaL5l8zomTHxBisd3q1oJoB5CAwL5sYHi4B/
         Lq0Q83KrLGKTwD0RNllabJswrvAkKzplllFpV6b3T7AJsF5XEv+TSP2ELCKpGD0C+uBS
         63dQnytbjv7nRLou5w9Wi7RNbx9/y48FgP5/OWdQ9fA+TrdWmRYAvKiCTsB8LeWSxzHA
         Z9i227pB+Gp0Mxn2wN2XZcghum0fA6snc+/e0SD7mnnG/brImO7q2NyqnNu+uxZPJhG1
         5VsQ==
X-Gm-Message-State: AA+aEWYTDN5zZ12BvfpywWNb5uVHfebZzVVzKxQuSqo9qtRZcQsgFQe0
        0hFJqb9QFCPirh2xi6h1qNo=
X-Google-Smtp-Source: AFSGD/VqDQscYuJ8ALNwzh27HqgKOVYYtpdEPy2pZrvviMmp2qu3DbroicydTvMWekEl/qLtJTN6Xg==
X-Received: by 2002:a37:6a42:: with SMTP id f63mr16354369qkc.224.1543870726289;
        Mon, 03 Dec 2018 12:58:46 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:e729])
        by smtp.gmail.com with ESMTPSA id z8sm9848396qth.34.2018.12.03.12.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:58:45 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:58:42 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blkcg: introduce common blkg association logic
Message-ID: <20181203205842.GA90035@dennisz-mbp.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-5-dennis@kernel.org>
 <20181130095209.GA17103@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130095209.GA17103@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Fri, Nov 30, 2018 at 01:52:09AM -0800, Christoph Hellwig wrote:
> >  EXPORT_SYMBOL_GPL(bio_associate_blkcg);
> >  
> >  /**
> > - * bio_associate_blkg - associate a bio with the a blkg
> > + * bio_has_queue - required check for blkg association
> > + * @bio: target bio
> > + *
> > + * A blkg represents the relationship between a blkcg and a request_queue.
> > + * If there is no request_queue, there is no blkg and therefore nothing to
> > + * associate with.
> > + */
> > +static inline bool bio_has_queue(struct bio *bio)
> > +{
> > +	return bio->bi_disk && bio->bi_disk->queue;
> > +}
> 
> How do you ever see a bio without a queue?  We can't even do I/O in
> that case.

The case I found was with the flush bio in dm which is statically
allocated in dm_alloc(). The issue issue is that bio_set_dev() is called
on a bdev that isn't opened. So, the bdev wasn't pointing to a genhd.
I've fixed the issue with the patch below, which will be added in v5.

I think I was being overly cautious with the change and have taken this
out in v5. It seems that this should be a one-off case which should work
with the patch below.

Thanks,
Dennis

---
From 3ee13402af369ee8618549b63593d68ffca574ca Mon Sep 17 00:00:00 2001
From: Dennis Zhou <dennis@kernel.org>
Date: Mon, 3 Dec 2018 10:56:34 -0800
Subject: [PATCH 05/14] dm: set flush bio device on demand

The next patch changes the macro bio_set_dev() to associate a bio with a
blkg based on the device set. However, dm creates a static bio to be
used as the basis for cloning empty flush bios on creation. This
association is with a not-opened bdev so bd_disk is %NULL. To easily get
around this, we will set the device on the static bio every time and use
that to copy to the other bios.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 drivers/md/dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a733e4c920af..b5e996c5c709 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1417,10 +1417,14 @@ static int __send_empty_flush(struct clone_info *ci)
 	unsigned target_nr = 0;
 	struct dm_target *ti;
 
+	bio_set_dev(ci->bio, ci->io->md->bdev);
+
 	BUG_ON(bio_has_data(ci->bio));
 	while ((ti = dm_table_get_target(ci->map, target_nr++)))
 		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
 
+	bio_disassociate_blkg(ci->bio);
+
 	return 0;
 }
 
@@ -1939,7 +1943,6 @@ static struct mapped_device *alloc_dev(int minor)
 		goto bad;
 
 	bio_init(&md->flush_bio, NULL, 0);
-	bio_set_dev(&md->flush_bio, md->bdev);
 	md->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
 
 	dm_stats_init(&md->stats);
-- 
2.17.1

