Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9AC77B61
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 14:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjC2OQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjC2OQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 10:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5359DD
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 07:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD57C61D4F
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 14:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E43FC4339C;
        Wed, 29 Mar 2023 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680099344;
        bh=rEWEhDShqg7d5LUQrwZW5nc+7s7+ICat6EtlrOjs+lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP033oWrjHp+YR2pxJd7vVcE+g2YikCzJ9eA+oWtEzptWZuT3M9b8+XxCupWQG4lZ
         pCc/cnvxye2InXK26YkOXNgT2zL2evU14kfzexRbRncERAUFxO/qEsEYmHdN9JDGde
         6HT3r1w4bXiXSWEi+s8vp0VCPETsTm7vLbVnh36qzHRW3t1v8DIjPzLpL4qmvv4oaR
         /f4NQVYU3t96B4ztnhRnLNY9KzuFG69z8dPhWCs+eyAaBHHHnb+MJ//QLNLmnTdPcF
         hF6xDLHu3ClMs8A4maapCy3LhB6rQ2lbB2xB7PswYTjLInr47W8c7dr7UJQ+d5K9mp
         frfSnBus1GRPQ==
Date:   Wed, 29 Mar 2023 16:15:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH 1/5] sed-opal: do not add user authority twice in boolean
 ace.
Message-ID: <20230329-amendment-trodden-75a619120b5e@brauner>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-2-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-2-okozina@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:00PM +0100, Ondrej Kozina wrote:
> While adding user authority in boolean ace value
> of uid OPAL_LOCKINGRANGE_ACE_WRLOCKED or
> OPAL_LOCKINGRANGE_ACE_RDLOCKED, it was added twice.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> ---
>  block/sed-opal.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index c320093c14f1..d86d3e5f5a44 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1798,22 +1798,6 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
>  	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
>  	add_token_u8(&err, dev, OPAL_ENDNAME);
>  
> -
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_bytestring(&err, dev,
> -			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
> -			     OPAL_UID_LENGTH/2);
> -	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
> -	add_token_u8(&err, dev, OPAL_ENDNAME);
> -
> -
> -	add_token_u8(&err, dev, OPAL_STARTNAME);
> -	add_token_bytestring(&err, dev, opaluid[OPAL_HALF_UID_BOOLEAN_ACE],

This index only appears one time in the code. IOW, you're completely
removing OPAL_HALF_UID_BOOLEAN_ACE leavig only
OPAL_HALF_UID_AUTHORITY_OBJ_REF. Is that intended and if so why is
OPAL_HALF_UID_BOOLEAN_ACE not needed anymore?
