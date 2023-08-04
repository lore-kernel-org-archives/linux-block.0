Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0A3C001DB
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjHDKM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjHDKMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 06:12:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAF64C06
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 03:12:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcfe28909so259796266b.3
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691143923; x=1691748723;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z/BBpUHOKZw/yM1RuCQetqt09D0HDNroD0eqExzLP8=;
        b=qAglTcQHAi7J5xkbECHo54idHG5ZAssxJuX7Bl8jhY5e6BcEvoSnwYAtj906AH7vaw
         vrWT4UXqR0II5BN3LA6AiibMSxFA+FE6yqGJx+8FJGjhZX9A9YbPHaTiJWNg1Yq1rEcY
         pv0hFIFi8pQXYNvwxG5tY34DjPZiGZAdQlqAE/V1+iu/UAhwRW/HeeSgFvHhEchU34nb
         OB1jkg2RhaqRiiG6gf/XgsfdCdbNjD2e59ueeMEWLD5XYki239eHKX2LzRoruGWgqOZK
         ueExBqMb3mAfVj10y2bfP4Bq8+uXoWt6ZIl+242+Pq/vCnOLHT0NAp1jlQ/eegnRwlw2
         Y+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143923; x=1691748723;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z/BBpUHOKZw/yM1RuCQetqt09D0HDNroD0eqExzLP8=;
        b=jwT2MOdl9j59pMiJLwP8gvKwXUjOqZuRmJGU7Dw8vawcDV2y+pPK2hWYnciGr3ViSZ
         szrWojaA1KrHRGhKwKOLJitwYF+u+yFI/H/vWqBeVKPG+RncMDNoWSNzghWULAdz0uzp
         VTbAgrXrT0kbY3OYLn3/IQGqKxl26BLossh4YiI1zrr847raaVcdOCfCd74tHddcdcxp
         MwYaHXzZRYkRtLXAOOjZTVIOo6p+bJaFiDOfysLjWaxi7NVyOqviXchlMCvdUkLUx2Gm
         2rFh9xoL9MqKBt2xtv5SSxTIuqhR9JpiKOs7rk/wNVSseRsHbpORAqBcdPLidwhsPrjM
         Cdrw==
X-Gm-Message-State: AOJu0YxCuNFUF+U4yceXdbO+pqQiD/6W48cOGJPg/b5IOUwxrFFPlMKZ
        94T4s9oxAd0hwdcEilU4h8+39w==
X-Google-Smtp-Source: AGHT+IGgKoqlVBCCrx+yDVP8YPkTx4bOULHiCzASIQ6ASvusb2sFAvk0zdDN7Fy3ljAWpk5UEIazDw==
X-Received: by 2002:a17:906:28c:b0:99b:bca6:cf90 with SMTP id 12-20020a170906028c00b0099bbca6cf90mr1137092ejf.9.1691143922719;
        Fri, 04 Aug 2023 03:12:02 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id gt7-20020a170906f20700b00988b86d6c7csm1082249ejb.132.2023.08.04.03.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:12:02 -0700 (PDT)
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-4-nmi@metaspace.dk>
 <f339913a-3f73-5fc3-27d1-73491a8028a7@wdc.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/3] ublk: enable zoned storage support
Date:   Fri, 04 Aug 2023 10:59:03 +0200
In-reply-to: <f339913a-3f73-5fc3-27d1-73491a8028a7@wdc.com>
Message-ID: <87y1irw1zh.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:

> On 03.08.23 16:09, Andreas Hindborg (Samsung) wrote:
>> + buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>
> Missing #include <linux/vmalloc.h> so the bot doesn't complain.

Thanks, gotta add that so code compiles for Sega Dreamcast!

> But while we're at it, why can't you just use kvmalloc() here?

I don't see why not. It should be better for small reports I guess. I will change it.

BR Andreas

