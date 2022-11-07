Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61360C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 14:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKGO22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiKGO1l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 09:27:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7791EAC8
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 06:22:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d20so10125106plr.10
        for <linux-block@vger.kernel.org>; Mon, 07 Nov 2022 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik2+y8IF52g+m5bk/aYkFet3pzFw8bcdKkBwNiPEt0M=;
        b=O6GsnmkroB+yLenPGib3vLB6XCa713TB2eFHALv47vfGZ+iUkcwn72gn+eruvUNoDe
         /DuTQVeRXHGbVb/ISMmwQ9fkihMqluxPc7VRwL2YLO9JWvpDRp6qGysP5ggH8FZ3Wmu2
         O+M+njIVIcLy7ZiogIkVKjL96R7msY/VC7iXd2999bcVVtWMXGfzJdXxjofRUKGrPx6G
         fPlceLpYm7eQyFlF35qtksa/JsXzxUrQLyjAHUKDgN+sxIJfp8g962yZteCu0deZ/PRA
         LQPW6OB2CmgjJB0Quu7jAx7eLvGjKuDuzQaCzJQbQ8Pis3X5v9AABj19IKHLCpf/Ltfw
         ldEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik2+y8IF52g+m5bk/aYkFet3pzFw8bcdKkBwNiPEt0M=;
        b=WRcX/OUEZKEdlnbNylY4tQh6Dt+c1WxAfq2Z8k9n37Hef9dhDIQr5i3kU0EGPAqbM3
         O7Yx2H0Ue4PgulmYFahiDUu2JgPCOuvdiTGJEELut8zHcygQk30Jy0kC66sQ5/x4WgGt
         wfCQCStCjcOFsDVd1DCDowMISUsuzBMnJOGMQAQH2Zbxg0Tpun1g79Y8BqJIZl6nYv0T
         HB33CMAvq1ebEBSmu086ybnzXd2wXCj6uibN1KgfPNoxor7zsep80lnczflNzOJjraEg
         h7SWdffMzUX+5apleklPj57Izfe2O+vtKL+oHGPm2W/KkyUk3G1moWjJGth1Vt+6bQRR
         entg==
X-Gm-Message-State: ACrzQf1VxcOfFFwe0LrpJnZOhFRLxB5yo+nndze5qTE+nLemk+0EzM2q
        AzKoS+J/LRqZj6D1VU+hI5fDJg==
X-Google-Smtp-Source: AMsMyM5eOXuxL/d9kFFYFKnRWdYXVtHtUAmNQOKshJPGdfxXjQDv6JeTY/Ru2NGOqwuACdYvJdKj7A==
X-Received: by 2002:a17:902:9888:b0:186:9c32:79ca with SMTP id s8-20020a170902988800b001869c3279camr50375067plp.17.1667830933937;
        Mon, 07 Nov 2022 06:22:13 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001869394a372sm5074355pla.201.2022.11.07.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:22:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20221107062255.2685-1-yang.lee@linux.alibaba.com>
References: <20221107062255.2685-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] block: Fix some kernel-doc comments
Message-Id: <166783093301.6467.9896856409636651914.b4-ty@kernel.dk>
Date:   Mon, 07 Nov 2022 07:22:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 7 Nov 2022 14:22:55 +0800, Yang Li wrote:
> Remove the description of @required_features in elevator_match()
> to clear the below warning:
> 
> block/elevator.c:103: warning: Excess function parameter 'required_features' description in 'elevator_match'
> 
> 

Applied, thanks!

[1/1] block: Fix some kernel-doc comments
      commit: 5b2560c4c20e6d6933625b4b56f6843d6c7faf0f

Best regards,
-- 
Jens Axboe


