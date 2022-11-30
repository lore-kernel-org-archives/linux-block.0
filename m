Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFDC433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 13:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiK3N4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK3N4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 08:56:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7507E490A8
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 05:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CTkJx8JRlmMYM8d984nsdcAHse7udOqUT7yY2TVWS9c=; b=BJbDLb0KZTI0whIg/V3ue4rrYv
        87U0ESLhkbLlNy34hatcc3nhtRQ07FOhZlu0WFHLF5RBO+XqKY0soyFItDR4P/vNmaTt/1UtK01VA
        6iHP5vUdDjDQsmjo5jZYgCc9cescnV287dJsSV6ZWIKIfHI+AUuwBROolH2CXpc0pX1yxJ7uHG3ed
        Kza0Wdc62Ou1A8uze0SQ5hlvhSE48kUil1umvK52TOYBhGUVVc4X48EIqxXC9mumQREwl/xjElI/c
        ai9biKlgorqxDTr3GTfqYYCoKpmUeBguNBNOuLcP5csgk5kLSaHy2vm+4SmK/UyDTfp3K7qYHjKai
        sbXki/7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0NZI-00Gdqj-8T; Wed, 30 Nov 2022 13:56:08 +0000
Date:   Wed, 30 Nov 2022 05:56:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Partitions created under RAID devices
Message-ID: <Y4dg+OTSdLOFFpvX@infradead.org>
References: <20221130135344.2ul4cyfstfs3znxg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130135344.2ul4cyfstfs3znxg@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 30, 2022 at 02:53:44PM +0100, Jan Kara wrote:
> As I've studied history behind partition rescanning I understand it is
> difficult to please everybody :). But creating partitions under assembled
> RAID device looks wrong to me. So I was wondering - couldn't
> disk_scan_partitions() just refuse to operate on the device if there's
> another exclusive opener (it will be a bit painful to do the check but it
> is doable)? That will fix this problem with RAID and should
> not be prone to races with udev or similar problems causing troubles in the
> past. What do people think?

Yes, that seems like a very reasonable thing to do.
