Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586BC38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 14:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIGOMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIGOM2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 10:12:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288C5578AA
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 07:12:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d68so11520230iof.11
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XLm2FS4jato4lheGsNY4LowY5TrnyAyqeiZDY4H2/yM=;
        b=5MKSEGVBkug8VZmE0BjiTtziIZRjpAip/BCo9UCoKKGsa6AHBcXLO3X3etSiSHYAk9
         dD55ixrjONSFhVKfUwMmzyry5F68fD8aCiCMX09lBYqWKcA6qWwGpO/jC2xBf1tLw+qH
         NJeYHhXLepPDT6Nx2a8QebU6YNqJxl8eW4zA1A2VncL2eT6VnCIJWDuaufe/65ehEEe3
         v8zdTvZb1QV234MvnorE8cTh+fD8ocHbn+m0cz9zusacYRxWQXYA/AR95BX1HiPznUsx
         x0GoIdwDBA8a+azN4G5unS1EpJu8QpxyrSkbtWRcIBlrKUksIUd+MkTqtE71ad6soHh3
         riDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XLm2FS4jato4lheGsNY4LowY5TrnyAyqeiZDY4H2/yM=;
        b=EBiuGVsKpd0s71zOH3TQ3YtBO5hb5joeH4K3ATswsUcIZBxryACo3fy/XpFERjFh55
         6zs+hQ4cctCDcgVY48je9YtcBvmtM5MDhsotTXZHScIoyTilX3RzpIPp+4ryEokGiAz2
         3+mNH8Lnh2XcZYqkLyyO/8bjHt2aaJ3Yk2Fxk35nM1b//+pVLsDaJnSFEux+w4oLFDEs
         B6K8pxxCkxM0SMLn6kqKIUNetVEZOfBRir6aoF5G7jO4dWnUvf6ColIZbXiWUIXOOb6D
         BUuKyat8iPNqpUuUNbykqw6rKrh2VjhH2IAkI57KCn37JmBOTEE2YReTwliw9DZNBgk2
         vPXQ==
X-Gm-Message-State: ACgBeo10CFxnqYB2+UKips4IOSDH5MbKEXzFXHKps5+6XG0U1twhP3cY
        NG6oSbhiWf/hAumQmNo0bsXTkw==
X-Google-Smtp-Source: AA6agR6OBEe6T0vcnaHnxzvoaMZck9XBTuq4bd8R0W64zMzEoTYU/Lawb92RtwF512h9lab1lkc8pg==
X-Received: by 2002:a02:294a:0:b0:349:fb9e:b5e0 with SMTP id p71-20020a02294a000000b00349fb9eb5e0mr2247160jap.115.1662559944962;
        Wed, 07 Sep 2022 07:12:24 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o3-20020a027403000000b0034f36a43ec8sm6796219jac.78.2022.09.07.07.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:12:24 -0700 (PDT)
Message-ID: <d4a8f2a4-b662-19c2-f3ad-cc27fcd5211c@kernel.dk>
Date:   Wed, 7 Sep 2022 08:12:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] kernel: export task_work_add
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20220829040013.549212-1-ming.lei@redhat.com>
 <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org>
 <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
 <20220907140550.GA21414@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220907140550.GA21414@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/22 8:05 AM, Christoph Hellwig wrote:
> On Wed, Sep 07, 2022 at 07:44:05AM -0600, Jens Axboe wrote:
>> On the patch itself, it definitely makes sense in the context of ublk.
>> My hesitation is mostly around not really wanting to export this to
>> generic modular users. It's OK for core interfaces, of which ublk is
>> on the way to becoming, but I really don't like the idea of random
>> modules using it. But that's not really something we can manage with
>> the export, it's either exported or it's not...
> 
> Yes, I'm really worried about folks doing stupid things with it.
> Thinking of the whole loop saga..

Exactly. But we don't really have any tools outside of clearly marking
it as such. It's not like we have an EXPORT_MODULE_CORE_GPL() and with
that requiring a driver or modular kernel feature that marks the module
as MODULE_IS_CORE_GPL().

-- 
Jens Axboe
