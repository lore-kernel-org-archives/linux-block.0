Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E2C432C1
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD31D21D7F
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 10:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DfgkPxwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfIYKUW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:20:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36721 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfIYKUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 06:20:21 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so12388574iof.3
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rqFBMqfsMIpbGjDwxfXDqANibsggHAFEEva+wKNyXE=;
        b=DfgkPxwgx6IlpUoSFjiUg4LiX/fG8wfVimfdGdpw2liTnDBWvLTGoU9C7bB/7yLTUg
         qH2AHhlB0eaOIBKbTsEwbBl1udQuu0qGGMtjj3hkw5OnPucDQ/MdqG3vE9Wg2UvJXnyj
         uMBI/VE3tTGNNuyqjt4K6teCYhvnLTzP9OiXW2yz5TdrbwGL/Dy8gfbR4UqxqhWf3krj
         LVij26nEtetuReQCOJMhJGEcBXc3xiWcUU4KvuVfjTDfa8G6avGrjMnc5Hca9HVKHkyi
         DcUxdkC2Js9Xdih/lcwem5gakt/JXv67AoSPrqQhTltTb2Ys9PAD8+IqNakIbXY9/EUH
         0zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rqFBMqfsMIpbGjDwxfXDqANibsggHAFEEva+wKNyXE=;
        b=VKBBybkKiv1oynIu2XI9HP91GkXtSn3c1H6jZfWzpmUlTllruTpm17wLJGdYiWSFrz
         pIDXccgWrZTgDwfmYYwNlOK2Gi18Zwlb0ehSiWDmstA6PxVdnOlYl0Ssps5mBQILIfMj
         OTgBFBG1jyy+VdU0x642BlNlXqOLKQiXe01qj3t6JxeX8nJ2BTj70JRN7TNQty0iwmNq
         LZpg0YZPoLAPbtBq53Il/6vz+sz6o/lMSKzBMefQwmNk45ksX5hDv5YDLfayq7Lyvapk
         v1NDkEYeKliXNWWEdf0npAm5Og9rNE7Nn588UJffovnc8Xox3KoOhgm1IOZvZgG7zh9x
         sv2g==
X-Gm-Message-State: APjAAAWUkTrEL0MCvJqsOZUp2ZMk+FfOYmoN7IaBO4KmpRFuvNW2pdEK
        tM5mFiObZwWmfY5YJ2VRo3dGSEqrnCgxIzEzdMxy
X-Google-Smtp-Source: APXvYqx+RGnccnEgT58KjxdVj/nQvPItToncpQDPGd+ehxdmlkE7H+NkwxQZ4ZlFn+x0gCdOp3N6ctOidA05VbXT0YQ=
X-Received: by 2002:a92:1508:: with SMTP id v8mr169482ilk.116.1569406820486;
 Wed, 25 Sep 2019 03:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-3-jinpuwang@gmail.com>
 <0607ca2d-6509-69da-4afc-0be6526b11c4@acm.org>
In-Reply-To: <0607ca2d-6509-69da-4afc-0be6526b11c4@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 12:20:09 +0200
Message-ID: <CAHg0HuyL2V4YqPFvSzaahGL7vHG5mKybudpxkE3hZYsLg1wM+g@mail.gmail.com>
Subject: Re: [PATCH v4 02/25] ibtrs: public interface header to establish RDMA connections
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 23, 2019 at 7:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > +/**
> > + * enum ibtrs_clt_link_ev - Events about connectivity state of a client
> > + * @IBTRS_CLT_LINK_EV_RECONNECTED    Client was reconnected.
> > + * @IBTRS_CLT_LINK_EV_DISCONNECTED   Client was disconnected.
> > + */
> > +enum ibtrs_clt_link_ev {
> > +     IBTRS_CLT_LINK_EV_RECONNECTED,
> > +     IBTRS_CLT_LINK_EV_DISCONNECTED,
> > +};
> > +
> > +/**
> > + * Source and destination address of a path to be established
> > + */
> > +struct ibtrs_addr {
> > +     struct sockaddr_storage *src;
> > +     struct sockaddr_storage *dst;
> > +};
>
> Is it really useful to define a structure to hold two pointers or can
> these two pointers also be passed as separate arguments?
We always need both src and dst throughout ibnbd and ibtrs code and
indeed one reason to introduce this struct is that "f(struct
ibtrs_addr *addr, ...);" is shorter than "f(struct sockaddr_storage
*src, struct sockaddr_storage *dst, ...);". But it also makes it
easier to extend the address information describing one ibtrs path in
the future.

> > +/**
> > + * ibtrs_clt_open() - Open a session to a IBTRS client
> > + * @priv:            User supplied private data.
> > + * @link_ev:         Event notification for connection state changes
> > + *   @priv:                  user supplied data that was passed to
> > + *                           ibtrs_clt_open()
> > + *   @ev:                    Occurred event
> > + * @sessname: name of the session
> > + * @paths: Paths to be established defined by their src and dst addresses
> > + * @path_cnt: Number of elemnts in the @paths array
> > + * @port: port to be used by the IBTRS session
> > + * @pdu_sz: Size of extra payload which can be accessed after tag allocation.
> > + * @max_inflight_msg: Max. number of parallel inflight messages for the session
> > + * @max_segments: Max. number of segments per IO request
> > + * @reconnect_delay_sec: time between reconnect tries
> > + * @max_reconnect_attempts: Number of times to reconnect on error before giving
> > + *                       up, 0 for * disabled, -1 for forever
> > + *
> > + * Starts session establishment with the ibtrs_server. The function can block
> > + * up to ~2000ms until it returns.
> > + *
> > + * Return a valid pointer on success otherwise PTR_ERR.
> > + */
> > +struct ibtrs_clt *ibtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
> > +                              const char *sessname,
> > +                              const struct ibtrs_addr *paths,
> > +                              size_t path_cnt, short port,
> > +                              size_t pdu_sz, u8 reconnect_delay_sec,
> > +                              u16 max_segments,
> > +                              s16 max_reconnect_attempts);
>
> Having detailed kernel-doc headers for describing API functions is great
> but I'm not sure a .h file is the best location for such documentation.
> Many kernel developers keep kernel-doc headers in .c files because that
> makes it more likely that the documentation and the implementation stay
> in sync.
What is better: to move it or to only copy it to the corresponding C file?

>
> > +
> > +/**
> > + * ibtrs_clt_close() - Close a session
> > + * @sess: Session handler, is freed on return
>                       ^^^^^^^
>                       handle?
>
> This sentence suggests that the handle is freed on return. I guess that
> you meant that the session is freed upon return?
Right, will fix the wording.

>
> > +/**
> > + * ibtrs_clt_get_tag() - allocates tag for future RDMA operation
> > + * @sess:    Current session
> > + * @con_type:        Type of connection to use with the tag
> > + * @wait:    Wait type
> > + *
> > + * Description:
> > + *    Allocates tag for the following RDMA operation.  Tag is used
> > + *    to preallocate all resources and to propagate memory pressure
> > + *    up earlier.
> > + *
> > + * Context:
> > + *    Can sleep if @wait == IBTRS_TAG_WAIT
> > + */
> > +struct ibtrs_tag *ibtrs_clt_get_tag(struct ibtrs_clt *sess,
> > +                                 enum ibtrs_clt_con_type con_type,
> > +                                 int wait);
>
> Since struct ibtrs_tag has another role than what is called a tag in the
> block layer I think a better description is needed of what struct
> ibtrs_tag actually represents.
I think it would be better to rename it to ibtrs_permit in order to
avoid confusion with block layer tags. Will extend the description
also.

> > +/*
> > + * Here goes IBTRS server API
> > + */
>
> Most software either uses the client API or the server API but not both
> at the same time. Has it been considered to use separate header files
> for the client and server APIs?
I don't have any really good reason to put API of server and client
into a single file. Except may be that the reader can see API calls
corresponding the full sequence of request -> indication -> response
-> confirmation in one place.
