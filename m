Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF83CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 23:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiCYXdx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 19:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiCYXdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 19:33:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AB5EDE1
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 16:32:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id jx9so8889997pjb.5
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=oixGAxtc9S1yvFWVFxAuZyUsgbSJfEBC4tEWOkoMM3k=;
        b=H/N+De6eHRQZbLGn8dMJwiTfu8BZZjusF2dCxJEbvKbyTi536PFtt91SuRc9v/oPJy
         qPWM71oct1PbHsdfqnI7o2nTd7hcZ9+ZB3+NukhNC1Cimftk4ZIscZwB7wdoSq2S2Cb8
         hGRXR8QlG3w9gwyEjAlnvRG3pV//mVuZArcWk0zRDyeH//3cV/t3dHtXG51hPAe9nnSh
         /Nakfby14UvXhlpH1cVRREYGzYCoQ2uA3DdMYHevTFqEpIjE1ymIWxZlbze1ZzPhKTef
         jUSAsbszSBVJ6j5yYxUxtTFVixS3QUyXLYG6ZcBU6igvmRk7AAzNuGbnXGb61i2KNA1N
         J3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=oixGAxtc9S1yvFWVFxAuZyUsgbSJfEBC4tEWOkoMM3k=;
        b=t2c8sIZSVfflLdB55H3hsOBa/vDRSwWgBqJX5YTaqCUbGSQFDNOVwR2Bau9h13EbDj
         6COcKUeghX15VwR/Kw5Adh0kJLXYItLD8zP4R5Owr0L2BaUV03XAVra5+m3oU36JYtvy
         RaAepdDt0/6P5RCTRkhOqtyS49QdE/qbIFDt/LqYwwZUEFjZsQmDqGLN73N66VkoW9om
         XOzGnILhRvR6QvK2hcq9IoE8rCMhbUsaqfHXQFqmdUl6DnHL2y49BoEkiWfs6EGaq1ZO
         1dRNFX0bhu4aYUe6pi45jaw206BqyYI1Ca0854h3HwyHlmH3fH37zNfIzsVNK3f2wPVH
         M7EA==
X-Gm-Message-State: AOAM5300RK87yTVfUrZgrLXbWJJHomgs9TgvNarowXGOrRtjtpb1B00W
        OBv/T0jbIGOOeMxEYJsy/PzwFeVlkD2BYt3h
X-Google-Smtp-Source: ABdhPJzPvgPO5sXFfsew84C5dcHPsJ1GM8L1iyTzcAV5tXQol0Nw/NBu+i+N1Ec4wYC4PvkdVsV4jA==
X-Received: by 2002:a17:902:9345:b0:153:4d7a:53d9 with SMTP id g5-20020a170902934500b001534d7a53d9mr14481336plp.116.1648251137067;
        Fri, 25 Mar 2022 16:32:17 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm7053893pjf.32.2022.03.25.16.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:32:16 -0700 (PDT)
Message-ID: <a3c160b2-1e7d-06cd-4644-b2edf136726a@kernel.dk>
Date:   Fri, 25 Mar 2022 17:32:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow up bio allocation fixup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

We got some reports of users seeing:

Unexpected gfp: 0x2 (__GFP_HIGHMEM). Fixing up to gfp: 0x1192888

which is a regression caused by the bio allocation cleanups. Please pull
this followup fix, thanks!


The following changes since commit 64bf0eef0171912f7c2f3ea30ee6ad7a2ad0a511:

  f2fs: pass the bio operation to bio_alloc_bioset (2022-03-08 17:59:03 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-25

for you to fetch changes up to 61285ff72ae59e1603f908b13363e99883d67e09:

  fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage (2022-03-23 09:42:15 -0600)

----------------------------------------------------------------
for-5.18/alloc-cleanups-2022-03-25

----------------------------------------------------------------
Christoph Hellwig (1):
      fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage

 fs/mpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
Jens Axboe

