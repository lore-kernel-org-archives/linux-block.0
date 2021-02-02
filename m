Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3521AC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA7664DCC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 17:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhBBRp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhBBRoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 12:44:10 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91108C06174A
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 09:43:30 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u20so8133253iot.9
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtD0BtUx5Er+Wsi4ZVwrP5AJ9In+NpH9yW0BLmuixe0=;
        b=bPV17FHWE0VwzkPPxZvIBGx6tBb0G+Rmuk2Gj3jqdZF4eNHK77gdFJLn6UGqO4OXWc
         QKRuR1OacuOQ/q1k9Ldj0NB0kQ6p4eNUPOBm6h2ck2MXlv7Kku1WKISsfD7EfRIqLw8r
         pAo/abXOMZQMIIi1L6MZbD+q7DmZaYxa14RCNglqoVW0Of6M9vdiC2E8YAjwINe8bHGo
         nOhe1Lsut9NLyJV1+tomd4FICxCP5Xof02/hxkGn7tfozrgSrbL5nPxwc9kkYS9Snx1R
         KNKHadH840V/otPcZ6+mZsyYD+ZcDgeOyXpBGfbfcRXKV6vWrza/z5PYPFjvU+fDKzmJ
         ak9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtD0BtUx5Er+Wsi4ZVwrP5AJ9In+NpH9yW0BLmuixe0=;
        b=bZTmGftiS38N+yplE4gilP7es3NNxpoaTxF+PQVMRe143X+8+1TxSkUIVn49PfDVks
         wZxNZa18hTGMtsS2TZPsOYwrDSG9Tmp3qL7GuwesDtufDaHFP2gDILSJx04wKuV35eVs
         Zba+RWNlc0DthvzBBX79pmIPfRRUnWYX2mOlkEDwJ7Xy4o6CKMDbEEoLY2XV6eBUv0Z+
         XPD1qXc4aNSv3Fc2fqegYF9iiPZKiL+FMgeXjmI7uvJO8w2hrrvfC9/jNlqZOX0hDYqg
         kuv6o4A41ZIqhLrd04cFb2tftdOECj2q8AtVXuyCgy6xavup6fKr20CWMJzYjI1RiHrS
         UhIg==
X-Gm-Message-State: AOAM5313kJV0ZKVMzQgp/uKKbmtY+SJJGRqrxrlgM2+7SAdDzqPwcvIf
        9DgGygclqo/pt/8wKU3INVgEgQ==
X-Google-Smtp-Source: ABdhPJwFaAqjyYVbXyS580/67bS1Dm10Mi9A92fvnNillmxqvI/0Sj5e534TqKGoRt5PFqhr25f0rg==
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr17823035iow.160.1612287809996;
        Tue, 02 Feb 2021 09:43:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x3sm610521iof.21.2021.02.02.09.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 09:43:29 -0800 (PST)
Subject: Re: [GIT PULL] first round of nvme updates for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YBkcYFf7hJfpK+vl@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fba2a647-1885-f508-0f40-e3968b005cbe@kernel.dk>
Date:   Tue, 2 Feb 2021 10:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBkcYFf7hJfpK+vl@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 2:33 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.21-2020-02-02

Pulled, thanks.

-- 
Jens Axboe

