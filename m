Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F2C77B78
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjDSQ0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjDSQ0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 12:26:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106803C15
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:26:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a69e101070so272635ad.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681921570; x=1684513570;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nk7DukEHygBF7OfEfeT7+bd9dAHf3EkU0v+mFpmuK0U=;
        b=PG/jw+jbMIX4jeVZ/8fFajT33zhqZYER6WeVKRCY1HAjgn9q5JCSVtA2s0fU4wwEiA
         owwgtznZcutgrEyDoPhQLHl0BmL1bnV/3PmeCS/UVGptChxeTbJyIG35n6CjZI5I7nf6
         2Qoqf1XiizV5RzThNdSP5B9VXNJ4EcjhIGPwGWQpOzHnqLp9rlYZLu1t/AoBvybkEOoM
         Ct0GpRt2oqfNbQjcm3Iky+eGmRIFW6KgB57w3NVrTylpb34NghYLYiZ/HjIpJpbpGFDq
         Is8OAm/0aIfGCaTuV7bOWACWmNvibRjn25GZldYth8JHmqhp2W7U5aOtOcwkIIqOyBHo
         hZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921570; x=1684513570;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk7DukEHygBF7OfEfeT7+bd9dAHf3EkU0v+mFpmuK0U=;
        b=Xcz0EibSJirRhg4FR0YP5reqI6Kdha2d96wLcYlmvrh91XQWYo5DAtRwbdlmPlowSG
         WxXkia/6q5Qfi7qGQ2tRkVuVXrkpHyONgQbW2gtWazr1Nc/2fn/kfFDg2+QWGJuW8a2g
         pczwFgE1HFQtmTDgD1OOFDhUKzXXnXRCzWNvCNraqFfNlb4t4jZLT4HFM46q2WhIyDfV
         nUNwcKVrlS8CqbhoUbU4d5vEsLmb+1GbYBWUJ7rGsW+lno/pvzyRFlsYH5YM8PYGyAq2
         k+t/4uuhg4gifu3TAih7buhOtMHmBSflERIpGWxFUmigEvnzAHKAeiRnrt6Gab9K71pt
         FnEA==
X-Gm-Message-State: AAQBX9ct9/th9+G/NEcJ5UlCXyQVhbBgfj5f0/2S5y9VbYDgNASaSD1R
        2L5B2+6Y6Zm2oVffk5K8UAdTtQYtpx8t/q/I1jM=
X-Google-Smtp-Source: AKy350bTs4nCNjXuRYVnpnVHV4MTvqxiMoyA1U0OkEC4Due/rmR505gz2EAb0PKuF0isuX8yfdIogw==
X-Received: by 2002:a17:902:da91:b0:1a6:5682:af48 with SMTP id j17-20020a170902da9100b001a65682af48mr22701362plx.0.1681921570245;
        Wed, 19 Apr 2023 09:26:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ea9200b00194d14d8e54sm11627903plb.96.2023.04.19.09.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:26:09 -0700 (PDT)
Message-ID: <3652617b-c977-05e1-6798-7926aabdfd1e@kernel.dk>
Date:   Wed, 19 Apr 2023 10:26:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET 0/6] Enable NO_OFFLOAD support
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     luhongfei@vivo.com
References: <20230419160759.568904-1-axboe@kernel.dk>
In-Reply-To: <20230419160759.568904-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/23 10:07 AM, Jens Axboe wrote:
> Hi,
> 
> This series enables support for forcing no-offload for requests that
> otherwise would have been punted to io-wq. In essence, it bypasses
> the normal non-blocking issue in favor of just letting the issue block.
> This is only done for requests that would've otherwise hit io-wq in
> the offload path, anything pollable will still be doing non-blocking
> issue. See patch 3 for details.
> 
> Patches 1-2 are just prep patches, and patch 4-5 are reverts of async
> cleanups, and patch 6 enables this for requests that don't support
> nonblocking issue at all.

Wrong list... Just disregard this patchset.

-- 
Jens Axboe


