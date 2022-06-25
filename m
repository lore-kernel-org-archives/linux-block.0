Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42ABC433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 02:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiFYC7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiFYC7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 22:59:42 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD268C57
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 19:59:26 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id h192so4029791pgc.4
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 19:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O6j0hJrmTu5Ew55Csjs/Tbzvl3K9W58G3YqOrsxHsag=;
        b=fY/P2j5myXAL/Od8GlcTMfgXfrselV0AbmTWzRuQANd29PNDLQHSRnyuTA4cg5EMDZ
         qjSfKGJmSy3+LCR3T64WJ/rqqjdR01Mr59acAp5F6m3D82teXnBEHwX4zEGXiHJZc/O9
         0o6C4MatcjgUIC5aL1KohfcH63m29lhOOk3wRLP5l4U8eOTh8pHm22IGse9ajxwgFuat
         Vm5BzIMeXohOMxT119sp3/fu8jTCY0/Z2Bh123vwfjJJKF18Qfxaon8N9URDzSMNCv4C
         UMh+77zfYRgmrKGK57Sp5/7UNGO+gwIY4Uq7+YscLABFNw3OzlwbwwzG99jUYuNrchYl
         be7w==
X-Gm-Message-State: AJIora8jXuVjERTQwqRf5EtlRzhd5RO08cXsl2SxqvGXdFDwpdJDUDLH
        SHmlV8wdbDP5HaL/0IdKvnIWmNLxAjQ=
X-Google-Smtp-Source: AGRyM1sBToSq/rQbsCjcPVIIhY9g/PeoLd9TI1yKkw1h3PapHxBkDOOgPB2AgJhjRb0t0zMGp1xwNw==
X-Received: by 2002:a63:4418:0:b0:3fd:af26:a795 with SMTP id r24-20020a634418000000b003fdaf26a795mr1804449pga.331.1656125966013;
        Fri, 24 Jun 2022 19:59:26 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902760d00b0016a55f6bd73sm2514168pll.27.2022.06.24.19.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 19:59:25 -0700 (PDT)
Message-ID: <0ccb3f73-7673-a46c-a997-ee819cf141b2@acm.org>
Date:   Fri, 24 Jun 2022 19:59:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/6] block: remove a superflous queue kobject reference
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220624052510.3996673-1-hch@lst.de>
 <20220624052510.3996673-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624052510.3996673-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:25, Christoph Hellwig wrote:
> kobject_add already adds a referene to the parent that is dropped
                              ^^^^^^^^
reference?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
