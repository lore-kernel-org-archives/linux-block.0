Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB4CC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8589E60F25
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 14:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhH3OZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:25:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbhH3OZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 10:25:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D181922045;
        Mon, 30 Aug 2021 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630333488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDItVvyZwFZxV21BA7w3UOhFlQb9BLHQxAKev2Zt2d4=;
        b=AJowyQbnEV49vkUTNXeMyFmCLZzR3y+NX+vLRT7bYN9DhPKCVCRrpPqqxN38kKtSU+xxU7
        dCFQ+hKl9zxVrK9RrrukBOTvQ/th1ZZkcmUhANu1U64x9lIQd2laQEi21Am1Xjcdv7O+3A
        mDDPFhujvUF+TMYyZ/8/bbNGKp9A9VI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A41F113990;
        Mon, 30 Aug 2021 14:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3tTKJDDqLGEsBQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 14:24:48 +0000
Subject: Re: [PATCH] blk-mq: Use helpers to access rq->state
To:     linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210512095017.235295-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f87da2cd-93d0-663d-15be-30d64f69a5bc@suse.com>
Date:   Mon, 30 Aug 2021 17:24:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210512095017.235295-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12.05.21 г. 12:50, Nikolay Borisov wrote:
> Instead of having a mixed bag of opencoded usage and helper usage,
> simply replace opencoded sites with the appropriate helper. No
> functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Ping
