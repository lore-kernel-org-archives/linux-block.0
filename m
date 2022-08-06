Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB8C19F2D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiHFSRN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiHFSRN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 14:17:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B3E09E
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 11:17:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so6931593edd.4
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=beih6qymZGmHssTmn8x7/qNw7kafqzxWG12k8T6XYyQ=;
        b=fpEv+s5lGFXhjqT8I0VRiiV2Uc1nGDuNPX3d112J3OgcSTUfFJhJFY54ByXhoVJAOp
         lxmpdq+nfrlkqUhqwT7OOkZJQauVrI8uAvG3vif8xq38PHslKsXk6Xso7ggJzquReLwi
         sA/mrnw/K2vxd9nvsUfHbIrIhxb4IdpAP0Yhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=beih6qymZGmHssTmn8x7/qNw7kafqzxWG12k8T6XYyQ=;
        b=BRHOSeSnm0l1N2by7uYozdt/TrL4VcsHopvIi09klrQncQlRTAd9TcE5+vsivatr+s
         6JW0v+Rv7Q1dXzb7rvMtqfphYE6qjfjsUsILoc3M1FaOTLd8gMW3YtKyYEmDXNgTSnDu
         19Jqeef05Bc5YWIeeqP1Bcy5Pg51EOACoDOUk04/ejfdp0Uuhv7cU3taEs9OrpnLMtqI
         +Ern3T/vXP8ZZcvFeyjyQADA6StlquwApfs+ws+5YUF677eLtMFw2Ud+dbE/yJUFMOa6
         peBl4U5QTTHplmNvvoVPDh36fGPfEjBYbI2DU5DM9JxgL69VPdPn2L8bhGdUcSYyoCRp
         PVqg==
X-Gm-Message-State: ACgBeo0r7Xm97c7HeLu0Do/JlAVnr2zHlg41kCMVVh+j0tY5UDpU5W97
        NWdaTWYfuEbLxphxL22u7jrcJGoHnu7mFlY1
X-Google-Smtp-Source: AA6agR5LitJt9MquOWWT7StjHGwY1t83hhjDBpyrey+LTosrIjPLZG2o8qqoAvU1ESk+DmtjTA7A7w==
X-Received: by 2002:a05:6402:4507:b0:43b:b8df:571d with SMTP id ez7-20020a056402450700b0043bb8df571dmr11583076edb.230.1659809830284;
        Sat, 06 Aug 2022 11:17:10 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id bq7-20020a170906d0c700b0072f1d8e7301sm2918811ejb.66.2022.08.06.11.17.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 11:17:09 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h13so6520746wrf.6
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:17:08 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:222:c7ad:2d9a with SMTP id
 e13-20020a056000178d00b00222c7ad2d9amr122329wrg.274.1659809828435; Sat, 06
 Aug 2022 11:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <YugiaQ1TO+vT1FQ5@redhat.com> <Yu1rOopN++GWylUi@redhat.com> <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
In-Reply-To: <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 11:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoweVdRqvaVESkJGbj4Xmsw4NMQQRPpy5Om2X4QRwQ8A@mail.gmail.com>
Message-ID: <CAHk-=wjoweVdRqvaVESkJGbj4Xmsw4NMQQRPpy5Om2X4QRwQ8A@mail.gmail.com>
Subject: Re: [git pull] Additional device mapper changes for 6.0
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 6, 2022 at 11:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Feature bitmasks work. Version numbers don't. Version numbers
> fundamentally break when something is backported or any other
> non-linearity happens.

Side note: even feature bitmaps should be discouraged as an interface,
unless there's some fundamental need for actually negotiating some
kind of initial state.

For 99% of all kernel cases, the better option is to simply just rely
on unsupported features erroring out (ie making sure unsupported
argument flags are checked and cause errors, rather than silently
ignored).

So while version numbers are actively broken as an interface
description, often feature bitmask are just pointless and wrong too.

And yes, lots of things get this wrong, and have "I implement feature
Xyz", and then you have pain and gnashing of teeth when versions
change and you have to support them all. It's just a horrible design
pattern.

                  Linus
