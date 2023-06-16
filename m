Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E339EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 21:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFPVsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPVsP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 17:48:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAB1993
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 14:48:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b50a419ab6so2613015ad.1
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686952094; x=1689544094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8j8JrHWHG0dyB/Y6Y8tKCDtvtcnvzyiYePhEonun9g=;
        b=pCWNDc8zZqR1nRTFmju77DdnuLb7TAtowVtlzumxk61j4hAjRiq888HFq7X7gb5hTM
         F9x2kxTJiP/e1LyA+0dFfZgacZwKv9t7L6vtDdr0fkVuMpC4QsOQX0LFq8OC1X01qhMw
         cxjOQQrZlUHDYLyaBrb/HG4uMTS63QYB1vYVAsNrxrjDHzC0ohAdLXJmtLgKsNiirSdu
         L2QVAY6wMDihCXEmyNHh4NU6ohD+ddR57oqBQutjw0Qd+YMS2C/CotKGjTiFFQO595xP
         BDNnhjdaJTlYuLvm6vxH7imqFp+ai4aXNEWdCrKoOkAl5XNXccs3ytWMzCrh8/BuwA1C
         UKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686952094; x=1689544094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8j8JrHWHG0dyB/Y6Y8tKCDtvtcnvzyiYePhEonun9g=;
        b=bKCjvBG2CNM+lTcjNEZuGzz9pfkmMAHz1rHJRV6RrlEJ8AnX+2T0lbX5E2cbOQebsX
         dHYYEX04YjrmKyA+LBRCfEo+jMb5UKKMY28zXT5Btr0rwaEPNvOaFrofjPvmTLOa/aDY
         VedvXuOEo2hgtUeUoICeZ+XzlJJe5PV6nXORX8V/uWy+eZw/RPMA94P2ZgSmFhO0bZ/3
         tolnJ/e3YCp3volMQxZ4/h1NaJwZkh6mjMqwAwze4legKgq0aMSnrT5+upskHA/kA2cE
         b+JjrZVYKW02paSItptGegaANzMebL162bwSSxwdqBflH1yfCXCKVMtQ972QueCbOAni
         zopQ==
X-Gm-Message-State: AC+VfDxUppnozCZu8Tvm3Sh4MZ4V5NeqaRqKGhuUFL63VaIVSybT51yY
        xuxeAHN/H0/3SMwG+1+Lr0WSMg==
X-Google-Smtp-Source: ACHHUZ7g3pkU8hkuHpRvEU0LQ29xAnYaMyVQ+bLLs9bTQNEWM9/rR02pWUbVMKuEZZv0ClyZeb7KBw==
X-Received: by 2002:a17:902:ea01:b0:1b3:e842:40a7 with SMTP id s1-20020a170902ea0100b001b3e84240a7mr3653544plg.1.1686952093948;
        Fri, 16 Jun 2023 14:48:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b001b3fb909f73sm1951034plb.112.2023.06.16.14.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 14:48:13 -0700 (PDT)
Message-ID: <e5782494-1a57-819d-d790-13f2051c4714@kernel.dk>
Date:   Fri, 16 Jun 2023 15:48:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
 <20230615041537.GB4281@lst.de> <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org>
 <20230616070237.GC29500@lst.de>
 <d0dce017-390e-301f-1c85-0970c91ed80d@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d0dce017-390e-301f-1c85-0970c91ed80d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/23 2:26?PM, Bart Van Assche wrote:
> On 6/16/23 00:02, Christoph Hellwig wrote:
>> But it seems like no one is insisting on using it with larger than 4k
>> page sizes.
> 
> The Android common kernel (ACK) team is working on bringing up 16K
> page size support. This involves kernel changes and also changes in
> user space code. Once 16K page size support is ready, I expect that
> more users will ask for 16K page size support in Android and also that
> more users will ask for small segment size support.

Like Christoph said in a previous email, gate the 16K page sizes on
hardware that can sanely support it. If it can't, then it runs 4K
kernels. Nudge the vendors to ensure what they deliver comply with that,
I believe Google has quite some pull in terms of that...

-- 
Jens Axboe

