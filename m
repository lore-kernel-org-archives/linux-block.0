Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE5C433E2
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71958207DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 11:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFkTPyu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgFALhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFALhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 07:37:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A82C03E97C
        for <linux-block@vger.kernel.org>; Mon,  1 Jun 2020 04:37:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so7731191ljj.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQTt+MIIpyDA4belDkYAgM2iFZj3fYj7DkPTdahh8pc=;
        b=mFkTPyu0DgEndR/rPSLh+6SZhzSM1qBKDd8PBw9+8FvGjQLyi0X4GhIxr44O0HNY9S
         B0O6ex76hLxTjxqQ49jCMJRn0P5+NwecUxkmaO+2TZvf9guPUE23aZWwKzSV1NJUHrcB
         XWTjHPSBLmNyW5MpuJeasWOkKZDwWVMWV09Kuyua48ogCAyegiD3cR/TT1fDiwk8TBVe
         y4rDFfND0mqTQzB7qrGexH6onIGb5aDrS1KF78f7S5UesCrxYaMWTUjSc4eMyNToKq9P
         irMvgdInEjpirCLJqjXh2FRQc1HtYKpAsHox8q+6ds+nU4NbLZHd1w9jc1+L/R2rJGAo
         PjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQTt+MIIpyDA4belDkYAgM2iFZj3fYj7DkPTdahh8pc=;
        b=OwL8lbGSZ1WMnLtEYsFOF8RekEjRBJyB73VUnN/3xG6/hzVjnMs4+UxeulYZr/uDIA
         begu20tRHSb+Id9nvz4JWuWTq16qyP+wjAsNPa77NjPMCxNa2stbcCp5/aIq6UVjVTUA
         3tzPFG9Cj7UbvGGa890KhvjCGMcmoM9yQF3VIr5EFnVTLHKZesg+lkxMaClxEdk2YYo1
         sKS/mKZilaADHOnSwBcSs9q4PzW0G9O2S+LMqbsJyvocbaK/AqwjyL/l1gHXv0DTN+E9
         oo/I6p/hzgx2G7lOBrcgkQedbWA+bTb/+ZvfQZKPZqxrbz6pcn5AtDNh38ntXpXqtYzs
         rcdQ==
X-Gm-Message-State: AOAM531BkTV4eV2lUsmfEnn+yOt8pqMlgMaxxORySTiDnnNqs7tfwB1+
        ss/YL6YgUdIt3kjqE2NP3CGmj5ql1XGSWbDEnBr+cw==
X-Google-Smtp-Source: ABdhPJw+PTS+SxItJ484C0YqddclYX1X+Em1nuXbhwpxd5uIYFTeFzaNLSV1mhgdPe0vjmuzIUkSf9IuyYYdVc5kqow=
X-Received: by 2002:a2e:92d7:: with SMTP id k23mr1854314ljh.100.1591011425955;
 Mon, 01 Jun 2020 04:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200528081003.238804-1-linus.walleij@linaro.org> <20200601074957.GE1181806@T590>
In-Reply-To: <20200601074957.GE1181806@T590>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Jun 2020 13:36:54 +0200
Message-ID: <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 1, 2020 at 9:50 AM Ming Lei <ming.lei@redhat.com> wrote:
> On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
> > The Kyber block scheduler is not suitable for single hardware
> > queue devices, so add a new flag for single hardware queue
> > devices and add that to the deadline and BFQ schedulers
> > so the Kyber scheduler will not be selected for single queue
> > devices.
>
> The above may not be true for some single hw queue high performance HBA(
> such as megasas), which can get better performance from none, so it is
> reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
> issue directly if hw queue isn't busy in case of 'none'"), and the
> following link:
>
> https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/

I see, but isn't the case rather that none is preferred and kyber gives
the same characteristics because it's not standing in the way
as much?

It looks like if we should add a special flag for these devices with
very fast single queues so they can say "I prefer none", do you
agree?

Yours,
Linus Walleij
