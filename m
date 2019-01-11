Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66034C43444
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380D520872
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfAKO5Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:57:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41003 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbfAKO5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 09:57:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so13310607otk.8;
        Fri, 11 Jan 2019 06:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JGzfeS2moeGKrgbjYztqlSp3x8nVRM2tLKzBtYuE4IA=;
        b=YInLNuCgDrXZy+DE7XfmrgzujpHNntol40vFAgOier14G/PrjWC4IHemEdSIBo2rj5
         a2j3uEr2wABMPMT8EuDk0Txo+ajdGMGhrT3TRnc+R4OMsxJ+ZawCN0np4bFm8tn6tYB1
         7R+7nMycC0U4E67j0xSVm1a3DLg7GzMC0avLTQA8DwFdYAo7/xGUUdDZ3c8gN6XNjWlU
         s/dDiK4PgwG+TQXTnXfM62XEek051IgbcTUAx1sdF7ss6/s0LrqPuccD84BAU2iZ93rM
         SYS2h4FXa1WeGd2Le89tr4iWaA7FPmgiV1a4txeoUyxx/eGu6LfvhG41z5OohT1AQYIf
         H4GA==
X-Gm-Message-State: AJcUukflCtJhds7yS6zGr6fQfGmsiS1OjUoCisFL33ZQ3HXHOKdeJvNu
        v1cujv0KEO2DZFgtGoS0T0SP9dAZ5uv/GJM4IC0=
X-Google-Smtp-Source: ALg8bN7u9dodIM0o2cAk2ZRM5QOUptT7ubs4+QkZDq1cZiM48WpMhSndJGY/pxu+Tyw2Ssp/lh1qsXU5pM0LqDH9yzU=
X-Received: by 2002:a9d:75da:: with SMTP id c26mr10569533otl.39.1547218633801;
 Fri, 11 Jan 2019 06:57:13 -0800 (PST)
MIME-Version: 1.0
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
 <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
 <20190107120107.euf7mrq7gk6bmibz@mac> <35c7d495-2d6c-5fec-abf8-c5aef55cf866@oracle.com>
 <56819579-def2-b045-f414-4de45188fe2e@oracle.com> <20190107152708.z4mecdm2apfxz2rk@mac>
 <d347524f-20e1-6ce4-70f5-95b699374bb2@oracle.com>
In-Reply-To: <d347524f-20e1-6ce4-70f5-95b699374bb2@oracle.com>
From:   =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <royger@freebsd.org>
Date:   Fri, 11 Jan 2019 15:57:02 +0100
Message-ID: <CAPLaKK4VAS1EXAXRmSxSShdxQK=ZdShVRMeCkswg=RPEjvRVog@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v4 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        axboe@kernel.dk, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Paul Durrant <Paul.Durrant@citrix.com>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 8, 2019 at 10:53 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> Hi Roger,
>
> On 01/07/2019 11:27 PM, Roger Pau Monné wrote:
> > On Mon, Jan 07, 2019 at 10:07:34PM +0800, Dongli Zhang wrote:
> >>
> >>
> >> On 01/07/2019 10:05 PM, Dongli Zhang wrote:
> >>>
> >>>
> >>> On 01/07/2019 08:01 PM, Roger Pau Monné wrote:
> >>>> On Mon, Jan 07, 2019 at 01:35:59PM +0800, Dongli Zhang wrote:
> >>>>> The xenstore 'ring-page-order' is used globally for each blkback queue and
> >>>>> therefore should be read from xenstore only once. However, it is obtained
> >>>>> in read_per_ring_refs() which might be called multiple times during the
> >>>>> initialization of each blkback queue.
> >>>>>
> >>>>> If the blkfront is malicious and the 'ring-page-order' is set in different
> >>>>> value by blkfront every time before blkback reads it, this may end up at
> >>>>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> >>>>> xen_blkif_disconnect() when frontend is destroyed.
> >>>>>
> >>>>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> >>>>> once.
> >>>>>
> >>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >>>>> ---
> >>>>> Changed since v1:
> >>>>>   * change the order of xenstore read in read_per_ring_refs
> >>>>>   * use xenbus_read_unsigned() in connect_ring()
> >>>>>
> >>>>> Changed since v2:
> >>>>>   * simplify the condition check as "(err != 1 && nr_grefs > 1)"
> >>>>>   * avoid setting err as -EINVAL to remove extra one line of code
> >>>>>
> >>>>> Changed since v3:
> >>>>>   * exit at the beginning if !nr_grefs
> >>>>>   * change the if statements to avoid test (err != 1) twice
> >>>>>   * initialize a 'blkif' stack variable (refer to PATCH 1/2)
> >>>>>
> >>>>>  drivers/block/xen-blkback/xenbus.c | 76 +++++++++++++++++++++-----------------
> >>>>>  1 file changed, 43 insertions(+), 33 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> >>>>> index a4aadac..a2acbc9 100644
> >>>>> --- a/drivers/block/xen-blkback/xenbus.c
> >>>>> +++ b/drivers/block/xen-blkback/xenbus.c
> >>>>> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>>>>   int err, i, j;
> >>>>>   struct xen_blkif *blkif = ring->blkif;
> >>>>>   struct xenbus_device *dev = blkif->be->dev;
> >>>>> - unsigned int ring_page_order, nr_grefs, evtchn;
> >>>>> + unsigned int nr_grefs, evtchn;
> >>>>>
> >>>>>   err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
> >>>>>                     &evtchn);
> >>>>> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>>>>           return err;
> >>>>>   }
> >>>>>
> >>>>> - err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> >>>>> -                   &ring_page_order);
> >>>>> - if (err != 1) {
> >>>>> -         err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
> >>>>> + nr_grefs = blkif->nr_ring_pages;
> >>>>> +
> >>>>> + if (unlikely(!nr_grefs))
> >>>>> +         return -EINVAL;
> >>>>
> >>>> Is this even possible? AFAICT read_per_ring_refs will always be called
> >>>> with blkif->nr_ring_pages != 0?
> >>>>
> >>>> If so, I would consider turning this into a BUG_ON/WARN_ON.
> >>>
> >>> It used to be "WARN_ON(!nr_grefs);" in the v3 of the patch.
> >>>
> >>> I would turn it into WARN_ON if it is fine with both Paul and you.
> >>
> >> To clarify, I would use WARN_ON() before exit with -EINVAL (when
> >> blkif->nr_ring_pages is 0).
> >
> > Given that this function will never be called with nr_ring_pages == 0
> > I would be fine with just using a BUG_ON, getting here with
> > nr_ring_pages == 0 would imply memory corruption or some other severe
> > issue has happened, and there's no possible recovery.
> >
> > If you want to instead keep the return, please use plain WARN instead
> > of WARN_ON.
> >
> > Thanks, Roger.
> >
>
> Is there any reason using WARN than WARN_ON? Because of the message printed by
> WARN? something like below?

Oh, so WARN also takes a condition, I was expecting WARN to not take
any parameters. Just use WARN_ON(true); then, there's no need to
re-evaluate !nr_grefs.
