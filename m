Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D49C83013
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F384C2222E
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgLBIav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbgLBIau (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 03:30:50 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFBC0613D4;
        Wed,  2 Dec 2020 00:30:10 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so2399040ejm.0;
        Wed, 02 Dec 2020 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOr64WR7JFh8O6zNoSvDJ/dxwL5S48zFZviyd6WC91U=;
        b=IdFVuOEzP1UAX1qbacan+RDDK2HPWdWW+uKPz5xMiXD8BrBdZyaBWurby6ulSX3FSM
         Sd2D2MZ+RJyzLsf59s1tTiJ7GgHpZsIJT2aqiZzENw5+NzLIKsvTvEu63yi60hSdL7iH
         jJRuoQ1tzzsAHfEq9jfcT/p9H0Qj1Ps69GZpNCOzWqO9bmxivYwkjZEZDPeXZhiPCW1X
         sG5F1TQF+MZuiw7kxeGNrD5ctg8U7N91rLjY/LXOn5Yyl9jADe/JZAsi5HFcA7rFIDSb
         gykybnUCwp2zkHSpuBd8tmgHGMSXQ1VWblo65+PwYk0eWMIg8vOhnGtVVU4onE1jFMBe
         GfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOr64WR7JFh8O6zNoSvDJ/dxwL5S48zFZviyd6WC91U=;
        b=lkqqHAzMeKh//yZSqm1AcghkpL2gusaVaf73gmIn9Y31zb/8tqUzwZHAG9239Hb1it
         5Q/DuQWeJTpxN1TnsWYTBCh7xw/gYnZnXgCRmtPVZbSmybwRFALmD0WLdUibR2jgSkNO
         ntJedunzsfJF7cvpKflztHshidrKF3qeG+43mn2eKaS8VMaopaT41nMw5frxLU4KW31O
         v4DNR9GbMC8CBfycJo0jVaPZqEzExF15d8YMIQpzj0bC6jjVzaivffvgFuZpQ+OjrL7F
         OCQ+jxeYKeiO4aTqDNi6ycdcxbB6javX6mPeCRcFyvAuD2UUrgxv0pZyfWETQAMQzNrJ
         czEA==
X-Gm-Message-State: AOAM532qJr7RG/6WCuw2rflNwECsbMmEPeaiP42NzN0d02NLXouzjMe8
        1/aZSrUEaQMUehUbnr1eltuIsW2Nz5PnUc1cWAE=
X-Google-Smtp-Source: ABdhPJyRsn8F0ekuoReb0bu4eiYLt4n3UgNR7w1ghBcz65//gOpSDr+Z68bjAUScjfVTmjnqIQRXB44LXSR8nb15Zf4=
X-Received: by 2002:a17:906:6693:: with SMTP id z19mr1249325ejo.376.1606897808576;
 Wed, 02 Dec 2020 00:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e@epcas5p4.samsung.com>
 <20201201053949.143175-3-selvakuma.s1@samsung.com> <20201201151628.GA27728@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201201151628.GA27728@redsun51.ssa.fujisawa.hgst.com>
From:   Selva Jove <selvajove@gmail.com>
Date:   Wed, 2 Dec 2020 13:59:57 +0530
Message-ID: <CAHqX9vYLtpjWKu1otDWnSTM=MF+oMpFxSqLZvTZRcmp68LgCcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] nvme: add simple copy support
To:     Keith Busch <kbusch@kernel.org>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Damien Le Moal <damien.lemoal@wdc.com>, hch@lst.de,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 1, 2020 at 8:46 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Dec 01, 2020 at 11:09:49AM +0530, SelvaKumar S wrote:
> > +static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
> > +                                    struct nvme_id_ns *id)
> > +{
> > +     struct nvme_ctrl *ctrl = ns->ctrl;
> > +     struct request_queue *queue = disk->queue;
> > +
> > +     if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
> > +             queue->limits.max_copy_sectors = 0;
> > +             blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
> > +             return;
> > +     }
> > +
> > +     /* setting copy limits */
> > +     ns->mcl = le64_to_cpu(id->mcl);
> > +     ns->mssrl = le32_to_cpu(id->mssrl);
> > +     ns->msrc = id->msrc;
>
> These are not used anywhere outside this function, so there's no need to
> add members to the struct.

Sure. Will remove these entries from nvme_ns.

>
> > +     if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue))
> > +             return;
>
> The queue limits are not necessarily the same each time we're called to
> update the disk info, so this return shouldn't be here.
>

Makes sense.

> > +
> > +     queue->limits.max_copy_sectors = ns->mcl * (1 << (ns->lba_shift - 9));
> > +     queue->limits.max_copy_range_sectors = ns->mssrl *
> > +             (1 << (ns->lba_shift - 9));
> > +     queue->limits.max_copy_nr_ranges = ns->msrc + 1;
> > +}
>
> <>
>
> > @@ -2045,6 +2133,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> >       set_capacity_and_notify(disk, capacity);
> >
> >       nvme_config_discard(disk, ns);
> > +     nvme_config_copy(disk, ns, id);
> >       nvme_config_write_zeroes(disk, ns);
> >
> >       if (id->nsattr & NVME_NS_ATTR_RO)
> > @@ -3014,6 +3103,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >       ctrl->oaes = le32_to_cpu(id->oaes);
> >       ctrl->wctemp = le16_to_cpu(id->wctemp);
> >       ctrl->cctemp = le16_to_cpu(id->cctemp);
> > +     ctrl->ocfs = le32_to_cpu(id->ocfs);
>
> ocfs is not used anywhere.
