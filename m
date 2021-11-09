Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEA4C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC5361208
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 22:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhKIWNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhKIWNo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 17:13:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8EFC061764
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 14:10:58 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j28so360596ila.1
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 14:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=I4CD5j9e6+8ZN+DcD8qclyLUPhPpswPfYN2h/ob3YkI=;
        b=E7BtWxCfIHWFcxehf2XUgRRybhiyPsIO+JoyGtGQCR8qoi/8kDW/9HNpnVdvRytNgt
         hM+aUapS5Tug97ke57SpXuna+LyrS518IoRIhcKe6P9BySo50G9scY0LpWU7FMF4hq/i
         7kUmza67SfKPl1cowaZRgfxVPFE83N4DU0cKWUmm4CjmsT28r4gpwCLfz7XXl+1Ktcog
         6W9BDCuyC/isI5p9DUzSaGfF0kk/gmTXgGXpHLD9XR+IEvL3vSqSbZZRtswDSyrJph1N
         7w+2khyTSramUELyaCC9GFeMoaSsnCkaYaHmZ6o5yDU6E7EfCegMkCv4YSnkyl5VVLAQ
         Y8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=I4CD5j9e6+8ZN+DcD8qclyLUPhPpswPfYN2h/ob3YkI=;
        b=SSEoa06SI+KTIBRYOey/5P7lipS4VVNKCn7JvdDITkY3v86W2m9k2lWwAGF0gUVRWB
         wwNk0PCc7HBDupbyKgs7f2Lr7eqiTlJ2e5xvQpp2Q9UQzhE0FrczVbCD5bwe14Ytzafi
         GXKA4r1q9ASuNfe9JaZrbz5qTG3yfAig2S+ds/3EVsUeE0mzAhABj1t0OyL7Q5PMRIJj
         +Hq3RXEBKousG2+44gy6QtlWHbsKB3w+RVqm9fl2rhPevHQgxeTcMj6AOub/Fuo3Fww4
         C3z9CzJglvz+JzVIuDcu75JPFRWyQbhxahGcO8AkPwF724G/l+vV7YN1k3a2/0l20RgR
         lcww==
X-Gm-Message-State: AOAM5301+eTmNYZhE0yqRvFIhmyrrJ6RkArWF/NoT5kRSq2JLb+q0JMl
        e6speddW6QSczQVfNk/r4e+yeBEED+wCakxB
X-Google-Smtp-Source: ABdhPJzFurz5WIRsUbrmKIigH58w6XBVWpW5sGPp5lsyYnuOfn1cgqh4tQEglCdLeoqJwLLALglceg==
X-Received: by 2002:a92:c241:: with SMTP id k1mr7511019ilo.207.1636495857569;
        Tue, 09 Nov 2021 14:10:57 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z9sm5508874ile.29.2021.11.09.14.10.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 14:10:57 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: use enum type for blk_mq_alloc_data->rq_flags
Message-ID: <1a4b790b-8074-1f67-24f5-662400b2976e@kernel.dk>
Date:   Tue, 9 Nov 2021 15:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kernel test robot reports that we now trigger some sparse warnings:

block/blk-mq.h:169:32: sparse: sparse: restricted req_flags_t degrades to integer
block/blk-mq.h:169:32: sparse: sparse: restricted req_flags_t degrades to integer
block/blk-mq.h:169:32: sparse: sparse: restricted req_flags_t degrades to integer

which is due to ->rq_flags being an unsigned int, rather than the
stronger type req_flags_t enum.

Change the type to req_flags_t to silence this warning.

Fixes: 56f8da642bd8 ("block: add rq_flags to struct blk_mq_alloc_data")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.h b/block/blk-mq.h
index cb0b5482ca5e..39370bbdf3b6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -149,7 +149,7 @@ struct blk_mq_alloc_data {
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
-	unsigned int rq_flags;
+	req_flags_t rq_flags;
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;

-- 
Jens Axboe

