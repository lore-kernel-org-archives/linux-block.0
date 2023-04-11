Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BCC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDKN3H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKN3H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CB135
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF2761D89
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 13:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA88C433EF;
        Tue, 11 Apr 2023 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681219745;
        bh=IVEX+2HCTdmiFSli9ScoF6Hm8RUjBJuATvyntYVo3bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwj6DLjbSaW1r9/bn6fwMrGPs0Rh2hfiG0UgoF0Y9AtIJ6bw0ueh4xrG++BYq66gd
         S+MSMG7PQwl9PpOG7bXdbJNgwViK5HlEowjUWbXCGv+gcoapGnD1RphcGcZCiP9k/Z
         5SSXK+Te3TOb+kLavpif26toQN3cjZvX9piNQHLMXvjp7XIti3uVG+4mH0Z0zkOvm/
         QltGtk+hO2Knlf0mkRa5lO0onujDFdX+sMUM89t6EhLOJNgNRtLcOLSi0MpwdvqQsF
         NuxoaLj1q0II4DUdYnRafCDv7rH/suawhNL7bYtz0f7b5B2QnW/D4k5N1wfoyvDgrz
         0iTATqxMlr/vQ==
Date:   Tue, 11 Apr 2023 15:28:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, jonathan.derrick@linux.dev
Subject: Re: [PATCH v2 1/1] sed-opal: geometry feature reporting command
Message-ID: <20230411-fernsteuern-lauwarm-b17322cd58e2@brauner>
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230411090931.9193-1-okozina@redhat.com>
 <20230411090931.9193-2-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411090931.9193-2-okozina@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 11, 2023 at 11:09:31AM +0200, Ondrej Kozina wrote:
> Locking range start and locking range length
> attributes may be require to satisfy restrictions
> exposed by OPAL2 geometry feature reporting.
> 
> Geometry reporting feature is described in TCG OPAL SSC,
> section 3.1.1.4 (ALIGN, LogicalBlockSize, AlignmentGranularity
> and LowestAlignedLBA).
> 
> 4.3.5.2.1.1 RangeStart Behavior:
> 
> [ StartAlignment = (RangeStart modulo AlignmentGranularity) - LowestAlignedLBA ]
> 
> When processing a Set method or CreateRow method on the Locking
> table for a non-Global Range row, if:
> 
> a) the AlignmentRequired (ALIGN above) column in the LockingInfo
>    table is TRUE;
> b) RangeStart is non-zero; and
> c) StartAlignment is non-zero, then the method SHALL fail and
>    return an error status code INVALID_PARAMETER.
> 
> 4.3.5.2.1.2 RangeLength Behavior:
> 
> If RangeStart is zero, then
> 	[ LengthAlignment = (RangeLength modulo AlignmentGranularity) - LowestAlignedLBA ]
> 
> If RangeStart is non-zero, then
> 	[ LengthAlignment = (RangeLength modulo AlignmentGranularity) ]
> 
> When processing a Set method or CreateRow method on the Locking
> table for a non-Global Range row, if:
> 
> a) the AlignmentRequired (ALIGN above) column in the LockingInfo
>    table is TRUE;
> b) RangeLength is non-zero; and
> c) LengthAlignment is non-zero, then the method SHALL fail and
>    return an error status code INVALID_PARAMETER
> 
> In userspace we stuck to logical block size reported by general
> block device (via sysfs or ioctl), but we can not read
> 'AlignmentGranularity' or 'LowestAlignedLBA' anywhere else and
> we need to get those values from sed-opal interface otherwise
> we will not be able to report or avoid locking range setup
> INVALID_PARAMETER errors above.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>  block/sed-opal.c              | 29 ++++++++++++++++++++++++++++-
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 13 +++++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 3fc4e65db111..c18339446ef3 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -83,8 +83,10 @@ struct opal_dev {
>  	u16 comid;
>  	u32 hsn;
>  	u32 tsn;
> -	u64 align;
> +	u64 align; /* alignment granularity */
>  	u64 lowest_lba;
> +	u32 logical_block_size;
> +	u8  align_required; /* ALIGN: 0 or 1 */
>  
>  	size_t pos;
>  	u8 *cmd;
> @@ -409,6 +411,8 @@ static void check_geometry(struct opal_dev *dev, const void *data)
>  
>  	dev->align = be64_to_cpu(geo->alignment_granularity);
>  	dev->lowest_lba = be64_to_cpu(geo->lowest_aligned_lba);
> +	dev->logical_block_size = be32_to_cpu(geo->logical_block_size);
> +	dev->align_required = geo->reserved01 & 1;

This is really ugly. Both the naming of the variable and testing against
an unnamed constant. I'd prefer if that could be fixed but otherwise,

Reviewed-by: Christian Brauner <brauner@kernel.org>
