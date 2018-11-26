Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33EFC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB98720862
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dwkEBsIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB98720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbeK0Ftm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:49:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33103 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeK0Ftm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 00:49:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so14410281lfc.0
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZW1RSy+Pg4CzGdxv/poKG/ywLSVWL2EfUiFOOSa+Go=;
        b=dwkEBsIGx2n6MKQEh99DSK+jIxMltvzhPkBH5pNwBgwh4HOoF8YoulvBNmJQvQAe9C
         dYYGELI/OqYWwfvi4Xsqm3k3WbNVxSCuv+M4ePIxYvGmDq/7efS9VvXOapv5j3pHX5IG
         Tmykb7sayHHbi9Xw2HJXBF9y29WtlHR+xB+7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZW1RSy+Pg4CzGdxv/poKG/ywLSVWL2EfUiFOOSa+Go=;
        b=S1jWGIkwHtOSjR/W7uVp/4b3b0cOLR7J4/6F5DxHFdDEMpS2TVLdVqDbzOldBIjhqd
         HJUtU/le8W9GCDuMpbKjVgnH4c/k/tomWWLzefRNA8GWuaDp57KepRGClxhlG30em2CM
         6FHDAPg0o0kaz73MUG0dimWtHIx/nJyssR5Yk+KBXco9dEnkKmVqfNCXJnkTWUxn1sKi
         0dPnNT2MW8JJUJYdsPcGsw8s+mqaRaf1SPiqy1m3e+DlyztDbPz+JMf8OsTaGr63uKIZ
         hC0FGCLhZ4SwiKf0iNedWkm11CBhJDh3qrtVcLIU6OrgZL7ZOMJIYJ5FaSJdkRKOvkUK
         MW3A==
X-Gm-Message-State: AGRZ1gIms9JQ3Rv5jTfUDGLHd8rZ+NsqMtOkMP7viQggha8kc0u8Dgjx
        hgBjcDc45lBDjVTGUXsXAI44I6U1x1U=
X-Google-Smtp-Source: AJdET5fQY3sH2dRw+DdFqxaxDC06G7N+/XeV4MpLpeQnb6rloxlnPsXqRdY7RvVVN+7BYnpXZ0qiLg==
X-Received: by 2002:a19:9c92:: with SMTP id f140mr16015379lfe.41.1543258479745;
        Mon, 26 Nov 2018 10:54:39 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l63sm178306lfl.76.2018.11.26.10.54.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:54:38 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a16so14396506lfg.3
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 10:54:38 -0800 (PST)
X-Received: by 2002:a19:1bca:: with SMTP id b193mr16081053lfb.153.1543258478240;
 Mon, 26 Nov 2018 10:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
In-Reply-To: <20181030230624.61834-3-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 26 Nov 2018 10:53:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
Message-ID: <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     axboe@kernel.dk
Cc:     Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 30, 2018 at 4:06 PM Evan Green <evgreen@chromium.org> wrote:
>
> If the backing device for a loop device is a block device,
> then mirror the discard properties of the underlying block
> device into the loop device. While in there, differentiate
> between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> different for block devices, but which the loop device had
> just been lumping together.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Any thoughts on this patch? This fixes issues for us when using a loop
device backed by a block device, where we see many logs like:

[  372.767286] print_req_error: I/O error, dev loop5, sector 88125696

-Evan
