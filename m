Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8CCC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F97B20644
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfHORZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:25:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37569 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbfHORZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 13:25:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id f17so7179069otq.4
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 10:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7XUkgWHsoYr+9qJH7gY0FNPB406RMOgVzJRnvTPV01A=;
        b=IvuVG8RO6qi4V6OGisvbEEdjMiI6+70uJBl6Hm3juLax1MxN49YeXm/5iAwnpMqiNA
         dVz4jLPrGIcZOPCSZlSZqcoF5u9kl2q7zc2yPJr+jFA20l/+EVeywoB+pjFQqeAv7DKq
         CARxkx90p8AwbV9kFS1bdC6XauS8YTnGuLGR7y5ONee3Tqzp+xgdeKF2kVcCWAUls6iG
         mcV227Lfu77YdwZhe2IX62LL3TOeNStSj0IfI+yw+9NkYUjKT+tTou2pJ6E2J8PEz/rI
         p3dy4nIh13D64eCaZWmwQ4S6j2lMF5p2iOE8e8Cm6jcp+eTw45IYWm3Q5ZB8EyDrYFU9
         DiUA==
X-Gm-Message-State: APjAAAVMeqyRqXEzl1IVinBTm7Promo0Id6oKWqXyXLkhMjJeyAhx8st
        hF0gZeqY4aiCicjUYEjqRb8=
X-Google-Smtp-Source: APXvYqzrKUWp0c2ZIhbsF9m1CLVFRB3lEed0AnijUDhowC3XgoZMlbS6OasJR+hLQbS3BWO5SlrGkA==
X-Received: by 2002:a05:6830:18d6:: with SMTP id v22mr998122ote.13.1565889901004;
        Thu, 15 Aug 2019 10:25:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 94sm1134475otl.62.2019.08.15.10.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:25:00 -0700 (PDT)
Subject: Re: [PATCH] nvme: Fix cntlid validation when not using NVMEoF
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
References: <20190814142610.2164-1-gpiccoli@canonical.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18251667-7b5e-789e-a1f0-78f3cbfe1b85@grimberg.me>
Date:   Thu, 15 Aug 2019 10:24:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814142610.2164-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pulling this to nvme-5.3-rc
