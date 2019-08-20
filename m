Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55E2C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C5922CE3
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xC/bqvMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfHTPfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:35:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44969 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbfHTPfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 11:35:12 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so13023023iop.11
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDLheKP6pGdQfFEeB4dyMPXQqCp/tXAIcEa2C9CtwRg=;
        b=xC/bqvMRmPicB0aCaUMSBRrAXb2Nm+wZMFmPlr0tjDAIMEW/2sAnrVBjEvboVJSsH9
         fHkrGztAVyhHHrDvyegww5R7bN5F+6t8qWrQtIdF9FY/Sjen9mVQoA6QFS7zb+KM6YhY
         D3pnk6076y8t7kLZ0lMTaB4Ox2hfHDM/1VZ4RJ05sM2EHTFuXAcju7E68IUBTUSySof3
         UAL/VsAlf5y/gosIfth7eeRGHEI6N1/Pa4QN1aZ7a4kF1h1jxxu0l17VK1ZktSrd2Ff/
         qxTBTdJOVTsiFZ86xAbDs25icv+EStK6AdwGC7bAQJ35UoJr5ne7a0EPS+BkwIFGXR6Y
         2ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDLheKP6pGdQfFEeB4dyMPXQqCp/tXAIcEa2C9CtwRg=;
        b=d9mWimQZrFOudRMfhn4e0RwCf6+fqhyDcDW56ipcdc65+W8jqpQWg5048QkdkQtdOo
         ysXREDlghiBICLlwTdTCu4A0RhdvhSegEbiYra0Ezwe+xGvu07sP8rS9Ki34JjmuzEbQ
         j5p/tzWXZnfxsgJwvdkyEnWxIdTT2RWc0NZalR5rNDL21Ue860w0GcP4QYalRbfS5Dmb
         UOUx1oRNqQeq8xGTuINUvqNnxI+z3B1bFsSSg13VZRkq83YYcCwGVBfu30JettluaKLi
         TLapRSRYMUAY3vWWOnNfEv5L/tII/N/zptoNLayjsVxWOPz4UNp6kY/kDWzstjjg2Bfz
         pY5w==
X-Gm-Message-State: APjAAAX/cblu5zZ22qHXGpOBHYSW0l2OLzq69fXoXBXQsH2LwX9kSLsG
        +SK/7/hjDK7QtO5GjoiK+X+faA==
X-Google-Smtp-Source: APXvYqx1tMaTMjVdog5AZ4klO2jUQwzDhmH8+fDMxgGw0oQrLy/41LqimRPj0pD/TdP1NQUqTosi6A==
X-Received: by 2002:a6b:2cc7:: with SMTP id s190mr23753210ios.164.1566315311367;
        Tue, 20 Aug 2019 08:35:11 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w5sm23799041iom.33.2019.08.20.08.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:35:10 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] block: sed-opal: Code Cleanup Patches
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
References: <20190820153051.24704-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a4299af-2310-b34d-7129-90ab592976fe@kernel.dk>
Date:   Tue, 20 Aug 2019 09:35:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820153051.24704-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/19 9:30 AM, Revanth Rajashekar wrote:
> This series of patch is a cleanup for sed-opal in kernel 5.4. It
> 1. Adds/removes spaces.
> 2. Removes an always false conditional statement.
> 3. Removes duplicate OPAL_METHOD_LENGTH definition.
> 
> These cleanup patches are submitted with the intend to submit a new feature
> after this.
> 
> Changes from v2:
> 	1. Added reviewed-bys
> 
> Changes from v1:
> 	1. Fixed up commit messages
> 
> Revanth Rajashekar (3):
>    block: sed-opal: Add/remove spaces
>    block: sed-opal: Remove always false conditional statement
>    block: sed-opal: Removed duplicate OPAL_METHOD_LENGTH definition
> 
>   block/opal_proto.h |  5 +----
>   block/sed-opal.c   | 49 ++++++++++++++++++++++++++++++++++++++--------
>   2 files changed, 42 insertions(+), 12 deletions(-)

Applied, adding a commit message for patch #3. Don't use empty commit
messages.

-- 
Jens Axboe

