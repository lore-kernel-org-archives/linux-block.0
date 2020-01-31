Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552EFC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278B920705
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaW/VNMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAaK60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:58:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44431 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgAaK60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:58:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so8038287wrx.11
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 02:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7Gk9cPCkTSDWbB6q2tFBeDsbXEH+JlFhYj6vVW0a78=;
        b=CaW/VNMjLavLEKQ9zQkokXUu91Rs6qoKPOjeTO05XgmSs5hWoGjo6OjbvD+NnW0576
         lqlLGYwz410Xp7UHQerU0r8SGQGJ5Xf8Ti1CKsgMr2CrXq5Bc6tXXu0RGmC5PQEDTb8g
         OwSAtHSxs/G6ePgghgLRuKsu9DudRe+Un//tD3dtHw1bV1Y3mv7kxULkZeXz0CWJP0ej
         YQlgsSRoimQyN3YU2OYoZeU27F+EZv6SmXxDbVzeVWCIe4Yfy2pPRYvprOhs8QJdFAib
         GM6bRYPJtbcoEBqmxPIVozA1elcJbYp6YwSTe++19yEBg8Z4/3EvlFiimahKtlc5qc7+
         PGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7Gk9cPCkTSDWbB6q2tFBeDsbXEH+JlFhYj6vVW0a78=;
        b=gBjPR46JFrZu7zxHF8kBLpHzL8htlJlY0gCLplQzBPcRgteppuWkZwuhubaLE1VlTy
         yhCfwnEaJ2sOfj21vSeBe3UX+0n1zGdac0DStryDadg9gZJOJYVkxgn26Q7aFXpxDaK+
         2TI/EQ+wzr7HZOmtbmF5ogKuBfJSlu6EbdoALhKgyEH0MmdHGhJF2dpYezcwXYFy3fNd
         ybxnrcCI8sKJvgrbCYSTXS34+poFG+GwBmj/O82x+zWbdS8+GzQJHQ2iYbBgkzV9Utt3
         ZONz5L3LBqPfBwdwTgOUUexF2n6GnTTPBj+TJxEpJhtS7rB+8WiQjWpXINPYVUZGz1kM
         EkRA==
X-Gm-Message-State: APjAAAW0Fgk4YJEV7rXLxGPQYRoQq9wM/gP8l7SF1ApWSLtydRIMrhSQ
        DOZJX/Hy0KkNcwMKDjkVZ2TsalaBdveXLSGd8p0=
X-Google-Smtp-Source: APXvYqwSoiD3EswQat0PkEr32vEVKUQdWmV2A3IsT3Apct8EPPvVSsmFkK3mTljG5qgmpE5srYiS+Xb1Xtf/l3ZEfOk=
X-Received: by 2002:adf:db84:: with SMTP id u4mr11666377wri.317.1580468304721;
 Fri, 31 Jan 2020 02:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20200115114409.28895-1-ming.lei@redhat.com> <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com> <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
In-Reply-To: <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 31 Jan 2020 18:58:12 +0800
Message-ID: <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 31, 2020 at 6:24 PM John Garry <john.garry@huawei.com> wrote:
>
> >> [  141.976109] Call trace:
> >> [  141.978550]  __switch_to+0xbc/0x218
> >> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
> >> [  141.986027]  process_one_work+0x1e0/0x358
> >> [  141.990025]  worker_thread+0x40/0x488
> >> [  141.993678]  kthread+0x118/0x120
> >> [  141.996897]  ret_from_fork+0x10/0x18
> >
> > Hi John,
> >
> > Thanks for your test!
> >
>
> Hi Ming,
>
> > Could you test the following patchset and only the last one is changed?
> >
> > https://github.com/ming1/linux/commits/my_for_5.6_block
>
> For SCSI testing, I will ask my colleague Xiang Chen to test when he
> returns to work. So I did not see this issue for my SCSI testing for
> your original v5, but I was only using 1x as opposed to maybe 20x SAS disks.
>
> BTW, did you test NVMe? For some reason I could not trigger a scenario
> where we're draining the outstanding requests for a queue which is being
> deactivated - I mean, the queues were always already quiesced.

I run cpu hotplug test on both NVMe and SCSI in KVM, and fio just runs
as expected.

NVMe is often 1:1 mapping, so it might be a bit difficult to trigger
draining in-flight IOs.

Thanks,
Ming Lei
