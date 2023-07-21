Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114BEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 06:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGUGgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 02:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGUGgc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 02:36:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC730C0;
        Thu, 20 Jul 2023 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dNj9HqDsh0etQFD7jEaoC/caRXY3w0DSveX/n+3VHl4=; b=4p6T2id0FidHtcx3NOENyCPePm
        Z3I2YToRlMfoa5NXVaq3fxELj//CxCV4hu3dntZFCb5YMC4EyxnxmepXmnrQnNqA1OoEyrxK2E7Iq
        5TrmdWDBAqXhrc7t4c3X5pmKZPeO2x68/HOIzjAF9lUO7nZRstoNY3vZ6HgYd9XSRz0OaeIRQ5sfw
        3OLawY/RiOuwBka8po6tIqM46jCHJerAUKpyabW8YJObfwwQGDcQ8+DZXM84reE43Yy+pxEAZ1lBB
        0YQYRWrfgOMEIpwNDOfpJKHfTD3Wv9nsh/wMdN/9ufm0nyNr0vJ9l08ZGSAcSEPaaWj5tqWML84bX
        0tD/I02A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMjk3-00D37H-0b;
        Fri, 21 Jul 2023 06:35:55 +0000
Date:   Thu, 20 Jul 2023 23:35:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] block: implement NVMEM provider
Message-ID: <ZLonS7QXLj2lg4Zg@infradead.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> +			      void *val, size_t bytes)
> +{
> +	pgoff_t f_index = from >> PAGE_SHIFT;
> +	struct address_space *mapping;
> +	struct blk_nvmem *bnv = priv;
> +	size_t bytes_left = bytes;
> +	struct folio *folio;
> +	unsigned long offs, to_read;
> +	void *p;

Btw, this function really should be using kern_read on a file
using filp_open instead of poking into block device internals.
That way you can even have a generic file provider that works
on anything that can be read from.

