Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6717C2D0C2
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E81F2085B
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Y7c5ibWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgACM1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:27:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45392 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgACM1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 07:27:12 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so41138770ioi.12
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AY4ENTKPki66emH2g9fmeFjRDPYR4sj8uuWTQfASH2Q=;
        b=Y7c5ibWcDaQ+N8VgeVXOsdUtulknBTWLT+PK7S6fxPvnvazw3njGcUYaXc9eMAQ7tX
         uLuz1DWntOD9AHqWYtYE1CFYOfVX0N4X3eCgv2fGIWZR8XdyYyrHr+yaBqjepPdhKJ/0
         +zMtTa+PsiiLWfwRbvmOki8yEq0q1wHSTckOMYg8ldKrdatRFqs7AQiapyQxfGEPsue6
         S2YqNpweiUiia/ygpPmkR9BG5p56GWQNIVYD+ANxcCde5zu4hx0xf09b4lAXzOdV42b0
         Be6riRI/H9FmiPl2N8vXLl0FSZIB9q9cQWS5cAKtCRJRI5/VzpHBirMk9681/rUQQOgr
         zVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AY4ENTKPki66emH2g9fmeFjRDPYR4sj8uuWTQfASH2Q=;
        b=e3d5Pco0yUH6dBXkyVZskT76ZR+YHT+kgIPz1ORoCAxxENpop3NknYjejc46yKqOsU
         CuYIjTVCx+DO1Z7JMc/vjQhYMYdHH68mh5nI3yx0vhRx8ivl84w3TmGe0La1AYsK3r+G
         78Oxi7kJCO3kaHi85nrdRg+3usG3xDrapVbltcm8UQhuuJJ2AKlfKAAkpaNJXZBm1ukM
         RFKnatUV7tOIZQUYEYlSVBDk7/azZ1D0OGVSd89dNUluqK1ef1E18BOE8Dcg5ip+jnvk
         binxkByJ090D5GTMbuq71cg1KIbOppl7WDNgQ3V1qOAIthyhhDkBaQ5mXIH8vRlzb0XU
         7KeA==
X-Gm-Message-State: APjAAAXk+u9q5yUVnAGky/Ji04IdU2HM8fsyKwSyKY6mkF3YiHwvXHyg
        xqFOcQ7/Rbjqw8RdSTvCJ8tW1Cuy890EXPj7iOEzlA==
X-Google-Smtp-Source: APXvYqy/91gAe2+VPox86yTo+9ToaL14N2oDfwm7v5SmfgAIpCUDxaxOhw4hDyYg0wV7JtFgs/lrVEcBOGJWOb99d/g=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr60280343ioh.22.1578054431743;
 Fri, 03 Jan 2020 04:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-4-jinpuwang@gmail.com>
 <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org> <CAMGffEmC3T9M+RmeOXX4ecE3E01azjD8fz2Lz8kHC9Ff-Xx-Aw@mail.gmail.com>
 <51f2aec2-db24-ce7b-b3e8-68f9561a584b@acm.org>
In-Reply-To: <51f2aec2-db24-ce7b-b3e8-68f9561a584b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 13:27:00 +0100
Message-ID: <CAMGffEnA93du=4Nj3=sNCcCN3LL52F6r52uz3eHLWHruFy-XNw@mail.gmail.com>
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
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

On Thu, Jan 2, 2020 at 6:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/2/20 7:27 AM, Jinpu Wang wrote:
> > On Mon, Dec 30, 2019 at 8:48 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 2019-12-30 02:29, Jack Wang wrote:
> >>> +enum {
> >>> +     SERVICE_CON_QUEUE_DEPTH = 512,
> >>
> >> What is a service connection?
> > s/SERVICE_CON_QUEUE_DEPTH/CON_QUEUE_DEPTH/g, do you think
> > CON_QUEUE_DEPTH is better or just QUEUE_DEPTH?
>
> The name of the constant is fine, but what I meant is the following: has
> it been documented anywhere what the role of a "service connection" is?
ah, get your point now, will add a comment before the constant.
>
> >>> +struct rtrs_ib_dev_pool {
> >>> +     struct mutex            mutex;
> >>> +     struct list_head        list;
> >>> +     enum ib_pd_flags        pd_flags;
> >>> +     const struct rtrs_ib_dev_pool_ops *ops;
> >>> +};
> >>
> >> What is the purpose of an rtrs_ib_dev_pool and what does it contain?
> > The idea was documented in the patchset here:
> > https://www.spinics.net/lists/linux-rdma/msg64025.html
> > "'
> > This is an attempt to make a device pool API out of a common code,
> > which caches pair of ib_device and ib_pd pointers. I found 4 places,
> > where this common functionality can be replaced by some lib calls:
> > nvme, nvmet, iser and isert. Total deduplication gain in loc is not
> > quite significant, but eventually new ULP IB code can also require
> > the same device/pd pair cache, e.g. in our IBTRS module the same
> > code has to be repeated again, which was observed by Sagi and he
> > suggested to make a common helper function instead of producing
> > another copy.
> > '''
>
> The word "pool" suggest ownership. Since struct rtrs_ib_dev_pool owns
> protection domains instead of RDMA devices, how about renaming that data
> structure into rtrs_pd_per_rdma_dev, rtrs_rdma_dev_pd or something
> similar? How about adding a comment like the following above that data
> structure?
rtrs_rdma_dev_pd sounds better to me, will also add the comments.
>
> /*
>   * Data structure used to associate one protection domain (PD) with each
>   * RDMA device.
>   */
>
> >>> +/**
> >>> + * struct rtrs_msg_conn_req - Client connection request to the server
> >>> + * @magic:      RTRS magic
> >>> + * @version:    RTRS protocol version
> >>> + * @cid:        Current connection id
> >>> + * @cid_num:    Number of connections per session
> >>> + * @recon_cnt:          Reconnections counter
> >>> + * @sess_uuid:          UUID of a session (path)
> >>> + * @paths_uuid:         UUID of a group of sessions (paths)
> >>> + *
> >>> + * NOTE: max size 56 bytes, see man rdma_connect().
> >>> + */
> >>> +struct rtrs_msg_conn_req {
> >>> +     u8              __cma_version; /* Is set to 0 by cma.c in case of
> >>> +                                     * AF_IB, do not touch that.
> >>> +                                     */
> >>> +     u8              __ip_version;  /* On sender side that should be
> >>> +                                     * set to 0, or cma_save_ip_info()
> >>> +                                     * extract garbage and will fail.
> >>> +                                     */
> >>
> >> The above two fields and the comments next to it look suspicious to me.
> >> Does RTRS perhaps try to generate CMA-formatted messages without using
> >> the CMA to format these messages?
> > The problem is in cma_format_hdr over-writes the first byte for AF_IB
> > https://www.spinics.net/lists/linux-rdma/msg22397.html
> >
> > No one fixes the problem since then.
>
> How about adding that URL to the comment block above struct
> rtrs_msg_conn_req?
Ok

Thanks
