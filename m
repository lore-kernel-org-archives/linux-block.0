Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A43AC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1970C20708
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dbnCKelu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGHWHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:07:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E29C061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 15:07:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k4so4584194pld.12
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8dB1ohpmoZBjOOLN9zQVoN7WexdWOZ3szubnu5wAwvc=;
        b=dbnCKelu0gFJDNuuHepB6+Vpj85lHsPy2wnLHeLzyahEGeo1cVWc2FXSZ/uT2WPgt0
         ikHNQPPPzR41dBkaJPXT3CRG9WRoLtfFzp7ogzv8auvrAq+o0SHmmq+ed2ywuxkGM5E5
         GwkFJOEkQISS9N5g2STmOM2egxtTd3AutL0nTBa0MLNXvmzJSyoQ6ZAT3TlE6QxIx7zU
         MWzeBRsun382G8JovOWanhQ62h0/LdmmxaHaiSOuQjLdF3tOBI6M8yuH/xGq/jMoQN4I
         rFV0vDGxufWTdGrUNH1lD5ey4hmi3wXcuTESWiKcTVcsFKsde5FV8oVFIqs6ckmesUfL
         4IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dB1ohpmoZBjOOLN9zQVoN7WexdWOZ3szubnu5wAwvc=;
        b=QhYxUixeMIF1w6vmuP7b42nfKudza8vzDzfW6RrDtA90bgCMF10JlerZlhY1ifWkMl
         V5kmTxaerkAEPQMCSJAWEJViltQebw/czDj730FnMh5MNFIC/WBJua5la+RKXeu9mfPz
         nlb2iadr09wsBju+JWADniXhn0lBPUG8m2CDo1wtAVDpBwov06GqXUfiM9z3xg7pDm0D
         SHM2m3wShDSK8bdNchvL44A0FgLXGfFw3AC1w7h3n8Juz4AaakmYhr0bFuPS75h5rrUA
         cLgsNK5V8vnIM7S6lnuriQVCCUSdZ9TKoUkL4srQWrJlotw91oZwUYCggp+evCAXdFo6
         hPjQ==
X-Gm-Message-State: AOAM533R87nv4zStue5hTX7knOa7KBFSixnteNVBsGTn4fhGZyMeATEv
        GyKIDfBsH70S0qoloX7YcSR63A==
X-Google-Smtp-Source: ABdhPJypeN693YxD6no7sX7479afPV1/rxspYKWJqzw7bPftmVaSFEJ7CSL2BBXGsBHx39yDftcmPQ==
X-Received: by 2002:a17:902:7005:: with SMTP id y5mr17593969plk.342.1594246025654;
        Wed, 08 Jul 2020 15:07:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w20sm684509pfn.44.2020.07.08.15.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:07:05 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200706144111.3260859-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d764315c-b751-0b6d-d968-16c4261dd155@kernel.dk>
Date:   Wed, 8 Jul 2020 16:07:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706144111.3260859-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/20 8:41 AM, Ming Lei wrote:
> Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
> all are good to do during getting driver tag.
> 
> Meantime blk-flush related code is simplified and flush request needn't
> to update the request table manually any more.

Applied, thanks.

-- 
Jens Axboe

