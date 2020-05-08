Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FCC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B5E208D6
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 06:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syJ9oRgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgEHGom (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHGom (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 02:44:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47890C05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=syJ9oRgnxtyNB5zc35Et1mrd4D
        sd/0ktiptibUB3/mZrh2LL8JM0Z8MIJCOSUNPb5Y8hJR6OkezEGpESey5HrPepSE4vrPidKPjEpLw
        XcyAf40ce6O1AMLOQsxlTJkaoP7yS15ov0NavIV+M2kAJZKzc89HoRvLJOQd2pnp2Hl6U14wFJfQH
        vNNCfrQRoZgqqXu59a+4gwBNWCoqVHnEyFsXQOU6/3++uLemE30G4jZtHbVb1lrq5DJPlJ6OIyEGX
        di5vG89o/mrTN+kIiNWG2jKxdEVkUakeR8RiWalhJgm/f2YoyLp+RljMYZw2kxW1jpr8XdjqAiSBt
        O1881pjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWwkT-0003Qz-F9; Fri, 08 May 2020 06:44:41 +0000
Date:   Thu, 7 May 2020 23:44:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH V2 1/4] block: fix use-after-free on cached last_lookup
 partition
Message-ID: <20200508064441.GB11136@infradead.org>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
 <20200508044407.1371907-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508044407.1371907-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
