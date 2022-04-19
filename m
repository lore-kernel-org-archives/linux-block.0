Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F93AC433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 06:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiDSGft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 02:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiDSGfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 02:35:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B712611F;
        Mon, 18 Apr 2022 23:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mEA1zORyqfjRljCelmq6ahOxZI2mvs8e/1u/HcZHz7U=; b=U7ChaIlKYTEonM+tjnN7rHqR5p
        5xPHaPXk2u8Fw9c5yuZttueYYbSPKQ5xjohcy/myxDrutZ+xpeDQEHaHtR4ToW111+ApMh2yI7Odi
        CSONfAWo6Ww2cSv+rZlZRTYnILU3ELOsr5XBrV1h6KS4Gt5e2d3p9T6aZOXJYTbbW80zGeRHWLSjG
        pIJqyvsprBIW8fx7ydV0cssYfQuounv4ze021cHhie6PYbJlc3yyOOLA7/Sui7lq+Ba4D95h0lwCp
        xph1m/1QRa8x6kCPZ3RTBLOUWrD8duQr1t+ADEZnRAM54PWMzbiZTt1HT63S1PLngfYrMIBRkKh/c
        p+3q0EMg==;
Received: from [2001:4bb8:191:364b:8ef6:df8:5a60:ae5d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nghQ9-001hyv-9l; Tue, 19 Apr 2022 06:33:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: SPDX tag and top of file comment cleanups for the loop driver
Date:   Tue, 19 Apr 2022 08:32:59 +0200
Message-Id: <20220419063303.583106-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Ted,

the loop driver still had no SPDX tag, so this series cleans up some
lose ends and fixes that up.

Ted, does the SPDX tag match your original licensing decision back then,
or do we need to correct it?  Does the auto-converted tag on the loop.h
SPDX header (GPL1.0 or later with syscall exception) make sense, or
should that have been GPL2 only with syscall exception?
