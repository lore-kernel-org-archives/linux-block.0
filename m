Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06393C73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 20:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C412D2166E
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 20:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dgIPp7dT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfGIUfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:35:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41654 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfGIUfx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 16:35:53 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so26704076ioj.8
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2019 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4pxG1ZYSx2dIuXVzQtCTrGDL0o/YKhhWIjq9TfXU1E=;
        b=dgIPp7dTLqn/bPXw+FoO1qAHhuET7InfYp6VMrGIQ0eW8Pz0zf6CKDG5PI38nrasen
         vYqme4kCgLmdmpKUl+ijBz4928fwqq0eXrF2IuC/IlTCo38oaKicQvU0Xa9Z2lgYcdrO
         Q/u7ry+CT6pDHilngTS+DU0qaYVCXbhS8gAI3ZgoV7eSUpJdgu5gyz+XlgIUHLE+UEfW
         IiGqUb2penb/GCSs5/O/oar9IkT8Pb2Z1FnNcXkORvtrcPiySGijk0tR8zmKmuDj8+od
         vVJbxkg+IND4dM3x+2kmJDveH94AFxxlzme1rXGIN8aZxRyGl4W0fsZiUVLs4zidG4dy
         Sa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4pxG1ZYSx2dIuXVzQtCTrGDL0o/YKhhWIjq9TfXU1E=;
        b=BF8B6XPpjcIn5KpPoOmcW18XEmAR7x8ilES73uNQuXincKbtAlWdOUUIACaWIPu84n
         1Z7qGmsUf8v6s4tH5rFMSBzDZ+Xrp+ulf8aZJNwuebGOzOlsEBD++BbCFjlRf85CVaD3
         NeKM+hkwZjaIMOkh3BtsJBdmQhDoj365zNBhSb1zS1Y8eLNo5GO8CKpH7K87MebN9vIl
         XXa9fSIaiM+72cx+Vtb8jlfQA1S+P1W3TCPSV3ylPd7vc8eqwYDZ6gA6wBUjq6i4YlTC
         O+PLjk8s5Zl3nOrhXrKNZTx84bk5hoa2bSjNiZsVApQBg5NOKdMMKcPODbboeijcapKE
         0+8A==
X-Gm-Message-State: APjAAAUlm6sAd3an1oSDruq6UzrpNINDqKvnQET5cdL7zrIIynUSrO0G
        ryVep4OH1CrIAfU/NxxVWmnLn9KDMFDHVg==
X-Google-Smtp-Source: APXvYqwjO34qDS1yZ9O4v429raTP9QO4kaXAQCm0aBV+KUzo3BZA8r0MRa2X3IB5pw6vSgHj0Xm67w==
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr21181181ior.231.1562704551910;
        Tue, 09 Jul 2019 13:35:51 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p63sm22897849iof.45.2019.07.09.13.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 13:35:51 -0700 (PDT)
Subject: Re: [PATCH] Add regression test cases for kthread stuck
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190709012527.1816-1-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87cacc33-0e77-c92c-8cdc-3d7d9c24aa62@kernel.dk>
Date:   Tue, 9 Jul 2019 14:35:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709012527.1816-1-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks, committed as:

test/a4c0b3decb33-test.c

since there's now a properly upstream bound commit for it.

-- 
Jens Axboe

