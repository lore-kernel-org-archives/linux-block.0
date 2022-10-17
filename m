Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0EBC433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 07:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJQHrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJQHrn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 03:47:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EBF5300B
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=97dQH1N2xHtpMxxG0nDV8SAuoMet2OPAMXZD917IpZM=; b=z039A3vITwRWuA1HXZgeBYakBD
        7xC4neQ7EcXvQeb8NQ4CKQheW7COtTUTjtJjiid/MrmHsrRXn5fV8FwEa5m6URB8vB7R2djetc20h
        YyH/FDaZMV2T9ObJrQ75QK2FkLzhpugsG443Rj7PiY5GRjQfuPNzPi3kvZjozTfX+hI9kpM6zpgqK
        Cqn0Xv0UN1AsE9RqdcVQw8L1S4s7k4cOzw43GtwSLqLLM3RhZtEnBs46N3P9A3PFFP15BsGyDe4AO
        Wgs8sV6z6uPXYHtRRbsUKhkIpRp7oFpozsR2zvEniq9RK6vGgjME5VupY1c7u2HdtJuQJYb5GAfte
        30EJC4Xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okKqZ-008bH4-DG; Mon, 17 Oct 2022 07:47:39 +0000
Date:   Mon, 17 Oct 2022 00:47:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     hare@suse.de, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] tests/nvme: set hostnqn after hostid uuidgen
Message-ID: <Y00Im55493i+BWBi@infradead.org>
References: <20221011174325.311286-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011174325.311286-1-yi.zhang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please explain why here.

