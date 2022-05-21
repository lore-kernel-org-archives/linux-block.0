Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E360C433FE
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 12:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbiEUMcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiEUMcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 08:32:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980239C2E7
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:32:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p8so9801981pfh.8
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=JgECGUYQPfzQccxjQJUi8fr2KJeySrPf4gVLNaVPy0U=;
        b=WXY1ugt3fKDzvhExzkLtPKfAnoaTleIm5nLQSD1VDR4y9vBVjrL0twjYEe0rHhtMV6
         1RyA3k/9mC8X7ckdY1XjXshHVglKqwrEMD2ZwIElo41MmucmJlUFkiMHR61XvU+Zf/6Z
         mylPQ6yvSzXb3yoRzuFcEw3dgwcJJ/uKKF355S7fw325qu/3dGuDPXD/sxL2KlkTWXcL
         spDpLa6rx2va0TFSjedicNGQH+fWRBMhIG0Zpx2uNTcJpO2y63MXlYsCKf0O5dCyLf/D
         8FLzBK1swN4AFRFmYptHnjLmAke3cowmC+hgzlRSKMV260ru/V6fjelTbufXtI8ZVVWU
         P/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=JgECGUYQPfzQccxjQJUi8fr2KJeySrPf4gVLNaVPy0U=;
        b=r1LHN/4gTtwhXU5LyKFvRF5gKDC8o9Tsb1isWVMVKn6qGHOEQHrJGkvbASh9RhV0PQ
         YC8qSSG1zetsRrV/7k+BcKaGt4gUkiNmqr15SmLRpBoWDI2mWYzGcCk7dN01bwDLrDsu
         zwVSrNVb8vq+gXp7PZwuHWiHmymih3ApqTnIsSnNgKlxmqUiF8afPoMt+wIxKfzVqV49
         P8jC8+II9kbo+H+VhsD9TVnMHyu55/PgxSpiw1pcN/h5beOMaG5kpKiq0sf2cm7TAMsR
         2vsyPgkmyjg0xWUlTaqTV9ty++Qk8W3SC8qz++1prLdCPp9gTEx1iYtpKsR4uaLgZoRw
         DIxw==
X-Gm-Message-State: AOAM5302/Ag93GD29ZVK+HkCCiQ59Wz+nNIOheguFttJe1TH35lO1Flq
        QhMz2FGCb5If0l5nbLsDNxDhkQ==
X-Google-Smtp-Source: ABdhPJyywiQeka0cL1QIQ52HrCa75B117/TtMloSmZELBFW0UPcqBV4nCigEW/gs58JskI9ne6BDZg==
X-Received: by 2002:a63:4765:0:b0:3ab:812a:ded2 with SMTP id w37-20020a634765000000b003ab812aded2mr12851246pgk.214.1653136365061;
        Sat, 21 May 2022 05:32:45 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e20-20020a170902ed9400b0015e8d4eb1f5sm1506394plj.63.2022.05.21.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:32:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Julia.Lawall@inria.fr
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20220521111145.81697-28-Julia.Lawall@inria.fr>
References: <20220521111145.81697-28-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] mtip32xx: fix typo in comment
Message-Id: <165313636386.19482.14816930857839555999.b4-ty@kernel.dk>
Date:   Sat, 21 May 2022 06:32:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 21 May 2022 13:10:38 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] mtip32xx: fix typo in comment
      commit: 537b9f2bf60f4bbd8ab89cea16aaab70f0c1560d

Best regards,
-- 
Jens Axboe


