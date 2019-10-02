Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39502C35280
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048252133F
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="TfizWOp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfJBPM7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:12:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35519 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfJBPLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 11:11:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so7398828wmi.0
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2019 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIwBPELl88iaMbSYiV7ycp6Z2I2x7UqLvm1fpqtgIXY=;
        b=TfizWOp1O5grpdnBXDk3+LRhC3jOPjmjiOtARGAnecRh/K1l/Eze0BI3ax7G8dcRfN
         9npLURBC3t5GSXRgBjBXwPLtG8NtfXp1SzSZw9jSNwJfz8oFxTNxaoQKOzpl1NKDcQd0
         q1jkbm9GH5JRcVoAZjecW3T1H8QtX7UjbNT7L+ohbCmO7o0dw/yBsC2CTcXSjnwcAMqy
         /OAk9npnpenDU9whhCeJdWn5BOJGGjqo/zL5lz+AsmWrLITNhG9VGiO3DHzZyb8j2X9b
         QGotpTE2h7+/dKG+DuYJnFItWYtl+q7Cw0IpNvCS5ewq5P0+u2kan5huNKVyJaxLIvxU
         Tuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIwBPELl88iaMbSYiV7ycp6Z2I2x7UqLvm1fpqtgIXY=;
        b=npNYyvVJejEwN54X9wZeucQyZFav+hzb9xHuuiBwx/DuS1KOOWdsYAiCCpHgzHRryS
         +9pZvE75vduBcURjVbNwJjWrcCcghJDOLuhhZVWyoo47zZIT1x2sL8RxmPnnxBmjbSpC
         xipKko3W7rZWPc7PsO3+lF2M88Bc8Egmc/XPjnTjQap6vcfAbPpmJhSyyLVttxNrmOzW
         QqwPSe1GXL7pTuWjClIZMX0KAj3bFLUStqAIbZPJoQ0XJuxu2s9w0xJgULSOwxBX/638
         1CNQaG4eLTMgPRPD7MLvDWBq2X7O9CeL5ONfy/1JEyJZiWxiEi0mqkLUkfmzO69JgPWd
         h13Q==
X-Gm-Message-State: APjAAAX4QAlUYCPxdxgbQoS/tYLu5OxhBijHu9yXimuSpqqinFMAwTna
        KokYelvgAo4G6u5I+pkXM1ArB8CdKoEOezaWJHlTDQ==
X-Google-Smtp-Source: APXvYqyVYtXXGpUdVB6ylwGhw1yNpK4mJ8Vn9U3jNTlfbgR4PTFniUnt/0j6bekeqzWI3mTgTbrRUGwR5AFnXJ0n2wQ=
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr3082276wmm.37.1570029091670;
 Wed, 02 Oct 2019 08:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-13-jinpuwang@gmail.com>
 <456f046d-391e-2344-f61b-ba84290ff7b1@acm.org>
In-Reply-To: <456f046d-391e-2344-f61b-ba84290ff7b1@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 2 Oct 2019 17:11:20 +0200
Message-ID: <CAMGffE=RkDw0rbL-qMnuv0jA-PkH-iaeWGAUyDxVvXanL59n+A@mail.gmail.com>
Subject: Re: [PATCH v4 12/25] ibtrs: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 2:00 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static void ibtrs_srv_dev_release(struct device *dev)
> > +{
> > +     /* Nobody plays with device references, so nop */
> > +}
>
> I doubt that the above comment is correct.
>
> Thanks,
>
> Bart.
will fix it,

Thank you, Bart!
