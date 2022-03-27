Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5EEC433F5
	for <linux-block@archiver.kernel.org>; Sun, 27 Mar 2022 17:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiC0R4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiC0R4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 13:56:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB28BF45
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 10:54:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z12so7386660lfu.10
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RRo28ZJgxNtm0LxGk4jcyTDu6M+7JuDAPmhILttShY=;
        b=CQHKZ1HJv46CMKFC/9NHyeb8GX2/NuT7YFjHLDpMxUzWDIZMf+tV2ISipfQrhQK4jK
         IHPXlZC8p8e0aSUutE9AXbCI0I9GILAy9avHD3w0cQZ907uc67pmTfI8ojN5DFOXvUXA
         +DbZUf+cv84PYxC9stg+YgliFWxMQe1Y/V0QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RRo28ZJgxNtm0LxGk4jcyTDu6M+7JuDAPmhILttShY=;
        b=wU/Ngv4riKkSBf0ufJ5W/ot1ep9KbZ7KAm9zsU4ZYzjmL16Jb2qU79CnFKEFQtRLRo
         +CY9Dc7ihfhyUh5yBrgSEXDOBJm2IivSqamjhLg3VU3PPYVw7XdD9tyUakFejmKcKwAj
         CsA1qwa7ecTqSEgkxs4DDo3S8Wn35ncj6cdREPTr6f4jVoEPYEoZZdn3B++AMySZBf9p
         U1W15+LCDu2Tl9FaUL/anbbl/bMab4xsYXVrE0ClHuAETw1F9bVlkkzWq4Mt+BxNa8GI
         kA8nVbUVPpY+d6VuI6AQ6CJSIV91EUXhAJPIEbE5nZkIFEIKrQiYR/6rb1DjXd+6NMKB
         Y7Dw==
X-Gm-Message-State: AOAM5308ErVgNcLMOxQtS6O5aF+j0AC9YDJK5rqE1rljmR3oQL5xEqLP
        q+RYejft2i6Ie2lCNebqDOrgQ1e4N+YA5CDpaq4=
X-Google-Smtp-Source: ABdhPJxCTyT4lAaEW7HUExfHX3Pl8r5+PPvSIgvg65/WFbd1xwF4JQmVCf/adbEuhbuVN92b3LPaDQ==
X-Received: by 2002:a05:6512:ac7:b0:44a:9c24:a5b7 with SMTP id n7-20020a0565120ac700b0044a9c24a5b7mr169158lfu.199.1648403671840;
        Sun, 27 Mar 2022 10:54:31 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l17-20020a2ea311000000b00249667be913sm1447901lje.102.2022.03.27.10.54.29
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 10:54:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r22so16407988ljd.4
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 10:54:29 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr2136622ljg.291.1648403669304; Sun, 27
 Mar 2022 10:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220327173316.315-1-kbusch@kernel.org> <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
In-Reply-To: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 10:54:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrNHfwp4BM_xXNfoix4YSgkSZJ-Tq_R9NiFLqL1v0dHw@mail.gmail.com>
Message-ID: <CAHk-=wjrNHfwp4BM_xXNfoix4YSgkSZJ-Tq_R9NiFLqL1v0dHw@mail.gmail.com>
Subject: Re: [PATCH] block: move lower_48_bits() to block
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 27, 2022 at 10:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because admittedly the 21st century has been all that great so far,

 *hasn't

Duh.

             Linus
