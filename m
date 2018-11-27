Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FB6C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A3208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 02:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u89ca9Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1A3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeK0Nvy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:51:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50697 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeK0Nvy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 08:51:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id 125so20315394wmh.0;
        Mon, 26 Nov 2018 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCmD6Tz7iCxWyreyZhP9ACxtmOf5xsbNROFEMLo+/ao=;
        b=u89ca9MsOdRjjCC04lcQ2BpRhU97tkZh1o7lMQFpBUj1jLk05XN/aLHRIdvvbnNx/L
         NqXKRiXYoEhc6c73D2/QJJwgwbzygSWeuQ+hPxCdUnOGHmD1wJxQzEOdUSbJZd06o0U6
         1Z5maSC0b78DAOdtfuo9psamMhHxHK1J+dH93bQ042YMub8wggVqk/w2ykKev7WuF3u7
         VgddTkGhOfUDkT6S5hh09ISqnUwGqFPnFtdYUVkRS1MBPeBlimAlrDVV/itk7j2gRl/Y
         FO4m65Vtgg2dGUI1TJHecXEdXGgdlihKKHTIHGArbuRC+LLuo/xKO5LWmESPLAjNI0FU
         6jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCmD6Tz7iCxWyreyZhP9ACxtmOf5xsbNROFEMLo+/ao=;
        b=VnxffwyDS3Peiv3US7aIJrcnRUbeJ24Z3a1T4tzoJjR2GomJZri/2uHEJnR7zf7doy
         qzri+Gc2axIJ8wOzo5Om2Ih6DlZbBXvErESyQev/XoFqkjZySlqwvV3QeZ3qzATqutkO
         nbvHOYrjRXZla5+ySWNMBOE+04+1N7QnXl2qfCYXmAZe1iexQh+w/UJD/gyQeahKuags
         cuRuwLhviHPTCEXMkKleQaZTO4CUVk4GLrMaAt0ha1O3SWHvO2PLRITli6E0RxJPteAF
         y2P+amWKjXA4QwrFyjbD7NKP1sr4q6uR4p/NjhbAgPNbCggKRj09hGWIbzkuxog74paQ
         zPAA==
X-Gm-Message-State: AA+aEWYj7XqJVEs5HmGUxtKQo5fbijZ61OGp+8+p7w+Ngh+BHGBFE/PY
        ECfBesGt0knKz9kt9A4FCovUspg7gedl6cmARhk=
X-Google-Smtp-Source: AFSGD/W9TnnxT6RIwMKxAhpncHJ6xVO6zb/Bh5A6DLzfiUpUAjnOlA3TT0bgynUdh/250lad0q4sjFRSu1IVzKnR9Hc=
X-Received: by 2002:a1c:9d10:: with SMTP id g16mr24971739wme.43.1543287332780;
 Mon, 26 Nov 2018 18:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
 <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
In-Reply-To: <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 27 Nov 2018 10:55:20 +0800
Message-ID: <CACVXFVN63UDefvBnYTQ==tWwYqGJbCS_HK==-1jVa5sVc=-Upw@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     evgreen@chromium.org
Cc:     Jens Axboe <axboe@kernel.dk>, gwendal@chromium.org,
        asavery@chromium.org, linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 2:55 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Oct 30, 2018 at 4:06 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > If the backing device for a loop device is a block device,

This shouldn't be a very common use case wrt. loop.

> > then mirror the discard properties of the underlying block
> > device into the loop device. While in there, differentiate
> > between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> > different for block devices, but which the loop device had
> > just been lumping together.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Any thoughts on this patch? This fixes issues for us when using a loop
> device backed by a block device, where we see many logs like:
>
> [  372.767286] print_req_error: I/O error, dev loop5, sector 88125696

Seems not see any explanation about this IO error and the fix in your patch.
Could you describe it a bit more?


thanks,
Ming Lei
