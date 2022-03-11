Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B31AC4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 17:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiCKRbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 12:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiCKRbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 12:31:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4515169C
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 09:30:46 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q11so10885279iod.6
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXWf3I0xCujxLu8bDz7q+9+6F+4g6AyNkKp3SeHhzQU=;
        b=Gw0hXQsoHkv9ZTjG/cWtnt4/GhK687iHDGX4SHp9exn7x/089wn4x5rmPdgD7+c7+b
         eCDqKZpfNMMcuQzAajePs5PghSpYARbXnHLYcU9CeyqQbWlZqfi4ICd8aCUncygzzSxm
         6jQ69tZnHKzmhg28HdUIlrPyh2NhX1DqAg2jSB07pso631qy9i6vrOHMaoA43hACPOKT
         jDKg06rZ0WwhQMDva91IgkPH2f4XHy3UbOIoEReRnwyyA3yYfE/nlISMEF+zvKLqITl5
         9ica4pLaVGUOESqsSqX2lvQGWtBIrZSuoCNvaoS7DUUtYukweDbOf2IQuypDrJgA5lC7
         v45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXWf3I0xCujxLu8bDz7q+9+6F+4g6AyNkKp3SeHhzQU=;
        b=hxN3CKp3H178IYxYVskp+gwJ/sqFZzc3FUvqTMSIVDupP6kJlbBJeEkuQpZVc+XFbn
         y3BYI/z06ROxJOdc5Oi7JtcOyJ4pBrRsQsVAZiRx0WwFG0yUQDBNyNNUy7XiD0puh+di
         E029pSjgf8myx+f1CXqU0DgBNN8CijWYrX+eaJWtlJzXLPUiy4AWJuEflIcdDEsFCa4i
         IvSe2786jkFX2n80locd83EuaUmW8wniMDjxJAXG+/ojAAns2dBjTjYENQ+Oqg9mNIhA
         6SC1Z4wLJI5InQ4BgUPdb3MpJ+eXikkiQfq2+AGhi93aw7370spOqnbeUpv/BPEk63Ls
         xZBw==
X-Gm-Message-State: AOAM53020zc99n18ak4zDmSjxV5uWnpNbgGKCqbK9Uk8+86eV57yOLvN
        iuJwpnz4XTX0e1KtYOHowbb0iBhJzb6hA7oH
X-Google-Smtp-Source: ABdhPJw6RkyEEarUKe3MuVgm7RweWmu0f/TyIsSTGawK16k+fDCI1QxenS7OBmHoUWt8ZgyqFtuhAA==
X-Received: by 2002:a05:6602:2c52:b0:646:2488:a9a0 with SMTP id x18-20020a0566022c5200b006462488a9a0mr9005491iov.130.1647019845634;
        Fri, 11 Mar 2022 09:30:45 -0800 (PST)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r2-20020a92d442000000b002c62b540c85sm4622356ilm.5.2022.03.11.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:30:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        llowrey@nuclearwinter.com, i400sjon@gmail.com,
        rogerheflin@gmail.com
Subject: [PATCHSET 0/2] Fix raid rebuild performance regression
Date:   Fri, 11 Mar 2022 10:30:39 -0700
Message-Id: <20220311173041.165948-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This should fix the reported RAID rebuild regression, while also
providing better performance for other workloads particularly on
rotating storage.

-- 
Jens Axboe


