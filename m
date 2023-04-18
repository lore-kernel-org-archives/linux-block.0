Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1394CC77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 05:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDRFTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDRFTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 01:19:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E240E5
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 22:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGRRbv0LGAyHqJaxlUKVNOKfBAH3MkAn1rH2QkARBMs=; b=49pP8hmEhXgfj+O7xjFUKdraZg
        Np4oUse9sBwnenNFJ7uZvw7XV9PdDv0BwBbKutBVM/AN4ZVHz+4+8atZaiUDnc0cVc+tNEu9oJrr6
        CflhjYkPyC1J9m60wUohwOSozYkh/leeICizS2nfuYXZCHH/sssiJItzsodhqdLfS41Qc6xglyyF9
        h5tJ246MaswN5EY1Qxl9s4enHNdoOSjkWprQXsDjyw5UFCCbJsIF5Nw+a3jmrubp1ailQur2tnh09
        14w5rk4wilxEbnCLFWxiYLWaIWGd5zYOQLcpPV/f549XUs8HDEHCR+gk/cCS/AQW9A6Xpdsu8a3J7
        T4xjRtVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1podkC-000tLy-38;
        Tue, 18 Apr 2023 05:19:08 +0000
Date:   Mon, 17 Apr 2023 22:19:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH V2] block: ublk: switch to ioctl command encoding
Message-ID: <ZD4oTLHESjSv+g5u@infradead.org>
References: <20230417164608.781022-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417164608.781022-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 12:46:08AM +0800, Ming Lei wrote:
> All ublk commands(control, IO) should have taken ioctl command encoding
> from the beginning, because ioctl command encoding defines each code
> uniquely, so driver can figure out wrong command sent from userspace easily;
> 2) it might help security subsystem for audit uring cmd[1].
> 
> Unfortunately we didn't do that way, and it could be one lesson for ublk driver.

FYI, a bunch of overly long lines in the commit message here,
please stick to 73 lines.

> 
> So switch to ioctl command encoding now, we still support commands encoded in
> old way, but they become legacy definition. Any new command should take ioctl
> encoding.
> 
> ublksrv code for switching to ioctl command encoding:
> 
> 	https://github.com/ming1/ubdsrv/commits/ioctl_cmd_encoding
> 
> [1] https://lore.kernel.org/io-uring/CAHC9VhSVzujW9LOj5Km80AjU0EfAuukoLrxO6BEfnXeK_s6bAg@mail.gmail.com/

Maybe quote the main contents here?

> +config BLK_DEV_UBLK_NO_OLD_CMD
> +	bool "Disable old command opcode"
> +	depends on BLK_DEV_UBLK
> +	default n

I'd invert this option and have a

	BLKDEV_UBLK_LEGACY_OPCODES

or so commands.

(also n is the default default, so no need to state it, but with
inverting the option that becomes moot anyway).

> +	if (IS_ENABLED(CONFIG_BLK_DEV_UBLK_NO_OLD_CMD) && ioc_type != 'u')
> +		return -EOPNOTSUPP;
> +	if (ioc_type != 'u' && ioc_type != 0)
> +		return -EOPNOTSUPP;

Maybe switch these checks around for them to make more sense?

> +	if (IS_ENABLED(CONFIG_BLK_DEV_UBLK_NO_OLD_CMD) && ioc_type != 'u')
> +		return -EOPNOTSUPP;
> +	if (ioc_type != 'u' && ioc_type != 0)
> +		return -EOPNOTSUPP;

And maybe factor this into a helper?
