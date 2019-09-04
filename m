Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8AC3A5A8
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F6321670
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfIDRtQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:49:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfIDRtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 13:49:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so1015676pfb.7
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 10:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bXjlaA+cJTDpBVthjWSEhfdyBmu64WqVPQD2IzEDFds=;
        b=TwqyGRhEihDRKofkmS7NN8IhVvg1YqXFjJuxuxIYaBAvRZx3YlCDCUibPBYyxGFIQj
         zkVf/cnJduQuappGqfcx7XepkUS8gyfrP08HbVWmJ/WFS/fA2GGO7J5KePD0lA0fv6sE
         8dacvRxJPNMWUXudrGu6LHHhuOkZWUeP6FYb1CboUpOiWlxbrOnwOjmPbdW4xlVOFfKw
         /BvuFWp6MvZ5jzzQ0kpTzvT7vTsHZ7FrH4v9JcGqqdlOAkZACq4d9smyBNu0eLploTkX
         ilKamqgV4OK3BD0BmU4ZcQO3dKk4WtNOCDpKWDoTp/SCAiPpevtNuI3c7sbwfSKDG5or
         9nNg==
X-Gm-Message-State: APjAAAX5J10mbT9WyntR/vcKqtykLEgD+EZ8PZeCj4Bo1fGX0PiUylYC
        5fUXYPivt6LWyRSw4kfFTHk=
X-Google-Smtp-Source: APXvYqxccRPpld0d1hn+tS5K6QNf35w6UuU4NxDkC5OUHgiwyvDkqFUEtkpLaoOwS8eTLclTGSVLoA==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr6250486pjo.119.1567619355315;
        Wed, 04 Sep 2019 10:49:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i74sm11432392pfe.28.2019.09.04.10.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 10:49:14 -0700 (PDT)
Subject: Re: [PATCH blktests 0/4] Four blktests patches
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>
References: <20190808200506.186137-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2e2e3abb-1420-7743-eb7f-cd9744d36686@acm.org>
Date:   Wed, 4 Sep 2019 10:49:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808200506.186137-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/19 1:05 PM, Bart Van Assche wrote:
> Hi Omar,
> 
> This series includes one improvement for the NVMe tests, two improvements for
> the NVMeOF-multipath tests and version two of the SRP test that triggers a SCSI
> reset while I/O is ongoing. Please consider these for the official blktests
> git repository.

(replying to my own e-mail)

Hi Omar,

This patch series was posted about one month ago. Feedback about how to
proceed with this patch series is still welcome.

Thanks,

Bart.
