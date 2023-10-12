Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E6CDB47E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441925AbjJLR41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLR40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 13:56:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5ACB8;
        Thu, 12 Oct 2023 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sgLQgFGbhBa3OWMLEXQ5AgPAbvhy379YNkqJpx9j8Ig=; b=u05oCMn+HurfCZPIECBMmQyZKB
        JAKo7BJeKKkMi+JefRlAvhCt8AFE9smjdYSL0ZWekUep5gWu2FYgD3mEttz+FLNh8vFeWpdLT4kuy
        1o4eP0wQ7gHQWL5vAHeYiZ5nU+LD+L2OcKRzyDB3SIgtM2PjNp9+gjPaa1v5jy1XmbazQqRqo8tBH
        iPehbvDHwHoLgkhGWlE0tgOBBgMBf4Vlr1NKlVQNPa6FNiCYH3ZroZwznDOQNFX/uq1FIR0KNgv5R
        aO3UMY7Cmt407L3zgpyjkGMnZ9z+oPpKXEWXp1cegdhI+j5fIGuE8gShnFXGXaaqOqUKGANvz8zGW
        Ieqiyh2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqzv6-001ZBt-1H;
        Thu, 12 Oct 2023 17:56:24 +0000
Date:   Thu, 12 Oct 2023 10:56:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>, mcgrof@kernel.org
Subject: Large Block Sizes update and monthly sync ups
Message-ID: <ZSgzSPAF8VpC9PPD@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Folks working on LBS met up at this year's ALPSS 2023 conference and
we have started to put effort to merge our efforts together so that the
next patch iteration is done in coordination as a group effort. The first
order of work is to merge the minorder stuff on the page cache with its
respective huge set of testing requirements. In parallel other work can go.
There has been enough interest in this topic, so to this end top help sync
with folks we're going to be putting together a monthly sync up where we can
review progress, blockers, questions, and next steps before we post the next
patch series.

The first sync up will take place on Halloween October 31st 2023 at
5pm CEST / 8 am PST. If you're in Asia we apologize in advance, but
given at least one person's expressed interest in that region in the
future we could pivot the next meeting to acomodate that time zone and
then alternatate every other month so we all suffer equally.

This sync up will take place over zoom, if you'd like to attend please
let me know and I'll add you to the calendar invite.

  Luis
