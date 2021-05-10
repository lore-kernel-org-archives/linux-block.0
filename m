Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDFC433B4
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFF06112F
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 17:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhEJRu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhEJRu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 13:50:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C28C061574;
        Mon, 10 May 2021 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dGzXWiBIPYg+gHFXCo5+gYyyl/xbSNUj05YBsxBkKe8=; b=TzsLk/UPp7TTb4MvqcVD9zoDXZ
        rHyMKq6Q4jRNs6yCv+32xySjEIIwt/9pgX7/ATzcEiwl6eBanM1u+HOLd1XZZq+36foWXNQ8ZOGad
        P3YSTooLH0o9NQFObpg0MNMXVW1d01T4/wQaHyQEeoqx8cK40MJO2WJ+Vp5K/pxFv1D5TiB31b4YW
        svhBv2ogYl9gn+D7ZKG0LGvKk0E3JD08NviomHnZ3BGASC8RE29FCVUiToBGaRfs1gqCpmi7q/trW
        TVlX02Vei9TkHCk3iLLx+03Un471Xp67kV9iqJzBzUc4620f7o81FMCEaqZ6fTqxGRiflCwNeRtVV
        QAGE9yFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgA1H-006QxS-PK; Mon, 10 May 2021 17:48:55 +0000
Date:   Mon, 10 May 2021 18:48:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Block device congestion
Message-ID: <YJlx9+FQUBu5HmcI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


I wish to re-nominate this topic from last year:

https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.org/

I don't think we've made any progress on it, and likely won't until
everybody is forced into a room and the doors are locked.

