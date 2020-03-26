Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A25DC43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9E220737
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIO41+p1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZPwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:52:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46647 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgCZPwC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 11:52:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id q5so5251235lfb.13
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2020 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tp9mM3jlwtId/vdqhTHtN2qnBeVBExLHzO6AXaG0BKU=;
        b=fIO41+p1lsoj4sTyeTV3Z5vIfVmAWEEXvMSsrj4r/H/bTELLTO7Hqr2hYtQpIJmMU2
         ADaUGqnKSD26u15LhwVmQt9N/NRMkM8Ek8sxuCarwy8yW5eRjDOeqbe0zTrdtVkOSOBE
         hqO5Pyy0ddR6yvTUbY5NbroZgzWDXZNPWfNz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tp9mM3jlwtId/vdqhTHtN2qnBeVBExLHzO6AXaG0BKU=;
        b=RVx3Ayp6N8KzOS5YrfrtGXy1e3dX0VW6h0JwwAzmyrWld0yiy5MSMDiHvWgEG5VW23
         73j83cFE4jCINQxGbKIZjcHfog/5YgNRL/EOUa1RxVl0L/NRX8DezY5p72PPPzUhGF4w
         ZzlkhDOUBpnHMFYFH3KPnpsOhk6pQ74d2LdBnJQutuSbeI6GNl4er1Du7NahxBEsdP7B
         GzYQHZF+19RWwxb/iyOtJVgof1c6ggDM2i0v3ATLXPxSufnn80uAGG1umUKV8my9OSsg
         w0Ic9jHTqXKhWDVX2x7CdhInGgx4o9KHupWQt6nmOmKPJqW/hO4LwhsKLCJ6KmXDiYkg
         2idw==
X-Gm-Message-State: ANhLgQ2ATzUXNScyxvOQxg1q6ryxqq70oJn/rkUuXT368KXsIZirn7+U
        R6X0fyA4E1YX7iuI77+FodarmrkwVRw=
X-Google-Smtp-Source: ADFU+vu+IMp8JgCG6gRvrR6Wso+fQUmUo1/gp3G8vllZH5VBUBb9cU7MO3zU+QmxEsJN+zNT+bTfhg==
X-Received: by 2002:a19:c388:: with SMTP id t130mr6395620lff.175.1585237919617;
        Thu, 26 Mar 2020 08:51:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r9sm1699443ljd.10.2020.03.26.08.51.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 08:51:58 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p10so6700597ljn.1
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2020 08:51:58 -0700 (PDT)
X-Received: by 2002:a2e:9497:: with SMTP id c23mr5569835ljh.286.1585237917916;
 Thu, 26 Mar 2020 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200317151111.25749-2-andrzej.p@collabora.com>
 <20200317165106.29282-1-andrzej.p@collabora.com> <20200326145253.GA18623@infradead.org>
In-Reply-To: <20200326145253.GA18623@infradead.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 26 Mar 2020 08:51:21 -0700
X-Gmail-Original-Message-ID: <CAE=gft5w_8XwSGRNS6DZ0kppOihoUtYxrMfaTrM5eRifjBYYNQ@mail.gmail.com>
Message-ID: <CAE=gft5w_8XwSGRNS6DZ0kppOihoUtYxrMfaTrM5eRifjBYYNQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] loop: Report EOPNOTSUPP properly
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 26, 2020 at 7:53 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 17, 2020 at 05:51:06PM +0100, Andrzej Pietrasiewicz wrote:
> > From: Evan Green <evgreen@chromium.org>
> >
> > Properly plumb out EOPNOTSUPP from loop driver operations, which may
> > get returned when for instance a discard operation is attempted but not
> > supported by the underlying block device. Before this change, everything
> > was reported in the log as an I/O error, which is scary and not
> > helpful in debugging.
>
> This really should be using errno_to_blk_status.

I had that here in v7:
https://lore.kernel.org/lkml/20191114235008.185111-1-evgreen@chromium.org/
