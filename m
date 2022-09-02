Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECAC001B5
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 15:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiIBPjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiIBPi1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 11:38:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C0E3C12
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 08:25:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n202so1883591iod.6
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fxq1owxnTH3V7as3vtwlM0mTq14/nO0sQyftu/XKdXg=;
        b=CmazcpeKfh7KTOIax1/y9v+8DY18LhM+cUURdBj+oSP+2Q+Dp22RYprOiFPQpTXknn
         zQoGJN7hWIBygoRsRfMQboJVz6/MkPW6mtvaOsL4FCTf5GwSrq3J4C8BafPBZO24UQAq
         rJO1eutqZ6c0M2CysqYsbKORLuyT837SZVm8a9vrnHAE5CuGsxqbmUXoRJ9fXq7kevb8
         pukB8+c4yyqyCxAlxCZJc1ULEixyja41kfwxWI6ShfzeWOfftp5WOBupGOuXlBnxGUCL
         Jk3YXT9YtgoOHjBnHMJswK/tumnluuKcnGROSYuhYkwdNKBM3l+REXVon5MrW4NYtn9w
         KXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fxq1owxnTH3V7as3vtwlM0mTq14/nO0sQyftu/XKdXg=;
        b=VDlcWWslpW8Dqd49riKLZ7NrCdNVo8lVMJrW5jpHPMzekrzUuHzkTs+DfjJWSWz+Wx
         jN0mg9vQk23Nbx1OQpFWVUF/qKGJQb2aORLze04FgdlI4Tyl0m1P6BX4mzL4GaRU/b33
         1aoE5gxIcQsxbJcyMCTkxAc3Eqoh/QEy7PfYZQTFh2rc+zrSIoQowhYaMeGf53ehfNU9
         Nt6OYLAv5TSzL8hqHnNZovkF49vGc/ukzWVTOvVACw6LfoqNmsg06v7u6PsNpX9v58p/
         PmgGG4ZGLrntmqQg6JQNzOZbUMynDyRQn3qDYYfkAmnyaxQn6HGfnnYSS3+t05qSe7z1
         oQeQ==
X-Gm-Message-State: ACgBeo24GmDYVSNgB0o54FVYrS4jnV96Du1yekyOfpnJsx/gf7Slg+9L
        7GgGCfJpRE2fj2cX2FJCSBSikUmll3hrlA==
X-Google-Smtp-Source: AA6agR6IQavXVVzu8pV/9ULn0HUlUyl8IazWjzGSOoiVlyIExQjf08KsmToAnfJRIhWIxr3/sb/SeQ==
X-Received: by 2002:a05:6602:2b94:b0:68b:3263:f92f with SMTP id r20-20020a0566022b9400b0068b3263f92fmr13102037iov.171.1662132347498;
        Fri, 02 Sep 2022 08:25:47 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ck12-20020a0566383f0c00b0034fdf8771b3sm246297jab.31.2022.09.02.08.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 08:25:46 -0700 (PDT)
Message-ID: <6be00631-eb53-c180-7716-a615680d6a6c@kernel.dk>
Date:   Fri, 2 Sep 2022 09:25:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH V4 1/1] Documentation: document ublk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <20220902152302.757375-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902152302.757375-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/22 9:23 AM, Ming Lei wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f512b430c7cb..08a5c465a160 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20760,6 +20760,7 @@ UBLK USERSPACE BLOCK DRIVER
>  M:	Ming Lei <ming.lei@redhat.com>
>  L:	linux-block@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/block/index.rst

Documentation/block/ublk.rst

?

I'll make the edit when applying.

-- 
Jens Axboe
