Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3141C83005
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 20:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjFGU3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjFGU3C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 16:29:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700226A1
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 13:28:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6584553892cso977039b3a.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686169718; x=1688761718;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1NtfRKLBxewd34t5Gh6CqfpKexDHoQxzpKbSXODOss=;
        b=hpH8J+RP6Lx2aCaOgiVhXeFACjtdhhQmTUYfxAHMCF+wJ3p2S2tMcmkixOxxQpDWTO
         e3rGDzk+QEIzH0pfJGC3LM1e0YI/l7Jcp5l5MRb1P5MjgBq38h0dtJSS4dpW18bYDzjA
         BdK6z2QXlcrO0sQ3we+AuWjuEL/KPmT3nSil5wDyzbwdZfE/2hZ1Mll9BjH+ckTvxe4m
         oLKQGHnZ/cbg2Qhhijkeez+vSolIVI8VXNT/YzqhFdvO/u8pGdcrozv4ULslU+6VKGxP
         vXg088Ig7qrznPB58ztwc1JZ/ZmDRYczE7fmjWZCqtQp0HXUiENC5hfy8NazPBsBnw4T
         cA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686169718; x=1688761718;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1NtfRKLBxewd34t5Gh6CqfpKexDHoQxzpKbSXODOss=;
        b=HqJlsbM5h/5NSBqmwhRXHr5P3MAcOU/5W2vYRWpXIIMKGF4ybFgauGq2tz8AAPoURi
         62IWFeVtv0ZC2ZFTR3UJm3+DoEe315Rls9gyyq9Xs1UGFNUhf9D2kXsQ751gEs5tE/fM
         aUBuoHlRo8eJd94AgUKhEL7mTlJyUBZ44eTWK0G/P2OER4PAaDoPZG48dicWEARxjsw4
         gRcOzxeFO1G8l3Q/Wv4MkDWnTRwImdw5ganEuNUfMkm02eYzECUBd1oKg54kVXYl9fij
         tbGgLbozz3n/gyuDsiR9BDOsWoREqgn1fUblJUZglR0O/jZkA8VM4OmotPOHO1pgxyP+
         BO1Q==
X-Gm-Message-State: AC+VfDyJgESmp/vGjP3oqeEXLleKLRibqwA0LPmSfVmsdYnADh0eVNqJ
        iE9W/jx/22dQBquWzehZuA7T+PrUwSKKaeSVGAY=
X-Google-Smtp-Source: ACHHUZ4U2oYKGpIcb8vlY9R5t+nDeGtzp/Blv5niP/qS7WsFMO8inGOI4BMBYdCMMh4UXRRgY/z2PQ==
X-Received: by 2002:a05:6a00:2909:b0:662:a9c3:7b84 with SMTP id cg9-20020a056a00290900b00662a9c37b84mr1578756pfb.2.1686169718218;
        Wed, 07 Jun 2023 13:28:38 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::2:9b70])
        by smtp.gmail.com with ESMTPSA id fe16-20020a056a002f1000b00653dc27acadsm7828231pfb.205.2023.06.07.13.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:28:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/9] pktdvd: Clean up the driver
Message-Id: <168616971619.107466.374645634630337878.b4-ty@kernel.dk>
Date:   Wed, 07 Jun 2023 14:28:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 10 Mar 2023 18:45:40 +0200, Andy Shevchenko wrote:
> Some cleanups to the recently resurrected driver.
> 
> v2:
> - added tags (Greg)
> 
> Andy Shevchenko (9):
>   pktcdvd: Get rid of custom printing macros
>   pktcdvd: replace sscanf() by kstrtoul()
>   pktcdvd: use sysfs_emit() to instead of scnprintf()
>   pktcdvd: Get rid of pkt_seq_show() forward declaration
>   pktcdvd: Drop redundant castings for sector_t
>   pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
>   pktcdvd: Use put_unaligned_be16() and get_unaligned_be16()
>   pktcdvd: Get rid of redundant 'else'
>   pktcdvd: Sort headers
> 
> [...]

Applied, thanks!

[1/9] pktcdvd: Get rid of custom printing macros
      commit: 3a41db531e5124adaa3a9ab9ca0c724aee85b10c
[2/9] pktcdvd: replace sscanf() by kstrtoul()
      commit: 1a0ddd56e545b743af510b5a1b8dbdfe7d35cd3b
[3/9] pktcdvd: use sysfs_emit() to instead of scnprintf()
      commit: 3bb5746c26cdfcc354af4867c02f1e0ec1131a62
[4/9] pktcdvd: Get rid of pkt_seq_show() forward declaration
      commit: f023faaa988671f0f1d1a965dc5d7e61d0f5e65e
[5/9] pktcdvd: Drop redundant castings for sector_t
      commit: 93c8f6f38be67e30adf8d8eb5e7e9ccb89326119
[6/9] pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
      commit: 80d994d2a71f88e0809dcaccef2259c791d2e3ef
[7/9] pktcdvd: Use put_unaligned_be16() and get_unaligned_be16()
      commit: 046636a4bac575aff78e44c7e1cff84c83a345a9
[8/9] pktcdvd: Get rid of redundant 'else'
      commit: 6a5945a8eb5a626afe6feb341824e7e1d007c8ff
[9/9] pktcdvd: Sort headers
      commit: 7da15fb0318f18398feea2848d099a8d0d7b5965

Best regards,
-- 
Jens Axboe



