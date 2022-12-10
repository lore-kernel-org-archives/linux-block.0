Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA14C4332F
	for <linux-block@archiver.kernel.org>; Sat, 10 Dec 2022 18:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiLJSzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Dec 2022 13:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLJSzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Dec 2022 13:55:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD8140FC
        for <linux-block@vger.kernel.org>; Sat, 10 Dec 2022 10:55:06 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id fu10so6100438qtb.0
        for <linux-block@vger.kernel.org>; Sat, 10 Dec 2022 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjD4ucfx+sg79aU2mhUtRUhlS74JIWv5Z/WsZ5sivF0=;
        b=BzvvoS4YZaiHtVtTnrMPkORr9QN1kyuo5edsRj1EnzCjtxaavYwgd1MdZhbSrsmMz/
         pQLt+8DKvwX5PRNY3AkuVsEXWG3TG9LNQME3xhKH5umXkHq8wRVg5p7P0UkLsc4gLlOz
         C1Wz8XlCiVSbwQEORsXQiY6twwLuti4patvKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjD4ucfx+sg79aU2mhUtRUhlS74JIWv5Z/WsZ5sivF0=;
        b=zL9+NZbXzRX7jOsq6HgHEe+Deap0mSv/ebw9Hs4cW7wGDnjMceqeyJWxk+UAnUGXXA
         kIs7xWCk4E+uF4C82OAzoNhF+zxUryuvByEN/BBHchmNBuxkdltwh7Nt88lIMflVsJfA
         QcE0xJXSnqrGLCP8+EPEAxtLGNX8zd0gcg5JTYAvewl/kqg8ASqQadbEsc1uN+CAbJe1
         JWhPXqJAcspN4M6DhFXdHKuk6A0u3oE/55k+F2LtPGvVCVWIFug+K2/8+5qaDrmJzJSb
         9+1O5poiSJ82J7VPXQX1Mvgk8wgEGU8Xzcc8fu79ZUG2hTw+9g2M0B0gM2EIxziXxK70
         Xlyg==
X-Gm-Message-State: ANoB5pnzKjiHsoid09QtZF606o71xH816eOczLsfpL2+vOopyQASiysC
        xeP74SIMw7HXdZoabka1jvlf+wpeamJN4oTh
X-Google-Smtp-Source: AA0mqf78T0mpyY87ECPzUhy1xbGuHkavuJmOpq/H+GUXGjAIFRdtPlWh4e2gZMl1dLJaNXYG4fQ6HA==
X-Received: by 2002:a05:622a:249:b0:39c:da21:f1d2 with SMTP id c9-20020a05622a024900b0039cda21f1d2mr19413243qtx.51.1670698505354;
        Sat, 10 Dec 2022 10:55:05 -0800 (PST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8068f000000b0039c7b9522ecsm3136326qth.35.2022.12.10.10.55.04
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:55:04 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id a17so5424219qvt.9
        for <linux-block@vger.kernel.org>; Sat, 10 Dec 2022 10:55:04 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr68313518qvj.130.1670698504390; Sat, 10
 Dec 2022 10:55:04 -0800 (PST)
MIME-Version: 1.0
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 10:54:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiw4bYT=rhA=UJD4u41Oq_uoWt1dAXpzqwQYdOtJQqYZw@mail.gmail.com>
Message-ID: <CAHk-=wiw4bYT=rhA=UJD4u41Oq_uoWt1dAXpzqwQYdOtJQqYZw@mail.gmail.com>
Subject: Re: [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak on
 add_disk() failures
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, darklight2357@icloud.com,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 10, 2022 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
>
> I'm posting two patches for the iolatency memory leak issue after add_disk()
> failure. This one is the immediate fix and should be really safe. However,
> any change has risks and given that the bug being address is not critical at
> all, I still think it'd make sense to route it through 6.2-rc1 rather than
> applying directly to master for 6.1 release. So, it's tagged for the 6.2
> merge window.

Ack. I'm archiving these patches, and expect I'll be getting them the
usual ways (ie pull request).

If people expect something else (like me applying them during the
merge window as patches), holler.

            Linus
