Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203BCC352A1
	for <linux-block@archiver.kernel.org>; Sat,  3 Dec 2022 16:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLCQ14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Dec 2022 11:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLCQ14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Dec 2022 11:27:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD5E26DC
        for <linux-block@vger.kernel.org>; Sat,  3 Dec 2022 08:27:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g10so7254408plo.11
        for <linux-block@vger.kernel.org>; Sat, 03 Dec 2022 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFhsulPsPHvOyONkpTyQ+xbocqKNoUqhz2MWHZ1fQoM=;
        b=HCV4bo6pyoFwPnLnxUrE4+NQmiEIvSzc38MWSU1F/O+3k3vreVhIfDjfXwbMfOg0Qj
         +IPcbiQfIU7NWl+vN0iiSASnjXtNhDGBZNpx7jZV9d20OqP+Lmk5bL+Bu5xrRbW91Yzr
         SMI045jHxPND23hM6R8N5j1DX9YOTAUxz/WcMCewEcsafxten0ifedj6ZTD/CCz09TK+
         DefvvjJCUnmaCM5igfODJrKqXssU0SO7FfrSxPWIQV2t7uyEm8iY8z3Jd4X42Tx3Hod6
         kMTGsi1bSTJOcKmFmxkyRkNdkAUIfwMCb0Dhh/fw0UjqnP+x0IeJzheSb9Y0lY+Znyj9
         9MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFhsulPsPHvOyONkpTyQ+xbocqKNoUqhz2MWHZ1fQoM=;
        b=Pcbqi7QUxNV9b8tJay03Dsu4ujsB0ndPNLCdfabyN5Xo6HRADOaF39Oq6UYrfq9CrJ
         Ueq8kQwKy/LNAchMGXn1fuaapZHmAUq6E1VmKJ0Z+AT3EjROV5EFBn78fNr5IqrDITph
         bVxUS990MFP2XKUQyYSYymjlq5MWqYyC2HyFXutTg+owN+c5yqjb5NZdV1yFG0NObCv1
         Lmbtfps20YmWnNUHJFrGtLt+ZHs/YHXnqPU+77S9O0fb5Br3BrsCTdPXqjy0VAQ1sIWR
         e8YpghrQtkTzUJgXvoctwGdT1Qr1hjmWa2w1/XGVVgO1R4VSw7A3eers0g9pcT3Bs1Rf
         dEXA==
X-Gm-Message-State: ANoB5pkPbgRmFnU4gM34RntxMSBmnznHButs+4fwcSm4Us+Jge+DguRn
        42lpXhVxKReUCiTn+06Vsc9u1A==
X-Google-Smtp-Source: AA0mqf4l9Gq/NyriF9XNkJYHsltSulsw3feL9iCauzAUehTiMaovPc+hql9CG/b5bLj8iK9/iKEEAg==
X-Received: by 2002:a17:90a:440b:b0:219:886b:9155 with SMTP id s11-20020a17090a440b00b00219886b9155mr9592082pjg.167.1670084873536;
        Sat, 03 Dec 2022 08:27:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b0018980f14ecfsm7658119plx.115.2022.12.03.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 08:27:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221203140747.1942969-1-gregkh@linuxfoundation.org>
References: <20221203140747.1942969-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] block: remove devnode callback from struct
 block_device_operations
Message-Id: <167008487227.998221.5510218779438847268.b4-ty@kernel.dk>
Date:   Sat, 03 Dec 2022 09:27:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 03 Dec 2022 15:07:47 +0100, Greg Kroah-Hartman wrote:
> With the removal of the pktcdvd driver, there are no in-kernel users of
> the devnode callback in struct block_device_operations, so it can be
> safely removed.  If it is needed for new block drivers in the future, it
> can be brought back.
> 
> 

Applied, thanks!

[1/1] block: remove devnode callback from struct block_device_operations
      commit: 85d6ce58e493ac8b7122e2fbe3f41b94d6ebdc11

Best regards,
-- 
Jens Axboe


