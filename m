Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E28C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D58320FC3
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PUXtWENM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgIAPMg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgIAPMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 11:12:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B232C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 08:12:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f18so944736pfa.10
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cmf60kaJnLulg3nAlNSWgeIZ5TjNS3h/lBYUaqJ+ijw=;
        b=PUXtWENMVYij/8AtBgV+4W8+/5W2969p/IUR9ILXAOvur9w1a9yuX66ytR5HfSHRK6
         oQ/1dTamqXUwKXceOL61TXZOEDAJkX5GKHRlXFT8UaZpx/efMtEN1OoIZXvxL6Z2Nwg2
         F8zV9kv3m1pvIAjpn2xBBBo6B6HFD+oPoGGAH7zjOv77GFwpyZiln1nf49PHwFKLobQj
         oCWw/WruUY28QerNJaSGhVMg5/EKPSrJpdgxfjuSMnPIrGXFghAWZY3MC/4/rTFDZ+mV
         bTafXLOggtmKtV/UTSs16opGn6lAsTUtooyMvLlpp4v6RE8kb1Vee8Y53s4HzK1yN225
         geSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cmf60kaJnLulg3nAlNSWgeIZ5TjNS3h/lBYUaqJ+ijw=;
        b=nNPNNMOCSJVyup/3ySQAGnrAkPHItxlczT/2bWXUo6plapTjPmgHAWvMt+twgRBwb8
         iA6AESmpnEVRIzoW91NvEIH8pAhuDrWY9BnmwKCzhjkIf7b0zhpxB6UproGXCzzcGh4E
         jpIGeN6UkCBRSCtprd+mGY0UDuB3OcKm9OhcQxmVZzvoLDzT4tskTwlzKbs2GbQoLpu6
         ulU4UqL1rok9Ol9eoHomd+hvoYii6GwmsAjcPX94d/VRq39OhPNsJpCqgIEQ6TtrI8wy
         BLEprltlyxfsJf1fx6dHqLL8nRtpoKx45NX0liKQ9YVhLwUz8bM0IVwsEtOd/GuUw+xC
         V75w==
X-Gm-Message-State: AOAM531FsBbT1NAI63ZI+8QU0+C3TScfA1V93+X87MXH8qLJrlGPAGu8
        3+G//pFSfZF6685HSkKdkgwM9NLZ1mHEShof
X-Google-Smtp-Source: ABdhPJwaSfX8F6fx/bDTrbxrhtb+/nRpHK/9BtWiLlneV1Q6RJn7SVQ/xhXxCBgUasXWdaV9UjS3PQ==
X-Received: by 2002:aa7:9d8b:: with SMTP id f11mr2266050pfq.5.1598973148416;
        Tue, 01 Sep 2020 08:12:28 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p24sm1835504pju.57.2020.09.01.08.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 08:12:27 -0700 (PDT)
Subject: Re: misc cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200831180239.2372776-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c0c026a-7363-0b90-3da2-4b06712fcae8@kernel.dk>
Date:   Tue, 1 Sep 2020 09:12:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 12:02 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has a bunch of misc cleanups that didn't fit any other
> series.

Looks good to me, applied.

-- 
Jens Axboe

