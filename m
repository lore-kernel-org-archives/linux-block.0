Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D51C282DA
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94F20B1F
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDFWLa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:11:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46648 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDFWLa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 18:11:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so7623853oia.13
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 15:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoL9NODfzh6NhEfGK3mpT89SHndUqby2BRELgHO9iU8=;
        b=dpHAr+2jNAoZ49hHTCiwqLoMnANUlDjgbgZ57v3Da2bL8krljguJVtiFnun/Ej5Voo
         Nzp4czgYnELLKr0IGInotEk1hC/Zu9408Oc4EbQ9tNwrzyR2nLEKZ1dBnytD0l29lcaa
         DXLInG1RlbbY36Q8fRoOWMBiiPj3+I6pljt5NCHm1AwFfRo5lUTgBFWJHn2jjlkC+FE7
         XkR05ZGSvdzEqg9oQM2KgM5AELK4c63Gq5no2KrgQuwXBVz0nxGu5SuzSooWXOcGVhhU
         P29GNrpJVt8gRskbmUi1NXOPZW1D71i+/C8LSli2VzpTu+U/KLvWSS+LFwRDrly6Vgfn
         ecVQ==
X-Gm-Message-State: APjAAAUKj3nKUN/5SapiGNQIAgxICbVALajS8UguNIQSqOE3GSCCs5XM
        pRdzbasAyidsWvlEduNOCy1Vjt5VGKz3kFW3SCerZA==
X-Google-Smtp-Source: APXvYqyuvjEfth4YDehvnlu4sg7KzZH+V864rH17G0t9W1ipszxnBv8MvBpVbMlUcfCSULzoA7RICAMA293yeg0LB58=
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr11594549oig.23.1554588689839;
 Sat, 06 Apr 2019 15:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190405214245.19834-1-jpittman@redhat.com> <f737dfe8-9e7f-4cb2-1f15-82daa62c479c@kernel.dk>
 <CA+RJvhxyp2n=p2gfbkv1qHstshCBq1rO2i0quxV4HPjNsqCFpg@mail.gmail.com> <7333e34d-a10d-cbf8-a2d3-e6119abb3724@kernel.dk>
In-Reply-To: <7333e34d-a10d-cbf8-a2d3-e6119abb3724@kernel.dk>
From:   John Pittman <jpittman@redhat.com>
Date:   Sat, 6 Apr 2019 18:11:19 -0400
Message-ID: <CA+RJvhzVRwP_rFXB98VTge2Avj+4bxtM-WSniEKuiQP7aJp5nA@mail.gmail.com>
Subject: Re: [PATCH] null_blk: prevent crash from bad home_node value
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        Yi Zhang <yizhan@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yep, yours works better. :)  Thanks a lot Jens.


On Sat, Apr 6, 2019 at 12:50 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/6/19 8:47 AM, John Pittman wrote:
> > Hi Jens, I got some unexpected results with this patch this morning.
> > When loading null_blk with no arguments, I got the invalid home_node
> > value error message.  I did some debug and found that the values
> > seemed fine:
> >
> > +       pr_err("g_home_node is %d", g_home_node);
> > +       pr_err("nr_online_nodes is %d", nr_online_nodes);
> > +       pr_err("NUMA_NO_NODE is %d", NUMA_NO_NODE);
> > +
> > +       if (g_home_node >= nr_online_nodes) {
> > +               pr_err("null_blk: invalid home_node value\n");
> > +               g_home_node = NUMA_NO_NODE;
> > +       }
> > +
> >         if (g_queue_mode == NULL_Q_RQ) {
> >                 pr_err("null_blk: legacy IO path no longer available\n");
> >                 return -EINVAL;
> >
> > [root@localhost linux]# modprobe null_blk
> > [  296.336473] g_home_node is -1
> > [  296.336474] nr_online_nodes is 1
> > [  296.336514] NUMA_NO_NODE is -1
> > [  296.336558] null_blk: invalid home_node value
> > [  296.338825] null: module loaded
> >
> > [root@localhost linux]# numactl --hardware
> > available: 1 nodes (0)
> > node 0 cpus: 0 1 2 3
> > node 0 size: 828 MB
> > node 0 free: 451 MB
> > node distances:
> > node   0
> >   0:  10
> >
> > Fortunately, and also unexpectedly to me, I was able to fix the issue
> > just by casting nr_online_nodes as an int.
> >
> > +       if (g_home_node >= (int)nr_online_nodes) {
> > +               pr_err("null_blk: invalid home_node value\n");
> > +               g_home_node = NUMA_NO_NODE;
> > +       }
> > +
> >
> > Would you like me to send in a v2 for this?
>
> Well, I already added it... I'll just edit it. But I think we should
> make it:
>
> if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes)
>
> instead.
>
> --
> Jens Axboe
>
