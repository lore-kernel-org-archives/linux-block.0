Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F2EB64DD
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 09:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjHNJjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjHNJiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 05:38:46 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA5173E
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 02:38:04 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1295331a12.1
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 02:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005878; x=1692610678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eML3dbDdV7FB4Va827hh5Q5QJm9umEJcmICBYPAeFZo=;
        b=FEB8z/XXoKqBfOvHMx4Tp36rvQ5kLR7YKgz2oQYdioQPnCXF0h1g1AiK0KvHllX31a
         vmDwTVEc50mcMQIEw4Jvn54xePcoH+ask6wPPva/iBSoyb/XI7xcDarU9Qzm+R5kwC20
         3S9N7DizxpdlucCw3F4puJMw/4D6+A87ii4QR7QERtXElJp4SCQPGioOfwT61t+XDFtw
         /XsQ+y5+l+R2ytXpYiFRlzZwCH3JHgDVvvrgRODVmpLy1rrDoiYqIun3qYKWOfIemakN
         Pa+zI1hmnIuA6qpnEvetvWJVI1s0FoojOytV2DK40QZHu3gjIjDkYORxsYPnMqzCKuPb
         kxUA==
X-Gm-Message-State: AOJu0Yzlk6Gtvsis0LltiKEE60QERSdIgUowo9AZ4ykyJwM948SXnyTT
        jQQWmROpAE5c+1aOq/2qwCY=
X-Google-Smtp-Source: AGHT+IHCqeZA5fZuiYWf4EyC/985KnonSfc9jEbo9VIu7+DLlecKfF2ztCbvN47WBzVZb3o2n6c8HA==
X-Received: by 2002:a17:906:7394:b0:99b:d682:f306 with SMTP id f20-20020a170906739400b0099bd682f306mr6364779ejl.4.1692005878299;
        Mon, 14 Aug 2023 02:37:58 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lj5-20020a170906f9c500b0098d2d219649sm5556604ejb.174.2023.08.14.02.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:37:57 -0700 (PDT)
Message-ID: <149f023e-e4f4-3b36-56d5-e2d0f486439f@grimberg.me>
Date:   Mon, 14 Aug 2023 12:37:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.

Shouldn't this call udevadm --settle or something?
