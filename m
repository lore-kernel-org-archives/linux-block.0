Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26842C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94C2217F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 05:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOH0f7Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCNFHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:07:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39401 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCNFHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 01:07:45 -0400
Received: by mail-io1-f66.google.com with SMTP id x3so3864228ior.6
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=qIfz2MYxtV3lIq0a4Yn0Ym2PlsacFa9dXHJGs5Q3BH0=;
        b=fOH0f7Am2JlStMBziup+mWPqCoZqF/8tqJLlebZGk5/xuMzgav2XTTrgtSyL+Ke5Ye
         eLjAse0D8KmgybmYPrCvn/rwkmuYstVAyiG6sWXcFQurKRdYnbqzjYs/D/cCdPZ8LQJ1
         RK6ADe1ZbOn/kwWGLrXHQ0zOsDICSywb/An9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=qIfz2MYxtV3lIq0a4Yn0Ym2PlsacFa9dXHJGs5Q3BH0=;
        b=EeRZO/nrNH7D7ddJe3BpIbD0ky4G6a6e3nuzjQSVFjUoHYw+1sFfM5PSFuj/icSPj0
         U6geawagoVUJe2hX9/Tc7Hf+zu0rcEWJ4TMNknURNOi1aSXOeN9rX8o5LksBFOlHe3ek
         LYVQpM2HSbqqaVUXnG5zgeN41XcIJ2ZeC2pGsDHdCr69UdS2y61MM35MgSoEJBijhvHv
         3F6gvtA4WlSWeI/UxDchcpdtQCOG9QPNONs3ILj4yh148Vl3wwbDdbKpW8PCaKUERWlj
         1lvN8galMl3ncibLONPd9ND7ql8xNy/0QEIWZatkJ/vS6wx3Sd3sNI0lz+xdNDlruvvy
         pl7A==
X-Gm-Message-State: APjAAAUmYQtUKfaDOwmOTL+BA3fskm46oi91Zy4Pvms83ImgPkGBAF7S
        wVKeVEtJhaMta1uGkBH+12DGdcFcjDwQeeUCYdWtvA==
X-Google-Smtp-Source: APXvYqw7vBN2co7SWgIQmy5sV69ceZMt84tL3wCUoaBo1vYn5R3wz9eDVC15I7wG1GGhqHNPsLH7ePV5gPxAoG1IR9M=
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr8154480iot.192.1552540064355;
 Wed, 13 Mar 2019 22:07:44 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Mar 2019 22:07:43 -0700
From:   Gwendal Grignou <gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
References: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
MIME-Version: 1.0
Date:   Wed, 13 Mar 2019 22:07:43 -0700
Message-ID: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
Subject: Re: [PATCH] loop: drop caches if offset or block_size are changed
To:     axboe@kernel.dk
Cc:     jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jaegeuk,

We have observed an issue in production with this patch.
(ihttps://bugs.chromium.org/p/chromium/issues/detail?id=938958#c38)
If we mount -o loop,offset=... $file, mount will issue 2 ioctl back to back:
- LOOP_SET_FD
- LOOP_SET_STATUS64 with offset change.

Looking at kill_bdev, it calls truncate_inode_pages(). From its
comment, mapping->nrpages can still be non-zero:
"""
 * Note: When this function returns, there can be a page in the process of
 * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
 * mapping->nrpages can be non-zero when this function returns even after
 * truncation of the whole mapping.
"""
It is therefore possible to have truncated all the pages, but nr_page
still be !0.
We would fail the mount with -EAGAIN while it was perfectly valid.

Is the test for nrpages really necessary in the second part of the patch?

Gwendal.
