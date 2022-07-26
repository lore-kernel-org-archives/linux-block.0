Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6CCCA48C
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 04:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiGZE55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 00:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiGZE54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 00:57:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CF26AE1;
        Mon, 25 Jul 2022 21:57:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e132so12199854pgc.5;
        Mon, 25 Jul 2022 21:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OOsbGRJHrD/a6HapTby2zw5mB5E6t8uLTz45iTXTcS4=;
        b=Mh3qdoJ4CRmYIw4CbhzOfhnxeqKa3MeBvx1zT0AaJTKvTTj31a9VTXz6HyqLCWzxvE
         DjI0KCTtEiTeJSA0h0dboC+aIcZWOnqP5+oRp20UmJORLK7pP0/QZWxTqJkS7LqwGkvW
         Uv6DATG88fJBMVYBE7iAOW0XAIytqEWSaW5qRVUhzN/FXNjYqgvQh3LEMWnbNSNQC+8L
         c+TkV3F2gV0SDLdwMPUJj3ud3u4/UukfB2c87zEN7XxAuuqN0fS6mvB4xX/yjO+p/NQM
         LXYebG73z9hxZRC9NSC1pIJ4wxIxZWmptIMBNkIXxw0myt5I2sc2dd/dKvc8TO3I4NNI
         Kwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OOsbGRJHrD/a6HapTby2zw5mB5E6t8uLTz45iTXTcS4=;
        b=2jZlj2wlG3WhXkAVoIpeG5W3xs4QiidDnUeKoHzGYFogkBQJ0uLHWZ9v7YYVaXnLNw
         3PtdcssGPlpbhjq2qbBIPNxG3siLdb4+RHsi1xONn2tjr2IMvaRqmADNMwZqzc8RcRDR
         /3vGb249+/lo1F/ms6/j7BUKUJ9LGabtLKpHbPZIcMmAuvBzaXtLt9uOzQS1yvH0rsvo
         VoiMx+q/oN/yDBvT6Zqts+TQ2d4xA5Mlu4w5Yjpy9l3IPvSThtWsQPQks++l/fk4v9RH
         pWnBc3DYwK51pScWctpa5IQplGngfVX9bZ8J02mkfEjYNvfQwcWgMW+Yz5rNy8ZOPBvq
         YCmQ==
X-Gm-Message-State: AJIora8Z/TWQDJHAbeNrNUMDS3LrqvW0qnN0ZUETF/3OSVS+y9oXvCcc
        /9GsFCyC/5PY/oPou3DBNK0CVlsKKFM=
X-Google-Smtp-Source: AGRyM1sRaNczYP6kEORYgYh5nvx6dR1ojF2WgnTtqMrTD/QTvlJKQkGmVfRpDHqu7LnN8FDdaQ8HpA==
X-Received: by 2002:a63:fc0c:0:b0:41a:8177:35f with SMTP id j12-20020a63fc0c000000b0041a8177035fmr13507094pgi.285.1658811473283;
        Mon, 25 Jul 2022 21:57:53 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id u6-20020a62d446000000b00528d41a998csm10773177pfl.15.2022.07.25.21.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 21:57:52 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id B273636020D; Tue, 26 Jul 2022 16:57:49 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Subject: [PATCH v8 0/2] Amiga RDB partition support fixes
Date:   Tue, 26 Jul 2022 16:57:45 +1200
Message-Id: <20220726045747.4779-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Resend of the final version of the Amiga RDB partition table patch,
updated to current linux-block.
 
I've split off the part fixing the incorrect use of signed int
for partition start address and size as separate patch. It does fix the
bug that Martin Steigerwald reported six years ago for a 2 TB disk.
I have tested this patch with the identical RDB partition data that
Martin saw the bug with. I have incorporated Andreas' feedback on proper
use of casts to avoid integer overflow in this version.

The simple fix still leaves ample room for overflows in calculating start
address and size of a RDB partition, though such overflows should only be 
seen in rather unusual cases. To address these potential overflows, checks
are added in the second patch of this series. Comments by Geert have been   
addressed in full. 

Both patches now reviewed by Geert - Reviewed-by tags added. 

Cheers,

        Michael

