Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C8C54FCB
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2EE20700
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 20:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZU2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:28:18 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:50652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZU2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 16:28:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E605C182CED5B;
        Sun, 26 Apr 2020 20:28:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bomb38_8261953751d37
X-Filterd-Recvd-Size: 1958
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Apr 2020 20:28:15 +0000 (UTC)
Message-ID: <6a051ca29c9017f1c6fefc5d2894c8dd4542a208.camel@perches.com>
Subject: Re: [PATCH v2 2/3] floppy: add defines for sizes of cmd & reply
 buffers of floppy_raw_cmd
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 13:28:14 -0700
In-Reply-To: <20200426130728.63399-3-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
         <20200426130728.63399-3-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2020-04-26 at 16:07 +0300, Denis Efremov wrote:
> Use FD_RAW_CMD_SIZE, FD_RAW_REPLY_SIZE defines instead of magic numbers
> for cmd & reply buffers of struct floppy_raw_cmd. Remove local to
> floppy.c MAX_REPLIES define, as it is now FD_RAW_REPLY_SIZE.
> FD_RAW_CMD_FULLSIZE added as we allow command to also fill reply_count
> and reply fields.
[]
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
[]
> @@ -1847,7 +1846,7 @@ static void show_floppy(int fdc)
>  			output_log[(i + output_log_pos) % OLOGSIZE].jiffies);
>  	pr_info("last result at %lu\n", resultjiffies);
>  	pr_info("last redo_fd_request at %lu\n", lastredo);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, FD_RAW_REPLY_SIZE, 1,
>  		       reply_buffer, resultsize, true);

FD_RAW_REPLY_SIZE happens to be 16, but it's misleading
to use it here.

This use of 16 is not for FD_RAW_REPLY_SIZE, but the
width of the line
being dumped, and this value must be
either 16 or 32.


