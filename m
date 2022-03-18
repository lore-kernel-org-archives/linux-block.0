Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 02:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiCRCsZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 22:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCRCsZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 22:48:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1682CCA06
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 19:47:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t2so8363755pfj.10
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 19:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yHHce095Z+cMMKE90z3st8GfylQGCRwqvgLzXY2KQ3k=;
        b=e4esWQq4NmSxkwXv2sqcgG8JpNP3nGmnaKZqkMPdAoRV+iF+1Nxk+/eKQEUK8EnmyV
         Kk1y1Y7l/8Ld/iPiI9cH/FxPjefkXOfVhdqaTyAeMlwg5QToCWSifxGqEw7FHzLmQDJf
         2W9ISug8XRsyYf81mRY9Xixi5H51D2sNK9XkfUekInKVE82hB9VpWHw5kY0Odm7SvQ1Y
         3/Q6zMkYFXTnzLiCrBFHuoGQx+triCWxpI61t+LicydFp0HxQx0fCBd9WLHuGBYsuTi0
         i7xb1YFy7Fgp7XjMIULHvVr5ZPZW5L9WEpohjcPB/4JhvvmitGrixBFhdf8ggHQURzj3
         AHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yHHce095Z+cMMKE90z3st8GfylQGCRwqvgLzXY2KQ3k=;
        b=GKpIIcN2mf5Ij5tb6L5UKrGP1xwIuBet4xt7ndbhZBm56mZ97siBMA7f/8dj9ln/86
         thkC3y0irb++E9PtGr3bMk19uL8oonjBy9ZnHH5Fp89+nlsAdfTuhIqRD811So/R/RMq
         CSD3lZD4v0Sy6qVA09Kwg3e377LblfjfaEZIMWYrjOUsvwSRBlLYpN8pTotahd7jd9KK
         +zM8zUZCvxbiFfXDmXFnRWgriVmrQ1+mYtjlc8oow0ImuIotgmOvMxuNKGw/mKt4uahK
         Y8QEIwjEXeET3Ujqv5fZ7N0Je5gva7OdSFIGCdrd8Pwb/L6Jg5dt6Av19Sp+Kp3H2ise
         purg==
X-Gm-Message-State: AOAM53299SqbzXQInu24Pyjhg1uVOLpwmVh9AJ5gJWlrGnSnYDL8DVmZ
        18rAlA1JmNwGBBN/+D7Rnr55gRasrRq5Z2O0
X-Google-Smtp-Source: ABdhPJw+LjoCQsY5qugenJ+cnDZOuejYF1SQfesGpmzqOhfpTyT+Ly6jPqb1DIN+ujPfOIEdnAyLKA==
X-Received: by 2002:a05:6a00:14c9:b0:4f7:763b:2efd with SMTP id w9-20020a056a0014c900b004f7763b2efdmr8016623pfu.55.1647571627260;
        Thu, 17 Mar 2022 19:47:07 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm6210563pgk.74.2022.03.17.19.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 19:47:06 -0700 (PDT)
Message-ID: <0657d1b4-fedd-09a3-1ab6-fffdbd158b6d@kernel.dk>
Date:   Thu, 17 Mar 2022 20:47:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.18
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YjNrAsjvdSd+abfu@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YjNrAsjvdSd+abfu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/22 11:08 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-17

Pulled, thanks.

-- 
Jens Axboe

