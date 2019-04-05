Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CDC282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BA521726
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq7EmK6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDEXgp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:36:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40829 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEXgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 19:36:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so8834230wmi.5
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myVV+UpxqfYhzO56wXbyZ7q49GuH4zJ91tiw74k9rAE=;
        b=gq7EmK6cbvULTUyIxj0gJcTUiAJ+HjV3AbixecBsZ5Zgd2GbpMWaiSgMdCv+/Qr1l7
         5o1Yy/XrPD1gnKeg6044ST4E+ft1FS8sdRf56pza9FatN9hROE/MQN1kkNtLl3UPXWJr
         wgATFmVOTMUPMGaoDBabcEgzYVgsvFyGkucsPpUUKdEvtfx02AqTU7nZFMPs4af+0au9
         oZ9SB/zHyOFkLzbYszk0ERvQvJy6lSo0TQhwjokoToefWYn9+DJwSmn7GF1lGgfnb2q+
         NKGqgnffNm3ZLKZzr8s5n4UVGKxSKIu3PzVVozxnZKf7PaGD4mOCu+7xqQurAtVR4Qys
         JcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myVV+UpxqfYhzO56wXbyZ7q49GuH4zJ91tiw74k9rAE=;
        b=brVbu4HLsLYmn375BuzXxk/ppaIqvRGz13H7OH7SKGxVDmRMtEFtfbrpg2w8jXWC5P
         PyX4aIwspjGELIcLLQHSThB2lPDh5Oqw8/ocbXUqrEZaWpkkXmvGCf7qebJFcfDTq7tI
         ai1dwf55ruZGwuyyuucxMgO1AiAxB50H/CKeoxjaLiR3wbnehLZKpXAXtcivZ5xZzyod
         AsD+KKf45NACN8LoLnX5/Oc2Xys1W8+PtR5PiW2iKW64Clsxi+khn64Xd9l5SB0xVFS9
         idyaiY5I4LO5kT2yX2iAC7SG2B7puWEiRGRwp4CZjU35M++BGMkm4TzNXFgepcaZHaac
         cwZA==
X-Gm-Message-State: APjAAAWFy72pwvp+HSR1ztEdqMJ0m6rJEOsn68u6WH8Jo7oVNV1INn3d
        m/fkq03eUicdZtfggV2m7tdYkWKaqRFomaeTxvo=
X-Google-Smtp-Source: APXvYqzseSxAkLUCVExlRMTmuDJ8nnwZhcn2Cr8fcMeGFFe0N7RTtV65ikKy8KKeQ4y7IoxZtkX1scDt/jq/pJ87dVU=
X-Received: by 2002:a1c:be13:: with SMTP id o19mr8997367wmf.19.1554507403615;
 Fri, 05 Apr 2019 16:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190405215920.27085-1-keith.busch@intel.com> <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain> <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
In-Reply-To: <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Fri, 5 Apr 2019 17:36:32 -0600
Message-ID: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> Looking at current peak testing, I've got around 1.2% in queue enter
> and exit. It's definitely not free, hence my question. Probably safe
> to assume that we'll double that cycle counter, per IO.

Okay, that's not negligible at all. I don't know of a faster reference
than the percpu_ref, but that much overhead would have to rule out
having a per hctx counter.
