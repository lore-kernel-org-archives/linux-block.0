Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D014C433FE
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 12:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiESMO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbiESMOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 08:14:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B5EB8BF2
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:14:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso5111926pjg.0
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=;
        b=p27yU6tdtyX4ZiycgPNJ1iNvzRs1b87/Voz0GLihHtppsn0VQ3J005iotBD+d8vcfc
         pSl70SwV2zgj2wW1XGGR3wzVPV7Ted5GdEV4zVKBunzNd7u8sjyc1eF/FWWXPgUxIwIf
         rp0p9c8opyZr+BSNShaf8iK1fu1Cbe4GNVcGr4uk4VJx3YUoRhpv0RT1/T/lPz5S7v4J
         A75Bhgl5CyQT7JAgoVP2i1Z78/9hWaX9YUb5WeKxD0xv9+85PAj0cNWCP3s0G31qjmJ6
         8diBYNnWVIkLmLoJXFzKa8Ez8S2M3Cog4RKVqWXlcK5ghGu7VAX+O5HJqzjgeyXisdvo
         GKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=;
        b=RJQeNB52I+TtuiGYfQod/BUDQ4ChK6+fthmOI2h4xyHFaGLcJrwEqtmCcfXcf8LgJ0
         FoGQG4qVTxM3DEHnVGNHTjk5vx5Gc10fdf+eZ/oPYQv/aadRH+ptJRP+rL2a+TR47Fik
         Rmc8w8786sP8/x6O2Ev/44hy3LWwwqmbRit18aN6zvnRUTdXYtwOUYWVz0SAJPrlHzZA
         WLhaLL2SszLyCv51g3LfVRGsxT4GNUdxt7UdikGgspzLkApaq/KNnFjSiBzO1yS4wc0r
         N9IxyfneedR73b9aVTTkxufEI9BuJCD+bcUuLhrJD7mnqJmS79wdi/158WcuqugQePA9
         m3EA==
X-Gm-Message-State: AOAM532tKFHd+O1TmqUT/N8RtJJXAuGjBU0+icmE7cHXXwHTRxXFF6DB
        cj3NEC51XE4HRDJ3Nky/dXPbNw==
X-Google-Smtp-Source: ABdhPJw2DRKb0mxn4KqbWP/jQzIrlt0CfwCkmk5n6p40P9UnKG1Hxulsj0NJK/Dq6iFqITKjk7qNMQ==
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id m2-20020a17090ade0200b001df3f94811cmr5442544pjv.112.1652962460260;
        Thu, 19 May 2022 05:14:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v10-20020a62a50a000000b00518285976cdsm3671518pfm.9.2022.05.19.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:14:19 -0700 (PDT)
Message-ID: <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
Date:   Thu, 19 May 2022 06:14:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
> Greetings,
> 
> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> 
> Console Logs :
> 
> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
> make -j 17 -s && make modules && make modules_install && make install
> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
> make: *** [Makefile:1914: modules] Error 2
> make: *** Waiting for unfinished jobs....

Christoph, can you fix this up?

-- 
Jens Axboe

