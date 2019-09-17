Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BAEC4CECE
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 13:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A750921852
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 13:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Evd/zsCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfIQNKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:10:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42623 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfIQNKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 09:10:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so2213424wrw.9
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BICN8Di8VFBMT6QS9s1kuCF6vCXiIA33xEhamtiRBAc=;
        b=Evd/zsCIgw7yEQFaqGzfEfTsoFVa4TrP8+U+AKl/gtR1Lh1I/Y7TH/O7D8YQ9z0FWJ
         uEWGi2BUecDkZvzN+xumjeUIVuuEBbmR4r++LyZbiINHgnwCJapYTDHOLzqxSvOop+DS
         0p0qIudRHJyQhlzviK0h79BIFO7lxLk4ZNnIFeDygI4utTj15Ve79vTxYwrTXPz+vpZA
         Zl31cQ++Vwxw32nyGSGkI6ye7l4cZhR2DNQeRbImBj/qLpnPKDM8E0ozFaajcOB8OplG
         60iQHPPlgxa10bN8EZlntoRI7RgTIkM3rF4hp2/a7ywX6sEfHjtCPCPbcXzmx0t3ew2I
         MoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BICN8Di8VFBMT6QS9s1kuCF6vCXiIA33xEhamtiRBAc=;
        b=X1zjgurHoohNCxR066/5pJGc+dP2Fg3xFOqYDv+nkuAQMtuGSwHsXpbu5jbbeiK82R
         dvU5Q3ooSolf7AezF94KUakeRQsMH1zKLTjEjMYg3rzZTgye0gXan8tIRS2goKmg0fRs
         zs35CMdGxrhIP3MzvTMDEt24SRzfOzf7G8DAKzK+ds3KCImnSOZlA+aDGwqaMmp1wTge
         ki23U00ql/iQf7/Tdc3vtGkfmQe/K/eEFftkOH00L5rbdFVCW4kQP2rpV+NiUnhRCmzk
         q9hDxnLhjNWzquyiuHMWo/l+c8lTUYkd5VrbpnqEvKDb00TSGMpcft6b3w4sSRNShpGo
         EuxA==
X-Gm-Message-State: APjAAAVzdU7b4K/zZ7MSVzHOO+ZQcWrH/Wkw6ROeSmFuHIOuUKcwRV/n
        /8NKWsl5O+u6rC8YKIf+YcfTtcxbDMV6mwEtmpweRg==
X-Google-Smtp-Source: APXvYqwU3kTDl5tpkjQLx7hf9KC1fHx48uzH/J2lDzS0SURFLa8T7Ce6hTgn0O0CSOeTjIIMEQ8ITUuVn7o8rDSsyLk=
X-Received: by 2002:a5d:4744:: with SMTP id o4mr2919160wrs.95.1568725801641;
 Tue, 17 Sep 2019 06:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
In-Reply-To: <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 15:09:50 +0200
Message-ID: <CAMGffEn6=P8bLi7SyUC19+7wbU6YEZ_5BqjR06+CBKvENw-tFg@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > +static void ibnbd_softirq_done_fn(struct request *rq)
> > +{
> > +     struct ibnbd_clt_dev *dev       = rq->rq_disk->private_data;
> > +     struct ibnbd_clt_session *sess  = dev->sess;
> > +     struct ibnbd_iu *iu;
> > +
> > +     iu = blk_mq_rq_to_pdu(rq);
> > +     ibnbd_put_tag(sess, iu->tag);
> > +     blk_mq_end_request(rq, iu->status);
> > +}
> > +
> > +static void msg_io_conf(void *priv, int errno)
> > +{
> > +     struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
> > +     struct ibnbd_clt_dev *dev = iu->dev;
> > +     struct request *rq = iu->rq;
> > +
> > +     iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
> > +
> > +     if (softirq_enable) {
> > +             blk_mq_complete_request(rq);
> > +     } else {
> > +             ibnbd_put_tag(dev->sess, iu->tag);
> > +             blk_mq_end_request(rq, iu->status);
> > +     }
>
> Block drivers must call blk_mq_complete_request() instead of
> blk_mq_end_request() to complete a request after processing of the
> request has been started. Calling blk_mq_end_request() to complete a
> request is racy in case a timeout occurs while blk_mq_end_request() is
> in progress.

Hi Bart,

Could you elaborate a bit more, blk_mq_end_request is exported function and
used by a lot of block drivers: scsi, dm, etc.
Is there an open bug report for the problem?

Regards,
Jinpu
