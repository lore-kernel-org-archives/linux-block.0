Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22236C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 04:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99A20645
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 04:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZLClw45b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF99A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLNE2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:28:37 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44714 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNE2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 23:28:37 -0500
Received: by mail-pl1-f176.google.com with SMTP id e11so1462413plt.11
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQOOyCJUMseGu5Ea37D3Y0l4K8tq11Qv8COgjmx7bH4=;
        b=ZLClw45bbb8SVO9CE3g/otcwIECiBlcB7FjmW+EtUi4a9C2yrypP2+sGdfvtzlg2fj
         W1sVLqk4UnpqUKJ1RmU9DpoQqfur0h89w4Iv8v8AL08oG3FjqKL0szrHCQ6Mkk5CH0DQ
         R/SgZ4DIjPnmOboxmeIQbou7/B0hv5OS4ZCBF9PkajZ9fgpwXjN25LDtpWs26ghOBmKY
         bDSrRFyxYBbinuwLnpFT4cBoxHyIIo5k3dIZl+7IE8jIY7U+q9IpvnwrDjJTxeBc0Nj4
         lG/Nm+HRZ6ejLc8lt9uLvpCvjx3zfVxdhDp+fAJBETDLVqy3J6RBCNyVkICE+0JXUXUu
         fNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQOOyCJUMseGu5Ea37D3Y0l4K8tq11Qv8COgjmx7bH4=;
        b=P1g62b4tplChwsbUwsyTtd9lL9W6F4cY0heTsnOhFRYhceuvrSKuCZX8JmipaYqpmJ
         L2/ANVuZb0+O7pNDs+j7VQ+KW9Vo7HquqWrKd1nXoKVY4KJkLf7YEXlZWgsvnrTo+dX0
         l3rytC7YkkJ+9WWUq2i/zXi/XTMo7roGz7cELqPRnAiKoYy5n57AR29pLpC+CLoU085O
         8wMVSZ0O8UmcCFAMlnlMLJV9C4aFihpp4wRxCumGnGBRlYh5g6dKfxXMq3tMI3DJ6e5E
         LTX2u8R7gj7mjVi7kqfUAejGltOmgaPC308nTe/epYGQ2VJsF5cNXtG085WMisCq8daL
         dX6g==
X-Gm-Message-State: AA+aEWb86yVFJR5iX/CJdADHlld/0ZT9DtX1m70HonTbtbziFZj5f9Vd
        CDzYEl1UAvnbFWHU5DBNHMN/qVK3IJiOow==
X-Google-Smtp-Source: AFSGD/X6Ip8WmTM/eSXgcCxuj9sHIHVuGfHGcEQdVIudVSG8Vu/L7RGFgAxNBcw5laTdHFQXV0Lv0g==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr1440011plb.70.1544761716263;
        Thu, 13 Dec 2018 20:28:36 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w88sm5677083pfk.11.2018.12.13.20.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:28:35 -0800 (PST)
Subject: Re: misc block cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20181213203214.10650-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a57919d-7098-8b00-bc72-54538d384d09@kernel.dk>
Date:   Thu, 13 Dec 2018 21:28:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213203214.10650-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 1:32 PM, Christoph Hellwig wrote:
> Remove a few pointless helpers and unused exports.

We've got quite a bit of churn this round, do you mind if we
push #1 to next round? I'm fine with killing the exports, if
they are not used, they should go.

-- 
Jens Axboe

