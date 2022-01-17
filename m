Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D59C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 14:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiAQOYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiAQOY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 09:24:29 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55428C06161C
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:24:29 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id i82so21735305ioa.8
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=QnlVfGau/F7tZrXmAnNOwZCm2aBpNZJtPAdbXap2B9Q=;
        b=Hnn1u4Nhy6WmbGVhJOFNJ35nZpV/fua3WdbWMI73tb+kYpCujMzmHh6XpfMJ5KzOE1
         zsCPoZuSVIveBBCJWUtAeQYq9Rrb2DaIJuyC/OvfxItSq2Tu6ILC8sA32TkIm+OIuzIb
         jk36xVOARsEYsWVKP/k02/aaS09EW9L/jWaavEjJAjDWF3QxSw+y9kYn/otg3keknkBq
         QoiLbrvOnV2KZWdpqa35WJf4MxmJfd3z4Bmuv6FzHwzQnJSJa7Dht3grbWdIZeryHe3v
         K8ooJ/rPT1EtMOAjNr4TULKlRvSYLG2UFhGQPEzuRDhAMPKy0+wxUw+5n8nfk/zebfbS
         8NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=QnlVfGau/F7tZrXmAnNOwZCm2aBpNZJtPAdbXap2B9Q=;
        b=nYAz6rfITkHCEBVvDllLEsWIs4rg3wbPa6NHax5jtNX6bOdJjX+4x8UomIhHDlzeZt
         oxK+xFKLPTxKdE9Kxs/zcEh93/1bzpb736VLXoQYOCPzQyJO/bbP6xPN60rU8V3Q+G0O
         cCvqS3tfMX0cffl3b70n/s51ErMXKXGVFdjgjbCIVnVc1HRBEFjEcCMi6YttNzVuqz8Y
         loa9c59HX8KiiDHUfTkcM//UySPJpyOpkcgyspoR0G2s764nFeF4RyioPaA5YS82/one
         QuTt2d40I556EN/X2GE7poCcsCZLrMnyCobAKYZjFME2BjVyO0VoIZCcfWa9j7cSzJV9
         AR/w==
X-Gm-Message-State: AOAM5306iae4anHyMbi7AE6l00pH3ehzL3kzPkkwkidH4m/eFaMJrD6L
        eZRM/5jC+N8OA9pxjWN6fmezSTOUfmOa5A==
X-Google-Smtp-Source: ABdhPJw0Xr+2cSDlHKmpA6oGpcW0KAAJowPBue1b9VJ3CQ1eci4T/Mizn6EDn2eny3u4IbJoQJwr1A==
X-Received: by 2002:a02:cf90:: with SMTP id w16mr9815336jar.94.1642429468615;
        Mon, 17 Jan 2022 06:24:28 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a2sm1271589iow.7.2022.01.17.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:24:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     GuoYong Zheng <zhenggy@chinatelecom.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1642414957-6785-1-git-send-email-zhenggy@chinatelecom.cn>
References: <1642414957-6785-1-git-send-email-zhenggy@chinatelecom.cn>
Subject: Re: [PATCH] block: Remove unnecessary variable assignment
Message-Id: <164242946547.334981.10563658391509061106.b4-ty@kernel.dk>
Date:   Mon, 17 Jan 2022 07:24:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 17 Jan 2022 18:22:37 +0800, GuoYong Zheng wrote:
> The parameter "ret" should be zero when running to this line,
> no need to set to zero again, remove it.
> 
> 

Applied, thanks!

[1/1] block: Remove unnecessary variable assignment
      commit: e6a2e5116e07ce5acc8698785c29e9e47f010fd5

Best regards,
-- 
Jens Axboe


