Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C3C43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiGFIIE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGFIIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 04:08:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1559F30
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Eyy0zIbzSn4AH+vIyOsqtV24B5bJizy4dg5kcIn22p0=; b=yClrc3d0N4W+mpSipwpC0zRv09
        /FKBHj+xOg2M4FTEzoAt+Js90y+72cDfjSZVSLFp0o6K4yDow3w5E2dtivXxsz+uuWLadpHf54VqS
        t3C/1JeAsiA6kzMcGkFxS8HWiUlR95onEJjkEj7uzrjTfT52kFcNxIW6nrgJ7NKC5vLqy4sxquS1N
        +JbnvNgueivCRcGl9VYPd6ci7I8RQ2MHJYW7+hOEEZlBspnzMBlVlEuyFeBnn3mRmx1XkbdPItyW3
        Sdvr0+UKhj3XpglOuT3xmuMn92KPeTYqs/OOG4EOST3HqsMnTaSjsUo0TIhL/4+SSvHncqTd4Dnc7
        f2eW6OQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o904p-007HbV-K4; Wed, 06 Jul 2022 08:08:03 +0000
Date:   Wed, 6 Jul 2022 01:08:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sun Ke <sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] nbd: add a module install and device connect
 test
Message-ID: <YsVC42qMNKN7Jomo@infradead.org>
References: <20220706070209.1494417-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706070209.1494417-1-sunke32@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 06, 2022 at 03:02:09PM +0800, Sun Ke wrote:
> This is a regression test for commit 06c4da89c24e
> nbd: call genl_unregister_family() first in nbd_cleanup()
> 
> Two concurrent processes，one install and uninstall nbd module
> cyclically, the other one connect and disconnect nbd device cyclically.
> Last for 10 seconds.

I think you mean load/unlock instead of install.

> +requires() {
> +	_have_nbd
> +}

This needs to use _have_modules instead.
