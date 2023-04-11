Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431D8C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 14:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDKOqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDKOqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 10:46:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7774DE
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 07:46:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt17so8832321ejb.11
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681224394; x=1683816394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xw/mxUKXpWj97EyrOhCIY5GQVAW/IVTixbTM7woSH08=;
        b=cf26QppW6hc6LUjqyHMEpZPG9vb23OlmrSSkPmSBv1WGwBvT8juUi3hqVsziAu1wWZ
         9UpurxajGrHC+xcSEVlodokdnj9hH008ozIAWC5F8PeFU/DNOERRG3WMZWYbY3/E3AkG
         n4ShuYEKYGDAMNqhyLwoPucpuyA8+iMZLKpAgrcmt6D81SRfijshYQrbsJ83kgh6eR5Q
         utZZSG33dIx1BqPyAWdrX6wZda7KzdbDPhbLg6PwpOLRJQ9fKo6iRViX13WJux0XmpJt
         Hpo6g6fmn/AEQq624M3+UzIu+H9+sCKJ8ww++EhU5bhXR79teDAftVprSXs/c8Q1qmT1
         Zvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224394; x=1683816394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw/mxUKXpWj97EyrOhCIY5GQVAW/IVTixbTM7woSH08=;
        b=BOEoj02A1l+s1X9pstu1uVmhHVaaAYDUFdfEjzyxZfnMXtm/8vdof2zC24QAwUKc1a
         4tcZAVBFdjV4Dtdo3Aa5g2ifm7JOH8ljbg/RdG7qC76W710w6cqEOpUSWdx50Ox3pPf2
         E5EN03P6x8gLxBXaiHyMtXI5LlCgmgeO2QvWUgcfBDeNov+0fxRcHqdI20LGlFvSMUfF
         KiZkyFxT4n1IeFiCt2mgivmMLPcD5TH0t0rAtJ/Q5iv7/IRCxOaBdfTNjc8Mj83BAvgl
         YiJZekxAPkhd9C+wXoLjsk2KYP1QCTQBmGuPtaLa2Vm6RO5XtJrlz6uYs4XrQ4HrQZp1
         UOwA==
X-Gm-Message-State: AAQBX9em6zVIMkPHwx99nlNQebG84Jhr22GVVdIgJd27Yr5ucTmb9p2S
        dcgusmuwcGGDJpRgMf9hQuw=
X-Google-Smtp-Source: AKy350a2ciFTg2uyVhlEf+IsdVsD7K4dbSIz6c3orKkFI2vUVbvfpeHZPHZt7nzqIndJ9Jmop6d9Og==
X-Received: by 2002:a17:906:aec4:b0:94a:93f4:711d with SMTP id me4-20020a170906aec400b0094a93f4711dmr2690400ejb.4.1681224394117;
        Tue, 11 Apr 2023 07:46:34 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id r25-20020a1709067fd900b0094a73c2c5c6sm2554143ejs.184.2023.04.11.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 07:46:32 -0700 (PDT)
Message-ID: <07619cf4-f487-a5ee-01ac-4d6d7dd3e32a@gmail.com>
Date:   Tue, 11 Apr 2023 16:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/1] sed-opal: geometry feature reporting command
Content-Language: en-US
To:     Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc:     bluca@debian.org, axboe@kernel.dk, hch@infradead.org,
        brauner@kernel.org, jonathan.derrick@linux.dev
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230411090931.9193-1-okozina@redhat.com>
 <20230411090931.9193-2-okozina@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20230411090931.9193-2-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 11:09, Ondrej Kozina wrote:
> Locking range start and locking range length
> attributes may be require to satisfy restrictions
> exposed by OPAL2 geometry feature reporting.

...
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>

v2 works on all of my SATA/NVMe OPAL drives, so

Tested-by: Milan Broz <gmazyland@gmail.com>

m.
