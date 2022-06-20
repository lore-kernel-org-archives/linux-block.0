Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91574C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 09:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiFTJAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiFTJAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 05:00:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183E12D21
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 02:00:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4354221BD2;
        Mon, 20 Jun 2022 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655715639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pa5DF0DvlUjj/R+braYan7SN0vB5sLwOMe0vADbgmY=;
        b=X91CJ1R0Yq0V07pgrH/7IiZHLXRdNJF/+jRPXPyQd9WegCQZAshivoSpCIPOcbd6U3YpNY
        JPXmUqUHi2+lq7ozBtT/sHqMCjhsCTQz/pyppKBSSgbhpWtMajdHZt3/IFTAB0MLYnM0DD
        8M7aSK4wVR7ykTayvjySXpt5arVnCuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655715639;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pa5DF0DvlUjj/R+braYan7SN0vB5sLwOMe0vADbgmY=;
        b=0GXtSrDVs60U/RVq7gZ5rQKzZSxIKdQcQR2WPYicnYEwIQNoyQK1mQL0xPSySuTg7P8kqw
        uOYjzqcpoi47XrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37B90134CA;
        Mon, 20 Jun 2022 09:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hLhcDTc3sGJrNgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:00:39 +0000
Message-ID: <77202429-5572-1455-2500-59827f210cd3@suse.de>
Date:   Mon, 20 Jun 2022 11:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 6/6] block: remove blk_cleanup_disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-7-hch@lst.de>
 <25329ddf-73d1-70e9-cd2f-372309e509ba@suse.de>
 <20220620085647.GA13464@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220620085647.GA13464@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/22 10:56, Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 10:49:06AM +0200, Hannes Reinecke wrote:
>> I wish we could have blktests for tearing down device-drivers; doing a
>> regression test here will be really hard.
> 
> The problem with a remove is that while we have a generic device remove
> attribute, it:
> 
>   a) isn't always in the same place relatively to the disk
>   b) once removed we have no generic way to add the device back for
>      further testing
> 
> nvme/032 has basic remove testing for nvme, and I think I can also
> wire up my scsi bind/unbind testing for blktests using scsi_debug without
> too much effort.  But that still isn't exactly a generic test.

Precisely my sentiment. This patchset is touch a _lot_ of drivers, and 
modifying the removal path of each.
Looking obvious from initial glance, but as usual the devil's in the 
detail. Or, to quote my QA maxim:
'The only way to be ensure it works is to ensure it works.'

But anyway, probably just wishful thinking.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
