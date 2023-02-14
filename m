Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5DC05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjBNSdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNSdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 13:33:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42C298CE;
        Tue, 14 Feb 2023 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kWj+QDtOKr8glFIwA9Ck7BAHXoUxqGc38pTRMscjd4M=; b=DXDNex9bH48IWfe6v7z2dGe8Xi
        tw7kBJqf94FGe8wW7OKdBLsO8MCOtgpbM/Uiarul/joEQxghyHKaGcnQU7QKGkkPfWKdYUFzvkukj
        bHJxBCJ7c72D+Nis1OX3gbP8Ghnem6iJQaTkMbKIQc7Q10RXl+M70JfE6rwhMjgQMinkF2+BKmlLt
        dxw5eQ00TvtNrI+5v1g32Xdd8VQUTuPAjqPhbfWaB1Gp54DyYqPAptyHCFLbRIBdMOHkB9dYzTqPk
        46qImg0ka5zW1JLJBUqgHRh2OPaFL/nXEw4AZS8i+StgcRr186SwKmUGWnMjP1G5bA1ynr6OonGX5
        KoFRQ88A==;
Received: from [2001:4bb8:181:6771:29b8:d178:cc31:6d8f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS077-003BaD-75; Tue, 14 Feb 2023 18:33:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: revert blk-cgroup changs
Date:   Tue, 14 Feb 2023 19:33:03 +0100
Message-Id: <20230214183308.1658775-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series reverts a bunch of blk-cgroup patches as one of them
caused a problem for which the time is running out to fix for this
merge window
