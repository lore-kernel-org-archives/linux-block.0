Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AECC352AA
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 03:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70883215EA
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 03:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jkoz62P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJBD2T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:28:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39076 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfJBD2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 23:28:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so6531685plp.6
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9gxpnvG1R2kRDmSJI+VyImXLH+QIOCaT7iUh4KHWjOw=;
        b=jkoz62P4haud2r8VmKtfK+wjAPS2w2pjVbHfcaOcfdxFR6N+/9Y/URWTGPLCxRu8BN
         /kgyoSlLtkSOKmaIr6x3gVHV3nQ96DA0H4SfzwW2awRb5v/7Ggei2FUIseB4RvgljzxP
         E7oYLK24GeOCZ1bLOkwLUly4iGaDkm7+FMOM8zc0I3b37jp7iLFFjkh4aFmQHgXjzC6b
         eWrn4v3QItGosjgfqjMdlheYBIhkk/hn5uvVclNdcnHRDFC9WtxcNzfFIbqNtK3Ljt3h
         u84lbu+PjbcoEBmxaAF1xq3JqY4hqM0g7HyJwqSmIPVJvDOrWIjpbMQ6s3uIXtriYSlm
         h4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gxpnvG1R2kRDmSJI+VyImXLH+QIOCaT7iUh4KHWjOw=;
        b=TIQ7CQKPvAP8i/V7jqQCGxuVbLjV2/fTgqM6mp0DLlkCWa1PUvkyDqeCPk4tDX9uue
         AMtpQ0ouYkhyqT867TneES27md2rrAFkiW83Z4dIVXU/yh7kpbztlty/Nm2zHRs4gZBh
         Uqu6wrZulaQsObq0rm96Db7R5W0+H7plJyj/wALtgxaGZn0FAnPlpMRtktbxR5cySR1T
         qS4KNBm117NXqPlXxb6XJKkHqP7PF1ikqqBdy8O6Ml4CpcRrNFFtp9OG47P/bnbfxAGh
         3Tv0LM1yFDJAe8h4R+IgJNQdzbESAxABzIzuMz/1yUgtxmoMGOXN1GLDkBQItYeox3RB
         pkfw==
X-Gm-Message-State: APjAAAURJBSeiRpnsA8mee2mEAh+MWvQlRyhZSTDycT1g+GnhQ9pRgs5
        Rl2FpuNRk9xM6O9eUqOsNQqawA==
X-Google-Smtp-Source: APXvYqypw/tQS2x3FmpPIZ8L8z3lCpHRYCN9kAVjyJSamfFIOvJH+YOdGP0KF7MnrXSjmNSmkepSaA==
X-Received: by 2002:a17:902:7610:: with SMTP id k16mr1322806pll.260.1569986898738;
        Tue, 01 Oct 2019 20:28:18 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id m68sm16805904pfb.122.2019.10.01.20.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 20:28:17 -0700 (PDT)
Subject: Re: [PATCH 0/8] Block layer patches for kernel v5.5
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190930230047.44113-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <69b55a10-922f-dded-993e-f079792b5356@kernel.dk>
Date:   Tue, 1 Oct 2019 21:28:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 5:00 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series includes the patches I prepared for kernel v5.5. Please
> consider these patches for inclusion in the upstream kernel.

Thanks Bart, applied.

-- 
Jens Axboe

