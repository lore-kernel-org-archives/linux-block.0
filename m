Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B7DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhLMS3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhLMS3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 13:29:53 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D8C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:29:53 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 7so24270000oip.12
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=yAnwtDa+Q46YbQ3nbqcUNlbKe1HKgMvVM13990TJIfw=;
        b=cK7QtU/ftWtLVr9hCGNn0l5JhTkdh48uSBw5hHxcjSpA8/K3daDdtiIvM5mnNJuJ1w
         XwugPjbs60t3Fn3RV+E2xcQIxFYXfjB27Nu34u8B5lj+JcMzpRLlybA71DY3zK4mA5f3
         f1FBsji4xv4D4xtGWPT+A6OXEV7DCa/ILyxxpN9BL8VI582wMMjjsU5ZJ0lCGKGQZ+Dd
         1+F4xxLAVgRylVruw58Kd7qkZRx1MbVMDr6EFlyTMVsdpDHx3yAvNOUSNjdf+HR3jqLV
         rmE4WgieLqibx4Egc0/Ia/D2Glhg+QeXECZ22Dbqzg7n0rcodFNeSqADFYgVsNXGAAHU
         oSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=yAnwtDa+Q46YbQ3nbqcUNlbKe1HKgMvVM13990TJIfw=;
        b=bRQtBjwM39msLaLJ802HXPpLU+uHbbKq/YimMxs5v7v7HtgIMsZ8FwcymKvMY41Oph
         RkDEmL7JzqCDGTh3HhZnD4E5YmKGWOzdxHb4JEKQm0MCF2Lb5lsBN/iH4ctsLGfa/ZJP
         L+mA2poLqAOkCk8R8ZdQuAFGfxHRN/4OEd2ae3yWKLs/VpXbrgEwbegHegK02I7gJYYF
         BEkS8Tiw9X6seA7Rqe288OiJOpfNzuHDuaMIwNTSP+945vH5iXthGz+9XrnrnDv3fHyv
         ILoIa1Z7/640+TYaVcgpSygzK/UPIuuhhCNVmUlgmDVg0hl38fzbckE/y/v+aOiyph8d
         lHwQ==
X-Gm-Message-State: AOAM530IftYKH/ZyRaqAjcnEEVUor+B3RjN0ewxtcMou8hSU6Z7iVnts
        PKQqiI3AStK9fhrHy8QI9iEJgMBaPl5ANg==
X-Google-Smtp-Source: ABdhPJxXIDuiQECtaU8qcFckWJ9ftSmkDTm/b+nJlQHcWuZisuaqTqTMi8FEDwvUBQlcg1KxH1UyCA==
X-Received: by 2002:aca:d606:: with SMTP id n6mr29171252oig.76.1639420192292;
        Mon, 13 Dec 2021 10:29:52 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v12sm2285374ote.9.2021.12.13.10.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:29:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20211206070409.2836165-1-hch@lst.de>
References: <20211206070409.2836165-1-hch@lst.de>
Subject: Re: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
Message-Id: <163942019142.141720.8766753069617616299.b4-ty@kernel.dk>
Date:   Mon, 13 Dec 2021 11:29:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 6 Dec 2021 08:04:09 +0100, Christoph Hellwig wrote:
> mtdblock / mtdblock_ro set part_bits to 0 and thus nevever scanned
> partitions.  Restore that behavior by setting the GENHD_FL_NO_PART flag.
> 
> 

Applied, thanks!

[1/1] mtd_blkdevs: don't scan partitions for plain mtdblock
      commit: 17f81f9d4b41d57e474975c3a5ca2a2c4c01e2ec

Best regards,
-- 
Jens Axboe


