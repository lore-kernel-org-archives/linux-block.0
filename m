Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F74C6FD19
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 16:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCPQtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCPQtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 12:49:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC61591EF;
        Thu, 16 Mar 2023 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kiy05oUdlDcyC41B3B5pZAsBeqMsbkcfvbNoSKteC+0=; b=LMeFYbDNrRFs3CNsdEoCiTxiVl
        cmjRKoYtQoIWVKcWk4o55Kc2Fc2Y2IQpQOQ92EFe3JRuqA88k8uhSZkBdC/yVou+NOFLkhQBNKqfd
        T4bTfJZEc4verfRjD/D7lCnjkXcgXQfPMMxpV9y4hVSYc97BUrFbNJgJCGcrMy7/JDJdOVj/Y02nX
        HH3IQB2M31Y5z5nwgEydZN4ivPlrzZFj7LmMv8K/WVvLPGEwUh4XpgXS0f/EPxJZZrKjA6cXW9DTZ
        i/s6383VqHEPV55cnbKh+lPaSsPOBzXm9uSXr0Keg6GH4Egly8gnaFgEn0fwoiKSji9DCWGfYxq61
        GfzY2mJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcqmp-00H3EX-0P;
        Thu, 16 Mar 2023 16:49:07 +0000
Date:   Thu, 16 Mar 2023 09:49:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports
 an internal cache
Message-ID: <ZBNIg8+rOdFKcsS8@infradead.org>
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316164514.1615169-1-ulf.hansson@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 16, 2023 at 05:45:14PM +0100, Ulf Hansson wrote:
> File systems typically uses REQ_FUA for writing their meta-data and other
> important information. Ideally it should provide an increased protection
> against data-corruption, during sudden power-failures. This said, file
> systems have other ways to handle sudden power-failures too, like using
> checksums to detect partly-written data, for example.

Sorry, but this is completely wrong and dangerous, if not intentionally
misleading bullshit.

The only way to provide data integrity is to ensure data is written to
the media and not a cache.  That can be done by a full blown cache
flush, or with a FUA-like optimization.
