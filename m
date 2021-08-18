Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A54BC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3881060ED5
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhHRJMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:12:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55206 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhHRJMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 05:12:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BF1D1FF99;
        Wed, 18 Aug 2021 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629277885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uSi5sDZAEhBJitiReUW3b07DTNRi68lpUR1JXtuwcCw=;
        b=uQr8vXknn7TgBVCO6/JnYVDeOY1UKboj4F2ss2FDbNO1pDKFEt5tLy7jENlkOQbY6xbY+W
        W1fofC4TkaZpvrXyVmCr6s9LmVtgwuDNNCMDFRZsyaD2BCqWEarrp+uzWw255YVcQpb/1B
        8OGw+4CcZfyKjHPSk/lN+L0MN91ZbuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629277885;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uSi5sDZAEhBJitiReUW3b07DTNRi68lpUR1JXtuwcCw=;
        b=/14nlupIKlU0cYeTVQ3GrSGQJVZoqIJdgxB21aanlfwwNdY3wVxcLqZ3i/9ZD6vZ6ZjXl0
        Xzd4PSuswqmqpSDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 29AC7134B1;
        Wed, 18 Aug 2021 09:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id bxolCr3OHGHrFgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 09:11:25 +0000
Date:   Wed, 18 Aug 2021 11:11:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, axboe@kernel.dk, gregkh@linuxfoundation.org,
        hare@suse.de, hch@lst.de, john.garry@huawei.com,
        linux-block@vger.kernel.org, sagi@grimberg.me, tglx@linutronix.de,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH V6 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <20210818091124.pwecqy6id73nsaw4@carbon.lan>
References: <YPp63niga//Q6GLV@T590>
 <20210722131245.u4dhcqotepxhwgbz@beryllium.lan>
 <20210722095246.1240526-1-ming.lei@redhat.com>
 <OFDADF39F5.DDB99A55-ON0025871A.00794382-0025871A.00797A2E@ibm.com>
 <OF2C4681CD.AF20CBB4-ON0025871E.004D37B6-0025871E.004E3B9F@ibm.com>
 <20210726170659.hrh4evhkdqnyjz5k@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726170659.hrh4evhkdqnyjz5k@beryllium.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any chance to queue this series?
