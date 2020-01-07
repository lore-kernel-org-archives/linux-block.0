Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D387C33C9E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 13:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBBC2081E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 13:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="R1PF8gg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgAGNUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:20:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38272 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgAGNUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 08:20:05 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so1659112ioj.5
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 05:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyJeyGAQMajDmokkNi3o4ULZUYvVF+dw0AQaqaM8BOI=;
        b=R1PF8gg/m0K/zrRzdZ3Lih9Zql4/kW2E84/qx4a+fIvYMC/n71tJflt9poKodpqdSW
         pAzQn4ISgLE98viw2JHTyZ1+ZDVQcicKmZZAuxa3DmZfub6cwdCm1JKRbGdu3CLmN/Im
         eDvo0vJwB1SPAF0wJtjUujcQc8T3LYuwBQrSZ6qb+wMQZH8megAU/pVMJKRr7YIkPakB
         A3FD7zJN4dk51TJ3fIXWSO3Qt1QdGnEY5BPcxPeYeQhVE7QgNPtP4OgOm05ZVlauz+jp
         t5bh2bekBDmtzxidqa9QdFR8XIx02jAvimIXuz8Gh1cYHNjQCYA7wH2E1xvSN7nCFiFa
         6Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyJeyGAQMajDmokkNi3o4ULZUYvVF+dw0AQaqaM8BOI=;
        b=PzbJQonPmwNhksTkZdFJ10BW8uN7PXa8jLsIM8XFFxJGQNSeQjwMQQ6EaImyAhl9Pk
         ecRzRQcokM9HcTUacyRsJ7lETy1EvUZXBvJusTpy7QDUE1ZQMKn+ZnsuJgthSumXopSF
         P3H7tz90VacpO1jETXWqpNOSyaSP48jUuFznE4cTlqBuFtteYrWy/FEIxwDO7PT2oYip
         InEbnwt0i3OmMnyRj8FVIPta7JjgZgUApDyXDwCoEyXqzTvnEEITqtU4+9Sgo9HYZ+7j
         tD5Pj22u5wIirs/7aNhsbZmBPMsdQ6GIdlW2/7R8lq0tYeqR8OMgfuP9vOZe3wQL8wOg
         mTvA==
X-Gm-Message-State: APjAAAXbE+tuWXb8sAurJKeLatdaovwjRu6XAviBSjiwDrRobh0bmOXk
        9VlvaT67DVdaWSgaHgqllG16xvuINM8VSqkFlALdzA==
X-Google-Smtp-Source: APXvYqw8xXZNU20Bm3377BpX9vuy8IVb5VJVPQguzsjg41gN5QjLWn9mgIZPUGIX7K6YkSnkUit/R+YfSSuqrBpqr5I=
X-Received: by 2002:a02:a610:: with SMTP id c16mr83166058jam.13.1578403204360;
 Tue, 07 Jan 2020 05:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-11-jinpuwang@gmail.com>
 <3fa42a11-5a85-f585-fed8-e8a2c0d7a249@acm.org>
In-Reply-To: <3fa42a11-5a85-f585-fed8-e8a2c0d7a249@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 14:19:53 +0100
Message-ID: <CAMGffEkhf8O01F-78LJnqiASsGsfdR9WWENPrPtrTOUYUp6=gw@mail.gmail.com>
Subject: Re: [PATCH v6 10/25] rtrs: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 11:03 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +MODULE_DESCRIPTION("RTRS Server");
>
> Please expand the "RTRS" abbreviation in the module description.
will do.
>
> > +static void rtrs_srv_get_ops_ids(struct rtrs_srv_sess *sess)
> > +{
> > +     atomic_inc(&sess->ids_inflight);
> > +}
> > +
> > +static void rtrs_srv_put_ops_ids(struct rtrs_srv_sess *sess)
> > +{
> > +     if (atomic_dec_and_test(&sess->ids_inflight))
> > +             wake_up(&sess->ids_waitq);
> > +}
> > +
> > +static void rtrs_srv_wait_ops_ids(struct rtrs_srv_sess *sess)
> > +{
> > +     wait_event(sess->ids_waitq, !atomic_read(&sess->ids_inflight));
> > +}
>
> So rtrs_srv_wait_ops_ids() returns without grabbing any synchronization
> object? What guarantees that ids_inflight is not increased after
> wait_event() has returned and before rtrs_srv_wait_ops_ids() returns?
We do rdma_disconnect/ib_drian_qp first, so no new io from client
could reach server,
then wait for all pending IO to finish
>
> > +     /*
> > +      * From time to time we have to post signalled sends,
> > +      * or send queue will fill up and only QP reset can help.
> > +      */
> > +     flags = atomic_inc_return(&id->con->wr_cnt) % srv->queue_depth ?
> > +                     0 : IB_SEND_SIGNALED;
>
> Should "signalled" perhaps be changed into "signaled"?
will fix.
>
> How can posting a signaled send prevent that the send queue overflows?
> Isn't that something that can only be guaranteed by tracking the number
> of WQE's in the send queue?
Selective signaling works. All we need to do is signal one WR for
every SQ-depth worth of WRs posted. For example, If the SQ depth is
16, we must signal at least one out of every 16. This ensures proper
flow control for HW resources.
Courtesy: section 8.2.1 of the iWARP Verbs draft
http://tools.ietf.org/html/draft-hilland-rddp-verbs-00#section-8.2.1

See also: https://www.rdmamojo.com/2013/02/15/ibv_poll_cq/

>
> > +/**
> > + * send_io_resp_imm() - response with empty IMM on failed READ/WRITE requests or
> > + *                      on successful WRITE request.
> > + * @con              the connection to send back result
> > + * @id               the id associated to io
> > + * @errno    the error number of the IO.
> > + *
> > + * Return 0 on success, errno otherwise.
> > + */
>
> Should "response ... on" perhaps be changed into "respond ... to"?
> Should "associated to" perhaps be changed into "associated with"?
Yes.
>
> > +static int map_cont_bufs(struct rtrs_srv_sess *sess)
>
> A comment that explains what "cont" in this function name means would be
> welcome.
will do .
>
> > +static inline int sockaddr_cmp(const struct sockaddr *a,
> > +                            const struct sockaddr *b)
> > +{
> > +     switch (a->sa_family) {
> > +     case AF_IB:
> > +             return memcmp(&((struct sockaddr_ib *)a)->sib_addr,
> > +                           &((struct sockaddr_ib *)b)->sib_addr,
> > +                           sizeof(struct ib_addr));
> > +     case AF_INET:
> > +             return memcmp(&((struct sockaddr_in *)a)->sin_addr,
> > +                           &((struct sockaddr_in *)b)->sin_addr,
> > +                           sizeof(struct in_addr));
> > +     case AF_INET6:
> > +             return memcmp(&((struct sockaddr_in6 *)a)->sin6_addr,
> > +                           &((struct sockaddr_in6 *)b)->sin6_addr,
> > +                           sizeof(struct in6_addr));
> > +     default:
> > +             return -ENOENT;
> > +     }
> > +}
>
> The memcmp() return value can be used to sort values. Since that is not
> the case for the sockaddr_cmp() return value, please document this.
> Additionally, it seems like a comparison of a->sa_family and
> b->sa_family is missing?
you're right, will fix.
>
> > +static int rtrs_rdma_do_accept(struct rtrs_srv_sess *sess,
> > +                             struct rdma_cm_id *cm_id)
> > +{
> > +     struct rtrs_srv *srv = sess->srv;
> > +     struct rtrs_msg_conn_rsp msg;
> > +     struct rdma_conn_param param;
> > +     int err;
> > +
> > +     memset(&param, 0, sizeof(param));
> > +     param.rnr_retry_count = 7;
> > +     param.private_data = &msg;
> > +     param.private_data_len = sizeof(msg);
> > +
> > +     memset(&msg, 0, sizeof(msg));
> > +     msg.magic = cpu_to_le16(RTRS_MAGIC);
> > +     msg.version = cpu_to_le16(RTRS_PROTO_VER);
> > +     msg.errno = 0;
> > +     msg.queue_depth = cpu_to_le16(srv->queue_depth);
> > +     msg.max_io_size = cpu_to_le32(max_chunk_size - MAX_HDR_SIZE);
> > +     msg.max_hdr_size = cpu_to_le32(MAX_HDR_SIZE);
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
> Please use a designated initializer list instead of memset() followed by
> initialization of multiple structure members.
ok, will do.
>
> > +static int rtrs_srv_rdma_init(struct rtrs_srv_ctx *ctx, unsigned int port)
> > +{
> > +     struct sockaddr_in6 sin = {
> > +             .sin6_family    = AF_INET6,
> > +             .sin6_addr      = IN6ADDR_ANY_INIT,
> > +             .sin6_port      = htons(port),
> > +     };
> > +     struct sockaddr_ib sib = {
> > +             .sib_family                     = AF_IB,
> > +             .sib_addr.sib_subnet_prefix     = 0ULL,
> > +             .sib_addr.sib_interface_id      = 0ULL,
> > +             .sib_sid        = cpu_to_be64(RDMA_IB_IP_PS_IB | port),
> > +             .sib_sid_mask   = cpu_to_be64(0xffffffffffffffffULL),
> > +             .sib_pkey       = cpu_to_be16(0xffff),
> > +     };
>
> A minor comment: structure members that are zero do not have to be
> initialized explicitly. The compiler does that automatically.
will drop some zero initialization.
>
> > +struct rtrs_srv_ctx *rtrs_srv_open(rdma_ev_fn *rdma_ev, link_ev_fn *link_ev,
> > +                                  unsigned int port)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +     int err;
> > +
> > +     ctx = alloc_srv_ctx(rdma_ev, link_ev);
> > +     if (unlikely(!ctx))
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     err = rtrs_srv_rdma_init(ctx, port);
> > +     if (unlikely(err)) {
> > +             free_srv_ctx(ctx);
> > +             return ERR_PTR(err);
> > +     }
> > +     /* Do not let module be unloaded if server context is alive */
> > +     __module_get(THIS_MODULE);
> > +
> > +     return ctx;
> > +}
> > +EXPORT_SYMBOL(rtrs_srv_open);
>
> Isn't it inconvenient for users if module unloading is prevented while
> one or more connections are active? This requires users to figure out
> how to trigger a log out if they want to unload a kernel module.
The logic here is when we have rnbd_server module load, we don't allow
unload rtrs_server,
you can still unload rnbd_server first then rtrs_server.

> Additionally, how are users expectied to prevent that the client relogins
> after the server has told them to log out and before the server kernel
> module is unloaded?

We don't support such use case yet.

>
> Thanks,
>
> Bart.
Thanks
