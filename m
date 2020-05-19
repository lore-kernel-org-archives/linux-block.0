Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC502C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A0D20657
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Uh2jpQ4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgESPnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgESPnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:43:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147CC08C5C0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:43:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t16so32895plo.7
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y//gBEyuh9LEoDa5NvkTsMGmsc68PNObmT5REgcCMtU=;
        b=Uh2jpQ4mxnIxmh6Us2RQV6PzYd237rZwV2CIaAedCSAQJb+uxTsC2A+4XN57BZsIWM
         AYYmw8k+T34NYSuKauIwK8xBnU3pTLsRqWwlmOh965+Y5O/VGDMDo9ANl/Axl7T15/zc
         +OewLJnWDs9jo1Euu1nZmzJm6DxOmrSHVORAFFbeAs1rplzCkF8vzaTyJ+yhtsA+6iQf
         9aNLqo16TvcCnuq7K6WswyOLrcBnmyXDqIqsaDdYQ5yoGaqlJlVukVzudWdDD/+wcor2
         KErtyOG1wqO4TQMkpHW/kDohLSwRpEVp5ZyLpSolnUyv3pCnd2bzD3h6koEUtNRDyv2s
         baGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y//gBEyuh9LEoDa5NvkTsMGmsc68PNObmT5REgcCMtU=;
        b=kIFCTVQmFVQqGewryAu6eSHJfvKex2Whi/G7AmHTo1ggkpAq6GNPwqZ+kQ3hG5ike/
         sfVUgkD+ZcFWhrmFtAmEBTlqGXRqtFEHib4QZ7LjuhChAwQCu/KFENLxzETXRb5u3Rth
         svHLkwlQ4BeNen4UTPE4xG+370gw4tK+VHms8vzGDUvaWR3Trvbbj4gtFd+45nynx+p5
         FK/aRl5Ua4vlHrC6Uv08LKiqmpAwIRr2t2CQb/E0nl0zh9+bKdXwsTCycdIAZVbjS9Ui
         fiapPCSvcOnVfPPoeGALT3k8mx3mBlfeUwVGG+6dbCwpEVLqUDv4lyuC4bS8JHXZzlne
         uWWA==
X-Gm-Message-State: AOAM533M0FCtvMs0Z/ByKgmhc5KeoUc1gx1DEBW1ZbvF8mEfVGlbU2RX
        YPF5n8rKXwOe8lITytkXWbYNNddBfdE=
X-Google-Smtp-Source: ABdhPJz5OE9IiXHIQaBGNuH5Ln22yWw3q+n1ikHFg9cB549RcWZJAGJcIIGC0YhuGnA0PLnRhVA1pw==
X-Received: by 2002:a17:90a:268f:: with SMTP id m15mr182185pje.190.1589902992181;
        Tue, 19 May 2020 08:43:12 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id x185sm11606326pfx.155.2020.05.19.08.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:43:11 -0700 (PDT)
Subject: Re: small block accounting cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200513104935.2338779-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22d85028-4b1d-1211-a08e-b735d265f2ef@kernel.dk>
Date:   Tue, 19 May 2020 09:43:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513104935.2338779-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/20 4:49 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> find a few small accounting cleanups attached, mostly cleaning up
> the somewhat ad-hoc blk-mq vs bio split.

Applied, thanks.

-- 
Jens Axboe

