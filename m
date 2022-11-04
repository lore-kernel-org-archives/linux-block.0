Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CFCC4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 17:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiKDRA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiKDRA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 13:00:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDB31EFC
        for <linux-block@vger.kernel.org>; Fri,  4 Nov 2022 10:00:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w4so3427828qts.0
        for <linux-block@vger.kernel.org>; Fri, 04 Nov 2022 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jNIi3NLp/0QE0eLEgGhnlZnXslRxZtVSsauwMnJ52A=;
        b=TyCMiI4ARMPxd18RVlEv+qm2LWR7zC104Hlivn40qb5lZJslIeDFuCNMNvjneFE/Nj
         LFwCX5vAwmEX/R8qjGO9x9K9/hgdwoRd2q59WUqMzWoiDvISQjer+tTT1jJ7UfSLA8Vn
         fR3VeAjk206NeR5DC2lSXJH82ZME8JVM9jplc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jNIi3NLp/0QE0eLEgGhnlZnXslRxZtVSsauwMnJ52A=;
        b=G4QBkHMgRONyHZMtw/owEnLuVFqKienVe+TUfcb0cJmLer6bRV8wVNk7xSZg9wxlZs
         9yd2zEwIGjqKJKZmy1/PZn5i2T3Rjj/sGCj3lPMd0l+4GxaJrGpVbepH7NLyWbPK9APG
         KwmnTnxw26utyB2m92wKpknx1u5fD3x2irboJtBv8FITSRmrQTI6kK86eLnB6iiK5m0P
         Wt0ATzQx8Dr6K180JpTTyk2iuyBoSIxMxlOszRHzleLwI1hpTgiTaMItrtOAGRag6wNy
         qWYcDSvKcXfOrrmBXgcDYhpVzPYWpcaSFMUQdmsT5ID/A/9KtDLcS0zq0zqsDpkwa3qM
         3h6A==
X-Gm-Message-State: ACrzQf0CZ0jO+cL/+P7v+VpROnFTkpI0oppU9aDnF2rHG7FH25PvKiRx
        mTbnbf+jNpt1qR32nWDaGqpKK3M7Rvd55Q==
X-Google-Smtp-Source: AMsMyM5HQHbziVrfRZaxruc612d8W3PRhcV2POVgwziqkHLz4PMVIIQVSHtF2GAR3lUxgEZ7caokOA==
X-Received: by 2002:a05:622a:191:b0:39c:e0dd:1ce9 with SMTP id s17-20020a05622a019100b0039ce0dd1ce9mr317836qtw.153.1667581224625;
        Fri, 04 Nov 2022 10:00:24 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id v25-20020ac87499000000b003a530a32f67sm2680088qtq.65.2022.11.04.10.00.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:00:20 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-333a4a5d495so48907747b3.10
        for <linux-block@vger.kernel.org>; Fri, 04 Nov 2022 10:00:20 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr27409344ywf.441.1667581219811; Fri, 04
 Nov 2022 10:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org>
In-Reply-To: <20221104054053.431922658@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 10:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 00/33] timers: Use timer_shutdown*() before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 3, 2022 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Ideally, I would have the first patch go into this rc cycle, which is mostly
> non functional as it will allow the other patches to come in via the respective
> subsystems in the next merge window.

Ack.

I also wonder if we could do the completely trivially correct
conversions immediately.

I'm talking about the scripted ones where it's currently a
"del_timer_sync()", and the very next action is freeing whatever data
structure the timer is in (possibly with something like free_irq() in
between - my point is that there's an unconditional free that is very
clear and unambiguous), so that there is absolutely no question about
whether they should use "timer_shutdown_sync()" or not.

IOW, things like patches 03, 17 and 31, and at least parts others in
this series.

This series clearly has several much more complex cases that need
actual real code review, and I think it would help to have the
completely unambiguous cases out of the way, just to get rid of noise.

So I'd take that first patch, and a scripted set of "this cannot
change any semantics" patches early.

                Linus
