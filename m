Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B3C761A6
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjDDPZi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjDDPZh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:25:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC84491
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vvJISdt6SJdtqfherRdm0ArvWPXXfX+n2/LixWo87v0=; b=YTnDFIV2CjGC8xAflJ9a7SCczj
        BYGw8ADehsiBi0wRBkh9eqV4py+eWeprBWBGm/M0lzBZoDnaTkqpWu/j/V1HPkclGdUNASFZmC1CC
        2mR6xsy6+jduUtrtzE+6gcGgQ9HVilbOeWj/1IPYV8Z/64ak7ww+LPzr1ES77q9GtEfhXXBT6hyt9
        YmYAJpgV+MgwFhTxfjzRuKLluyXAbSMRCgKh42mnmVIeZPkmtiyNKv9dln/SKnOYGy9duyhVQSEtM
        7G/5/rflwnAkUgUrJFewIkrhUqnvGpJarM5ORKtkQqF22lEgm18XVZJC/dui0klQVlbzhSnmwCF+E
        tpAjtamg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiXQ-001zxq-14;
        Tue, 04 Apr 2023 15:25:36 +0000
Date:   Tue, 4 Apr 2023 08:25:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, brauner@kernel.org,
        rafael.antognolli@intel.com
Subject: Re: [PATCH 2/5] sed-opal: add helper for adding user authorities in
 ACE.
Message-ID: <ZCxBcOBSfmf58Yxd@infradead.org>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-3-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-3-okozina@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:01PM +0100, Ondrej Kozina wrote:
> Moves ACE construction away from add_user_to_lr routine
> to be used later in added code.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> ---
>  block/sed-opal.c | 64 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index d86d3e5f5a44..2c3e38df9c65 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1759,25 +1759,16 @@ static int set_sid_cpin_pin(struct opal_dev *dev, void *data)
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>  
> -static int add_user_to_lr(struct opal_dev *dev, void *data)
> +static int set_lr_boolean_ace(struct opal_dev *dev, unsigned int opal_uid, u8 lr,
> +			      const u8 *users, size_t users_len)

Please avoid the overly long line here.

> +	for (u = 0; u < users_len; u++) {
> +		if (users[u] == OPAL_ADMIN1)
> +			memcpy(user_uid, opaluid[OPAL_ADMIN1_UID], OPAL_UID_LENGTH);
> +		else {
> +			memcpy(user_uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
> +			user_uid[7] = users[u];
> +		}
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_bytestring(&err, dev,
> +				     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
> +				     OPAL_UID_LENGTH/2);
> +		add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);

Please facto the logic for adding each user into a nice little helper,
which wil also avoid the overly long lines.

> +		if (u > 0) {
> +			add_token_u8(&err, dev, OPAL_STARTNAME);
> +			add_token_bytestring(&err, dev, opaluid[OPAL_HALF_UID_BOOLEAN_ACE],
> +					     OPAL_UID_LENGTH/2);
> +			add_token_u8(&err, dev, 1);
> +			add_token_u8(&err, dev, OPAL_ENDNAME);
> +		}

And this would also benefit from both a helper and a comment.

