Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BCC4360C
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 06:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710E220873
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 06:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oKxSFJOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfJPGcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:32:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfJPGcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 02:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UM35At7vBmzV+Xy4wBYs7Qno09nUj7BMnIORep9fhfc=; b=oKxSFJOpm4N79QdziA6hDYpaY
        moOnYRAXA8Z6/b9LkxnPDxV5X1EUESYGJO2XLHHBNQXjVV6nOjRQLMIc9GlUjrfnK0sVu3UXYxltT
        S9jFnctQEIs7kkZDHhhZkQItxh20cLUUQiY1FgY9LGeyViXQhg5Yc7d04dj72XjoEKVT0gSypNqVy
        e3AG8W2iSF5r37oAz2fMuJkpfMud44R6CMK6hzn3aWPH/mN322x79F2AJzf/alJZ/7CSDcvUgKkXc
        7TNe3tT8zu4d9rUFjhwGYr8I8usZMVJQem4OMAdVeJPZ2Y1MhQ1KYBiq1LQSjbP4HiFZB4/j7Zei8
        39PhOfRvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKcqy-00035m-Kt; Wed, 16 Oct 2019 06:32:12 +0000
Date:   Tue, 15 Oct 2019 23:32:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/3] block: sed-opal: Generalizing write data to any
 opal table
Message-ID: <20191016063212.GB6852@infradead.org>
References: <20191015230246.10171-1-revanth.rajashekar@intel.com>
 <20191015230246.10171-3-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015230246.10171-3-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 15, 2019 at 05:02:45PM -0600, Revanth Rajashekar wrote:
> +static int generic_table_write_data(struct opal_dev *dev, const u64 data, u64 offset,

Please at least fix your basic coding style issues before the next
resend.
