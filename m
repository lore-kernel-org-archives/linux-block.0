Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F85C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EA120737
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VRdcekaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgGBESm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGBESl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 00:18:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D23C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 21:18:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t11so7091184pfq.11
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 21:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8+JjGZz0rJOxMtjzzj8jQSTtBK7AXi3WVPOGoTbwuCQ=;
        b=VRdcekaQo6iUaHkdscWE/o9nODkviYJFS0Py0muQ0N1YHYttzupagZqtsZc+qpYr8v
         O5o2FQJ5739Y+uBxQn6pcFGXKaqDV1l2j+4du1dgqshc1IX7VkzcfxlyjtJsTbAxFmo+
         dk0ar12OPXyTCt6PmZRn46f4hv8q5I+CDxEL4kQHJAVCTFN7BQxgZ0BxshYSKfQ/M/lu
         W6wCseEwhqa9QAQMY3oC1ls8YjI2l890xv3ehtZwLS0RIA4Da+J7njybHGd6TGbtF9Ak
         6VZc+tMnV7Zl+g9vg2wwLtAXFmbDL0UrA7GQdV4UlRX7hxTbdcKwsE7MLbfBiVITvTu6
         Gs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8+JjGZz0rJOxMtjzzj8jQSTtBK7AXi3WVPOGoTbwuCQ=;
        b=BT8m0LF8Dvfl7mdOAW88xUGfrgNm/SWcxIxzvTpRpr/fK73qhB6FKlTrPBpHmb815m
         GPkpiLhpBIz6Uul76m3G9TBkQPOGwQPzCxSYLO1Om6RBdLLcvtae9htXz5sngk80r9g9
         2h2sAEVInCMynih91B2I6S9+eKIh5sIT/78JuNeQOxI2Runakus7m7ZwVmXvoCjPLOWu
         8jkvmkHTz8C/SoJ+fg1KHL+Gl0qFhZhJdohYWciKv2m6PHSMIQzb2ATTlxlULx1WGCUB
         Mu4snNpKxT99HjFtkkfIjQA+o6oHy/aarM7ZuVZlm0pIbWFoNAbSLF9xQUsjjGCyaWhX
         DkFA==
X-Gm-Message-State: AOAM533Em57pOGe4jEU9N3sIolcJlHEuh2XJtuLVvl7OESD2OWmarkBP
        C3ApRaBpKnNIq9T2KABuI55agnjyJxeEwA==
X-Google-Smtp-Source: ABdhPJxcgMB1/F6jFJ13oraRRGLOFR3JudkKdVQNFw0wX/cHIRawWEaxf/mzixFgK0Ci6uw9RA/KIw==
X-Received: by 2002:a62:7505:: with SMTP id q5mr25238413pfc.262.1593663520798;
        Wed, 01 Jul 2020 21:18:40 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b0a2:2229:1cbe:53d2? ([2605:e000:100e:8c61:b0a2:2229:1cbe:53d2])
        by smtp.gmail.com with ESMTPSA id d12sm3047507pfd.51.2020.07.01.21.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 21:18:40 -0700 (PDT)
Subject: Re: [PATCH -next] block: make function __bio_integrity_free() static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Cc:     linux-block@vger.kernel.org
References: <20200702014807.32432-1-weiyongjun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ebddd74-a415-ce55-aa82-a4cdd4736c30@kernel.dk>
Date:   Wed, 1 Jul 2020 22:18:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702014807.32432-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 7:48 PM, Wei Yongjun wrote:
> From: Hulk Robot <hulkci@huawei.com>

This patch (and the other you sent) both look fine and correct, but
this doesn't look like a real persons name. Can you attribute the
patch to yourself instead? I can't use a CI name.

-- 
Jens Axboe

