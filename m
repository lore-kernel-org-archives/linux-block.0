Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0CEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 13:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJJNbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJNby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 09:31:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127B17AB8
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 06:31:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f37so16595637lfv.8
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RpUSvVnWaGbOoIwxcuWyRel5Kf5muzD0mHkI19EVMmM=;
        b=Sh54JfuMpHwEKxXAkdFj8nCT/Qexz9mu+YaW/MJKOTW5fEPqbMW+n56wDSaUzzlTyD
         W6maaxmQsJVVSo+82Bho6BjER15oIA5QvLcV6EZUzXtEUXCpArIKQRrHL0MmGbDc9G7E
         z8QFHhyn6aYhnqBZgCw2tZtU0LF07D90m7HDyEjUrcMeZswUEKKs1E2j6kGHbWpd0DE5
         pT7vGmq7JRZ7cEmnnuLsqaUEO2Zq9xmt/471Bvgr1HaeFwHX20M/Hv9ZeolJDE7pumaY
         iY6spfsVcIwi7YgsQD5TkJX9EPvI6bgmgIvHQsqLGx/BqxjAn1COp+j7bcWbiBbJpJ/8
         ZA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpUSvVnWaGbOoIwxcuWyRel5Kf5muzD0mHkI19EVMmM=;
        b=FhmhF0RS7A4ruq6kq4XzK4YdhIf84eFQ/E/l+VPGVB81lsxi+g4PiTePUS5BKZoJsu
         Pzpakv56++veqKadP2ODAnh+FFgKmshaj+IUuKUkuElzXQVZOTXmL84ymAno6Vr7aXgy
         0JsPlyS3lGQkvhnBWWHvd9EuzVCtGe0NxAU/3VEC9HdbysbLugJlhaXKhDXF+lsWXW81
         Xm8bjH83TtnBZaApzZS0+2zg04mspTjWNKxpvM7tJYkA8LakmYMy1A4Ch+BTPeLTNRoz
         m8nMZnybEh+MvLcmGEJQ4Rg1xUK4dLDf7yJUaXRgrZQi8OSgq8qNkzFPEdwg2eYkEGxd
         +RUg==
X-Gm-Message-State: ACrzQf2W0dlCEXect4l/Af9jD61N3KGZbGE2nCVD7pWY7hNR8mcc+Wby
        o3BHNpJnSRCU4SUuZi7hwxhNHdhewiokj5C/NE0=
X-Google-Smtp-Source: AMsMyM4XwbfUFAkoLu3m6gd65bR0pXwTQkyux9wM4Uwjov0jrCeInT8i/MmRJoPJJJnw1kV+SDjmLfPSiaqRES+FbQA=
X-Received: by 2002:a19:5503:0:b0:4a2:329d:bc74 with SMTP id
 n3-20020a195503000000b004a2329dbc74mr7363290lfe.77.1665408711438; Mon, 10 Oct
 2022 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220930001943.zdbvolc3gkekfmcv@shindev> <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev> <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
In-Reply-To: <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Mon, 10 Oct 2022 15:31:32 +0200
Message-ID: <CAOSXXT7RVg8rNWP4cDwV6Ywtu1_DSZ=XhAyMkKrqS1uCi5UFKA@mail.gmail.com>
Subject: Re: lockdep WARNING at blktests block/011
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 7, 2022 at 10:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 10/3/22 08:28, Keith Busch wrote:
> > On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
> >>
> >> BTW, I came up to another question during code read. I found nvme_reset_work()
> >> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
> >> controller is already disabled when the reset work calls nvme_sync_queues().
> >
> > Right, everything previously outstanding has been reclaimed, and the queues are
> > quiesced at this point. There's nothing for timeout work to wait for, and the
> > sync is just ensuring every timeout work has returned.
> >
> > It looks like a timeout is required in order to hit this reported deadlock, but
> > the driver ensures there's nothing to timeout prior to syncing the queues. I
> > don't think lockdep could reasonably know that, though.
>
> Hi Keith,
>
> Commit b2a0eb1a0ac7 ("nvme-pci: Remove watchdog timer") introduced the
> nvme_dev_disable() and nvme_reset_ctrl() calls in the nvme_timeout()
> function. Has it been considered to invoke these two calls asynchronously
> instead of synchronously from the NVMe timeout handler (queue_work())?
> Although it may require some work to make sure that this approach does not
> trigger any race conditions, do you agree that this should be sufficient to
> make lockdep happy?

We still have to sync whatever work does the reset, so that would just
shift which work the lockdep splat indicates.
