Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B49C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256CA20851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256CA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLDBhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:37:12 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35628 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeLDBhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:37:09 -0500
Received: by mail-oi1-f182.google.com with SMTP id v6so12857878oif.2
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YpDi1psvg/JCiJH6UhAJdOrNuH70Qp+dZUv7Fppd1ilTHpxKRFNhAUPib2489U5gWY
         zSEE4xR/10ZUAnTBgt1YTsX2aECJK1UQ2gqczW04kiaNew2hK7Jg7oeTj2WpmLkaEbv2
         UT3+gOZ2rw+sEBprmKs+SiYHSpJZ3oAP0NUlpOwLMG3r+mJCSqyOvrlGzM+bH0DalOHV
         gJYt9reCO0qsTPokiq6ULGULEbTlewFj3gWSLx+5xrPius6Wh/C5gdmCvxsn1sDwCXFT
         TEoxk9I2gh/NKBGuBAyQQPIseco5V8Q7V6367Je2Si2G5amQQy5H/SsNiqf4lYxXMgFy
         t1YQ==
X-Gm-Message-State: AA+aEWaNwtFunHEGnZnMj6d5j9ze2oOKgHRfjP4VZiRMpef9UWfb1DrH
        e0l/Zf5WbRN0xbwV6Eqv/X4=
X-Google-Smtp-Source: AFSGD/UsF3DKe6VZbepbRX/M0hqmLuSwc4KQyg/cVBgYDkGhvqKvLFc1c/ds93+mX5fXDBbWq8cc2Q==
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr11591267oia.278.1543887428755;
        Mon, 03 Dec 2018 17:37:08 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d5sm4519082oth.78.2018.12.03.17.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:37:07 -0800 (PST)
Subject: Re: [PATCH 5/7] ataflop: implement mq_ops->commit_rqs() hook
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-6-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <88b0dba4-385d-4594-9d0c-21b2956abaed@grimberg.me>
Date:   Mon, 3 Dec 2018 17:37:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128133538.20329-6-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
