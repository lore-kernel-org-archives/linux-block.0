Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE06DC48BE8
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC27460FE9
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 16:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFOQCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:02:41 -0400
Received: from verein.lst.de ([213.95.11.211]:50060 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232062AbhFOQCe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 12:02:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A407668AFE; Tue, 15 Jun 2021 18:00:27 +0200 (CEST)
Date:   Tue, 15 Jun 2021 18:00:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Fine Fan <ffan@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>
Subject: Re: ? PANICKED: Test report for kernel 5.13.0-rc3 (block, 30ec225a)
Message-ID: <20210615160027.GA31772@lst.de>
References: <cki.E3198A727A.0A5WS1XUPX@redhat.com> <CA+QYu4qjrzyjM_zgJ8SSZ-zsodcK=uk8xToAVR3+kmOdNZfgZQ@mail.gmail.com> <20210615115243.GA12378@lst.de> <CAFj5m9Kp4T1R_RB1B4W3dvjU5M17wWCZ6OVbvYWjXLcGvab6=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFj5m9Kp4T1R_RB1B4W3dvjU5M17wWCZ6OVbvYWjXLcGvab6=A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 09:58:03PM +0800, Ming Lei wrote:
> On Tue, Jun 15, 2021 at 7:52 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Jun 14, 2021 at 02:40:58PM +0200, Bruno Goncalves wrote:
> > > Hi,
> > >
> > > We've noticed a kernel oops during the stress-ng test on aarch64 more log
> > > details on [1]. Christoph, do you think this could be related to the recent
> > > blk_cleanup_disk changes [2]?
> >
> > It doesn't really look very related.  Any chance you could bisect it?
> 
> It should be the wrong order between freeing tagset and cleanup disk:
> 
> static void loop_remove(struct loop_device *lo)
> {
>         ...
>         blk_mq_free_tag_set(&lo->tag_set);
>         blk_cleanup_disk(lo->lo_disk);
>         ...
>  }

Indeed.  Something like this should fix the issue:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a48b3f9a15c..e0c4de392eab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2172,8 +2172,8 @@ static int loop_add(struct loop_device **l, int i)
 static void loop_remove(struct loop_device *lo)
 {
 	del_gendisk(lo->lo_disk);
-	blk_mq_free_tag_set(&lo->tag_set);
 	blk_cleanup_disk(lo->lo_disk);
+	blk_mq_free_tag_set(&lo->tag_set);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
