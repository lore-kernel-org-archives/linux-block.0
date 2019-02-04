Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DEC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054092082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDduhYOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfBDOoW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:44:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfBDOoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p73KgyuSAVAYbEax7hctuTvlmu5Kp53T9k1cuAn3VLc=; b=QDduhYOs+G8tA1b2CWTzZqZng
        PFAaPQdlRWpMCBXhsuX1ExQJQli3Yi5PN1YjQXsJdYej4iflUuaxcgN9MIhduLy1OC7z7rzOCxWaC
        opqN9zkk6mHD6f4w8Zobh1Slir6wvM3VcezcJdHVBkl0elSUIM99ambiGF92vqtITqGy3GQdVta4j
        xNI6tERvQ6YaMO3l7sHhhWB/1Op0DQgB7rzosTnbGAJw0sdM+IQU/3OGdJx685BNvVxc3aYE2nI4C
        njt1XKohBhWX0rwtPBNcZl5gD27RqoqT3JdsR9tVtWUUkL1O/mlEvSwk89mSPcjERXgaB0GuIRmaQ
        2kGDavPqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfTv-0008J1-3J; Mon, 04 Feb 2019 14:44:19 +0000
Date:   Mon, 4 Feb 2019 06:44:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 03/16] block: sed-opal: unify space check in
 add_token_*
Message-ID: <20190204144418.GC31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-4-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-4-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:10PM +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> All add_token_* functions have a common set of conditions that have to
> be checked. Use a common function for those checks in order to avoid
> different behaviour as well as code duplication.
> 
> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 5c123a5b4ab1..980705681806 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -510,15 +510,29 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
>  	return opal_discovery0_end(dev);
>  }
>  
> -static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
> +static size_t remaining_size(struct opal_dev *cmd)
> +{
> +	return IO_BUFFER_LENGTH - cmd->pos;
> +}

This function seem a little pointless to me, at least as of this patch
where it only has a single user just below.

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
