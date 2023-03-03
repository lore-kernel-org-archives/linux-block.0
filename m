Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C2C64EC4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 11:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCCLEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 06:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCCLD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 06:03:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42A231CB
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 03:03:57 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so5738925pjg.4
        for <linux-block@vger.kernel.org>; Fri, 03 Mar 2023 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyqRiQrjRd/DgKhnwDjD3VNPSs/VOxygJCdNlbvjnIQ=;
        b=MTjWfUGO+7ykPOHEHtUdUjVgNfC2Wh8lenSwuk4fUAIoNx3/ktfeZK9Z2CZ/OWGVyT
         V4tsskVxDRyzjTqtFEhiwf715Q9PyRkLQWTpfIO7dvOCKMgr/kLOyY4g7pWb8fZd96+e
         275b4uk2BRWxqZwCMAqXCDSCPsgSdlH6OZHkZlEbwNRMYgdX1BkYhwIe5dQpFB8S4cE8
         AMcKjjY8NiFnHeQPFptLt81zppCMc0XCNpFva5wlX1ddc9/psw/arCRD49p6KZyCuyz9
         D9dUPUIBaO3YdflGuksqSX65sK/vTuHTcvQkYDWNB/hh7MK3haxe4un+uc/KNxBj49nq
         heow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyqRiQrjRd/DgKhnwDjD3VNPSs/VOxygJCdNlbvjnIQ=;
        b=ukzWoBpJ/fqPxf6ODXqcZv5fVuwIfCkhA70ClB6HDDTwpSegkluC0qp/zrZ8obwNF6
         aLkZUiQ1YAxa/KDygVoSl8/Srf52vZjt4Oa2d/lI34Uanp4RztqNC03VfrbqLq6LQ5t2
         KAwwjaNUWOpjBddFXiEsKkdxkyOyRlQnXRn9m76KdAFf9sbR2KbKqDV4hzwOxcINpHJX
         LTpjnfbhL1BF2uxsr1G8lNsXZ6rLSQlKg+SApJo2HY9KhUUNlI2Gzod2e7py4BZqC5Bq
         rdudQHMTe0Tm1EnXLXsuu8HtrNOCvvoQ2CexcgpJDFU3xeOlLtinAkL9raQrGnas5/W1
         8r4A==
X-Gm-Message-State: AO0yUKVMRVYnil9C7TFKFjnGr5f5h3gHpQcir9vWd400x65N5TuOhm7a
        C9DvLZkZtO6hycJ7H1DfyytkzPs+0O5Xa4BscGLzWA==
X-Google-Smtp-Source: AK7set8phWiie3Nf4hACV/MQGfEnXNww+J1KCgqC7NMtdqylWMY0nYuw9qGmwMYEN4ozV+WJlaB6y5J3YvDp90b3470=
X-Received: by 2002:a17:90b:1283:b0:234:925b:7d61 with SMTP id
 fw3-20020a17090b128300b00234925b7d61mr433000pjb.9.1677841437114; Fri, 03 Mar
 2023 03:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <58bb34de-e333-00bd-ae3f-4ddf0e56aa5d@gmail.com> <DM6PR04MB657530D5D51EF32A442C1409FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657530D5D51EF32A442C1409FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Mar 2023 12:03:20 +0100
Message-ID: <CAPDyKFo4_qgHycq+MSqMDKMJdqwyf8w=dLm3f_sFQWz30S9EJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Bean Huo <huobean@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 3 Mar 2023 at 10:39, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On 02.03.23 3:43 PM, Ulf Hansson wrote:
> > > REQ_FUA is in general supported for eMMC cards, which translates into
> > > so called "reliable writes". To support these write operations, the
> > > CMD23 (MMC_CAP_CMD23), needs to be supported by the mmc host too,
> > > which is common but not always the case.
> > >
> > > For some eMMC devices, it has been reported that reliable writes are
> > > quite costly, leading to performance degradations.
> > >
> > > In a way to improve the situation, let's avoid announcing REQ_FUA
> > > support if the eMMC supports an internal cache, as that allows us to
> > > rely solely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a
> > lot cheaper.
> > > Note that, those mmc hosts that lacks CMD23 support are already using
> > > this type of configuration, whatever that could mean.
> > >
> > > Reported-by: Wenchao Chen<wenchao.chen666@gmail.com>
> > > Signed-off-by: Ulf Hansson<ulf.hansson@linaro.org>
> > Acked-by: Bean Huo <beanhuo@micron.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>

Thanks!

>
> Another option might be, allowing to report "broken_fua",
> should the platform owner chooses to, much like scsi does per sdev.

Are you suggesting a static or dynamic configuration option?

For mmc, we also have the card quirks that may be used to configure
the support for FUA, based upon what would work best for the card. Is
that what you were thinking of?

>
> Thanks,
> Avri

Kind regards
Uffe
