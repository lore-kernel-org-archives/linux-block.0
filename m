Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A88FC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C212721743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 10:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="AS7jt7FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfEAKhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 06:37:09 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:37416 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfEAKhI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 06:37:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id 02625A0261;
        Wed,  1 May 2019 12:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556707026; i=@fjfi.cvut.cz;
        bh=xUNgtvQRFKyYsdfzqHIQRM1/8TevvQ9MUZytgCe0Bcg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=AS7jt7FKvTgOTl13fyJcvaOTmNJ2dZf4ZuuB17hfuzLpXKbkjnJ9YmDqdAUvphajn
         YYnHoGYNT8phdmDr3oRDhSeVcuZC+Bf6ZNFTZbQaMA+eUDtosG332AHP0oBgX10g6m
         mKIOk1DPak4GBM7EkEAAILym7uJqpLbBOAHli7fo=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id sWmveC4fgvN5; Wed,  1 May 2019 12:36:41 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id 5D1DAA00DC;
        Wed,  1 May 2019 12:36:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz 5D1DAA00DC
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 147DB6004D; Wed,  1 May 2019 12:36:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id E8CC06002A;
        Wed,  1 May 2019 12:36:40 +0200 (CEST)
Date:   Wed, 1 May 2019 12:36:40 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 1/3] block: sed-opal: add ioctl for done-mark of shadow
 mbr
In-Reply-To: <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
Message-ID: <alpine.LRH.2.21.1905010145240.19150@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz> <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 1 May 2019, David Kozub wrote:

> @@ -104,6 +109,12 @@ struct opal_mbr_data {
> 	__u8 __align[7];
> };
>
> +struct opal_mbr_done {
> +	struct opal_key key;
> +	__u8 done_flag;
> +	__u8 __align[7];
> +};

While I just copied opal_mbr_data here, I wonder what is the point of 
__align in these structs. By itself it just pads the structure to have a 
size that is a multiple of 8. Is this to make sure that anything that lies 
past the structure is 8-bytes aligned (assuming the start is 8-bytes 
aligned too), perhaps for 32bit userspace with 64bit kernel?

And if it's this, is it needed for these IOCTL structs? (I can see it 
being useful for struct opal_key.)

Best regards,
David
