Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98AAC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EA021707
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z67xi9rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgJGOZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgJGOZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 10:25:04 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A79C061755
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 07:25:04 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q1so2444042ilt.6
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A7K1sHY6q/b2IdFDB45O/63cHris3UQRZX2+uyQGB10=;
        b=Z67xi9rzPKTp80uHhkurQLtC3skXmryBJtaenRQER9oIzoqYRElX5a0DF4Lafyra72
         /tLvHob1dfGrbG/loIPOSmGuJsmfbGGTsQA41aAgrNCdfLY7F4rhcTMSZslWJ1pZ/ODD
         8h7MG2NhsyaX6Cv1zVGyVb9D1QODk/MZYCiX0eFEZCYF5eMin9PJ+XT8uLroVVym9hkg
         6SYhIYWvhhCHvblaPIo/6QfZqmy9RyhJh7/GenoyNQYpK9yBgEjHryPY/B8Y0w/d4XRr
         oDJp1dvnJmpTRPtmwsmWqwVok9XprPx3KE/eDC0MRGGeWOauDFXh0bDoTgLZWjfaUcvG
         ZnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7K1sHY6q/b2IdFDB45O/63cHris3UQRZX2+uyQGB10=;
        b=pf5qIthpiuI2tGUrAuwmaMFDw62PSvKhw2ZmpfIM6kklVlPklDDiTR93L41FWsCbOR
         s6w+kgvIhp5mBErriryXtiMD9pH47++NUl+FroqMAZ8Ezz+/y6Eg3MCOkjxJl7B2IjPo
         hOrmDFQWfQQWgqoh2Jh1yS0HscgdvuQO6NWpmNULDoQH83Ixi7gdVrxmVlg5nRJbzJ/G
         HJd1PoRBC5yKXHRIesonCSR2T9d7e14HuFwXfHDV4nr54ItaMFB144Te0YthHYI5FsWG
         c27VP+XohukX6qpdF+K4v6eBCdNbtF/qt4JlU9mlbnfzwYztQ08nVkEB/Mjt/dgVkqOH
         L2kw==
X-Gm-Message-State: AOAM532DGOw+QlD49S8GuGZ8QnD6yCqZZ9vriaF0R9n4q2wYnf9/Lvgv
        lvNCTjic40oMFPl9cgJAWPku4g==
X-Google-Smtp-Source: ABdhPJyaPkfGb7JXNuxplHrvZZwINxTPrmRH4KFB+GvAm5CNgDm7EmCiP7Of84X20GVYBy2RoZ/Lsw==
X-Received: by 2002:a92:1f19:: with SMTP id i25mr3162991ile.198.1602080703493;
        Wed, 07 Oct 2020 07:25:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 15sm1089939ilz.66.2020.10.07.07.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 07:25:03 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fix for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201007142324.GA1458015@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2e10d2e-66a7-5785-881a-2c1daf310d60@kernel.dk>
Date:   Wed, 7 Oct 2020 08:25:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007142324.GA1458015@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 8:23 AM, Christoph Hellwig wrote:
> The following changes since commit 6d53a9fe5a1983490bc14b3a64d49fabb4ccc651:
> 
>   block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg() (2020-10-02 12:01:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-10-07

Pulled, thanks.

-- 
Jens Axboe

