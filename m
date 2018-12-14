Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B7AC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 06:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1720811
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HA+hEmI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F1720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLNGWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:22:35 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:38901 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLNGWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 01:22:34 -0500
Received: by mail-it1-f180.google.com with SMTP id h65so7778435ith.3
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 22:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=I12FPaqyGXSoogFjkNTkufV4uRDY/Cff2IBDxDI4KpI=;
        b=HA+hEmI1fKphcid3Wqu1l6r9epJ/ZrC2vCCrP9SKrX++r4BnMe45jrPKru5wNmoK1O
         pjY0mKOtL6UiEakepZpBrPXzVImU7tMs16KcKHx0EIjVyNrGRVwjVw3ryz44A01LWg3U
         6TWlbnM88ltDF/phoyFNk6I2WTsxw3t7X4/Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=I12FPaqyGXSoogFjkNTkufV4uRDY/Cff2IBDxDI4KpI=;
        b=li2huCp2BNPllYb9sGy1DTYHNxdX1HS643zFz/BEfrRzqyrVibhC9RTD8/BpNY3H4F
         Ec/VvSDDgrLqMeiyaEKO+1fqxl8N0+HlIu1fBKdiAsQ5sF8XRrLvqv4vO2az8FdNSGIn
         Whz8ElTnjoOYriiqPYmSoKMRGolK4Wpy9Paz8NbQzUeTry4DHfQrtQd1KjoIXCb4MpFj
         zmQv4h5KgmaRMql/CvCYTybIPxnCwWGgvOGkd5Upr08k3fHRnQgzN1hxMjayl/OLBqSQ
         96N2qvnvdStB3+qgYQ/G2IU2AdC0Yxvs+fBPsshm2FK48MLdpBBR2DdEWC336gpgtsyT
         rWDw==
X-Gm-Message-State: AA+aEWYUvndLLQGMBbL4RY7g+yrx0etuzSdgzCQy3y6Za1lijs2y6bJf
        O+y5YMLXGfVExr4FIBAlQ33wjYrSF0qAe8QiPNZhTA==
X-Google-Smtp-Source: AFSGD/X8Ub0uTcCConCF8ENpcIqIHjxFQbcdhTWudIeGDLDxp8Ds0t9IdjBcfL6EUmPR3MTazgoXkBLCgerOQaxaIsM=
X-Received: by 2002:a02:2303:: with SMTP id u3mr1611571jau.42.1544768553574;
 Thu, 13 Dec 2018 22:22:33 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1543943674.185366.194.camel@acm.org> <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p> <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
 <20181207101959.GF29027@ming.t460p> 88ed84836a807d5102f9164fceb157ac@mail.gmail.com
 1c6b4131aea4d2efa19d5ce0584bf6e3@mail.gmail.com
In-Reply-To: 1c6b4131aea4d2efa19d5ce0584bf6e3@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIDGsA5xuRcZ0ZzYKBZCDlABhVdmwHqGsmwAaocH2YATD8ANgEEvmLDpO7Q/qCABpVU4IAEJO3A
Date:   Fri, 14 Dec 2018 11:52:31 +0530
Message-ID: <c8843ac18d076085e6740db7e083ab21@mail.gmail.com>
Subject: RE: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > On Thu, Dec 06, 2018 at 11:15:13AM +0530, Kashyap Desai wrote:
> > > > >
> > > > > If the 'tag' passed to scsi_host_find_tag() is valid, I think
there
> > > > > shouldn't have such issue.
> > > > >
> > > > > If you want to find outstanding IOs, maybe you can try
> > > > > blk_mq_queue_tag_busy_iter()
> > > > > or blk_mq_tagset_busy_iter(), because you may not know if the
passed
> > > > 'tag'
> > > > > to
> > > > > scsi_host_find_tag() is valid or not.
> > > >
> > > > We tried quick change in mpt3sas driver using
blk_mq_tagset_busy_iter
> > and
> > > > it returns/callback for valid requests (no stale entries are
returned).
> > > > Expected.
> > > > Above two APIs are only for blk-mq.  What about non-mq case ?
Driver
> > > > should use scsi_host_find_tag for non-mq and
blk_mq_tagset_busy_iter
> > for
> > > > blk-mq case ?
> > >
> > > But your patch is only for blk-mq, is there same issue on non-mq
case?
> >
> > Problematic part from below function is code path which goes from "
> > shost_use_blk_mq(shost))".
> > Non-mq path works fine because every IO completion set bqt-
> >tag_index[tag]
> > = NULL from blk_queue_end_tag().
> >
> > I did similar things for mq path in this patch.
> >
> > static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host
*shost,
> >                 int tag)
> > {
> >         struct request *req = NULL;
> >
> >         if (tag == SCSI_NO_TAG)
> >                 return NULL;
> >
> >         if (shost_use_blk_mq(shost)) {
> >                 u16 hwq = blk_mq_unique_tag_to_hwq(tag);
> >
> >                 if (hwq < shost->tag_set.nr_hw_queues) {
> >                         req =
blk_mq_tag_to_rq(shost->tag_set.tags[hwq],
> >                                 blk_mq_unique_tag_to_tag(tag));
> >                 }
> >         } else {
> >                 req = blk_map_queue_find_tag(shost->bqt, tag);
> >         }
>
>
> Hi Jens,
>
> Any conclusion/feedback on this topic/patch ?  As discussed, This is a
safe
> change and  good to have if no design issue.

Hi, Since we have not concluded on fix, we can resume discussion on next
revision of the patch. I will be posting V2 patch with complete fix.

Kashyap

>
> Kashyap
