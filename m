Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA81C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2304208E7
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dGV1/Pvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2304208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLGKec (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:34:32 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:39640 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGKeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 05:34:31 -0500
Received: by mail-it1-f179.google.com with SMTP id a6so6305910itl.4
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=iX6dMcny5EuAE3vRbMCNdDIP/eIk9GcoqDKxKlrri34=;
        b=dGV1/Pvk7jZGMtMWIEn7GWQ9LkklZ2ymfXffeRT6xE1m2+eeyrI6VTpJoCNNwn0gcN
         +dCWzyB7qcH30g3xA6jgye5D/h13DsJLbVL/gq/wvJo0lpPJNbgohBdxtXyiCp+M+erv
         9zYKHeTXSzUsv/Q4o44zaD13+w/DV71Z8zslE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=iX6dMcny5EuAE3vRbMCNdDIP/eIk9GcoqDKxKlrri34=;
        b=q6EHrqEZI4bJwq5qKTNVTf76j/3W52MaLMvrwJPXjqFZqqnN/fQBK/thJ8nlASCTjC
         3D3N5P4ThuEWkLgmLKwlu/HXjWnMbZyxzTK4U4b8stTk9InqCX9nBuhvz4D+Z5ykFIVC
         7POj+6zB+P3WA7if+x04RIai8T/MAp9vomYNJoAHULrEuz3KE9iXOLHO/yI3E79sBfbc
         ZiEVFlyRcvSUVHvESdYxDvNTz9TieajLfjjjQkJJDrDcWQx13GsVH8yCSF4EEMVxzRo4
         gqe1DDIB63CNo6PpymY13zarOkAMfHDmpTtqpsWULAF6dpjThIfpcHI3K0YgcbaJELMs
         XIdA==
X-Gm-Message-State: AA+aEWZZIMHWr5UJpRCck3+rVD+3E23IqH8uWAm565B/Jkl1Yztjd/fn
        mracA3n2THRH00fO/HvmQWF4s4Xm2Fdnpk51H2Tu9Q==
X-Google-Smtp-Source: AFSGD/UIYLW+a1nyQ+/HBoH1gHLeItT1oaMttnKkZx0CNIzimkX9Q+kB1o6Fp6AtcJ3msY0PLjetwmWrL6WUQR6CR44=
X-Received: by 2002:a05:660c:3c7:: with SMTP id c7mr1467593itl.131.1544178870461;
 Fri, 07 Dec 2018 02:34:30 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1543943674.185366.194.camel@acm.org> <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p> <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
 <20181207101959.GF29027@ming.t460p>
In-Reply-To: <20181207101959.GF29027@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIDGsA5xuRcZ0ZzYKBZCDlABhVdmwHqGsmwAaocH2YATD8ANgEEvmLDpO7Q/qA=
Date:   Fri, 7 Dec 2018 16:04:29 +0530
Message-ID: <88ed84836a807d5102f9164fceb157ac@mail.gmail.com>
Subject: RE: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
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

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Friday, December 7, 2018 3:50 PM
> To: Kashyap Desai
> Cc: Bart Van Assche; linux-block; Jens Axboe; linux-scsi; Suganath Prabu
> Subramani; Sreekanth Reddy; Sathya Prakash Veerichetty
> Subject: Re: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in
> blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
>
> On Thu, Dec 06, 2018 at 11:15:13AM +0530, Kashyap Desai wrote:
> > >
> > > If the 'tag' passed to scsi_host_find_tag() is valid, I think there
> > > shouldn't have such issue.
> > >
> > > If you want to find outstanding IOs, maybe you can try
> > > blk_mq_queue_tag_busy_iter()
> > > or blk_mq_tagset_busy_iter(), because you may not know if the passed
> > 'tag'
> > > to
> > > scsi_host_find_tag() is valid or not.
> >
> > We tried quick change in mpt3sas driver using blk_mq_tagset_busy_iter
and
> > it returns/callback for valid requests (no stale entries are
returned).
> > Expected.
> > Above two APIs are only for blk-mq.  What about non-mq case ? Driver
> > should use scsi_host_find_tag for non-mq and blk_mq_tagset_busy_iter
for
> > blk-mq case ?
>
> But your patch is only for blk-mq, is there same issue on non-mq case?

Problematic part from below function is code path which goes from "
shost_use_blk_mq(shost))".
Non-mq path works fine because every IO completion set bqt->tag_index[tag]
= NULL from blk_queue_end_tag().

I did similar things for mq path in this patch.

static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host
*shost,
                int tag)
{
        struct request *req = NULL;

        if (tag == SCSI_NO_TAG)
                return NULL;

        if (shost_use_blk_mq(shost)) {
                u16 hwq = blk_mq_unique_tag_to_hwq(tag);

                if (hwq < shost->tag_set.nr_hw_queues) {
                        req = blk_mq_tag_to_rq(shost->tag_set.tags[hwq],
                                blk_mq_unique_tag_to_tag(tag));
                }
        } else {
                req = blk_map_queue_find_tag(shost->bqt, tag);
        }

Kashyap
>
> Thanks,
> Ming
