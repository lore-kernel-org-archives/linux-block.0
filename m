Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F2C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBFPpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBFPpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:45:49 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D32B08E
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:45:17 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id v1so778322ilg.5
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGKB2X0srwqHqQK6rML/eiHcuXvhThrwfsy+2zVgZN0=;
        b=TDaOZjJ5N8PMWFUUOVH+tGKH6FhPhckUM80pvS5pOIeCeI5OpZbGwVQ/tqwdeUKOwR
         P9JKpLtVFKJAReCQk9RNXcLgXCcHFbNOxINZgtS2g4H7N/OMuC9297ji4TUC3x1tHEdi
         xsOciqhRbD4X73TNVLPeVZ1rk61QSDU1Raxmc9NvfVtvuycaq6n/FlOySsXc3igdCrw+
         IZlxO5NjtYfQlKTLgJKzmyAW03rRt/Jw/jAyGyLU/u1IrBCOdsWWFy+ui5/AeTiLgpny
         8SIcpSPegQSwFWEHW1g66xMXL46gyqFk4BZPFE38ZOd3IvOpoG/TUivjGUhwzHoyG5dQ
         uv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGKB2X0srwqHqQK6rML/eiHcuXvhThrwfsy+2zVgZN0=;
        b=Ly13lUVM7L2tAkLk92HrOaaft2i3GUhuWxhcAlPnrRbR4YkgB28Xzyb7cGdT8mtxNs
         hlzMbGrAdHnswxp/Q0R22ZuV/YsL5bHFFghyo7SyPXofp/CDk6HXL0AoviIbCJrlQYGb
         QrCFJ+uqP7jvKLbRM7VB7ohRGF6MzTTOrnC1+FIZMq9ZXp+Y5GXtzBYd5Lo9jpJx9f1o
         EhjtEnu9qY9RuE2PH3Mc5cUYMuAoHlwHgpg2oGFxHyV6nlxOvZR3ykT6z6/vd9HG7Yl8
         AyVE3gfAH13tJ+/HUJ8DE//eS1IjTD7DD6hK/34q6AvWltfsiFYf+I92GddOn9q+GW7G
         6SdA==
X-Gm-Message-State: AO0yUKXWD8AfFG+VnbVxCeBJLBUTBtNLQHFFCnJ82hYVmqUbaEK0+sXK
        e1xTBXllPbwI36eMkWvDTK3ikDfCw6Y2TE3l
X-Google-Smtp-Source: AK7set8xtKTbz3WQN6kbzxyp6xFA8fK6x1L9Ix0DfR9BY5t5ZjVNyrYs+37LoGOYduPQMO01yF6REA==
X-Received: by 2002:a92:b701:0:b0:312:7588:c730 with SMTP id k1-20020a92b701000000b003127588c730mr12422733ili.1.1675698316362;
        Mon, 06 Feb 2023 07:45:16 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k21-20020a02cb55000000b003bf4a01e9d4sm1856100jap.155.2023.02.06.07.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 07:45:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230203150209.3199115-1-hch@lst.de>
References: <20230203150209.3199115-1-hch@lst.de>
Subject: Re: [PATCH] block: stub out and deprecated the capability
 attribute on the gendisk
Message-Id: <167569831573.16737.18302752111407350806.b4-ty@kernel.dk>
Date:   Mon, 06 Feb 2023 08:45:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 03 Feb 2023 16:02:09 +0100, Christoph Hellwig wrote:
> The capability attribute was added in 2017 to expose the kernel internal
> GENHD_FL_MEDIA_CHANGE_NOTIFY to userspace without ever adding a value to
> an UAPI header, and without ever setting it in any driver until it was
> finally removed in Linux 5.7.
> 
> Deprecate the file and always return 0 instead of exposing the other
> internal and frequently renumbered other gendisk flags.
> 
> [...]

Applied, thanks!

[1/1] block: stub out and deprecated the capability attribute on the gendisk
      commit: e81cd5a983bb35dabd38ee472cf3fea1c63e0f23

Best regards,
-- 
Jens Axboe



