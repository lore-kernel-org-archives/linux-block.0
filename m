Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3AC433FE
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6183861108
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 17:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhIORmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhIORmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 13:42:22 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB11C061574;
        Wed, 15 Sep 2021 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qt2oy9vw0dXIN2QIKk1xtx0ae09ij6yfgJ9fhHl0i8g=; b=V1iybqMKBGo0UF49aDegibTuO4
        9KRsxbz9kIeDITVYr+X620EG5+yLurXE3Cq+pCcupyd3B4/A5D7rJ8LOamDGqDl6e9NsMM3OhcyBI
        DAxGVnoBNh+Y2+jXP3I5tcJc1S5aAIvMu41WpD2jFV0bwQEVhPCqgtcKFSxW3VstiFdFRZ70lydCF
        1sr9SWxF/NVT2Woq1s7vcalDk3Knhh+go2dPCb1phH5u312m3kAPuBurahHH74kkD+QJzoLt7sAvy
        5P83g8Lg4edQpZ0J2wWd2J5gCL0t6s+DYAgkX8ASczJLTjYrNZ4GpW4Kx6W6PMVuJ2Sgnno84xas1
        FurilX2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQYu1-009eBn-JQ; Wed, 15 Sep 2021 17:40:57 +0000
Date:   Wed, 15 Sep 2021 10:40:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lucas.demarchi@intel.com, linux-modules@vger.kernel.org
Cc:     live-patching@vger.kernel.org, fstests@vger.kernel.org,
        linux-block@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, osandov@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kmod: add patient module removal support
Message-ID: <YUIwKUXc7YbVAqut@bombadil.infradead.org>
References: <20210810051602.3067384-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810051602.3067384-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

*Friendly poke*

  Luis
