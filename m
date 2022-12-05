Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A552C4321E
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 07:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLEHJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 02:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiLEHJh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 02:09:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342EDECF
        for <linux-block@vger.kernel.org>; Sun,  4 Dec 2022 23:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wglbgGYTxQTf/2EU8llaDTWooQqtjIUUjkHgZaTrf48=; b=K94/ky7NCRMfpaXPbq29XqRqLF
        ti7oKnoZaxHToRwp/AXLaeFzNIrFmnnBiUCELYotuI5bJRMTVRS8VwCdWtPa5pV6nNY7KNY92IsKt
        YOFCORz+eQLKrc8JmLYM2Gr9wm6IiwWt8aM7zNd0jkwQ/M5J0r8QcYNDGxha0C8F1F7fhlPkNrnHu
        3odJ6quS3qeQpBvPjy0OlNiT0bdPQiyMjZSmgqgLVEpIf5oJSO3/Jbpd5bTPo6XjI63UpxMbIlWnS
        2bofpKRJLcuhgDq5gT7Essai0BcJj20UGY0oKQxCy4X73lOADV2IDi70E8lcOZmfgrPlLBlUoeZGP
        fxmAQgTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p25bZ-00FLg6-CR; Mon, 05 Dec 2022 07:09:33 +0000
Date:   Sun, 4 Dec 2022 23:09:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev,
        gmazyland@gmail.com, axboe@kernel.dk, brauner@kernel.org,
        stepan.horacek@gmail.com
Subject: Re: [PATCH v2] sed-opal: allow using IOC_OPAL_SAVE for locking too
Message-ID: <Y42ZLf8uiZEkv5xc@infradead.org>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221203001243.16482-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203001243.16482-1-luca.boccassi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 03, 2022 at 12:12:43AM +0000, luca.boccassi@gmail.com wrote:
> +	 * Usually when closing a crypto device (eg: dm-crypt with LUKS) the volume

As said last time, please correctly format your block comments so that
they don't spill out of 80 characters for every single line and become
completely unreadable.

> +	if (lk_unlk->l_state == OPAL_LK &&
> +			lk_unlk->session.opal_key.key_len == 0) {
> +		struct opal_suspend_data *iter;
> +
> +		setup_opal_dev(dev);
> +		list_for_each_entry(iter, &dev->unlk_lst, node) {
> +			if (iter->unlk.save_for_lock &&
> +					iter->lr == lk_unlk->session.opal_key.lr &&
> +					iter->unlk.session.opal_key.key_len > 0) {
> +				lk_unlk->session.opal_key.key_len =
> +					iter->unlk.session.opal_key.key_len;
> +				memcpy(lk_unlk->session.opal_key.key,
> +					iter->unlk.session.opal_key.key,
> +					iter->unlk.session.opal_key.key_len);
> +				break;
> +			}
> +		}

And please split this logic into a helper.

>  	__u32 l_state;
> -	__u8 __align[4];
> +	__u8 save_for_lock:1; /* if in IOC_OPAL_SAVE will also use key to lock */

Please never use bitfields in ABIs, the psABI rules for them are just
a mess to start with, and not filling all of them leads to leaks of
stack contents as well.  Just turn the entire 4 bytes into a flags
field and then just bitmasks.
