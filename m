Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C8C636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 09:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjBGJc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 04:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGJc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 04:32:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468F10407
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 01:32:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so41479807ejc.11
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 01:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNP+q3vs+Z5udWIjPmGdcVF0GpLoD0c1sc+OhYugIDg=;
        b=QHsiNh2heWH9koqO0gtTY0fr1XHDtyS7qtY6vXa6+R17sles4JC6euJHiDqUOyXJNk
         4g3gNURY+c7vi2JpCm9Sh0cSRIm657LyFr9AyZsVisqqTcGXkb1LN01F86mtQxGo4uWc
         ZfDbUQ+juh8iX9rmjNpi44e+UZcaiVXIXkTfeJwOlI0dTvF4THsYp3Q+TaWWz0aCbxBM
         4MpnHQnA3Gr487S3iCYwB35BC0WKRXPbFrfQVSM82VQZaGE/kpeQfFqAv4xv0fvYli+n
         KZ/ugWM1ylsUhVFncbGPm9Ig9ysOuYTEBtQ/epU9NVa7MbEJOj2uxldQXkqtdHnGivOD
         PQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNP+q3vs+Z5udWIjPmGdcVF0GpLoD0c1sc+OhYugIDg=;
        b=vLTM1klhz7S4lgoqkBgtJO2SbLtYXA/RZ+oum2bx5LpO+EDAm05Yek2m+7WG85blNS
         yXqKiSqPMhikCg6IO91GA5I1fQINBtnRtyN2vDIFGgskpK02EvI6dCf+otiZf9ZGpuXH
         y3CfZT2c/IdFUunmt3yltdVDufx7Foggt8EIXop4LK2PkVj4401GVGc0LGZEY4h4ics3
         +e1I0zv7EPwxpPh357d/4qXQ1JnlMuE6n+EmqoYdxcUtqkgkfcS9JkU7UU8CAwRLhJr1
         GVjZNfwmXw7BW+5ndQJgNBs+8pQP7SDe/nr98671oaF/Rf15N7Z6mL/Ohcksiwnhx1sC
         8EDQ==
X-Gm-Message-State: AO0yUKVRKIzKQg+Ts1ULLwxlLgK2nHFdtngYEte959x/Qx+BjVF+AQjv
        RKQ6mvTjbCrWNMISnOsBJKZLbT6vkbrxtsNlpUlkvw==
X-Google-Smtp-Source: AK7set+x27QD5r8pYTdsXOE7XRDFvhlMBCvzl9Cfl1Qlbw74cR7suFlkTUe+KVLAzLUiyxHbNWsF4GaH0mIasvkY4sw=
X-Received: by 2002:a17:906:6957:b0:886:73de:3efc with SMTP id
 c23-20020a170906695700b0088673de3efcmr761092ejs.87.1675762373122; Tue, 07 Feb
 2023 01:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20230206100019.GA6704@gsv> <Y+D3Sy8v3taelXvF@T590> <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
In-Reply-To: <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 7 Feb 2023 10:32:42 +0100
Message-ID: <CANr-nt1De3QmiGQGrCU5eRSufE1tGQdS9kX2uZrRt8COC=06qQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?UTF-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 6, 2023 at 3:35 PM Matias Bj=C3=B8rling <Matias.Bjorling@wdc.co=
m> wrote:
>
> > Maybe it is one beginning for generic open-source userspace SSD FTL, wh=
ich
> > could be useful for people curious in SSD internal. I have google sever=
al times
> > for such toolkit to see if it can be ported to UBLK easily. SSD simulat=
or isn't
> > great, which isn't disk and can't handle real data & workloads. With su=
ch
> > project, SSD simulator could be less useful, IMO.
> >
>
> Another possible avenue could be the FTL module that's part of SPDK. It m=
ight be worth checking out as well. It has been battletested for a couple o=
f years and is used in production (https://www.youtube.com/watch?v=3DqeNBSj=
Gq0dA).
>
> The module itself could be extracted from SPDK into its own, or SPDK's ub=
lk extension could be used to instantiate it. In any case, I think it could=
 provide a solid foundation for a host-side FTL implementation.

Thanks for bringing SPDK's CSAL up, I think it's a great example of a
well implemented host-ftl.

It does require a fast caching device with persistence guarantees
(like optane) though, not entirely unlike dm-zoned.
It also lives in the spdk universe, which makes it a bit harder to
work with than a standalone ftl.

While a cache in front of the backing storage gives the ftl some time
to organize writes in a device-friendly manner
before flushing, it adds cost (write amplification or having to add a
fast persistent cache device)

I've seen that SPDK already has the required plumbing for UBLK:
https://spdk.io/doc/ublk.html
I don't know if IO can be routed to CSAL yet.

That said, it would be great to support the CSAL use case in a common ftl.
Not all workloads require a cache, so I think that caching should be optima=
l.
Raiding and supporting multiple tenants from a combined pool of
storage is super-nice.

Cheers,
Hans
