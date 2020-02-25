Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFA7C35DE1
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711F12072D
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2cXQFv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgBYOLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:11:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40989 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgBYOLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 09:11:02 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so1955447ioo.8
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuyjphlA2CCveQ0MZg02qKZPdw8Avu4nSPzT/upFgrc=;
        b=g2cXQFv76MfCdlYpVLFP6jtndRlWTSDK3TNUVgQdXgBpfcsfynuC49Ke74FtjMjWUa
         kH449V60JUqdnjOfQWnK3/dLTFIT3RHevYNkRllK1SrGCLTU+Q0pejeS3YtYoF7ZrO72
         GP9B7oMUpvkC16sdSik/eLJfw5VrpDzM3wemDYbUKzk9ze2Sww5aR+d/O2CWpeSWA104
         xmL1GbSinyQnXDCkjVdrAK9FsNx+Fn/hetiL60bAmXnv38W1Nm+YKFwo++0HTEYb70e0
         iL1DTSikMS6Bu9QtboDb1aJvH+FkdAN7v35rews0aaIt4epbL6LVI8es/wGGdxgeFNHg
         4emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuyjphlA2CCveQ0MZg02qKZPdw8Avu4nSPzT/upFgrc=;
        b=q17ldgHMgmbVuQcmhSoUjZ9bLkCY0jEcv647wWydNffFcVY+aIiQeFiGj7Hiy//VaO
         P8u7ODm4BP/hc8xgSoaemV4KQYJzMxAyy8nE3rAG+3o/gWy23CoKmKFtMs9eOWiqQ2sk
         wM+sirIykG6DWRW0jrSAUn6i9n2QpcRAleP3DcLVAwv3baB7LbAj8W1fLJ12h/Hgrw6U
         mgBYFjuwfolk/JGUdvIuIQkb0zHubAPgetxYoLuWXMBgyaVEM+r3sObpnpYUMeHADxJe
         ADjxI6CLRN6BEtWHzyM5x+nE+6B49DkKTtbNWOEJ90s0hikMk2uTmMqQiK6PvmglE4lb
         eQdA==
X-Gm-Message-State: APjAAAVTaEwpQvqjzne4AVBdVOBUMWDoWU34Pz4rHdcsEln7Sbsx5EeA
        4qxmWfFYdOIDHO6bTxkwn8xxxmusbNlQE5NofoY7rA4o
X-Google-Smtp-Source: APXvYqyE7nlNBsyMe5ZIk4iCBnFH6h/vMwzeXCRYqgJHj28uhP3bmb39oYwp6byFOUt4J/WDFPoc8WDaLAl+3Kktiu0=
X-Received: by 2002:a6b:6b0e:: with SMTP id g14mr60619351ioc.71.1582639862067;
 Tue, 25 Feb 2020 06:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20200219063107.25550-1-houpu@bytedance.com> <20200219063107.25550-2-houpu@bytedance.com>
 <5E54BF6C.4060309@redhat.com>
In-Reply-To: <5E54BF6C.4060309@redhat.com>
From:   Hou Pu <houpu.main@gmail.com>
Date:   Tue, 25 Feb 2020 22:10:50 +0800
Message-ID: <CAKHcvQi=tHWkkMj=doPPf_kwCURvmumJdQNSWjwnsMo7vVREVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nbd: enable replace socket if only one connection is configured
To:     Mike Christie <mchristi@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 2:32 PM Mike Christie <mchristi@redhat.com> wrote:
>
> On 02/19/2020 12:31 AM, Hou Pu wrote:
> > Nbd server with multiple connections could be upgraded since
> > 560bc4b (nbd: handle dead connections). But if only one conncection
> > is configured, after we take down nbd server, all inflight IO
> > would finally timeout and return error. We could requeue them
> > like what we do with multiple connections and wait for new socket
> > in submit path.
> >
> > Signed-off-by: Hou Pu <houpu@bytedance.com>
> > ---
> >  drivers/block/nbd.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 78181908f0df..8e348c9c49a4 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -395,16 +395,19 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
> >       }
> >       config = nbd->config;
> >
> > -     if (config->num_connections > 1) {
> > +     if (config->num_connections > 1 ||
> > +         (config->num_connections == 1 && nbd->tag_set.timeout)) {
> >               dev_err_ratelimited(nbd_to_dev(nbd),
> >                                   "Connection timed out, retrying (%d/%d alive)\n",
> >                                   atomic_read(&config->live_connections),
> >                                   config->num_connections);
> >               /*
> >                * Hooray we have more connections, requeue this IO, the submit
> > -              * path will put it on a real connection.
> > +              * path will put it on a real connection. Or if only one
> > +              * connection is configured, the submit path will wait util
> > +              * a new connection is reconfigured or util dead timeout.
> >                */
> > -             if (config->socks && config->num_connections > 1) {
> > +             if (config->socks) {
> >                       if (cmd->index < config->num_connections) {
> >                               struct nbd_sock *nsock =
> >                                       config->socks[cmd->index];
> > @@ -747,8 +750,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
> >                                * and let the timeout stuff handle resubmitting
> >                                * this request onto another connection.
> >                                */
> > -                             if (nbd_disconnected(config) ||
> > -                                 config->num_connections <= 1) {
> > +                             if (nbd_disconnected(config)) {
>
> I think you need to update the comment right above this chunk. It still
> mentions num_connections=1 working differently.

Thanks. Will change the comment in v2.

>
>
> >                                       cmd->status = BLK_STS_IOERR;
> >                                       goto out;
> >                               }
> > @@ -825,7 +827,7 @@ static int find_fallback(struct nbd_device *nbd, int index)
> >
> >       if (config->num_connections <= 1) {
> >               dev_err_ratelimited(disk_to_dev(nbd->disk),
> > -                                 "Attempted send on invalid socket\n");
> > +                                 "Dead connection, failed to find a fallback\n");
> >               return new_index;
> >       }
> >
> >
>
