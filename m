Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19778C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 06:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbiEaGvX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 02:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244370AbiEaGvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 02:51:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B691542
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 23:51:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE8941F944;
        Tue, 31 May 2022 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653979879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HEArpTEP5mGYdE29WNJbG4Jw4Ov2jb2Y2utYFYcL0E=;
        b=A30+TfeRSUC2TLNVWc9+MyU2NIWbfEyf5fzwaVKK7CjSupcIMhETd2LanFali7JVV4HuZA
        ARCqwC5uEugIVNHpFzncQpBuTXcpfhXsJ5CCMtMnv7W8S6QwWbt21KlXzF8Zgr5ePejzr8
        tkGVNQQAd8tnfiKDdxQgjxq1HTyf4iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653979879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HEArpTEP5mGYdE29WNJbG4Jw4Ov2jb2Y2utYFYcL0E=;
        b=5fA7UnlNb4GhiYwn7vSwpRGe7qyMoa5wKmupBT+DIPBxf19TpDq9H8ZEUrKfd3GM21LxE2
        RUyQaO3cJ/Q9ChDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75061132F9;
        Tue, 31 May 2022 06:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MvyJG+e6lWJbQAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 31 May 2022 06:51:19 +0000
Message-ID: <d2b67ff0-4bc0-e8c7-22b3-fdff9d8edc47@suse.de>
Date:   Tue, 31 May 2022 08:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] block: freeze the queue earlier in del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20220530134548.3108185-1-hch@lst.de>
 <20220530134548.3108185-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220530134548.3108185-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/22 15:45, Christoph Hellwig wrote:
> Freeze the queue earlier in del_gendisk so that the state does not
> change while we remove debugfs and sysfs files.
> 
> Ming mentioned that being able to observer request in debugfs might
> be useful while the queue is being frozen in del_gendisk, which is
> made possible by this change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
