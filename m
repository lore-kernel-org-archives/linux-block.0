Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D9C433DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F4520885
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BvINO9nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHQDH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgHQDH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 23:07:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA79C061385
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2020 20:07:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so7531325pfd.2
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2020 20:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/y3+sIpziI5i2x/IrsZTj9dc44wN9fN2Q4/rOL2VgUc=;
        b=BvINO9nn5tfb50yh6jKlnRihWrRMuT6XhZAD/8h6S8XRIIl93QpNwoycR/MeMYym08
         uD0zC8BOchR0VuTWgqhI5Jto7pkZ1ZS61S+3wO4FFUe+xeufo3kHKJ1xpQAXE4oZjEOA
         mEN5C/u75TR6ZXCF700os5SN475dlm6t7r1m3aOMVwOxY27wnIJzq9evFjUrOEWYi2Ca
         Qw2OTr6lJ+FRAayUrxECsUmIfmYbpuiGW5ergC+OQSqVBr56FjgGVeS478gWUzyLZ95X
         G7c7G5ic10fnKaeiLxMijuNIklPoPVtIqCO7VTX9ikSB5CfM/w2T6RA3R1DOF/yYOSWf
         nGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/y3+sIpziI5i2x/IrsZTj9dc44wN9fN2Q4/rOL2VgUc=;
        b=YE65bY4c0AE24YItYdWtTEQAVq0HPiO+pnC+JzG5xkcHD6bcp61VzFsSwSoUSMhqsi
         c6qRPWhdeF3USUsF1IBF9JNqmtci/MdMOzZt0Ex3qJyKWIHHuu0mz4Yu0fBkMNQmhtpS
         SbtWk3TxjsrMiyU0pW0gX5FA9qIRqA79al7poMfnEMiesr3r0QXkU6Lng1Zt4xIr8ifw
         N8uLe4Q6QTlsRvHoQFPrz7Bz46Kl3Dx6pzKdjSzCMrGauEYvtiiJ7GTNPDqf62gbBF97
         fhRoUn3bJ5Wqprzr89fJJZrChvB5RVXV0vCjdvfpXx3aqV1+AnEsRv9fTqlthGU16tHo
         z95Q==
X-Gm-Message-State: AOAM5325kbFC3D+Pt3PG+a1+b9vVtyRMWfviodq4xtFBQmX/lZyQqM06
        tvBo3tY/3Z44K1rPMJ7A6cEGaqVuPM6ZKg==
X-Google-Smtp-Source: ABdhPJy8AHV8k/93PskJpi0rA9JuD7vXvSvbRHrZ8o/IR6+gZ82f73n70Vt5ocBfZ+4dfTaRG0kMxg==
X-Received: by 2002:a63:e703:: with SMTP id b3mr8596103pgi.39.1597633644187;
        Sun, 16 Aug 2020 20:07:24 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ea1b:63b0:364:3a3b? ([2605:e000:100e:8c61:ea1b:63b0:364:3a3b])
        by smtp.gmail.com with ESMTPSA id w16sm15710766pjd.50.2020.08.16.20.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 20:07:23 -0700 (PDT)
Subject: Re: [PATCH] bsg-lib: convert comma to semicolon
To:     Xu Wang <vulab@iscas.ac.cn>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200817021649.9922-1-vulab@iscas.ac.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b17a63b2-ed72-66b9-6157-38636d4a7316@kernel.dk>
Date:   Sun, 16 Aug 2020 20:07:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817021649.9922-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/20 7:16 PM, Xu Wang wrote:
> Replace a comma between expression statements by a semicolon.

Thanks, applied.

-- 
Jens Axboe

