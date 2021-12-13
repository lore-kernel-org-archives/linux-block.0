Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3334C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 18:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbhLMS1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:27:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhLMS1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 13:27:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DFAE212B9;
        Mon, 13 Dec 2021 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639420063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyX4WtQsOEX0hjLfikaCsWEmeAWGoTEXuzaIMFiNl7g=;
        b=Fyvimeoy6q4dIgcDc0aZbRUNyR1EPrxNemXkfQA1BuYRnHLNrCI1YpY768oEFRq0zZnx+9
        i1fpwz4KPRrSkWh5iWtAoo3rBHtx8qYjmKQ7fle7VBa56lYOkZfulq0n0/JeW1gMArlPHB
        BxpjjvaUl1v9FsFaUH+Fh3YkAC2hE18=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 519F113EAE;
        Mon, 13 Dec 2021 18:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n3OkEJ+Qt2H4CgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Dec 2021 18:27:43 +0000
Subject: Re: [PATCH] bdev: Improve lookup_bdev documentation
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211213171113.3097631-1-willy@infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <08c26d1d-c98c-838a-4752-f8e4304f86c8@suse.com>
Date:   Mon, 13 Dec 2021 20:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213171113.3097631-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 13.12.21 г. 19:11, Matthew Wilcox (Oracle) wrote:
> Add a Context section and rewrite the rest to be clearer.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

