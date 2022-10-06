Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B21C433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 12:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJFMhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJFMhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 08:37:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C785A8E
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 05:37:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id u28so893316qku.2
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=vo1QAtKipx9eeiPoGvhZwuSOjBoSpY/YuVoAnsjypP4=;
        b=EY2O/cMHA42iCRWSbnjQ8cWURmH6PgapUPnHhUdnDrFiOkHPNJ1tU844qYunD33VqJ
         KBAOTA+eAAWEcRR5ubGkgmfMUa0wvsfIhEmeI4DbW0TzxWHTm+R1w5v4NLCj5AGlmpIA
         vKUMJGW4PiayCQl04g6X4N9XAtEVaSc0rCAL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vo1QAtKipx9eeiPoGvhZwuSOjBoSpY/YuVoAnsjypP4=;
        b=NQafxFF1iSESHYSej0ruTRCeB6Q0s9824pZOSEkSkf+vM727vT6RWAcve8BwCtewf6
         ZpwlFLLKpM4nbxu3ZFXMNiXhrsIw0FyFCoO1eTm8RwuZkRvMZeEnvhP15S7HR6gddyTY
         juExjzg8KVr8a/+4V8kxN/NivTniARiW9jrzvneBysjE1I2bOabHa9BqwtTveiKY+WSl
         3cAJGrOonCrHJo7wJW9JeXuobzFWmi83BIqMVmYyQTB5P6jPHn5UfOi/oSRvSVn+GLjl
         haVsD2ZSL/lsMWyFanVqFn025P61d7PLam2BweKCu8NkAfEOIio6csTTr7MsRxJZsZ2g
         Hnmw==
X-Gm-Message-State: ACrzQf2NaKwjtJByxPrr+oOnO/KUm7muytX59w6CbJx8doyctxeBg5Ic
        1nuofPBPNc6bfm2oqrGiszdASIsxY0zdt/cxmDB4zOPofOQ=
X-Google-Smtp-Source: AMsMyM5Jul0nHsUjVkEIN5JoE+lw8z295f5LXZKXLQvfONDh424ZXDNMnK0Tx5NhIdvIWXduWkzn20Lh4KlvqyiAEzQ=
X-Received: by 2002:a05:620a:1aa2:b0:6e1:15a7:72eb with SMTP id
 bl34-20020a05620a1aa200b006e115a772ebmr3064763qkb.632.1665059839607; Thu, 06
 Oct 2022 05:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
 <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
In-Reply-To: <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Thu, 6 Oct 2022 14:36:53 +0200
Message-ID: <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
Subject: Re: again? - Write I/O queue hangup at random on recent Linus' kernels
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I apply the
echo 0 > /sys/block/vdc/queue/wbt_lat_usec
at the production servers. I expect it will disable wbt. Could you
please confirm that my expectation is correct?

The issue is happening once per ~14-30d after some random higher IOps
(~25-100k) peak so we need to wait....

Best,



st 5. 10. 2022 v 23:03 odes=C3=ADlatel Bart Van Assche <bvanassche@acm.org>=
 napsal:

>
> On 10/5/22 12:43, Jaroslav Pulchart wrote:
> > I'm investigating a queue hangup issue of our databases running on the
> > 5.19.y kernel.
> >
> > I found "Write I/O queue hangup at random on recent Linus' kernels"
> > thread (https://www.spinics.net/lists/linux-bcache/msg10781.html)
> > already fixed some time.
> That message mentions WBT (write back throttling). Is WBT enabled in
> your kernel? If so, does disabling it help?
>
> Thanks,
>
> Bart.



--
Jaroslav Pulchart
Sr. Principal SW Engineer
GoodData
