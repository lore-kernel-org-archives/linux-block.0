Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E5C63703
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLHQUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiLHQUP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:20:15 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556D98972
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:20:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j28so1037224ila.9
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE3nKGrG/jnXk8dAh8ERR9wO29+XtYUm40qxdh+1aYY=;
        b=tZJhfs65g0BGTlq2P72wiy98oE4ezOnBD6EEgjc+1/5kAEi2wO+D60e4rh6s/qI6I7
         +AzZoG3WWMHmQoCcflM+i4f4S3f4e5vrf7XsAgnbsaXFkVMQQ2v7bA4bgoM3zwnIVDhA
         7S4rAPAPjaVpVOMWkK8/W3yqfK0tC5XIoDMpOleHhlj87qyEgqCjCk5qCC/ZP7qp1HO/
         qbLciYnufGSFJ+ODpdYwR/GtMJSOH7ekfOBGsflzI1hHE5USQJneKrrhwkY9vTcJSvjF
         /k6XYSToS8NTCRlO79z4ufUjbP4ij2IOb3P5k4FaMJineM3N+h7COIAUHqLU68iiI+vq
         qmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE3nKGrG/jnXk8dAh8ERR9wO29+XtYUm40qxdh+1aYY=;
        b=4/uHCCs+cXX4WwbSd/zLNgi2oVwusYo/r6tRspnZWHFWcpBhr4rwZLht2NAZUBBg9c
         vNcS2diT9MvCyf3xr3l0hqCkD6DboENnNozYvm64KHMFIKP3QSzkNbdDWWBdieN/jmeI
         NPFn0AlSDblQ9cRX65ihhB2UpPa7+IDMgjD3HLHmE8r++gjkCEj8fA8GsZRheO3zCya2
         SZNN7NBZQvmKtt1d1pdKjm28UxuZhGtI4AwB2CcfWH3WrY+1t7A2GdzWzJN0c4yusTSa
         vON7TCFBh5AyhFwP7gnEtxr10XsEe2NrUEerNeduXsNM3r7XQvift8DZfiym5h4tJkwk
         z18A==
X-Gm-Message-State: ANoB5pk47872RZQnH7j+9XPSrkQrdiK0MyHUHcPJFp3eeYvW4eWCeThd
        4JD7nT/ocQq163Q5ATVI07Uekg==
X-Google-Smtp-Source: AA0mqf76RgiQj3fkKhkHDoItWaEniiP9AT8wZfYPRv+g6TFQJPWd1PzxcGDo3WnBG/CzKIdfV8zL6g==
X-Received: by 2002:a02:8818:0:b0:38a:5560:60db with SMTP id r24-20020a028818000000b0038a556060dbmr7061160jai.117.1670516414751;
        Thu, 08 Dec 2022 08:20:14 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a10b000000b0038a5083cfa7sm3573087jag.88.2022.12.08.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:20:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, luca.boccassi@gmail.com
Cc:     jonathan.derrick@linux.dev
In-Reply-To: <20221206092913.4625-1-luca.boccassi@gmail.com>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221206092913.4625-1-luca.boccassi@gmail.com>
Subject: Re: [PATCH v4] sed-opal: allow using IOC_OPAL_SAVE for locking too
Message-Id: <167051641392.134647.7838460828463297928.b4-ty@kernel.dk>
Date:   Thu, 08 Dec 2022 09:20:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 06 Dec 2022 09:29:13 +0000, luca.boccassi@gmail.com wrote:
> Usually when closing a crypto device (eg: dm-crypt with LUKS) the
> volume key is not required, as it requires root privileges anyway, and
> root can deny access to a disk in many ways regardless. Requiring the
> volume key to lock the device is a peculiarity of the OPAL
> specification.
> 
> Given we might already have saved the key if the user requested it via
> the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
> key was provided here and the locking range matches, and the user sets
> the appropriate flag with 'IOC_OPAL_SAVE'. This allows integrating OPAL
> with tools and libraries that are used to the common behaviour and do
> not ask for the volume key when closing a device.
> 
> [...]

Applied, thanks!

[1/1] sed-opal: allow using IOC_OPAL_SAVE for locking too
      commit: c1f480b2d092960ecf8bb0bd1f27982c33ada42a

Best regards,
-- 
Jens Axboe


