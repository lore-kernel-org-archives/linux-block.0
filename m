Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E71ECE599
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 02:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB396218DE
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 02:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBh8gacb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395192AbfJQCRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:17:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46370 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393050AbfJQCRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 22:17:35 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so991616ioo.13;
        Wed, 16 Oct 2019 19:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK1OtpwhD+5T5SYc4aqWUSJoX7IiVAlBKWUj0KHIhec=;
        b=uBh8gacbPpI0VJl5KhIjIShsglvHOpHqpSWiu+6AxZwpiR2br9ZYDKkGK4jzLu+SUZ
         7pgTlEXcdIACDCfz+ZcAn1V3BDOLqi6DGWoP5O2RU3WMcLv1Lh90cXa+FJJrvFJQR2aT
         bAPtAcTfnfiJL+4duRq6FOhydOf/C+oXrqvtrxoGjsvx/VtGH1nkHRyAnI3TwxWEh6ex
         ReT4YQ6smyx7AQxDNe85Egx7Ln9loTOI253cZKhTn+qZA5IW7+3rjqztC8mgvP6Rcb+y
         WLxo78bSS6cWb63/APDyM9X9QxXPq5M3bemJVqbqCvakXx23eoJQZMAe3a4aculMMmgS
         AMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK1OtpwhD+5T5SYc4aqWUSJoX7IiVAlBKWUj0KHIhec=;
        b=mLU7tYNnGyXA8rQhdEMKyJMX2JMrRhoEwE0uB64D8D3mAql93OnkdiA2f6BrM5ch/v
         FjVhHHW8zuCkFXuXW5Mypprm7Ylz/WklblU0dEaeYRQxJNVQHh4ezmFSyeGo1L3jnA1C
         e46IHak4JYUAsyRQ6GPeuFNshEDCXcyZOXDwpada7urcwn7SqshBDTQ0BhWa5x9A3bOK
         aPMaVWiF7PXFVozSq4sv0kmtZeynSsdpgWmUT7bcPQNKGPiMNdSaMgfrmpH/ETBeEN5V
         WvstdylAyu96ccD3D7BotpvWGyBupyjTl+oxAjKLe8+T0Pl5nX+Hz7jpHhOfctYaLqhV
         rIqQ==
X-Gm-Message-State: APjAAAVXv2B4evh5rw2caL1OdEBiJaL0uvioVoGYQi9kTg+Ee9U/DRil
        Z9JyckTFOK0timimsWSQmWlW5AsaBokj2xkm+KY=
X-Google-Smtp-Source: APXvYqxULrKgQ13wwrDcc/ZVRpDzrh5ucuhgVylaQdb5YcGidUlTidsU1sTS0PxjOuF31m58p9CFtoXVTVngUlEoyDs=
X-Received: by 2002:a02:a11e:: with SMTP id f30mr1061524jag.95.1571278652391;
 Wed, 16 Oct 2019 19:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
 <20190729164226.22632-1-navid.emamdoost@gmail.com> <20190910113521.GA9895@unicorn.suse.cz>
In-Reply-To: <20190910113521.GA9895@unicorn.suse.cz>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 16 Oct 2019 21:17:21 -0500
Message-ID: <CAEkB2ES8rc4kkPwA+okfMa9CpFoDqmt=tx8H8vHZKBCfw9L_tg@mail.gmail.com>
Subject: Re: [PATCH v2] nbd_genl_status: null check for nla_nest_start
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, secalert@redhat.com,
        Navid Emamdoost <emamd001@umn.edu>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michal, please check v3 at https://lore.kernel.org/patchwork/patch/1126650/


Thanks,
Navid.

On Tue, Sep 10, 2019 at 6:35 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> (Just stumbled upon this patch when link to it came with a CVE bug report.)
>
> On Mon, Jul 29, 2019 at 11:42:26AM -0500, Navid Emamdoost wrote:
> > nla_nest_start may fail and return NULL. The check is inserted, and
> > errno is selected based on other call sites within the same source code.
> > Update: removed extra new line.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > Reviewed-by: Bob Liu <bob.liu@oracle.com>
> > ---
> >  drivers/block/nbd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 9bcde2325893..2410812d1e82 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -2149,6 +2149,11 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
> >       }
> >
> >       dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
> > +     if (!dev_list) {
> > +             ret = -EMSGSIZE;
> > +             goto out;
> > +     }
> > +
> >       if (index == -1) {
> >               ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
> >               if (ret) {
>
> You should also call nlmsg_free(reply) when you bail out so that you
> don't introduce a memory leak.
>
> Michal Kubecek



-- 
Navid.
