Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E1C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01F120851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01F120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLDBjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:39:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38332 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLDBjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:39:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so13666970otl.5
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gMlYw5I5zWNNH5AN+6frGTgLFBtfSLV+ZRowF7VEG3p+eFeUY7xwWmk3nUzqSd4rXK
         dU6mo1wtHA69VlWJSCxoSZCq1SADunpFHvGhbLmv9k1ILF3v+mqgNl4ZtpjHH+y1vWqX
         P53BhIVzXtN9FTPCEq1gwANh7WmYN6aGqFFIywAax8kS9UY30F9nb+Kp0s+Wbp+VZSbZ
         YYoPFkmJedEmarnruYw49zKRGRJdh2ko0/JRgsyRscmxy2R2ipf173AisU2vIpSYwoYh
         Sqk0u3JjBOAG51VwrpLAgdMEWUhei0g1I1jpgwxNHw2Y6hIDs1VADO6WAK86+R2Hu7rU
         6h2g==
X-Gm-Message-State: AA+aEWZ4yH1dOU53WKQD/ZrSc2ilmL72IbWoSoZ197wKbOrU+BRGELHD
        b1RE09VfUGcztS6hwVUtKcM=
X-Google-Smtp-Source: AFSGD/WNDGoovx7uty08hqEb1b4jd23zUAowqq6JM/ZsLcDp6q7srMuywCvxCPfwAKu5mCykoSpWxg==
X-Received: by 2002:a9d:12d:: with SMTP id 42mr11175298otu.352.1543887556182;
        Mon, 03 Dec 2018 17:39:16 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id k13sm18433966otj.19.2018.12.03.17.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:39:15 -0800 (PST)
Subject: Re: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f72ee67d-7611-9e28-7051-0c00a71da0fc@grimberg.me>
Date:   Mon, 3 Dec 2018 17:39:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128133538.20329-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
