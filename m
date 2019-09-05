Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A7FC43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E256206BB
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfIEUy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:54:26 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40211 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIEUy0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 16:54:26 -0400
Received: by mail-wr1-f46.google.com with SMTP id w13so4301724wru.7
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 13:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZllE0gIBJhpo05kcIgz3B2wrvprdqJzTT5m8KUHoNB8=;
        b=ARHSRJe2T4dC9y8eDSOlqkfbkzCmV2B1IOYzc3C8QnW0E/55/1ArO7YFp7Lc0eBphS
         AEUQT9Nzy4CAmNtcKtCBNvxecL9aCI6XugnzGZ5Tbg+6QN9/dhilOlpLAIT0iYrkY+1K
         aWOQIMeuXg2fkMJtLAzZMh+a+4GF32QKNegacqitvfHJQna8CQnb744cBcSbFeJjYMGZ
         l6BXYB+lUiGHDfq6PfVG6XH0F6bCMjATCOXjr4JhYuTSn+tSyIgdncB1seTpmDaVPsyS
         LkybkHMU0MzE49ADiEvcpbU90TNUe2vMMfOiiyloHfVb6kiIqFV10EW+nNEUW4+Ciglk
         guuw==
X-Gm-Message-State: APjAAAUzqDxaCCMHKq19yvZMOsDnElnweptMZvSsgsqulAKeeX6AuaJY
        IPxpTh1LQvqQ96OixzXvndg=
X-Google-Smtp-Source: APXvYqwiBhJHRNM263x1v6IXqCmw3woJ3rBTFzNpWREjsOeG8Ud+Dyku0ZqxeRKaibBKJHrqGliW8g==
X-Received: by 2002:adf:f186:: with SMTP id h6mr4116341wro.274.1567716864631;
        Thu, 05 Sep 2019 13:54:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x17sm7209495wrd.85.2019.09.05.13.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:54:24 -0700 (PDT)
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
To:     Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Omar Sandoval <osandov@fb.com>
References: <20190905174347.30886-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2b48ae83-77ff-9235-83b7-98469f591c8e@grimberg.me>
Date:   Thu, 5 Sep 2019 13:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905174347.30886-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good Logan,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
