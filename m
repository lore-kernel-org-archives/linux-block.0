Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FC9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 01:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiDNBYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiDNBYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 21:24:30 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DD51E51
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 18:22:08 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 2so3710885pjw.2
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 18:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=por8ILGxtBK9ivmjp5FA3GxjpM7n4jm4O0EywFMvrBw=;
        b=a0G3f4Ct3LhFxP9j+ih5rVrS4+e5f2wWPirrg9/o38bMFFlgjwmMkUAzQgVjgW/jA8
         39zUfzEFiUh6YnNj0+Tc0tay1C77x6rf7bgNXhAYdzhTQJirNmH113TsVyL/dxC+dXxU
         fc/87Nb5Wd5Hn+nQcU5E4e8LFboVMvnJNeNcPbwnrul71pVkabzznGhFoVoN5uOjKgx5
         sxo8N9y1S9hKQJ29cIReHQ2EtjSjkLq5deMzaSAvsNlcKbG9BHAetD7AdbKqO9orXiJw
         s+rFLVU5LUUxgbfF4Q3gfDO6Gb7m9t1BcGBlcq8GhGztJBZ2fSWgKl1XVZPQjQjGkP7U
         Va9g==
X-Gm-Message-State: AOAM5304UrRs/js4I2109wMnnHWwonVgJ+Zwc52Yly3uahDSTfRwx8yF
        T3zXrczN+apApTUV27BouaY=
X-Google-Smtp-Source: ABdhPJzcczCPOX0NtSMsHIo7WO8NVWNW5rv3/nl8T00ZarNOe1HcCwSsBRYEuS62yQsXBkLhTwNGgQ==
X-Received: by 2002:a17:90b:4ac1:b0:1cb:bc12:1a68 with SMTP id mh1-20020a17090b4ac100b001cbbc121a68mr1023677pjb.49.1649899327512;
        Wed, 13 Apr 2022 18:22:07 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090ac98100b001cd4e204664sm3785412pjt.4.2022.04.13.18.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 18:22:06 -0700 (PDT)
Message-ID: <09020b99-fa20-fd6c-abbc-ba294049a025@acm.org>
Date:   Wed, 13 Apr 2022 18:22:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktests srp failures with a guest with kdevops on v5.17-rc7
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org
References: <YldoSh6o5sbifsJf@bombadil.infradead.org>
 <8db9ded3-ae12-3c56-5ac6-35ee9b9117bc@acm.org>
 <Yldyy3ZSEbaTxwSj@bombadil.infradead.org>
 <Yld0t1DeZdNBzMR+@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yld0t1DeZdNBzMR+@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/22 18:11, Luis Chamberlain wrote:
> My exclusion list one-liner is getting longer, but hey, no crashes yet.
> 
> i=0; while true; do use_siw=1 ./check -q srp -x srp/001 -x srp/005 -x srp/006 -x srp/011 -x srp/012 -x srp/013 ; if [[ $? -ne 0 ]]; then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=$i+1; done;

An exclusion list? Why? The SRP tests are stable. I think that all test 
failures indicate a kernel bug.

Thanks,

Bart.
