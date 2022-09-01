Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA13ECAAD4
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 01:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIABEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIABEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 21:04:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25038107C52
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 18:04:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v5so9465845plo.9
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PI6aCTCbweBeRDa4xWdxio2HxJnrXeV8eIMex7Y3Ux8=;
        b=PBrQ6BEfP3EdKLcsxxgjvW+qPs6UlJbLGuXSIckYRL7q+tzQZkpg1d4fek9qAV/3YZ
         Nvrrqd2pxTJBjFneY3MOwSfIQXpc1x4+6JM/n1MpASl/jj7EWz/jiDpKN6ugJGF+csyN
         xf2V+9k4KC21fZ1NGNg5ESotmMF9vtZLtvqawkM9L3y3NmXuJ4fIN5etD0xabXKmLuKS
         cIhfc000MVHcDRTM97Evq7C8T5Hxo2cq1VEMe+xyndCt1jzL2f4T3wHvLfE5oncnLEIX
         1DYr4j69fjuh9vcCpXm57KZ+WRjMLIZANU890/0iLLmLxcaGVM1PtU6iASkHpIn1j1c+
         L20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PI6aCTCbweBeRDa4xWdxio2HxJnrXeV8eIMex7Y3Ux8=;
        b=KBTueRz9eXdZDyLqAzGmcT/T5Sht+EBUMKZ+l2YenLNRAI6LGEOP19YYZzSm4aSF1L
         gP2BVd7p7hvnbvab83m+y+YWZH03+5acrsapyNgqxjESn6XD5ioeU//ttLdde6YB3oUG
         /rfIXx/qxjQ6MX8ADuoSl4g7sEsYqhMVWCl+2QdDzEPxS2PX0lfExuxtODuTcsVwZL/C
         vVbxV17sJNxXXK/HFHUcP+wty0fVcDNaBXuYeVRVwgtVg/237T+FjQ/zu2aoHka4lL9V
         b454TrzKEtJWRjdiBrC5THbJJNdsSiB3jrEdNkb+lD8XwRIg/qc++/BXFOxxXYk1Qvra
         dTwQ==
X-Gm-Message-State: ACgBeo2R3xC1EZ/0ouUH+FA5j+TLYAOTdaiS79B8np0vS3hfhKuOjvsV
        e+fCdpNLGPRU2FXPVpTVrp5dbg==
X-Google-Smtp-Source: AA6agR4PC2H9F9wUlaC8aYR5nnEI+7s5ETG31rSwikYYQQlhm9n0ihPp+JjpG3zQCZopKpRc/RAgsw==
X-Received: by 2002:a17:90b:3b49:b0:1fe:3552:ed85 with SMTP id ot9-20020a17090b3b4900b001fe3552ed85mr4451608pjb.240.1661994275980;
        Wed, 31 Aug 2022 18:04:35 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0016ecc7d5297sm12341231plg.292.2022.08.31.18.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 18:04:35 -0700 (PDT)
Message-ID: <1a9815d4-7c99-81c0-8f9c-958fd3eef91d@kernel.dk>
Date:   Wed, 31 Aug 2022 19:04:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] Docs: ublk: add ublk document
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220828045003.537131-1-ming.lei@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220828045003.537131-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/22 10:50 PM, Ming Lei wrote:
> ublk document is missed when merging ublk driver, so add it now.

Ming, and you send a v2 of this so we can get it queued up for
6.0?

-- 
Jens Axboe


