Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8263CCA47D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346948AbiFOVah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbiFOVaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:30:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C356562D0
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:30:34 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h192so12540882pgc.4
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=gj8zUzDSKIR2PtxM/UZSWlhmSPN0w/aiFm/JeXggx3M=;
        b=weZbBbUSK+6ocvp/YzFFHERgkjbmlZTADEbrz1GAxTVzxSC0U49PCdEOH6oQqf7vPz
         nnHfHtXXNUDmyBx+yThH5CR4nybHplJAsV0CqFWV/6gMaSaL4qy+qeUGgvujL9s2yaWK
         4F6Uc981Rii/LasC0DFpKRLwmglkSD+vTqFfpdHMk+CQ7Lth+H7DzmI4llkqjDALQutO
         g/FQ6ChGc1D71hkvXTzI8me3/McOdQExjqL6ujqiWcUPZDRGGn4hoZO8oXDvSXwEU3L2
         6iKQkcF2xrS7xqRwL/WHHo3p0pIG/NlpMPnXukfcAG2XpyKd61H/Pi8VXAduwxBymBg5
         OGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=gj8zUzDSKIR2PtxM/UZSWlhmSPN0w/aiFm/JeXggx3M=;
        b=gIdPbwyy27ijDaLm1U2eQpb3JWGOP6/A8LAxJs/rMb78UpxxVWmadBuDPEQHK9jSbV
         K3jB1xlyyBdcngctinzFJkSePJ/CGZWd0sf9yYApr9zfQJRLj+CQ2TzUYpUJk3qgTQNf
         ADC7La8x5RvriW4vHTHMqpV0QlLxl9WdxhTXslMz9jbMwl8pQx/pQ2wwuofWL6UHHxEq
         HfWvyfa2hHUqEjZ/JTcJRcaPXbemtocmQQ9W0MmqeYTnDCxZorSrdFlIDR8aMrDqWbhL
         pstqajeMkRof9Nfva5VicDjw8JEJWUeYSrlGUxE1OC56Yt3RevFNehx74m2AiiHb32xB
         fOAA==
X-Gm-Message-State: AJIora9Iiusd0Gg6dlaugEIUuiWysjpkARxYkm40y3SLAmptAKJtrToJ
        wZPYY9pJS8fEP25WKLpFtJPb/rR57HOECA==
X-Google-Smtp-Source: AGRyM1v0IMTmN8GOvRn4uNva8PDhOEex3sAELCaW2rWI3VxM7LPVY+4GwPMUV/TKADCMwWmQqaUbnA==
X-Received: by 2002:a63:194c:0:b0:408:a9d1:400c with SMTP id 12-20020a63194c000000b00408a9d1400cmr1544266pgz.559.1655328633528;
        Wed, 15 Jun 2022 14:30:33 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id js12-20020a17090b148c00b001e86be34c98sm2313057pjb.13.2022.06.15.14.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:30:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     liubo03@inspur.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220615081816.4342-1-liubo03@inspur.com>
References: <20220615081816.4342-1-liubo03@inspur.com>
Subject: Re: [PATCH] block: Directly use ida_alloc()/free()
Message-Id: <165532863283.858456.2064903368423247771.b4-ty@kernel.dk>
Date:   Wed, 15 Jun 2022 15:30:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Jun 2022 04:18:16 -0400, Bo Liu wrote:
> Use ida_alloc()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> 

Applied, thanks!

[1/1] block: Directly use ida_alloc()/free()
      commit: c13794dbe936a62a9b509ece1423a59287b9c80f

Best regards,
-- 
Jens Axboe


