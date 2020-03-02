Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB2C3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9583E217F4
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Kw0yDXjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCBOjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:39:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44609 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgCBOjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 09:39:44 -0500
Received: by mail-io1-f67.google.com with SMTP id u17so6783963iog.11
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5K5V10b3zmzbHGxJ8mvxWaKndtERoQvtnRDMNpTBGA=;
        b=Kw0yDXjSHy8q2H5TZkLpNs+ZS2bsFqtcR0hXiyeDBPyWEtupfWGV25c6Us68B9e8x7
         Xut0YgXwMREznB0rwuY5+xJsokXReM9k/GHHgACt+lLC+LJBBHGyN986cOpbDOd8k1zg
         8erERBGk7UzPrFSzMhe8YOXp8wsCOqtzFTPltFEaLMy0uDmlRvsyuYcDwtywS8A+Gd49
         hl3KBOgnjBkZCL2e8cOe/VfdwmMDiKhr87/Bd29RHElEY9UUroL19laVYkfqWdcpH2PX
         sjAwgk9w5shZJ4xt33e6n47yeUGee+P3tUBZBJDpvtgcyq/MA4w1RS4xP1drSRVOebQX
         qMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5K5V10b3zmzbHGxJ8mvxWaKndtERoQvtnRDMNpTBGA=;
        b=N1MMJrjI4PX/8xl49XbwiFeqyuZMuEiARzmwsDJ6N3aIMaGNOjVZofa52lhZCIpeXF
         diDagByAnxhPOyCjtqK3tiC3xyOchXGpQ4f4wPDFuZvXM68NMzFh/BW8RFFeOSKk/Fdl
         ZBqCnqFb3uMWQokS7OhXHsoN9/W1ap1mn5/zchWTlivdxWRhZXmIgpImQaobeYi/bXJR
         jIgEJfxroEXtLqdc18kVp8Jl56qu5CbyvGafviAA5UE4vCt5AQRv7t6s6iclHQ+0SkPQ
         QbonDiFB5IZvgoN/5uPKhtj9mYzF476fxk4nrxXxKurFoj5WQKyw1puCBE+NRkf/5wi6
         Y4Bw==
X-Gm-Message-State: APjAAAU1iuIgNH/KS9LZUoSoUY2Equ3H7aZLT/jVCsOY369mqPtwSdob
        MJ8I6PHDyBM26ZPjuj5082TsBPyYmNJTraUjUx6/hw==
X-Google-Smtp-Source: APXvYqzPDwXk3WCzABHMvcgaPJJsWbrYSGIkg/3K/TRZsETJirhY4Lm7x3RDLsfTvFSiFlzA2avzIfjEv7sHBiZYmVw=
X-Received: by 2002:a6b:fc0b:: with SMTP id r11mr5949276ioh.298.1583159984321;
 Mon, 02 Mar 2020 06:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-11-jinpuwang@gmail.com>
 <c97843fa-84c4-ff7e-3b72-af3b916c059a@acm.org>
In-Reply-To: <c97843fa-84c4-ff7e-3b72-af3b916c059a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:39:33 +0100
Message-ID: <CAMGffEncP5NaQtHwQPO1WRKEvTrEmJXX6_UHA1R0++qgu-Nu=A@mail.gmail.com>
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 2:42 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
> > +{
> > +     struct rtrs_srv_sess *sess;
> > +     int err = -ENOTCONN;
> > +
> > +     mutex_lock(&srv->paths_mutex);
> > +     list_for_each_entry(sess, &srv->paths_list, s.entry) {
> > +             if (sess->state != RTRS_SRV_CONNECTED)
> > +                     continue;
> > +             memcpy(sessname, sess->s.sessname,
> > +                    min_t(size_t, sizeof(sess->s.sessname), len));
> > +             err = 0;
> > +             break;
> > +     }
> > +     mutex_unlock(&srv->paths_mutex);
> > +
> > +     return err;
> > +}
> > +EXPORT_SYMBOL(rtrs_srv_get_sess_name);
>
> Please make sure that the returned string is '\0'-terminated, e.g. by
> using strlcpy().
Ok.
>
> > +static int rtrs_rdma_do_accept(struct rtrs_srv_sess *sess,
> > +                            struct rdma_cm_id *cm_id)
> > +{
> > +     struct rtrs_srv *srv = sess->srv;
> > +     struct rtrs_msg_conn_rsp msg;
> > +     struct rdma_conn_param param;
> > +     int err;
> > +
> > +     param = (struct rdma_conn_param) {
> > +     .rnr_retry_count = 7,
> > +     .private_data = &msg,
> > +     .private_data_len = sizeof(msg),
> > +     };
> > +
> > +     msg = (struct rtrs_msg_conn_rsp) {
> > +     .magic = cpu_to_le16(RTRS_MAGIC),
> > +     .version = cpu_to_le16(RTRS_PROTO_VER),
> > +     .queue_depth = cpu_to_le16(srv->queue_depth),
> > +     .max_io_size = cpu_to_le32(max_chunk_size - MAX_HDR_SIZE),
> > +     .max_hdr_size = cpu_to_le32(MAX_HDR_SIZE),
> > +     };
> > +
> > +     if (always_invalidate)
> > +             msg.flags = cpu_to_le32(RTRS_MSG_NEW_RKEY_F);
> > +
> > +     err = rdma_accept(cm_id, &param);
> > +     if (err)
> > +             pr_err("rdma_accept(), err: %d\n", err);
> > +
> > +     return err;
> > +}
>
> Please indent the members in the structure assignments.
ok.
>
> > +static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
> > +{
> > +     struct rtrs_msg_conn_rsp msg;
> > +     int err;
> > +
> > +     msg = (struct rtrs_msg_conn_rsp) {
> > +     .magic = cpu_to_le16(RTRS_MAGIC),
> > +     .version = cpu_to_le16(RTRS_PROTO_VER),
> > +     .errno = cpu_to_le16(errno),
> > +     };
> > +
> > +     err = rdma_reject(cm_id, &msg, sizeof(msg));
> > +     if (err)
> > +             pr_err("rdma_reject(), err: %d\n", err);
> > +
> > +     /* Bounce errno back */
> > +     return errno;
> > +}
>
> Same comment for this function.
Ok, thanks Bart
>
> Thanks,
>
> Bart.
