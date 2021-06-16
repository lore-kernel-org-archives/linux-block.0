Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE42AC48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 23:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48BB613BF
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 23:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhFPXtQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhFPXtP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 19:49:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F41A5613AE;
        Wed, 16 Jun 2021 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623887229;
        bh=sJDlOkWvGKshDYWdi80hJckwC5hbqeaz/mhWyUvh0Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhvfDg1LQRfVXv0JQifBQ5odpWMF+RNb2wdhzr+NzmMrUtSIzuvmmGia3KfMT4pu9
         pAPEZvMsrtKqL6ciIE10wo5Xn4a+UASWu1UsfKwEpamtLJlY4dkGKkT0uTaLcsCXi9
         DVqpCIm4cPI0eszVB8hdNu5zpj/eHMav7psHCuS9/r8PqTXBCOxwWkMBb/pjGbtA1G
         cEBeZLnpOm8dWv80U5N8+GDaNptv8IkVl3CL4D0xv7LiyxPMF75sucv/F8oER30RqN
         n72q6HcOZsttLGAO/zAA8F11rM/PbVotxmaqJ4t1YCEfQEr6C4RWmUKl4OZ+AhV7Ik
         B37U+84MMFV3g==
Date:   Wed, 16 Jun 2021 16:47:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 01/10] block: introduce blk_ksm_is_empty()
Message-ID: <YMqNe4GdMBUghH3L@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-2-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:51PM +0000, Satya Tangirala wrote:
> This function checks if a given keyslot manager supports any encryption
> mode/data unit size combination (and returns true if there is no such
> supported combination). Helps clean up code a little.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/keyslot-manager.c         | 21 +++++++++++++++++++++
>  drivers/md/dm-table.c           | 11 +----------
>  include/linux/keyslot-manager.h |  2 ++
>  3 files changed, 24 insertions(+), 10 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>
