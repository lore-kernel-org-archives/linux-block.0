Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC05DC07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8143B2081B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ax7aIUFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8143B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeLKPGx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:06:53 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:38875 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeLKPGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 10:06:53 -0500
Received: by mail-it1-f170.google.com with SMTP id h65so4281010ith.3
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 07:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=WG/86L5z6rcP5InhTywage5CfyEa1ObSwjIGjzsd9Wc=;
        b=ax7aIUFR/rIT+uPBwZQuGuNvha7m2cTU9s+v3dLud5vD8Kz9SYkWi9q/+9mmJrskL7
         yHEbNo2vxJxBDuZhctNgQfvmROeN8EwSrcZq1iDxF38HkgdBKuYV+wRJW/TAtCSejq/K
         fE7YfcCI8Kt4aOg81ZqQ6weSeM0GCMAKO6sis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=WG/86L5z6rcP5InhTywage5CfyEa1ObSwjIGjzsd9Wc=;
        b=fCbkcJA8YJNQTf0ivJ37glYmyvqfY9wyZ7jP2cwY9b5KcOjTdKH5mm9qC3yMpooY9A
         TR5jIcGuHnAmPJwxMgBmTqPwSCKbVKBH+JtciangY4QZuKroUsJb1/VLb7p6xw7BFIfQ
         AsCDbwcHyT30P9yuXTACfMbi6fS761EbGdWVarlr5f1ridPbf5aHU+G2xIZYZYF8URtu
         LpPbRoyslIp3gi7BOhmEkis51kcTzfopcWYlV9uBcTy3yGYTKQ686FcSVkhmL97BBfJJ
         IhIxHJ6nfSajJ7aFrUarRBn5JNTdSD3SNSIxCNe6hOUncR1r6eZzNLo5O4it98bZbKe3
         QHoQ==
X-Gm-Message-State: AA+aEWaVkA1RxS7nkcXltDfGis2LtU6gxZrhCqbrIPb5IbYr7bMzr6F7
        CZZx6qOoH0tegWXXXKCbdE8pj76R7NBh6zTZD3p76Q==
X-Google-Smtp-Source: AFSGD/W6JS/3GCabSwA61WqsC4dYfWpDFW//gQawS4OzTp5w5QyFAAsUxaqw5J1MPPNOvlF7taMS+Ya0D1LokYn0sqI=
X-Received: by 2002:a24:3c91:: with SMTP id m139mr2645529ita.175.1544540811313;
 Tue, 11 Dec 2018 07:06:51 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1543943674.185366.194.camel@acm.org> <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p> <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
 <20181207101959.GF29027@ming.t460p> 88ed84836a807d5102f9164fceb157ac@mail.gmail.com
In-Reply-To: 88ed84836a807d5102f9164fceb157ac@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIDGsA5xuRcZ0ZzYKBZCDlABhVdmwHqGsmwAaocH2YATD8ANgEEvmLDpO7Q/qCABpVU4A==
Date:   Tue, 11 Dec 2018 20:36:49 +0530
Message-ID: <1c6b4131aea4d2efa19d5ce0584bf6e3@mail.gmail.com>
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

> > On Thu, Dec 06, 2018 at 11:15:13AM +0530, Kashyap Desai wrote:
> > > >
> > > > If the 'tag' passed to scsi_host_find_tag() is valid, I think
there
> > > > shouldn't have such issue.
> > > >
> > > > If you want to find outstanding IOs, maybe you can try
> > > > blk_mq_queue_tag_busy_iter()
> > > > or blk_mq_tagset_busy_iter(), because you may not know if the
passed
> > > 'tag'
> > > > to
> > > > scsi_host_find_tag() is valid or not.
> > >
> > > We tried quick change in mpt3sas driver using
blk_mq_tagset_busy_iter
> and
> > > it returns/callback for valid requests (no stale entries are
returned).
> > > Expected.
> > > Above two APIs are only for blk-mq.  What about non-mq case ? Driver
> > > should use scsi_host_find_tag for non-mq and blk_mq_tagset_busy_iter
> for
> > > blk-mq case ?
> >
> > But your patch is only for blk-mq, is there same issue on non-mq case?
>
> Problematic part from below function is code path which goes from "
> shost_use_blk_mq(shost))".
> Non-mq path works fine because every IO completion set
bqt->tag_index[tag]
> = NULL from blk_queue_end_tag().
>
> I did similar things for mq path in this patch.
>
> static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host
*shost,
>                 int tag)
> {
>         struct request *req = NULL;
>
>         if (tag == SCSI_NO_TAG)
>                 return NULL;
>
>         if (shost_use_blk_mq(shost)) {
>                 u16 hwq = blk_mq_unique_tag_to_hwq(tag);
>
>                 if (hwq < shost->tag_set.nr_hw_queues) {
>                         req = blk_mq_tag_to_rq(shost->tag_set.tags[hwq],
>                                 blk_mq_unique_tag_to_tag(tag));
>                 }
>         } else {
>                 req = blk_map_queue_find_tag(shost->bqt, tag);
>         }


Hi Jens,

Any conclusion/feedback on this topic/patch ?  As discussed, This is a
safe change and  good to have if no design issue.

Kashyap
