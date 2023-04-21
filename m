Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE2C77B75
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 06:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDUGcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 02:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDUGb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 02:31:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54314233;
        Thu, 20 Apr 2023 23:31:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD9351FDDD;
        Fri, 21 Apr 2023 06:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682058715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZL3smVNGoGzgHkXyetE+e6DnwvCvdKUVLpjzB8HJ4Xk=;
        b=mAMUnw65tZZr0jL/DSFdge8EnjZ2Lscy+CuUXihp3OMxK1tHviN/w3Kp4yz9VMx804Rnfq
        OdFnkL0FwJqtc0iPGES5KCqHV8DZnljqhh7gCENoQ7SzjK2+RrF45yOXPD8GpPuOQNDflA
        t02/wmtReYh6v5vpG8O5esn09Yat+w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682058715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZL3smVNGoGzgHkXyetE+e6DnwvCvdKUVLpjzB8HJ4Xk=;
        b=sIAzOr5bMncJl42mcqJcq5qFN7bU3FdYgYyD2XVzOagOFSeF6YuqHSbwzsQfVJxX02Tfp9
        aIwjEGgRFSHuVbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90DD113456;
        Fri, 21 Apr 2023 06:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JHKCItstQmRtcgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:31:55 +0000
Message-ID: <be94c092-2064-c2b7-23e1-6dc0ace824a3@suse.de>
Date:   Fri, 21 Apr 2023 08:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 6/9] nvme-rc: Add minimal test image
 size requirement
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-7-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 08:05, Daniel Wagner wrote:
> Some tests need a minimal test image size to work correctly. Thus add a
> helper to check the size and update these tests accordingly.
> 
> The image minimum is 4M because some of the test have hard coded values.
> All tests which use the xfs fio verification job have a minimum
> requirement of 350M impossed by the xfs filesystem.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/012 |  1 +
>   tests/nvme/013 |  1 +
>   tests/nvme/029 |  1 -
>   tests/nvme/045 |  2 +-
>   tests/nvme/rc  | 15 +++++++++++++++
>   5 files changed, 18 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

