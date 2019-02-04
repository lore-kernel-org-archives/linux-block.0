Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38651C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C832087C
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+4kmHYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfBDOws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:52:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfBDOws (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wVr8KsK/20wJEgsMbpfiIMc33iTF/7F1Fli2N7xSPoQ=; b=K+4kmHYozrc4Ww3lCN4NaAg3y
        pyP0HjYJ+77lvkm9kanLAej4XrWodQt7EhxWqRcNX1jcaL0PIMtuOzPJG4fWg/ty4pK/9XEd63H+/
        9ZGJNlz0jquUhoAS6J6iCqm+0I5kvNoKgeSDH1OMZ8vZXFUAN67CIxHmGJPbQLzvI1svlZiIZ+sdH
        ZOofLEf+ddYeNOEWSvB2tKXYrt0Sp8K/JFQLGnMGVh9oBCCBveYV7l8fzHS7nSJCoPgvaxM7mfK3n
        mKPvxlK+QhtHIw8OrLTnidU19n/Kl3q5ikHxRnkpyzeqgVL9EWB8Itaec98tqpmWJ7tyEq529pRxF
        Us2ziStNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfc4-0003RE-SR; Mon, 04 Feb 2019 14:52:44 +0000
Date:   Mon, 4 Feb 2019 06:52:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
Message-ID: <20190204145244.GJ31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:17PM +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Enable users to mark the shadow mbr as done without completely
> deactivating the shadow mbr feature. This may be useful on reboots,
> when the power to the disk is not disconnected in between and the shadow
> mbr stores the required boot files. Of course, this saves also the
> (few) commands required to enable the feature if it is already enabled
> and one only wants to mark the shadow mbr as done.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c              | 33 +++++++++++++++++++++++++++++++--
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h |  1 +
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 4b0a63b9d7c9..e03838cfd31b 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1996,13 +1996,39 @@ static int opal_erase_locking_range(struct opal_dev *dev,
>  static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>  					  struct opal_mbr_data *opal_mbr)
>  {
> +	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
> +		? OPAL_TRUE : OPAL_FALSE;
>  	const struct opal_step mbr_steps[] = {
>  		{ opal_discovery0, },
>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
> -		{ set_mbr_done, &opal_mbr->enable_disable },
> +		{ set_mbr_done, &token },
>  		{ end_opal_session, },
>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
> -		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
> +		{ set_mbr_enable_disable, &token },
> +		{ end_opal_session, },
> +		{ NULL, }

This seems to be a change of what we pass to set_mbr_done /
set_mbr_enable_disable and not really related to the new functionality
here, so it should be split into a separate patch.

That being said if we really care about this translation between
the two sets of constants, why not do it inside
set_mbr_done and set_mbr_enable_disable?
