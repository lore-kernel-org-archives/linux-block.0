Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663FAC433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A9D207F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HlADSP7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2RWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 13:22:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E88C061794
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:22:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i138so14165235ild.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W7fvMYge5Q1Ta5p3ZvTDXHqTSeNclIrTI36qUUMcAyk=;
        b=HlADSP7HKrDglShgm+sXTufnPs0+oLEn6CDyQVp7hr8PS5qbFk5gR4foanrAE0Kzs9
         e0jKxzLT03vgXhTHPyj9LKaFHGS+9Z4w1PzWAB66+VKVxZUmTz+GghMqxEYiGPVrvg7K
         jdV/762jk/s/4tuUzynFFhA4wFRkIfxAAX9avl+dhE7J5IWdYspYmaJSr/ahm4udBsdU
         6/NlBUE1chWWBddh/fVr4Rea1ZtVJSw+nDNTq46lEIWZ4WsBo1FEdW6AKerm2EQl3san
         R0khvOFoKkrk655BHg21o/iTbBvaJ6VVN9qtbtadYckGXx7sKCBi5ZGPJH0moYRRhj+R
         gUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W7fvMYge5Q1Ta5p3ZvTDXHqTSeNclIrTI36qUUMcAyk=;
        b=Ckl+YFZS5G60Ok5GO3RUGaij+SUF63IzHkbf6UTWYJrS8Vj82TDpEqfaxiGvQ63NHc
         o6m2umxIZThPRGaMK+zkqXTBo2syMgtK4DvGQOgPx0j8WMYTzpiTgQf7HTemR4GwrBxd
         ngAxerH8YPvZwv7kWNCDB8baN9r05YgFRdC2HtzofBuamNtVuw8RgfEQi69UipWr2pjH
         PpgHagE0eeaK5exJ1wQjFis6lzFK5szJm6/3jkxnxMxnZAvxINDx/tBsxXlszdo/u5De
         aLh19CasSqxLQKVTHFvJOttkax7qwO7zMl7RWTl8dl56vmz3JZHhPuAVIlwfLm41qGe+
         S2rg==
X-Gm-Message-State: AOAM533A1ew4axyPy2elSw3U+zPNWeVh5gUL4yYfGNsvpoDrguySiYbx
        bmWLz74bYU4dIAGbBx1TzNDc9A==
X-Google-Smtp-Source: ABdhPJyMl252WFz9msu4K9+BvPKZAA/tJsIfTjb1igEHkElhCA3ASMuGm3q8N4FB7r/ObCgy9uvIDg==
X-Received: by 2002:a92:bb84:: with SMTP id x4mr36499223ilk.177.1596043341266;
        Wed, 29 Jul 2020 10:22:21 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d16sm1521944ill.47.2020.07.29.10.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:22:20 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200729170952.GA21060@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa539a99-31a0-81cc-0d7b-3952721b2b22@kernel.dk>
Date:   Wed, 29 Jul 2020 11:22:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729170952.GA21060@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/29/20 11:09 AM, Christoph Hellwig wrote:
> The following changes since commit adc99fd378398f4c58798a1c57889872967d56a6:
> 
>   nvme-tcp: fix possible hang waiting for icresp response (2020-07-26 17:24:27 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8
> 
> for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:
> 
>   nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       nvme: add a Identify Namespace Identification Descriptor list quirk
> 
> Kai-Heng Feng (1):
>       nvme-pci: prevent SK hynix PC400 from using Write Zeroes command
> 
>  drivers/nvme/host/core.c | 15 +++------------
>  drivers/nvme/host/nvme.h |  7 +++++++
>  drivers/nvme/host/pci.c  |  4 ++++
>  3 files changed, 14 insertions(+), 12 deletions(-)

There seems to be more here than what is in the pull request:

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  4 ++++
 drivers/nvme/host/tcp.c  |  3 +++
 4 files changed, 17 insertions(+), 12 deletions(-)

In particular, this one:

nvme-tcp: fix possible hang waiting for icresp response

-- 
Jens Axboe

