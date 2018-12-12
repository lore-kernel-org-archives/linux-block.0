Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617AC65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007ED2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 18:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007ED2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeLLSFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:05:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36002 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 13:05:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so9243118pfc.3;
        Wed, 12 Dec 2018 10:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=46AtSObweSY7j0HJU3ot297ZA0znEqkuZ34+vdoYrZE=;
        b=jhrjOMWWWCPYkYOfUL/x3hrweZ3WV8jn7UsdSKahgOulupvT1mWje+FnJPBcV6iySL
         5mNknodJb7ZxKPF5v4zOABKA+/wsFjPDo957mQ26r6LtD+z0eAqERlPYxXDKdpMver/I
         UYZI8kFJ0HWiY4c8tkh0+ZC0iZ+dOQBGaFWwq1ZJ9NfY8uRIcQgSOB1g9nnP1ZCwwyAj
         r/cCEldKYUnmXvIihWxAVHA2M2X7Y8nlzBO0ZbZfyvXi3XKg41QIIHOGvjMQIgpc9RPo
         J1S7D5RksBRHjcuN3iDgipDP6WoCebbxW7WxvjRM17t3XYAd3G/xN6qsKvFTDFPbrY4J
         IBFA==
X-Gm-Message-State: AA+aEWYmzUju4mg27Djlqfta3sgPx4WCP+H3EyNL88blbHXsPRVVDrQS
        HPJ2yipWJbR+5kHkBXD01+Q=
X-Google-Smtp-Source: AFSGD/WUNWG3Y1FN+9wuGoTKRjKF91DsaB+BQFFNYFvq/tpFgRWOZpjkljwHfeNzot5jdX2+ruhf5A==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr20885487pfi.44.1544637915412;
        Wed, 12 Dec 2018 10:05:15 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id w185sm23981808pfb.135.2018.12.12.10.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:05:14 -0800 (PST)
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
To:     Steve Wise <swise@opengridcomputing.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        'Christoph Hellwig' <hch@lst.de>,
        'Keith Busch' <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd50927c-c72b-01f6-bad7-080076610cde@grimberg.me>
Date:   Wed, 12 Dec 2018 10:05:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hey Sagi,

Hi Steve,

> Is there no way to handle this in the core?  Maybe have the polling context
> transition to DIRECT when the queue becomes empty and before re-arming the
> CQ?

That is what I suggested, but that would mean that we we need to drain
the cq before making the switch, which means we need to allocate a
dedicated qp for that cq, and even that doesn't guarantee that the
ULP is not posting other wrs on its own qp(s)...

So making this safe for infight I/O would be a challenge... If we end
up agreeing that we are ok with this functionality, I'd much rather not
deal with it and simply document "use with care".

> So ib_change_cq_ctx() would be called to indicate the change should
> happen when it is safe to do so.

You lost me here... ib_change_cq_ctx would get called by who and when?
