Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B5C11D0C
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA0D24682
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 17:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUdFldeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBTRyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:54:44 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37285 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgBTRyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 12:54:44 -0500
Received: by mail-lf1-f49.google.com with SMTP id b15so3833701lfc.4
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqMQTNTqAScrbbjAL00quzcLbXeMUXLVbynXt4e9wxY=;
        b=LUdFldegpwqvpb6jUZ3KgoQ8St6ComRy2Mt0QI/Aro5+InOuut6omXAr9nQF3o2TGT
         t8Rje9zNPB+Y70s2ziwN6pzj+GBEpkV/rj+BJvNjdp28MIoeLj+1ryQVtLHF44L1cElj
         Fdmcu69yfiRlkdgybwGqgcdsYCwE0oNwuTzqYSVh4hXy5w1LwfsVrzdSuetsLJ3bp19V
         hcU3wPT47l5uUfH5g7uN61Kbwnu99/puDW/sAY+BQHCP2flbDaG/hTysnOcQcpaznGVy
         pTNhgGAGraAd+K2mXoQ4sfXQO/MBsz3Cee7NH71g9WoS+6nu0/qKW7/EQ9Eu1DGgnsoT
         Dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqMQTNTqAScrbbjAL00quzcLbXeMUXLVbynXt4e9wxY=;
        b=JIRtWlayngLa7xsVj6u0zXqsRjeYxGXDaSRPuqZsnNtks/+eydZ9U6Txyu2vGuAcnb
         Q86SZTdDqnNVlM5sCdzNY0CjI1kU7MLaEw4yMqascPIDicGoh3yP7l5riFB+YOXmwDex
         FBxVb7bTvxS0mpxVzMC9wcnEzP73hiGyqjQS5SKduA3TLTXYpBedXyxgY0leLHnmNt6W
         nQl0hiZ0flIXkZDvEmI7157rFHQdhuJ9GMcNdvIAsa7ahmpb/1kTxM9MSe4RvXOt7GZl
         KAT1a2EWruihU7gKNSPTUkCCeaE56QX/q7g6JDeujNvremmQ8r8btHGy4Q3ObHPOdJcF
         lG8w==
X-Gm-Message-State: APjAAAVy6DjckA9WbZfT5Bj4X7Tp1yhorkD1X0nnHCwy+BIDv8pCNcdg
        GVgb230MM1BEDFPU+90trZT8MD+tyZrfhXz0EpnRTpTJiOw=
X-Google-Smtp-Source: APXvYqw4jx+ECCaEc3pF2ddqAmUhWLsxs2tPv4F4B0Csslzt7ukoQ1EBe4t/LuTxKaPi4aNtoc+oNcCIYcIDitOBvUg=
X-Received: by 2002:a19:6d13:: with SMTP id i19mr16812579lfc.6.1582221282402;
 Thu, 20 Feb 2020 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
In-Reply-To: <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Feb 2020 23:24:31 +0530
Message-ID: <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
>
> Try to restore the value for the cache flush timeout, by updating the
> define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".

I have increased the timeout to 10 minutes but it did not help.
Same error found.
[  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
[  608.684964] mmc1: cache flush error -110
[  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0

OTOH, What best i could do for my own experiment to revert all three patches and
now the reported error gone and device mount successfully [1].

List of patches reverted,
  mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
  mmc: block: Use generic_cmd6_time when modifying
    INAND_CMD38_ARG_EXT_CSD
  mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

[1] https://lkft.validation.linaro.org/scheduler/job/1238275#L4346

- Naresh
